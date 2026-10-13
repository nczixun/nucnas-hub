---
title: "功耗计算器"
slug: "power"
description: "根据实测整机活动与待机平均功率、使用时长和电价估算每日耗电及电费"
date: 2026-03-01
lastmod: 2026-10-13
reviewedAt: 2026-10-13
contentType: "工具与公式核查"
sources:
  - "https://www.pubs.ext.vt.edu/content/pubs_ext_vt_edu/en/2901/2901-9014/2901-9014.html"
  - "https://www.intel.com/content/www/us/en/support/articles/000055611/processors.html"
---

# ⚡ 整机耗电与电费计算器

输入插座功率计记录的**整机平均功率**，估算耗电和电费。CPU/GPU 的 TDP 是部件规格，不能直接相加当作插座端整机实测功率。计算器不会测量你的设备。

活动、待机功率应分别覆盖一段有代表性的时间；瞬时峰值不等于平均功率。若其余时间完全断电，待机功率填 0；NAS 全天运行可将活动时长填 24。显示器、外置硬盘、UPS 是否在测量范围内，需要保持一致。

以下默认值仅为**假设示例，并非本站实测数据**。请替换为自己的测量和账单电价。

<form class="calculator" onsubmit="event.preventDefault(); calculatePower();" oninput="calculatePower();">
  <div class="calc-input">
    <label for="active-watts">活动期间整机平均功率 (W)</label>
    <input type="number" id="active-watts" value="35" min="0" step="any" required aria-describedby="power-input-note power-error">
  </div>
  <div class="calc-input">
    <label for="idle-watts">其余时间整机平均功率 (W，断电填 0)</label>
    <input type="number" id="idle-watts" value="15" min="0" step="any" required aria-describedby="power-input-note power-error">
  </div>
  <div class="calc-input">
    <label for="hours">每日活动时长 (小时，0–24)</label>
    <input type="number" id="hours" value="8" min="0" max="24" step="any" required aria-describedby="power-error">
  </div>
  <div class="calc-input">
    <label for="electricity">电价 (元/千瓦时，1 千瓦时 = 1 度)</label>
    <input type="number" id="electricity" value="0.6" step="any" min="0" required aria-describedby="power-error">
  </div>
  <p id="power-input-note" class="calc-note">功率由用户测量后输入；示例活动 35 W、其余时间 15 W，每天活动 8 小时。</p>
  <p id="power-error" class="calc-error" role="alert" hidden></p>
  <button type="submit" class="calc-btn">估算耗电与电费</button>
  <div class="result" id="result" style="display:none;" aria-live="polite">
    <div class="result-item">
      <span>全天平均功率（估算）</span>
      <strong id="total-power">0 W</strong>
    </div>
    <div class="result-item">
      <span>每日耗电（估算）</span>
      <strong id="daily-power">0 度</strong>
    </div>
    <div class="result-item">
      <span>30 天电费（估算）</span>
      <strong id="monthly-cost">0 元</strong>
    </div>
    <div class="result-item">
      <span>365 天电费（估算）</span>
      <strong id="yearly-cost">0 元</strong>
    </div>
  </div>
</form>

## 公式与计算范围

每日耗电（千瓦时）= `[活动功率 × 活动小时 + 其余时间功率 × (24 − 活动小时)] ÷ 1000`。电费 = 耗电 × 电价；30 天、365 天结果假设每天使用模式和电价相同。

例如，假设活动功率 35 W、每天 8 小时，其余 16 小时为 15 W，每日耗电为 0.52 千瓦时。以 0.6 元/千瓦时计算，30 天约 9.36 元，365 天约 113.88 元。这是公式示例，不代表任何具体主机的能耗。

阶梯电价、峰谷电价或每天负载变化时，应分别计算各时段再求和；固定费用未包含在内。长时间能耗记录可直接用功率计累计的千瓦时核对估算。

## 来源

