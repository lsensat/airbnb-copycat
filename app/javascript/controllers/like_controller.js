import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ['liked', 'unlike']

  connect() {
  }

  add(event) {
    event.preventDefault()
    console.log("hello world")
    this.unlikeTarget.classList.toggle("fa-solid")
    this.unlikeTarget.classList.toggle("fa-regular")

  }
}
