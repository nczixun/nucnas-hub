const assert = require('node:assert/strict');
const {runBatch, measurements} = require('../assets/js/browser-arithmetic.js');
// Each batch computes sum(a) * sum(b) with known fixed inputs.
assert.ok(Math.abs(runBatch(1) - 2550.25) < 1e-8);
assert.ok(Math.abs(runBatch(2) - 5100.5) < 1e-8);
assert.deepEqual(measurements(100, 1000), {pairs: 1000000, average: 10, perSecond: 1000000});
assert.equal(measurements(1000, 1000).perSecond, 10000000);
assert.throws(() => measurements(100, 0));
assert.throws(() => measurements(1.5, 100));
console.log('PASS: fixed workload, iteration-dependent throughput, invalid measurement handling');
