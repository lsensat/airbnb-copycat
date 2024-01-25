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


  dateRangeGenerator (start, end, step = 1) {
    let d = start;
    while (d < end) {
      yield new Date(d);
      d.setDate(d.getDate() + step);
    }
  };


  updatePrice(){
    const startTime = new Date(this.startTimeTarget.value)
    const endTime = new Date(this.endTimeTarget.value)
    let days = [...dateRangeGenerator(startTime, endTime)];
    console.log(days)

    // while (days[days.length - 1] < endTime.getUTCDate()){
    //   days.push(startTime.getUTCDate() + 1)
    // }
    console.log(endTime.getUTCDate() - startTime.getUTCDate())
    console.log("hello")
  }
}
