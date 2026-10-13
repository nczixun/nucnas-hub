const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');

const repoRoot = path.resolve(__dirname, '..');
function pageScript(filename) {
  const page = fs.readFileSync(path.join(repoRoot, 'content', 'calculator', filename), 'utf8');
  return [...page.matchAll(/<script(?:\s[^>]*)?>([\s\S]*?)<\/script>/g)]
    .map(match => match[1]).filter(script => script.trim()).join('\n');
}
const raidScope = {};
vm.runInNewContext(pageScript('raid.md'), raidScope);
const raid = raidScope.raidCalculator();
raid.calculate();
assert.equal(raid.valid, true, 'default four-drive RAID 5 should calculate on initialization');
assert.equal(raid.result.usableCapacity, '24.0 TB');

function raidResult(mode, count, size) {
  raid.diskCount = count;
  raid.diskSize = size;
  raid.selectMode(mode);
  return raid.result;
}

// Known configurations, including a many-way mirror rather than a fixed 50% assumption.
for (const [mode, count, size, usable, failures, efficiency] of [
  ['0', 2, 8, '16.0 TB', 0, 100],
  ['1', 2, 8, '8.0 TB', 1, 50],
  ['1', 4, 8, '8.0 TB', 3, 25],
  ['5', 3, 8, '16.0 TB', 1, 67],
  ['5', 4, 8, '24.0 TB', 1, 75],
  ['6', 4, 8, '16.0 TB', 2, 50],
  ['6', 6, 8, '32.0 TB', 2, 67],
  ['10', 4, 8, '16.0 TB', 1, 50],
  ['10', 6, 8, '24.0 TB', 1, 50],
  ['10', 8, 8, '32.0 TB', 1, 50],
  ['10', 24, 8, '96.0 TB', 1, 50],
]) {
  const result = raidResult(mode, count, size);
  assert.equal(raid.valid, true, `${mode}, ${count} drives`);
  assert.equal(raid.warning, '');
  assert.equal(result.usableCapacity, usable);
  assert.equal(result.faultTolerance, failures);
  assert.equal(result.efficiency, efficiency);
}
assert.equal(raidResult('10', 6, 8).conditionalMaxFailures, 3);

// Six-drive RAID 10: the three known mirror pairs are [0,1], [2,3], [4,5].
// Every single failure survives; failures 0+1 do not; failures 0+2+4 do.
const mirroredPairs = [[0, 1], [2, 3], [4, 5]];
const survives = failed => mirroredPairs.every(pair => pair.some(disk => !failed.includes(disk)));
assert.ok([0, 1, 2, 3, 4, 5].every(disk => survives([disk])));
assert.equal(survives([0, 1]), false);
assert.equal(survives([0, 2]), true);
assert.equal(survives([0, 2, 4]), true);
assert.equal(raid.result.faultTolerance, 1, 'conditional three-drive tolerance is not guaranteed');

// A rejected input must clear a preceding valid result instead of leaving stale capacity visible.
for (const [mode, count, size] of [
  ['5', 2, 8], ['6', 3, 8], ['10', 2, 8], ['10', 3, 8], ['10', 5, 8],
  ['10', 7, 8], ['0', 1, 8], ['0', 2.5, 8], ['0', 25, 8],
  ['0', '', 8], ['0', '   ', 8], ['0', 'invalid', 8], ['0', Infinity, 8],
  ['0', 2, ''], ['0', 2, '   '], ['0', 2, 'invalid'], ['0', 2, 0],
  ['0', 2, -8], ['0', 2, Infinity], ['0', 24, 1e308], ['unknown', 4, 8],
]) {
  raidResult('5', 4, 8);
  raidResult(mode, count, size);
  assert.equal(raid.valid, false, `${mode}, ${count} drives, ${size} TB should reject`);
  assert.notEqual(raid.warning, '');
  assert.equal(raid.result.usableCapacity, '0 TB');
  assert.equal(raid.result.faultTolerance, 0);
}
assert.equal(raidResult('0', '2', '0.5').usableCapacity, '1.0 TB', 'fractional TB should remain supported');
assert.equal(raidResult('0', 2, 0.001).usableCapacity, '0.002 TB', 'small positive capacity must not round to zero');

