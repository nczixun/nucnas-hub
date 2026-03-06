---
title: "计算器"
description: "硬件功耗对比、AI算力测试、性能跑分工具"
---

# 实用工具

<div class="tools-grid">
  <!-- 功耗计算器 -->
  <a href="/calculator/power/" class="tool-card">
    <div class="tool-icon">⚡</div>
    <h3>功耗计算器</h3>
    <p>根据 CPU/GPU TDP 计算整机功耗，估算电费</p>
  </a>

  <!-- AI 算力测试 -->
  <a href="/calculator/ai-benchmark/" class="tool-card">
    <div class="tool-icon">🤖</div>
    <h3>AI 算力测试</h3>
    <p>测试本地设备的 AI 推理性能</p>
  </a>

  <!-- 浏览器性能测试 -->
  <a href="/calculator/browser-benchmark/" class="tool-card">
    <div class="tool-icon">🌐</div>
    <h3>浏览器跑分</h3>
    <p>测试浏览器 JavaScript 性能</p>
  </a>
  
  <!-- GPU对比 -->
  <a href="/calculator/gpu-compare/" class="tool-card">
    <div class="tool-icon">🎮</div>
    <h3>GPU 对比</h3>
    <p>对比两款显卡的规格和性能</p>
  </a>
</div>

<style>
.tools-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
  margin-top: 40px;
}
.tool-card {
  background: white;
  border-radius: 16px;
  padding: 32px;
  text-decoration: none;
  color: inherit;
  box-shadow: 0 2px 12px rgba(0,0,0,0.06);
  transition: all 0.3s;
  display: block;
}
.tool-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0,0,0,0.1);
}
.tool-icon {
  font-size: 40px;
  margin-bottom: 16px;
}
.tool-card h3 {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 8px;
}
.tool-card p {
  color: #666;
  font-size: 14px;
}
</style>
