import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submitBtn", "idTypeLabel", "idTypeControl"]

  connect() {
    this.element.querySelectorAll('input[name="id_type"]').forEach(radio => {
      radio.addEventListener("change", (e) => this.onIdTypeChange(e))
    })
  }

  onIdTypeChange(e) {
    if (this.hasIdTypeLabelTarget) {
      this.idTypeLabelTarget.textContent = e.target.value.toUpperCase()
    }
  }

  onSubmit() {
    if (this.hasSubmitBtnTarget) {
      this.submitBtnTarget.disabled = true
      this.submitBtnTarget.value = "Verifying…"
    }
  }

  onSubmitEnd() {
    if (this.hasSubmitBtnTarget) {
      this.submitBtnTarget.disabled = false
      this.submitBtnTarget.value = "Verify"
    }
  }
}
