锘�---
title: "鍔熻€楄绠楀櫒"
slug: "power"
description: "鏍规嵁CPU/GPU TDP璁＄畻鏁存満鍔熻€楋紝浼扮畻鐢佃垂"
date: 2026-03-01
---

# 鈿� 鍔熻€楄绠楀櫒

鏍规嵁纭欢 TDP 璁＄畻鏁存満鍔熻€楀拰骞村害鐢佃垂銆�

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
    <label>鍏朵粬閰嶄欢 (W)</label>
    <input type="number" id="other-tdp" value="50" min="0" max="200">
  </div>
  
  <div class="calc-input">
    <label>姣忔棩浣跨敤鏃堕暱 (灏忔椂)</label>
    <input type="number" id="hours" value="8" min="0" max="24">
  </div>
  
  <div class="calc-input">
    <label>鐢佃垂 (鍏�/搴�)</label>
    <input type="number" id="electricity" value="0.6" step="0.1" min="0" max="2">
  </div>
  
  <button onclick="calculatePower()" class="calc-btn">璁＄畻鍔熻€�</button>
  
  <div class="result" id="result" style="display:none;">
    <div class="result-item">
      <span>鏁存満鍔熻€�</span>
      <strong id="total-power">0 W</strong>
    </div>
    <div class="result-item">
      <span>姣忔棩鑰楃數</span>
      <strong id="daily-power">0 搴�</strong>
    </div>
    <div class="result-item">
      <span>姣忔湀鐢佃垂</span>
      <strong id="monthly-cost">0 鍏�</strong>
    </div>
    <div class="result-item">
      <span>骞村害鐢佃垂</span>
      <strong id="yearly-cost">0 鍏�</strong>
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
  document.getElementById('daily-power').textContent = daily.toFixed(2) + ' 搴�';
  document.getElementById('monthly-cost').textContent = monthly.toFixed(2) + ' 鍏�';
  document.getElementById('yearly-cost').textContent = yearly.toFixed(2) + ' 鍏�';
  
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
