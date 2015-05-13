# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@hideOptionsMenu = (menu) ->
  menu.removeClass("visible")
  menu.parent().children(".email-options-link").removeClass("invisible")

$ ->
  $(".hidden-header-toggle").click ->
    if $(this).data("clicked") == "no"
      $(this).data("clicked", "yes")
      $(this).text("Hide Extra Headers")
      $(this).parent().parent().find(".hidden-header").css("display", "block")
    else
      $(this).data("clicked", "no")
      $(this).text("Show Hidden Headers")
      $(this).parent().parent().find(".hidden-header").css("display", "none")
    hideOptionsMenu($(this).parent())
  $(".email-contents-quote-mode").click ->
    contents = $(this).parent().parent().parent().find(".the-content")
    contents.data("quote-mode", $(this).data("quote-mode"))
    contents.html(simpleFormat(contents.data($(this).data("quote-mode"))))
    $(this).parent().children(".email-contents-quote-mode").removeClass("active")
    $(this).addClass("active")
    hideOptionsMenu($(this).parent())
  $(".email-options-link").click ->
    $(this).addClass("invisible")
    $(this).parent().children(".email-options").addClass("visible")
  $(".close-options").click ->
    hideOptionsMenu($(this).parent())
  $(".email-unread-toggle").click ->
    if $(this).data("clicked") == "no"
      $(this).text("Mark Read")
      $(this).data("clicked","yes")
      $.ajax({
        url: $(this).data("url"),
        type: "put",
        data: "email[unread]=1"
      })
    else
      $(this).text("Mark Unread")
      $(this).data("clicked","no")
      $.ajax({
        url: $(this).data("url"),
        type: "put",
        data: "email[unread]=0"
      })
    hideOptionsMenu($(this).parent())
  $(".email-reply-link").click ->
    $.ajax({
      url: "/emails/reply.js",
      data: "id=" + $(this).data("email-id"),
      dataType: "script",
      success: "success"
    })