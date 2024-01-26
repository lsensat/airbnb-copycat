import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  // Inform the controller that it has two targets in the form, which are our inputs
  static targets = [ "startTime", "endTime" ]
  static values = [ "price" ]

  connect() {
    flatpickr(this.startTimeTarget, {})
    flatpickr(this.endTimeTarget, {})
  }

  updatePrice(){
    const startTime = new Date(this.startTimeTarget.value)
    const endTime = new Date(this.endTimeTarget.value)

    // while (days[days.length - 1] < endTime.getUTCDate()){
    //   days.push(startTime.getUTCDate() + 1)
    // }
    console.log(endTime.getUTCDate() - startTime.getUTCDate())
    console.log("hello")
  }
}
