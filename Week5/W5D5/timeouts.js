// Simple Timeout
//
// Not sure why this doesn't work
// let alert4 = function alert(message) {
//   console.log(message);
// };
//
// window.setTimeout(alert4('HAMMERTIME'), 5000);

window.setTimeout(function () {
  alert('HAMERTIME');
}, 5000);



//Timeout plus closure

function hammertime(time) {
  window.setTimeout(function () {
    alert(`${time} is HAMERTIME!`);
  }, 5000);
}
