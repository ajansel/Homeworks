document.addEventListener("DOMContentLoaded", function(){
  // Phase 1
  var canvas = document.getElementById('mycanvas');
  canvas.height = 500;
  canvas.width = 500;
  var ctx = canvas.getContext('2d');

  // Phase 2
  ctx.fillStyle = 'rgb(255,255,0)';
  ctx.fillRect(0,0,500,500);

  // Phase 3a
  ctx.beginPath();
  ctx.arc(250,250,225,0,2 * Math.PI);
  ctx.strokeStyle = 'rgb(0,0,0)';
  ctx.lineWidth = 5;
  ctx.stroke();

  // Phase 3b
  ctx.fillStyle = 'rgb(255,255,255)';
  ctx.fill();

  // Phase 4
  // Look into more complicated shapes and examples of animation as time permits
});
