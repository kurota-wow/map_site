// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"
import jQuery from "jquery";
window.$ = window.jQuery = jQuery;
import("./custom/main.js")
import("./custom/wave.js")