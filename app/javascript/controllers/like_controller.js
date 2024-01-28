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

    const url = `/flats/${this.flatValue}/likes`
    const token = document.querySelector('meta[name="csrf-token"]').content;
    console.log(token)

    const content = {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify({
        "flat_id": this.flatValue,
        'X-CSRF-Token': token,
      })
    }

    fetch(url, content)
    .then(response => {
      console.log(response),
      response.json()})
    .then(data => {
      console.log(data)
      if (data.status === 'success') {
        // Handle success
        console.log('Success:', data);
      } else {
        // Handle errors
        console.error('Error:', data.errors);
      }
    })
    .catch(error => console.error('Error:', error));
  }

  delete(event) {
    event.preventDefault()
    this.likeTarget.classList.toggle("fa-solid")
    this.likeTarget.classList.toggle("fa-regular")

    const url = `/flats/${this.flatValue}/likes`
    const token = document.querySelector('meta[name="csrf-token"]').content;
    console.log(token)

    const content = {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify({
        "flat_id": this.flatValue,
        'X-CSRF-Token': token,
      })
    }

    fetch(url, content)
    .then(response => {
      console.log(response),
      response.json()})
    .then(data => {
      console.log(data)
      if (data.status === 'success') {
        // Handle success
        console.log('Success:', data);
      } else {
        // Handle errors
        console.error('Error:', data.errors);
      }
    })
    .catch(error => console.error('Error:', error));
  }
}
