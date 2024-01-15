import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  // Inform the controller that it has two targets in the form, which are our inputs
  static targets = [ "startTime", "endTime", "priceTotal" ]
  static values = [ "price" ]

  connect() {
    flatpickr(this.startTimeTarget, {})
    flatpickr(this.endTimeTarget, {})
  }

  updatePrice(){
    const startTime = new Date(this.startTimeTarget.value)
    const endTime = new Date(this.endTimeTarget.value)
    console.log(startTime.getUTCDate() - endTime.getUTCDate())
    this.priceTotalTarget.value = (startTime.getUTCDate() - endTime.getUTCDate())
  }
}
