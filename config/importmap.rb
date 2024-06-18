# config/importmap.rb
pin "application", to: "application.js"
pin_all_from "app/javascript/controllers", under: "controllers"