const elements = Object.fromEntries([
  ['active-watts', '35'], ['idle-watts', '15'], ['hours', '8'], ['electricity', '0.6'],
  ['power-error', ''], ['result', ''], ['total-power', ''], ['daily-power', ''],
  ['monthly-cost', ''], ['yearly-cost', ''],
].map(([id, value]) => [id, { value, textContent: '', hidden: false, style: {} }]));
const powerScope = { document: { getElementById: id => elements[id] } };
vm.runInNewContext(pageScript('power.md'), powerScope);
const estimate = powerScope.estimateEnergy;
const close = (actual, expected) => assert.ok(Math.abs(actual - expected) < 1e-9, `${actual} != ${expected}`);

const example = estimate(35, 15, 8, 0.6);
close(example.daily, 0.52);
close(example.average, 520 / 24);
close(example.monthly, 9.36);
close(example.yearly, 113.88);
assert.equal(elements['monthly-cost'].textContent, '9.36 元');
assert.equal(elements['yearly-cost'].textContent, '113.88 元');
assert.equal(elements.result.style.display, 'block');

close(estimate(40, 0, 24, 0.6).daily, 0.96, 'NAS running all day');
close(estimate(40, 5, 0, 0.6).daily, 0.12, 'all hours in the second state');
close(estimate(100, 0, 8, 0.6).daily, 0.8, 'unplugged remaining hours');
close(estimate(10, 10, 3.5, 0.6).daily, 0.24, 'identical power across both states');
close(estimate('35', '15', '8', '0.6').monthly, 9.36, 'number input values arrive as strings');
assert.equal(estimate(35, 15, 8, 0).yearly, 0, 'zero price must not silently become 0.6');
assert.equal(estimate(0, 0, 8, 0.6).daily, 0, 'zero power is valid');

for (const values of [
  ['', 15, 8, 0.6], [35, ' ', 8, 0.6], [35, 15, '', 0.6], [35, 15, 8, ''],
  [-1, 15, 8, 0.6], [35, -1, 8, 0.6], [35, 15, -1, 0.6], [35, 15, 25, 0.6],
  [35, 15, 8, -1], [Infinity, 15, 8, 0.6], [35, 'bad', 8, 0.6],
  [35, 15, NaN, 0.6], [1e308, 1e308, 24, 0.6],
]) {
  assert.throws(() => estimate(...values), undefined, `${values} should reject`);
}
elements.electricity.value = '0';
powerScope.calculatePower();
assert.equal(elements['yearly-cost'].textContent, '0.00 元');
elements.hours.value = '-1';
powerScope.calculatePower();
assert.equal(elements.result.style.display, 'none', 'invalid input must hide old cost');
assert.equal(elements['power-error'].hidden, false);
assert.match(elements['power-error'].textContent, /0–24/);

// Optional generated-site check: node scripts/test_growth_calculators.cjs <build-dir>
// Inline HTML must render as a real tool, rather than Goldmark's indented code block.
if (process.argv[2]) {
  const buildRoot = path.resolve(process.argv[2]);
  for (const [tool, ids] of [
    ['raid', ['raid-disk-count', 'raid-disk-size']],
    ['power', ['active-watts', 'idle-watts', 'hours', 'electricity']],
  ]) {
    const html = fs.readFileSync(path.join(buildRoot, 'calculator', tool, 'index.html'), 'utf8');
    for (const id of ids) {
      assert.match(html, new RegExp(`<input\\b[^>]*\\bid=(?:["']${id}["']|${id})(?:\\s|>)`), `${tool}: actual input ${id} missing`);
    }
    const codeBlocks = [...html.matchAll(/<(pre|code)\b[^>]*>[\s\S]*?<\/\1>/gi)].map(match => match[0]);
    assert.ok(!codeBlocks.some(block => ids.some(id => block.includes(id))), `${tool}: calculator HTML leaked into pre/code`);
    if (tool === 'raid') {
      assert.match(html, /<template\b[^>]*\bx-for=/, 'RAID mode template missing');
      assert.match(html, /<button\b[^>]*\bclass=(?:["']raid-mode-btn["']|raid-mode-btn)(?:\s|>)/, 'RAID mode button missing');
    } else {
      assert.match(html, /<form\b[^>]*onsubmit=/, 'Power calculator form missing');
      assert.match(html, /<button\b[^>]*type=(?:["']submit["']|submit)(?:\s|>)/, 'Power submit button missing');
    }
  }
  console.log('PASS: generated RAID and power HTML contain real inputs/buttons; calculator HTML is outside pre/code');
}

console.log('PASS: RAID capacities, RAID 10 guaranteed/conditional tolerance, invalid/stale input handling, measured-power energy scenarios and zero-price handling');
