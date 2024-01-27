import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ['like']
  static values = {
    flat: Number
  }

  connect() {
  }

  add(event) {
    event.preventDefault()
    this.likeTarget.classList.toggle("fa-solid")
    this.likeTarget.classList.toggle("fa-regular")

    const url = `/flats/${this.flatValue}/likes/create`

    const content = {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify({ 'flat_id': this.flatValue })
    }

    fetch(url, content)
    .then(response => console.log(response.json()))
  }
}
