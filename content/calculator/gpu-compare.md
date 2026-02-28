---
title: "GPU 对比工具"
slug: "gpu-compare"
description: "对比两款显卡的规格和性能"
---

# 🎮 GPU 对比工具

选择两款显卡进行规格对比。

<div class="gpu-compare">
  <div class="gpu-select">
    <div class="select-group">
      <label>显卡 1</label>
      <select id="gpu1" onchange="compareGPUs()">
        <option value="">选择显卡...</option>
        <option value="rtx4090">RTX 4090</option>
        <option value="rtx4080">RTX 4080 SUPER</option>
        <option value="rtx4070ti">RTX 4070 Ti SUPER</option>
        <option value="rtx4070">RTX 4070 SUPER</option>
        <option value="rtx4060ti">RTX 4060 Ti</option>
        <option value="rtx4060">RTX 4060</option>
        <option value="rtx3090">RTX 3090</option>
        <option value="rtx3080">RTX 3080</option>
        <option value="rtx3070">RTX 3070</option>
        <option value="rtx3060ti">RTX 3060 Ti</option>
        <option value="rtx3060">RTX 3060</option>
        <option value="rx7900xtx">RX 7900 XTX</option>
        <option value="rx7900xt">RX 7900 XT</option>
        <option value="rx7800xt">RX 7800 XT</option>
        <option value="rx7700xt">RX 7700 XT</option>
        <option value="rx7600xt">RX 7600 XT</option>
        <option value="a770">Intel Arc A770</option>
        <option value="a750">Intel Arc A750</option>
      </select>
    </div>
    
    <div class="vs">VS</div>
    
    <div class="select-group">
      <label>显卡 2</label>
      <select id="gpu2" onchange="compareGPUs()">
        <option value="">选择显卡...</option>
        <option value="rtx4090">RTX 4090</option>
        <option value="rtx4080">RTX 4080 SUPER</option>
        <option value="rtx4070ti">RTX 4070 Ti SUPER</option>
        <option value="rtx4070">RTX 4070 SUPER</option>
        <option value="rtx4060ti">RTX 4060 Ti</option>
        <option value="rtx4060">RTX 4060</option>
        <option value="rtx3090">RTX 3090</option>
        <option value="rtx3080">RTX 3080</option>
        <option value="rtx3070">RTX 3070</option>
        <option value="rtx3060ti">RTX 3060 Ti</option>
        <option value="rtx3060">RTX 3060</option>
        <option value="rx7900xtx">RX 7900 XTX</option>
        <option value="rx7900xt">RX 7900 XT</option>
        <option value="rx7800xt">RX 7800 XT</option>
        <option value="rx7700xt">RX 7700 XT</option>
        <option value="rx7600xt">RX 7600 XT</option>
        <option value="a770">Intel Arc A770</option>
        <option value="a750">Intel Arc A750</option>
      </select>
    </div>
  </div>
  
  <div class="compare-result" id="result" style="display:none;">
    <table class="compare-table">
      <tr>
        <th>规格</th>
        <td id="name1"></td>
        <td id="name2"></td>
      </tr>
      <tr>
        <th>架构</th>
        <td id="arch1"></td>
        <td id="arch2"></td>
      </tr>
      <tr>
        <th>显存</th>
        <td id="vram1"></td>
        <td id="vram2"></td>
      </tr>
      <tr>
        <th>显存类型</th>
        <td id="memType1"></td>
        <td id="memType2"></td>
      </tr>
      <tr>
        <th>带宽</th>
        <td id="bandwidth1"></td>
        <td id="bandwidth2"></td>
      </tr>
      <tr>
        <th>功耗 (TDP)</th>
        <td id="tdp1"></td>
        <td id="tdp2"></td>
      </tr>
      <tr>
        <th>3DMark 分数</th>
        <td id="score1"></td>
        <td id="score2"></td>
      </tr>
      <tr>
        <th>参考价格</th>
        <td id="price1"></td>
        <td id="price2"></td>
      </tr>
    </table>
  </div>
</div>

