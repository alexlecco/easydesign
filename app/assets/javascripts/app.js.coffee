$ = jQuery

$(document).on "ready page:load", ->
  $("#follow-btn").on "click", ->
    friend = $(this).data("friend")
    boton = $(this)
    $.ajax "/user/follow",
      type: "POST"
      dataType: "JSON"
      data: {user:{ friend_id: friend }}
      success: (data) ->
        console.log data
        boton.slideUp()
      error: (err) ->
        console.log err
        alert "No hemos podido crear la amistad"
