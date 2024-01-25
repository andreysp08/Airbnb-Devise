import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="searchflatautocomplete"
export default class extends Controller {
  
  static targets = ["results"]
  
  connect() {
    console.log("Connected!");
  }

  search() {

    const input = document.querySelector("#input-autocomplete");
    const url = `/flats/autocomplete?query=${input.value}`

      if (input.value.length >= 1) {
        console.log(url)
        fetch(url)
          .then((response) => response.json())
          .then((data) => {
            console.log(data)
            this.resultsTarget.innerHTML = "";  
            data.forEach((element) => {
              this.resultsTarget.insertAdjacentHTML("beforeend", `<li class="list-group-item">${element.name}: ${element.address}</li>`)
            });
          })
      } else {
        this.resultsTarget.innerHTML = "";
      }
  }
}
