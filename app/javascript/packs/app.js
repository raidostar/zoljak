import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'

import Navigation from './components/navigation.vue'
import Maintitle from './components/maintitle.vue'
import Searchbar from './components/searchbar.vue'
import Registration from './components/registration.vue'

import axios from 'axios'

import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

// require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

Vue.config.productionTip = false

document.addEventListener('turbolinks:load', () => {
  var element_app = document.getElementById("app")
  var element_sign_in = document.getElementById("sign_in")
  if(element_app != null){
    var app = new Vue({
      el: '#app',
      components: { 
        Navigation,
        Maintitle,
        Searchbar,
      },
      mixin: [TurbolinksAdapter, BootstrapVue]
    })
  }
  if(element_sign_in != null){
    var sign_in = new Vue({
      el: '#sign_in',
      components: { 
        Maintitle,
        Registration,
      },
      mixin: [TurbolinksAdapter, BootstrapVue]
    })
  }
})