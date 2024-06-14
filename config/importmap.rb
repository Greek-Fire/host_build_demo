# Pinning necessary modules
pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

# Pinning rails-ujs from a reliable CDN
pin "rails-ujs", to: "https://cdn.jsdelivr.net/npm/@rails/ujs@6.1.4/lib/assets/compiled/rails-ujs.js"

