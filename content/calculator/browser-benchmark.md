閿橈拷---
title: "濞村繗顫嶉崳銊ㄧ獓閸掑棙绁寸拠锟�"
slug: "browser-benchmark"
description: "濞村鐦ù蹇氼潔閸ｂ啑avaScript閸滃本瑕嗛弻鎾粹偓褑鍏�"
date: 2026-03-01
---

# 棣冨 濞村繗顫嶉崳銊ㄧ獓閸掑棙绁寸拠锟�

濞村鐦ù蹇氼潔閸ｏ拷 JavaScript 閹笛嗩攽閺佸牏宸奸崪灞捐閺屾挻鈧嗗厴閵嗭拷

<div class="benchmark-container">
  <div class="benchmark-info">
    <p>闁俺绻冩潻鎰攽 JavaScript 閸╁搫鍣ù瀣槸閿涘矁鐦庢导鐗堢セ鐟欏牆娅掗幀褑鍏橀妴锟�</p>
  </div>
  
  <div class="benchmark-tests">
    <div class="test-item">
      <div class="test-header">
        <h4>棣冩晿 鐠侊紕鐣婚幀褑鍏�</h4>
        <button onclick="runMathTest()" class="test-btn" id="math-btn">瀵偓婵绁寸拠锟�</button>
      </div>
      <div class="test-result" id="math-result"></div>
    </div>
    
    <div class="test-item">
      <div class="test-header">
        <h4>棣冩憫 鐎涙顑佹稉鎻掝槱閻烇拷</h4>
        <button onclick="runStringTest()" class="test-btn" id="string-btn">瀵偓婵绁寸拠锟�</button>
      </div>
      <div class="test-result" id="string-result"></div>
    </div>
    
    <div class="test-item">
      <div class="test-header">
        <h4>棣冨腹 濞撳弶鐓嬮幀褑鍏�</h4>
        <button onclick="runRenderTest()" class="test-btn" id="render-btn">瀵偓婵绁寸拠锟�</button>
      </div>
      <div class="test-result" id="render-result"></div>
    </div>
  </div>
  
  <div class="benchmark-summary" id="summary" style="display:none;">
    <h3>閹缍嬬拠鍕瀻</h3>
    <div class="score-display" id="total-score">0</div>
    <p id="score-rating">-</p>
  </div>
</div>

<script>
let scores = { math: 0, string: 0, render: 0 };

function runMathTest() {
  const btn = document.getElementById('math-btn');
  btn.disabled = true;
  btn.textContent = '濞村鐦稉锟�...';
  
  setTimeout(() => {
    const start = performance.now();
    let result = 0;
    for (let i = 0; i < 1000000; i++) {
      result += Math.sqrt(i) * Math.sin(i) * Math.cos(i);
    }
    const time = performance.now() - start;
    
    const score = Math.max(0, 10000 - time * 10);
    scores.math = score;
    
    document.getElementById('math-result').innerHTML = `
      <div class="score">${score.toFixed(0)} 閸掞拷</div>
      <div class="time">閼版妞�: ${time.toFixed(0)} ms</div>
    `;
    
    btn.textContent = '闁插秵鏌婂ù瀣槸';
    btn.disabled = false;
    updateSummary();
  }, 100);
}

function runStringTest() {
  const btn = document.getElementById('string-btn');
  btn.disabled = true;
  btn.textContent = '濞村鐦稉锟�...';
  
  setTimeout(() => {
    const start = performance.now();
    let result = '';
    for (let i = 0; i < 100000; i++) {
      result += 'test' + i + 'string' + 'operation';
    }
    const time = performance.now() - start;
    
    const score = Math.max(0, 10000 - time * 10);
    scores.string = score;
    
    document.getElementById('string-result').innerHTML = `
      <div class="score">${score.toFixed(0)} 閸掞拷</div>
      <div class="time">閼版妞�: ${time.toFixed(0)} ms</div>
    `;
    
    btn.textContent = '闁插秵鏌婂ù瀣槸';
    btn.disabled = false;
    updateSummary();
  }, 100);
}

function runRenderTest() {
  const btn = document.getElementById('render-btn');
  btn.disabled = true;
  btn.textContent = '濞村鐦稉锟�...';
  
  setTimeout(() => {
    const start = performance.now();
    const container = document.createElement('div');
    for (let i = 0; i < 1000; i++) {
      const el = document.createElement('div');
      el.style.cssText = 'position:absolute;left:' + i + 'px;top:' + i + 'px;';
      container.appendChild(el);
    }
    const time = performance.now() - start;
    
    const score = Math.max(0, 10000 - time * 10);
    scores.render = score;
    
    document.getElementById('render-result').innerHTML = `
      <div class="score">${score.toFixed(0)} 閸掞拷</div>
      <div class="time">閼版妞�: ${time.toFixed(0)} ms</div>
    `;
    
    btn.textContent = '闁插秵鏌婂ù瀣槸';
    btn.disabled = false;
    updateSummary();
  }, 100);
}

function updateSummary() {
  const total = (scores.math + scores.string + scores.render) / 3;
  if (total > 0) {
    document.getElementById('summary').style.display = 'block';
    document.getElementById('total-score').textContent = total.toFixed(0);
    
    let rating;
    if (total > 8000) rating = '棣冩畬 妞ゅ墎楠囬幀褑鍏�';
    else if (total > 6000) rating = '鐚革拷 娴兼ḿ顫�';
    else if (total > 4000) rating = '棣冩啢 閼诡垰銈�';
    else if (total > 2000) rating = '棣冩尛 娑撯偓閼革拷';
    else rating = '閳跨媴绗� 鏉堝啫鎬�';
    
    document.getElementById('score-rating').textContent = rating;
  }
}
</script>

<style>
.benchmark-container {
  background: white;
  border-radius: 16px;
  padding: 32px;
  max-width: 600px;
  margin: 0 auto;
}
.benchmark-info {
  background: #f8f9fa;
  padding: 16px;
  border-radius: 8px;
  margin-bottom: 24px;
  color: #666;
}
.test-item {
  border: 1px solid #eee;
  border-radius: 12px;
  padding: 20px;
  margin-bottom: 16px;
}
.test-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.test-header h4 {
  margin: 0;
  font-size: 16px;
}
.test-btn {
  padding: 8px 20px;
  background: #667eea;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
}
.test-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}
.test-result {
  margin-top: 16px;
  padding-top: 16px;
  border-top: 1px solid #f5f5f5;
}
.test-result .score {
  font-size: 24px;
  font-weight: 700;
  color: #667eea;
}
.test-result .time {
  color: #666;
  font-size: 13px;
  margin-top: 4px;
}
.benchmark-summary {
  margin-top: 32px;
  padding-top: 32px;
  border-top: 2px solid #eee;
  text-align: center;
}
.score-display {
  font-size: 64px;
  font-weight: 800;
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
#score-rating {
  font-size: 20px;
  color: #666;
  margin-top: 8px;
}
</style>
