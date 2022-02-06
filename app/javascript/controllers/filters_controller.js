import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["form"]
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
        this.formTarget.requestSubmit()
    }, 500)
  }
}