---
title: "功耗计算器"
slug: "power"
description: "根据CPU/GPU TDP计算整机功耗，估算电费"
---

# ⚡ 功耗计算器

根据硬件 TDP 计算整机功耗和年度电费。

<div class="calculator">
  <div class="calc-input">
    <label>CPU TDP (W)</label>
    <input type="number" id="cpu-tdp" value="65" min="0" max="500">
  </div>
  
  <div class="calc-input">
    <label>GPU TDP (W)</label>
    <input type="number" id="gpu-tdp" value="0" min="0" max="600">
  </div>
  
  <div class="calc-input">
    <label>其他配件 (W)</label>
    <input type="number" id="other-tdp" value="50" min="0" max="200">
  </div>
  
  <div class="calc-input">
    <label>每日使用时长 (小时)</label>
    <input type="number" id="hours" value="8" min="0" max="24">
  </div>
  
  <div class="calc-input">
    <label>电费 (元/度)</label>
    <input type="number" id="electricity" value="0.6" step="0.1" min="0" max="2">
  </div>
  
  <button onclick="calculatePower()" class="calc-btn">计算功耗</button>
  
  <div class="result" id="result" style="display:none;">
    <div class="result-item">
      <span>整机功耗</span>
      <strong id="total-power">0 W</strong>
    </div>
    <div class="result-item">
      <span>每日耗电</span>
      <strong id="daily-power">0 度</strong>
    </div>
    <div class="result-item">
      <span>每月电费</span>
      <strong id="monthly-cost">0 元</strong>
    </div>
    <div class="result-item">
      <span>年度电费</span>
      <strong id="yearly-cost">0 元</strong>
    </div>
  </div>
</div>

<script>
function calculatePower() {
  const cpu = parseFloat(document.getElementById('cpu-tdp').value) || 0;
  const gpu = parseFloat(document.getElementById('gpu-tdp').value) || 0;
  const other = parseFloat(document.getElementById('other-tdp').value) || 0;
  const hours = parseFloat(document.getElementById('hours').value) || 0;
  const electricity = parseFloat(document.getElementById('electricity').value) || 0.6;
  
  const total = cpu + gpu + other;
  const daily = (total * hours) / 1000;
  const monthly = daily * 30 * electricity;
  const yearly = daily * 365 * electricity;
  
  document.getElementById('total-power').textContent = total + ' W';
  document.getElementById('daily-power').textContent = daily.toFixed(2) + ' 度';
  document.getElementById('monthly-cost').textContent = monthly.toFixed(2) + ' 元';
  document.getElementById('yearly-cost').textContent = yearly.toFixed(2) + ' 元';
  
  document.getElementById('result').style.display = 'block';
}
</script>

<style>
.calculator {
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
.result {
  margin-top: 24px;
  padding-top: 24px;
  border-top: 1px solid #eee;
}
.result-item {
  display: flex;
  justify-content: space-between;
  padding: 12px 0;
  border-bottom: 1px solid #f5f5f5;
}
.result-item strong {
  color: #667eea;
  font-size: 18px;
}
</style>
