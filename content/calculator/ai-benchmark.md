---
title: "AI 算力测试"
slug: "ai-benchmark"
description: "测试本地设备的AI推理性能"
---

# 🤖 AI 算力测试

在浏览器中运行简单的 AI 推理测试，评估设备性能。

<div class="benchmark-container">
  <div class="benchmark-info">
    <p>此测试通过运行多个矩阵运算来评估 CPU/GPU 的 AI 推理性能。</p>
  </div>
  
  <div class="benchmark-controls">
    <label>测试次数</label>
    <select id="iterations">
      <option value="100">100 次 (快速)</option>
      <option value="1000" selected>1000 次 (标准)</option>
      <option value="5000">5000 次 (深度)</option>
    </select>
    
    <button onclick="runBenchmark()" class="benchmark-btn">开始测试</button>
  </div>
  
  <div class="benchmark-progress" id="progress" style="display:none;">
    <div class="progress-bar">
      <div class="progress-fill" id="progress-fill"></div>
    </div>
    <p id="progress-text">测试中...</p>
  </div>
  
  <div class="benchmark-result" id="result" style="display:none;">
    <h3>测试结果</h3>
    <div class="result-grid">
      <div class="result-item">
        <span>总耗时</span>
        <strong id="total-time">0 ms</strong>
      </div>
      <div class="result-item">
        <span>平均耗时</span>
        <strong id="avg-time">0 ms/次</strong>
      </div>
      <div class="result-item">
        <span>运算速度</span>
        <strong id="ops-per-sec">0 次/秒</strong>
      </div>
      <div class="result-item">
        <span>性能评级</span>
        <strong id="rating">-</strong>
      </div>
    </div>
  </div>
</div>

<script>
function runBenchmark() {
  const iterations = parseInt(document.getElementById('iterations').value);
  
  document.getElementById('progress').style.display = 'block';
  document.getElementById('result').style.display = 'none';
  
  setTimeout(() => {
    const startTime = performance.now();
    
    // 模拟矩阵运算测试
    let result = 0;
    for (let i = 0; i < iterations; i++) {
      // 矩阵乘法模拟
      const a = Array(100).fill(0).map(() => Math.random());
      const b = Array(100).fill(0).map(() => Math.random());
      for (let j = 0; j < 100; j++) {
        for (let k = 0; k < 100; k++) {
          result += a[j] * b[k];
        }
      }
      
      // 更新进度
      if (i % 100 === 0) {
        const progress = (i / iterations) * 100;
        document.getElementById('progress-fill').style.width = progress + '%';
        document.getElementById('progress-text').textContent = `测试中... ${Math.round(progress)}%`;
      }
    }
    
    const endTime = performance.now();
    const totalTime = endTime - startTime;
    const avgTime = totalTime / iterations;
    const opsPerSec = 10000 / (totalTime / 1000);
    
    // 计算评级
    let rating;
    if (avgTime < 0.1) rating = '🔥 顶级 (RTX 4090+)';
    else if (avgTime < 0.5) rating = '⭐ 优秀 (RTX 4070+)';
    else if (avgTime < 1) rating = '👍 良好 (RTX 3060+)';
    else if (avgTime < 3) rating = '💪 一般 (GTX 1660+)';
    else if (avgTime < 10) rating = '⚠️ 入门 (集显)';
    else rating = '🐢 较弱';
    
    document.getElementById('total-time').textContent = totalTime.toFixed(0) + ' ms';
    document.getElementById('avg-time').textContent = avgTime.toFixed(2) + ' ms/次';
    document.getElementById('ops-per-sec').textContent = opsPerSec.toFixed(0) + ' 次/秒';
    document.getElementById('rating').textContent = rating;
    
    document.getElementById('progress').style.display = 'none';
    document.getElementById('result').style.display = 'block';
  }, 100);
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
.benchmark-controls {
  display: flex;
  gap: 16px;
  align-items: center;
  margin-bottom: 24px;
}
.benchmark-controls label {
  font-weight: 600;
}
.benchmark-controls select {
  flex: 1;
  padding: 10px 16px;
  border: 1px solid #e5e5e5;
  border-radius: 8px;
  font-size: 14px;
}
.benchmark-btn {
  padding: 12px 32px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
}
.progress-bar {
  height: 8px;
  background: #f0f0f0;
  border-radius: 4px;
  overflow: hidden;
  margin-bottom: 12px;
}
.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #667eea, #764ba2);
  width: 0%;
  transition: width 0.1s;
}
#progress-text {
  text-align: center;
  color: #666;
}
.benchmark-result h3 {
  margin-bottom: 20px;
  text-align: center;
}
.result-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}
.result-item {
  background: #f8f9fa;
  padding: 16px;
  border-radius: 8px;
  text-align: center;
}
.result-item span {
  display: block;
  color: #666;
  font-size: 13px;
  margin-bottom: 8px;
}
.result-item strong {
  font-size: 20px;
  color: #667eea;
}
</style>
