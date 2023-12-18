import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "list"]

  connect() {
    console.log("Connected to PostsController")
  }
}