<script>
const gpuData = {
  rtx4090: { name: 'RTX 4090', arch: 'Ada Lovelace', vram: '24GB GDDR6X', memType: 'GDDR6X', bandwidth: '1008 GB/s', tdp: '450W', score: '32000', price: '¥16000' },
  rtx4080: { name: 'RTX 4080 SUPER', arch: 'Ada Lovelace', vram: '16GB GDDR6X', memType: 'GDDR6X', bandwidth: '736 GB/s', tdp: '320W', score: '28000', price: '¥8000' },
  rtx4070ti: { name: 'RTX 4070 Ti SUPER', arch: 'Ada Lovelace', vram: '16GB GDDR6X', memType: 'GDDR6X', bandwidth: '672 GB/s', tdp: '285W', score: '24000', price: '¥6500' },
  rtx4070: { name: 'RTX 4070 SUPER', arch: 'Ada Lovelace', vram: '12GB GDDR6X', memType: 'GDDR6X', bandwidth: '504 GB/s', tdp: '220W', score: '21000', price: '¥5000' },
  rtx4060ti: { name: 'RTX 4060 Ti', arch: 'Ada Lovelace', vram: '8GB GDDR6', memType: 'GDDR6', bandwidth: '288 GB/s', tdp: '160W', score: '13500', price: '¥3200' },
  rtx4060: { name: 'RTX 4060', arch: 'Ada Lovelace', vram: '8GB GDDR6', memType: 'GDDR6', bandwidth: '272 GB/s', tdp: '115W', score: '12000', price: '¥2400' },
  rtx3090: { name: 'RTX 3090', arch: 'Ampere', vram: '24GB GDDR6X', memType: 'GDDR6X', bandwidth: '936 GB/s', tdp: '350W', score: '25000', price: '¥12000' },
  rtx3080: { name: 'RTX 3080', arch: 'Ampere', vram: '10GB GDDR6X', memType: 'GDDR6X', bandwidth: '760 GB/s', tdp: '320W', score: '22000', price: '¥7000' },
  rtx3070: { name: 'RTX 3070', arch: 'Ampere', vram: '8GB GDDR6', memType: 'GDDR6', bandwidth: '448 GB/s', tdp: '220W', score: '18000', price: '¥4000' },
  rtx3060ti: { name: 'RTX 3060 Ti', arch: 'Ampere', vram: '8GB GDDR6', memType: 'GDDR6', bandwidth: '448 GB/s', tdp: '200W', score: '15500', price: '¥2800' },
  rtx3060: { name: 'RTX 3060', arch: 'Ampere', vram: '12GB GDDR6', memType: 'GDDR6', bandwidth: '360 GB/s', tdp: '170W', score: '13000', price: '¥2200' },
  rx7900xtx: { name: 'RX 7900 XTX', arch: 'RDNA 3', vram: '24GB GDDR6', memType: 'GDDR6', bandwidth: '960 GB/s', tdp: '355W', score: '30000', price: '¥7500' },
  rx7900xt: { name: 'RX 7900 XT', arch: 'RDNA 3', vram: '20GB GDDR6', memType: 'GDDR6', bandwidth: '800 GB/s', tdp: '300W', score: '27000', price: '¥6000' },
  rx7800xt: { name: 'RX 7800 XT', arch: 'RDNA 3', vram: '16GB GDDR6', memType: 'GDDR6', bandwidth: '624 GB/s', tdp: '263W', score: '23000', price: '¥4500' },
  rx7700xt: { name: 'RX 7700 XT', arch: 'RDNA 3', vram: '12GB GDDR6', memType: 'GDDR6', bandwidth: '432 GB/s', tdp: '245W', score: '20000', price: '¥3500' },
  rx7600xt: { name: 'RX 7600 XT', arch: 'RDNA 3', vram: '8GB GDDR6', memType: 'GDDR6', bandwidth: '288 GB/s', tdp: '190W', score: '14000', price: '¥2600' },
  a770: { name: 'Intel Arc A770', arch: 'Xe-HPG', vram: '16GB GDDR6', memType: 'GDDR6', bandwidth: '560 GB/s', tdp: '225W', score: '15000', price: '¥2500' },
  a750: { name: 'Intel Arc A750', arch: 'Xe-HPG', vram: '8GB GDDR6', memType: 'GDDR6', bandwidth: '512 GB/s', tdp: '225W', score: '13000', price: '¥1800' }
};

function compareGPUs() {
  const gpu1Key = document.getElementById('gpu1').value;
  const gpu2Key = document.getElementById('gpu2').value;
  
  if (!gpu1Key || !gpu2Key) {
    document.getElementById('result').style.display = 'none';
    return;
  }
  
  const gpu1 = gpuData[gpu1Key];
  const gpu2 = gpuData[gpu2Key];
  
  document.getElementById('name1').textContent = gpu1.name;
  document.getElementById('name2').textContent = gpu2.name;
  document.getElementById('arch1').textContent = gpu1.arch;
  document.getElementById('arch2').textContent = gpu2.arch;
  document.getElementById('vram1').textContent = gpu1.vram;
  document.getElementById('vram2').textContent = gpu2.vram;
  document.getElementById('memType1').textContent = gpu1.memType;
  document.getElementById('memType2').textContent = gpu2.memType;
  document.getElementById('bandwidth1').textContent = gpu1.bandwidth;
  document.getElementById('bandwidth2').textContent = gpu2.bandwidth;
  document.getElementById('tdp1').textContent = gpu1.tdp;
  document.getElementById('tdp2').textContent = gpu2.tdp;
  document.getElementById('score1').textContent = gpu1.score;
  document.getElementById('score2').textContent = gpu2.score;
  document.getElementById('price1').textContent = gpu1.price;
  document.getElementById('price2').textContent = gpu2.price;
  
  document.getElementById('result').style.display = 'block';
}
</script>

<style>
.gpu-compare {
  background: white;
  border-radius: 16px;
  padding: 32px;
  max-width: 700px;
  margin: 0 auto;
}
.gpu-select {
  display: flex;
  align-items: flex-end;
  gap: 20px;
  margin-bottom: 32px;
}
.select-group {
  flex: 1;
}
.select-group label {
  display: block;
  font-weight: 600;
  margin-bottom: 8px;
}
.select-group select {
  width: 100%;
  padding: 12px;
  border: 1px solid #e5e5e5;
  border-radius: 8px;
  font-size: 14px;
}
.vs {
  font-size: 20px;
  font-weight: 700;
  color: #667eea;
  padding-bottom: 12px;
}
.compare-table {
  width: 100%;
  border-collapse: collapse;
}
.compare-table th, .compare-table td {
  padding: 12px;
  border: 1px solid #eee;
  text-align: center;
}
.compare-table th {
  background: #f8f9fa;
  width: 120px;
  text-align: left;
}
.compare-table td:nth-child(2),
.compare-table td:nth-child(3) {
  width: 40%;
}
</style>
