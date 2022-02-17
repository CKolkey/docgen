/*
 * Persist scroll position on forms and links where data-action='persistent-scroll#savePosition' is set
 */

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["element"]

  initialize() {
    if (typeof window.persistentScroll === 'undefined') { this.setDefaultGlobal() }
  }

  savePosition() {
    this.elementTargets.forEach((element) => {
      window.persistentScroll[element.id] = { top: element.scrollTop, left: element.scrollLeft }
    })
  }

  setDefaultGlobal() {
    window.persistentScroll = {}
  }
}
