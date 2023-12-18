import "@hotwired/turbo-rails"
import "controllers"

const Mime = {
  turbo_stream: "text/vnd.turbo-stream.html",
  html:         "text/html",
  json:         "application/json",
}

document.addEventListener('turbo:submit-start', function (event) {
  const {
    detail: {
      formSubmission: {
        fetchRequest: { headers },
        submitter: { dataset: { accept } },
      },
    },
  } = event

  if (Mime[accept]) {
    headers["Accept"] = Mime[accept]
  }
})