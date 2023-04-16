import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post"
export default class extends Controller {
  static targets = [ "posts" ]

  connect() {
    console.log("post controller connected")
  }

  // Connects to data-action="post#showAll"
  showAll() {
    console.log("show all")
    fetch("/posts")
      .then(response => response.text())
      .then(html => this.postsTarget.innerHTML = html)
  }

  // Connects to data-action="post#showFriends"
  showFriends() {
    console.log("show friends")
    fetch("/posts" + "?filter=friends")
      .then(response => response.text())
      .then(html => this.postsTarget.innerHTML = html)
  }
}
