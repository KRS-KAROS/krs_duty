const playerDuty = document.querySelector("#duty");

function openDuty() {
  document.querySelector(".bg").style.display = "block";
  document.querySelector(".titolo").style.display = "block";
  document.querySelector(".onduty").style.display = "block";
  document.querySelector(".offduty").style.display = "block";

}

window.addEventListener("message", function (event) {
  let data = event.data;
  if (data.type === "openDuty") {
    openDuty();
  }
});

function post(path) {
  fetch(path, {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify({}),
  }).then((resp) => resp.json());
}

function selectOnDuty() {
  post("https://krs_duty/onduty");

  document.querySelector(".bg").style.display = "none";
  document.querySelector(".titolo").style.display = "none";
  document.querySelector(".onduty").style.display = "none";
  document.querySelector(".offduty").style.display = "none";

}

function selectOffDuty() {
  post("https://krs_duty/offduty");

  document.querySelector(".bg").style.display = "none";
  document.querySelector(".titolo").style.display = "none";
  document.querySelector(".onduty").style.display = "none";
  document.querySelector(".offduty").style.display = "none";

}

document.onkeydown = function (evt) {
  evt = evt || window.event;
  var isEscape = false;
  if ("key" in evt) {
    isEscape = evt.key === "Escape" || evt.key === "Esc";
  } else {
    isEscape = evt.keyCode === 27;
  }
  if (isEscape) {
    post(`https://${GetParentResourceName()}/chiudi`);

    document.querySelector(".bg").style.display = "none";
    document.querySelector(".titolo").style.display = "none";
    document.querySelector(".onduty").style.display = "none";
    document.querySelector(".offduty").style.display = "none";
    
  }
};
