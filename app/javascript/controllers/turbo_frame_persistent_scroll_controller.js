/*
 * Loads Position for a specific turbo frame
 * use persistent-scroll-controller to save the position
 */

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    for (const id in window.persistentScroll) {
      document.getElementById(id)?.scrollTo(window.persistentScroll[id])
    }
  }
}
