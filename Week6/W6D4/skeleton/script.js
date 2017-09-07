document.addEventListener("DOMContentLoaded", () => {
  // toggling restaurants

  const toggleLi = (e) => {
    const li = e.target;
    if (li.className === "visited") {
      li.className = "";
    } else {
      li.className = "visited";
    }
  };

  document.querySelectorAll("#restaurants li").forEach((li) => {
    li.addEventListener("click", toggleLi);
  });


  // adding SF places as list items

  // --- your code here!
  const formEl = document.querySelectorAll('.list-container form')[0];
  // debugger;
  formEl.addEventListener("submit", event => {
    event.preventDefault();

    const favoriteInputEl = document.getElementsByClassName("favorite-input")[0];
    const favorite = favoriteInputEl.value;
    favoriteInputEl.value = "";

    const ul = document.getElementById('restaurants');
    const li = document.createElement("li");

    li.textContent = favorite;

    ul.appendChild(li);
  });


  // adding new photos

  // --- your code here!



});
