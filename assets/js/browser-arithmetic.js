/* Fixed-input JavaScript arithmetic workload. No GPU or model inference. */
(() => {
  const size = 100;
  const a = Float64Array.from({ length: size }, (_, i) => (i + 1) / size);
  const b = Float64Array.from({ length: size }, (_, i) => (size - i) / size);
  function runBatch(iterations) {
    let checksum = 0;
    for (let i = 0; i < iterations; i++) {
      for (let j = 0; j < size; j++) {
        for (let k = 0; k < size; k++) checksum += a[j] * b[k];
      }
    }
    return checksum;
  }
  function measurements(iterations, milliseconds) {
    if (!Number.isInteger(iterations) || iterations <= 0 || !Number.isFinite(milliseconds) || milliseconds <= 0) {
      throw new Error('Invalid measurement');
    }
    return { pairs: iterations * size * size, average: milliseconds / iterations,
      perSecond: iterations * size * size * 1000 / milliseconds };
  }
  if (typeof module !== 'undefined' && module.exports) {
    module.exports = { runBatch, measurements };
    return;
  }
  const button = document.getElementById('benchmark-start');
  if (!button) return;
  const selector = document.getElementById('iterations');
  const status = document.getElementById('progress-text');
  const nextFrame = () => new Promise(resolve => requestAnimationFrame(() => setTimeout(resolve, 0)));
  button.addEventListener('click', async () => {
    const iterations = Number(selector.value);
    if (![100, 1000, 5000].includes(iterations)) { status.textContent = '请选择有效的测试次数。'; return; }
    button.disabled = true;
    selector.disabled = true;
    document.getElementById('result').hidden = true;
    document.getElementById('progress').hidden = false;
    document.getElementById('progress-fill').style.width = '0%';
    status.textContent = '正在预热，请保持页面在前台…';
    try {
      await nextFrame();
      runBatch(10); // Warm-up is not included in the measured workload.
      let elapsed = 0;
      let checksum = 0;
      for (let completed = 0; completed < iterations;) {
        const count = Math.min(25, iterations - completed);
        const start = performance.now();
        checksum += runBatch(count);
        elapsed += performance.now() - start;
        completed += count;
        document.getElementById('progress-fill').style.width = `${completed / iterations * 100}%`;
        status.textContent = `已完成 ${completed} / ${iterations} 次`;
        await nextFrame(); // Allow UI painting between chunks; wait time is excluded.
      }
      if (!(elapsed > 0)) throw new Error('Timer resolution');
      const measured = measurements(iterations, elapsed);
      document.getElementById('total-time').textContent = `${elapsed.toFixed(2)} ms`;
      document.getElementById('avg-time').textContent = `${measured.average.toFixed(4)} ms/次`;
      document.getElementById('ops-per-sec').textContent = `${Math.round(measured.perSecond).toLocaleString()} 组/秒`;
      document.getElementById('checksum').textContent = checksum.toFixed(2);
      document.getElementById('result').hidden = false;
      status.textContent = '测试完成。仅代表本次浏览器JavaScript运算结果。';
    } catch {
      status.textContent = '本次未得到有效计时，请保持页面在前台后重试。';
    } finally {
      button.disabled = false;
      selector.disabled = false;
    }
  });
})();
