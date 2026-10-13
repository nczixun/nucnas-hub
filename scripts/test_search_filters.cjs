const assert = require('node:assert/strict');
const {rank, prepare} = require('../assets/js/search.js');
const pages = prepare([
  {title:'NAS guide', summary:'storage', text:'backup', section:'nas', url:'/nas/a/', reviewed:true, reviewedAt:'2026-10-13'},
  {title:'NAS guide', summary:'storage', text:'backup', section:'hardware', url:'/review/b/', reviewed:false, contentStatus:'pending'},
  {title:'Ollama guide', summary:'local', text:'AI', section:'ai', url:'/ai/c/', reviewed:false}
]);
assert.equal(rank(pages,'NAS','',false)[0].page.url,'/nas/a/');
assert.equal(rank(pages,'NAS','hardware',false).length,1);
assert.equal(rank(pages,'NAS','hardware',true).length,0);
assert.equal(rank(pages,'NAS','',true).length,1);
assert.equal(rank(pages,'ＮＡＳ','nas',false).length,1);
assert.equal(rank(pages,'NAS backup','nas',false).length,1);
assert.equal(rank(pages,'','',false).length,0);
assert.equal(rank(pages,'unmatched','',false).length,0);
console.log('PASS: query normalization, source status, section/review intersection, empty and unmatched searches');
