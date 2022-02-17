/*
 * Persist scroll position on forms and links where data-action='persistent-scroll#savePosition' is set
 */

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["element"]

  initialize() {
    if (typeof window.persistentScroll === 'undefined') { this.setDefaultGlobal() }
  }

  connect() {
    setTimeout(() => {
      this.loadPosition()
      this.setDefaultGlobal()
    }, 1)
  }

  savePosition() {
    window.persistentScroll.document = { top: document.scrollingElement.scrollTop, left: document.scrollingElement.scrollLeft }

    this.elementTargets.forEach((element) => {
      window.persistentScroll.elements[element.id] = { top: element.scrollTop, left: element.scrollLeft }
    })
  }

  loadPosition() {
    if (document.URL.split("#").pop()) return // anchor tag in url

    document.scrollingElement.scrollTo(window.persistentScroll.document)

    for (const id in window.persistentScroll.elements) {
      document.getElementById(id)?.scrollTo(window.persistentScroll.elements[id])
    }
  }

  setDefaultGlobal() {
    window.persistentScroll = { document: { top: 0, left: 0 }, elements: {} }
  }
}
