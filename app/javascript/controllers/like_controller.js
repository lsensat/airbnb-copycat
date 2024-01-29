import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ['like']
  static values = {
    flat: Number,
    likeId: Number
  }

  connect() {
  }

  add(event) {
    event.preventDefault()
    // this.likeTarget.classList.toggle("fa-solid")
    // this.likeTarget.classList.toggle("fa-regular")

    const url = `/flats/${this.flatValue}/likes`
    const token = document.head.querySelector("meta[name=csrf-token]").content

    const content = {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify({
        "flat": this.flatValue,
        // "X-CSRF-Token": token
      })
    }

    fetch(url, content)
    .then(response => {
      return response.json()
    })
    .then(data => {
      if (data.status === 'success'){
        this.likeTarget.classList.toggle("fa-solid")
        this.likeTarget.classList.toggle("fa-regular")
      }
    })
  }

  delete(event) {
    event.preventDefault()
    const url = `/flats/${this.flatValue}/likes/${this.likeIdValue}`

    const content = {
      method: "DELETE",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify({
        "like_id": this.likeIdValue,
      })
    }

    fetch(url, content)
    .then(response => {
      console.log(response)
      return response.json()
    })
    .then(data => {
      if (data.status === 'success'){
        this.likeTarget.classList.toggle("fa-solid")
        this.likeTarget.classList.toggle("fa-regular")
      }
    })
  }
}
