$ ->
  success_rate = $("#test_success_rate_bar").data("rate")
  console.log success_rate
  $("#success_rate").width(success_rate + "%")
  $("#failure_rate").width((100 - success_rate) + "%")
