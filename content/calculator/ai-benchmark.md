---
title: "浏览器 JavaScript 运算测试"
slug: "ai-benchmark"
description: "固定输入的JavaScript运算计时，展示耗时与乘加组数，不测量GPU或模型推理。"
date: 2026-03-01
lastmod: 2026-10-12
tool: "browser-arithmetic"
---

本工具测量固定输入下的浏览器 JavaScript 运算耗时，没有加载AI模型或调用GPU。结果不能换算成显卡型号、FLOPS或模型生成速度。原网址保留，工具名称与说明已纠正。

每次执行100×100组“乘法后累加”，输入固定。先预热，再分段计时；预热与分段之间的页面等待不计入计算耗时。吞吐量按实际次数×10,000组÷累计计算时间计算。浏览器版本、电源模式、后台任务和计时精度会影响结果，不宜跨设备直接排名。

<div class="benchmark-container">
<div class="benchmark-controls">
<label for="iterations">测试次数</label>
<select id="iterations"><option value="100">100次（快速）</option><option value="1000" selected>1000次（标准）</option><option value="5000">5000次（较长）</option></select>
<button type="button" id="benchmark-start" class="benchmark-btn">开始测试</button>
</div>
<div class="benchmark-progress" id="progress" hidden>
<div class="progress-bar" aria-hidden="true"><div class="progress-fill" id="progress-fill"></div></div>
</div>
<p id="progress-text" role="status" aria-live="polite">请选择次数后开始，运行时保持页面在前台。</p>
<div class="benchmark-result" id="result" hidden>
<h2>本次结果</h2><div class="result-grid">
<div class="result-item"><span>累计计算耗时（不含等待）</span><strong id="total-time">—</strong></div>
<div class="result-item"><span>每次计算平均耗时</span><strong id="avg-time">—</strong></div>
<div class="result-item"><span>乘法后累加吞吐量</span><strong id="ops-per-sec">—</strong></div>
<div class="result-item"><span>结果校验和</span><strong id="checksum">—</strong></div>
</div></div>
<noscript><p>此测试需要JavaScript；仍可阅读上方的计算方法与限制。</p></noscript>
</div>

需要验证模型运行？沿 [本地AI阅读路线](/local-ai-roadmap/) 在自己的设备上记录实际模型、配置和结果。

<style>
.benchmark-container [hidden] { display:none; }
.benchmark-btn:disabled { opacity:.6; cursor:wait; }
@media(max-width:540px) { .benchmark-controls { flex-wrap:wrap; } .benchmark-container { padding:16px; } .result-item strong { overflow-wrap:anywhere; } }
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