- [Virginia Cooperative Extension 能耗估算指南](https://www.pubs.ext.vt.edu/content/pubs_ext_vt_edu/en/2901/2901-9014/2901-9014.html)：瓦数 × 小时 ÷ 1000 得到千瓦时，乘使用天数和电价估算费用。
- [Intel：处理器 TDP 的用途与功率边界](https://www.intel.com/content/www/us/en/support/articles/000055611/processors.html)：TDP 用于热设计，负载和睿频会影响部件功率。

<script>
function estimateEnergy(activeValue, idleValue, hoursValue, rateValue) {
  const rawValues = [activeValue, idleValue, hoursValue, rateValue];
  if (rawValues.some(value => String(value).trim() === '')) {
    throw new Error('请填写全部输入项；完全断电或电价为零时可填 0。');
  }
  const [active, idle, hours, rate] = rawValues.map(Number);
  if (![active, idle, hours, rate].every(Number.isFinite) || active < 0 || idle < 0 || rate < 0) {
    throw new Error('功率和电价必须是有效的非负数。');
  }
  if (hours < 0 || hours > 24) {
    throw new Error('每日活动时长必须在 0–24 小时之间。');
  }
  const daily = (active * hours + idle * (24 - hours)) / 1000;
  const average = daily * 1000 / 24;
  const monthly = daily * 30 * rate;
  const yearly = daily * 365 * rate;
  if (![daily, average, monthly, yearly].every(Number.isFinite)) {
    throw new Error('输入数值过大，请填写实际测量范围内的数值。');
  }
  return { average, daily, monthly, yearly };
}

function calculatePower() {
  const error = document.getElementById('power-error');
  const result = document.getElementById('result');
  error.hidden = true;
  error.textContent = '';
  result.style.display = 'none';
  try {
    const values = ['active-watts', 'idle-watts', 'hours', 'electricity'].map(id => document.getElementById(id).value);
    const estimate = estimateEnergy(...values);
    document.getElementById('total-power').textContent = estimate.average.toFixed(2) + ' W';
    document.getElementById('daily-power').textContent = estimate.daily.toFixed(3) + ' 千瓦时';
    document.getElementById('monthly-cost').textContent = estimate.monthly.toFixed(2) + ' 元';
    document.getElementById('yearly-cost').textContent = estimate.yearly.toFixed(2) + ' 元';
    result.style.display = 'block';
  } catch (problem) {
    error.textContent = problem.message;
    error.hidden = false;
  }
}
calculatePower();
</script>

<style>
.calculator {
  box-sizing: border-box;
  background: white;
  border-radius: 16px;
  padding: 32px;
  max-width: 500px;
  margin: 0 auto;
}
.calc-input {
  margin-bottom: 20px;
}
.calc-input label {
  display: block;
  font-weight: 600;
  margin-bottom: 8px;
  color: #333;
}
.calc-input input {
  box-sizing: border-box;
  width: 100%;
  padding: 12px 16px;
  border: 1px solid #e5e5e5;
  border-radius: 8px;
  font-size: 16px;
}
.calc-input input:focus {
  outline: none;
  border-color: #667eea;
}
.calc-btn {
  width: 100%;
  padding: 14px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: transform 0.2s;
}
.calc-btn:hover {
  transform: scale(1.02);
}
.calc-btn:focus-visible { outline: 3px solid #333; outline-offset: 3px; }
.calc-note { font-size: 14px; color: #555; line-height: 1.6; }
.calc-error { padding: 12px; background: #fff1f0; color: #a11912; border: 1px solid #d42b22; border-radius: 8px; }
.result {
  margin-top: 24px;
  padding-top: 24px;
  border-top: 1px solid #eee;
}
.result-item {
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 12px;
  padding: 12px 0;
  border-bottom: 1px solid #f5f5f5;
}
.result-item strong {
  color: #667eea;
  font-size: 18px;
}
</style>
