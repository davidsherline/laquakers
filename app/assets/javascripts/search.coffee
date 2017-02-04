# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $("#from").datepicker(datepickerOptions)
  .on "hide", (e) ->
    $("#to").datepicker("setStartDate", e.date)
  $("#to").datepicker(datepickerOptions)
  .on "hide", (e) ->
    $("#from").datepicker("setEndDate", e.date)

datepickerOptions =
  autoclose: true
  format: "yyyy-mm-dd"
  todayBtn: true
  todayHighlight: true
