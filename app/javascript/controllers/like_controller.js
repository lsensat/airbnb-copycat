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
      }
    })
  }

  // delete(event) {
  //   event.preventDefault()
  //   const url = `/flats/${this.flatValue}/likes`

  //   const content = {
  //     method: "DELETE",
  //     headers: {"Content-Type": "application/json"}
  //   }
  //   this.likeTarget.classList.toggle("fa-regular")

  //   fetch(url, content)
  //   .then(response => {
  //     console.log(response),
  //     console.log(response.ok)
  //   })
  // }
}
