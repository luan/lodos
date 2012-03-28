window.gravatar = (email, size) ->
  size = size or 80
  "http://www.gravatar.com/avatar/" + MD5(email) + ".jpg?s=" + size
