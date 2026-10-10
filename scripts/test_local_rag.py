"""Deterministic tutorial checks: no network, model download or inference."""
import contextlib
import importlib.util
import io
import json
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

path = Path(__file__).resolve().parents[1] / 'static/examples/local_rag.py'
spec = importlib.util.spec_from_file_location('local_rag', path)
rag = importlib.util.module_from_spec(spec)
spec.loader.exec_module(rag)


class TutorialTests(unittest.TestCase):
    def test_retrieval_and_http_contract(self):
        calls = []

        class LocalAPI:
            def open(self, request, timeout):
                data = json.loads(request.data)
                calls.append((request.full_url, data))
                self_timeout = timeout
                assert self_timeout == 300
                if request.full_url.endswith('/api/embed'):
                    self_result = {'embeddings': [[1, 0] if 'backup' in t else [0, 1]
                                                   for t in data['input']]}
                    assert data['truncate'] is False
                else:
                    assert data['stream'] is False
                    self_result = {'message': {'content': 'MOCK RESPONSE'}}
                return io.BytesIO(json.dumps(self_result).encode())

        with tempfile.TemporaryDirectory() as folder:
            # More than one embedding batch; a relevant file must rank first.
            for i in range(10):
                Path(folder, f'{i}.txt').write_text('garden flowers', encoding='utf-8')
            Path(folder, 'backup.txt').write_text('backup Saturday 02:30', encoding='utf-8')
            output = io.StringIO()
            with patch.object(rag, 'build_opener', return_value=LocalAPI()), contextlib.redirect_stdout(output):
                rag.answer('backup time?', folder)
        evidence = json.loads(calls[-1][1]['messages'][1]['content'])['evidence']
        self.assertEqual(evidence[0]['source'], 'backup.txt')
        self.assertEqual(len(evidence), 3)
        self.assertEqual(len(calls), 3)
        self.assertTrue(all(url.startswith('http://127.0.0.1:11434/api/') for url, _ in calls))
        self.assertIn('MOCK RESPONSE', output.getvalue())

    def test_empty_and_oversized_inputs_stop_before_network(self):
        with tempfile.TemporaryDirectory() as folder, patch.object(rag, 'api') as api:
            with self.assertRaisesRegex(ValueError, 'No non-empty'):
                rag.answer('question', folder)
            Path(folder, 'large.txt').write_text('a' * 100001)
            with self.assertRaisesRegex(ValueError, '100 KB'):
                rag.answer('question', folder)
            api.assert_not_called()

    def test_malformed_embeddings_are_rejected(self):
        with tempfile.TemporaryDirectory() as folder:
            Path(folder, 'demo.txt').write_text('test', encoding='utf-8')
            for vectors in ([], [[0, 0], [1, 0]], [[1], [1, 0]], [[float('nan')], [1]]):
                with self.subTest(vectors=vectors), patch.object(rag, 'api', return_value={'embeddings': vectors}):
                    with self.assertRaises(ValueError):
                        rag.answer('question', folder)


if __name__ == '__main__':
    unittest.main()
