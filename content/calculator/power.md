閿橈拷---
title: "閸旂喕鈧顓哥粻妤€娅�"
slug: "power"
description: "閺嶈宓丆PU/GPU TDP鐠侊紕鐣婚弫瀛樻簚閸旂喕鈧绱濇导鎵暬閻絻鍨�"
date: 2026-03-01
---

# 閳匡拷 閸旂喕鈧顓哥粻妤€娅�

閺嶈宓佺涵顑挎 TDP 鐠侊紕鐣婚弫瀛樻簚閸旂喕鈧鎷伴獮鏉戝閻絻鍨傞妴锟�

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
    <label>閸忔湹绮柊宥勬 (W)</label>
    <input type="number" id="other-tdp" value="50" min="0" max="200">
  </div>
  
  <div class="calc-input">
    <label>濮ｅ繑妫╂担璺ㄦ暏閺冨爼鏆� (鐏忓繑妞�)</label>
    <input type="number" id="hours" value="8" min="0" max="24">
  </div>
  
  <div class="calc-input">
    <label>閻絻鍨� (閸忥拷/鎼达拷)</label>
    <input type="number" id="electricity" value="0.6" step="0.1" min="0" max="2">
  </div>
  
  <button onclick="calculatePower()" class="calc-btn">鐠侊紕鐣婚崝鐔烩偓锟�</button>
  
  <div class="result" id="result" style="display:none;">
    <div class="result-item">
      <span>閺佸瓨婧€閸旂喕鈧拷</span>
      <strong id="total-power">0 W</strong>
    </div>
    <div class="result-item">
      <span>濮ｅ繑妫╅懓妤冩暩</span>
      <strong id="daily-power">0 鎼达拷</strong>
    </div>
    <div class="result-item">
      <span>濮ｅ繑婀€閻絻鍨�</span>
      <strong id="monthly-cost">0 閸忥拷</strong>
    </div>
    <div class="result-item">
      <span>楠炴潙瀹抽悽浣冨瀭</span>
      <strong id="yearly-cost">0 閸忥拷</strong>
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
  document.getElementById('daily-power').textContent = daily.toFixed(2) + ' 鎼达拷';
  document.getElementById('monthly-cost').textContent = monthly.toFixed(2) + ' 閸忥拷';
  document.getElementById('yearly-cost').textContent = yearly.toFixed(2) + ' 閸忥拷';
  
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
