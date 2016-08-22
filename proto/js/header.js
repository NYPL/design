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
  $(".search-query-text, .search-type, .search-button, .search-radio-label").focus(function() {
    if (hideTimeout) clearTimeout(hideTimeout)
    showSearch()
  })
  $(".search-query-text, .search-type, .search-button, .search-radio-label").blur(function() {
    hideTimeout = setTimeout(hideSearch, 100)
  })
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