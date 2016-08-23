var hideTimeout

function init() {
  $("input[type=radio]").click(function() {
    updateSearchRadio($(this).val())
  })
  $("#search-query-text").focus(function() {
    showSearch()
  })
  $("input[type=radio]").focus(function() {
    focusRadio($(this).val())
  })
  $("input[type=radio]").blur(function() {
    blurRadio($(this).val())
  })
  $("#search-query-text, .search-type, .search-button, .search-radio-label").focus(function() {
    if (hideTimeout) clearTimeout(hideTimeout)
    showSearch()
  })
  $("#search-query-text, .search-type, .search-button, .search-radio-label").blur(function() {
    hideTimeout = setTimeout(hideSearch, 100)
  })
  $(".email-toggle a").click(function(e) {
    if ($(e.target).closest('.email-toggle').length && !$(e.target).parents("#email-updates").length) {
      toggleEmail()
    }
  })
  $("body").click(function(e) {
    if (!$(e.target).closest('.email-toggle').length && !$(e.target).parents("#email-updates").length) {
      hideEmail()
    }
    if (!$(e.target).closest('.login-toggle').length && !$(e.target).parents("#login-links").length) {
      hideLogin()
    }
  })
  $(".login-toggle a").click(function(e) {
    if ($(e.target).closest('.login-toggle').length && !$(e.target).parents("#login-links").length) {
      toggleLogin()
    }
  })
}

function toggleLogin() {
  $(".login-toggle a").toggleClass("active")
  $(".login-toggle div").toggleClass("hidden")
}

function hideLogin() {
  $(".login-toggle a").removeClass("active")
  $(".login-toggle div").addClass("hidden")
}

function toggleEmail() {
  $(".email-toggle a").toggleClass("active")
  $(".email-toggle form").toggleClass("hidden")
}

function hideEmail() {
  $(".email-toggle a").removeClass("active")
  $(".email-toggle form").addClass("hidden")
}

function updateSearchRadio(type) {
  $(".search-radio-label").removeClass("selected")
  $(".search-radio-label[for="+type+"]").addClass("selected")
}

function hideSearch() {
  $("#search-query-text").removeClass("active")
  $(".search-select").addClass("hidden")
}

function focusRadio(type) {
  blurRadio(type)
  $(".search-radio-label[for="+type+"]").addClass("focus")
}

function blurRadio(type) {
  $(".search-radio-label").removeClass("focus")
}

function showSearch() {
  $("#search-query-text").addClass("active")
  $(".search-select").removeClass("hidden")
  // $("ul.nav-buttons li.search").toggleClass("hidden")
  // $("ul.nav-buttons li.search a").toggleClass("hidden")
  // $("#main-search").toggleClass("display")
  // $("#main-search .search-query-text").focus()
}

$(function () {
  init();
})