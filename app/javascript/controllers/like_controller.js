import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ['like']

  connect() {
  }

  add(event) {
    event.preventDefault()
    console.log("hello world")
    this.likeTarget.classList.toggle("fa-solid")
    this.likeTarget.classList.toggle("fa-regular")

    const postId = this.data.get("postId");

    // Use fetch for Ajax request
    fetch(`/likes?post_id=${postId}`, { method: "POST", headers: { "Content-Type": "application/json" } })
      .then(response => {
        if (response.ok) {
          return response.json(); // Parse JSON response
        } else {
          throw new Error("Failed to like");
        }
      })
      .then(data => {
        console.log(data); // Handle successful response
        // Update UI or handle success
        this.likeButtonTarget.textContent = "Unlike";
      })
      .catch(error => {
        console.error(error); // Handle error
      });
  }
}
