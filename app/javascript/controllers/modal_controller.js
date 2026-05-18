import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "backdrop"]

  connect() {
    document.body.style.overflow = "hidden"
  }

  disconnect() {
    document.body.style.overflow = ""
  }

  close() {
    // Animate out then clear the modal DOM — one-time view enforcement
    this.element.classList.add("opacity-0", "transition-opacity", "duration-150")
    setTimeout(() => {
      this.element.innerHTML = ""
    }, 150)
    document.body.style.overflow = ""
  }

  backdropClose(e) {
    if (e.target === this.element || e.target === this.backdropTarget) {
      this.close()
    }
  }
}
