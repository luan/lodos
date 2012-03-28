$ ->
  clearDatePickers = (except) ->
    ii = undefined
    ii = 0
    while ii < all.length
      all[ii].hide()  unless all[ii] is except
      ii++
  DatePicker = (element, options) ->
    @$el = $(element)
    @proxy("show").proxy("ahead").proxy("hide").proxy("keyHandler").proxy "selectDate"
    options = $.extend({}, $.fn.datepicker.defaults, options)
    if (!!options.parse) or (!!options.format) or not @detectNative()
      $.extend this, options
      @$el.data "datepicker", this
      all.push this
      @init()
  selector = "[data-datepicker]"
  all = []
  DatePicker:: =
    detectNative: (el) ->
      if navigator.userAgent.match(/(iPad|iPhone); CPU(\ iPhone)? OS 5_\d/i)
        $marker = $("<span>").insertBefore(@$el)
        @$el.detach().attr("type", "date").insertAfter $marker
        $marker.remove()
        return true
      false

    init: ->
      $months = @nav("months", 1)
      $years = @nav("years", 12)
      $nav = $("<div>").addClass("nav").append($months, $years)
      @$month = $(".name", $months)
      @$year = $(".name", $years)
      $calendar = $("<div>").addClass("calendar")
      i = 0

      while i < @shortDayNames.length
        $calendar.append "<div class=\"dow\">" + @shortDayNames[(i + @startOfWeek) % 7] + "</div>"
        i++
      @$days = $("<div>").addClass("days")
      $calendar.append @$days
      @$picker = $("<div>").click((e) ->
        e.stopPropagation()
      ).mousedown((e) ->
        e.preventDefault()
      ).addClass("datepicker").append($nav, $calendar).insertAfter(@$el)
      @$el.focus(@show).click(@show).change $.proxy(->
        @selectDate()
      , this)
      @selectDate()
      @hide()

    nav: (c, months) ->
      $subnav = $("<div>" + "<span class=\"prev button\">&larr;</span>" + "<span class=\"name\"></span>" + "<span class=\"next button\">&rarr;</span>" + "</div>").addClass(c)
      $(".prev", $subnav).click $.proxy(->
        @ahead -months, 0
      , this)
      $(".next", $subnav).click $.proxy(->
        @ahead months, 0
      , this)
      $subnav

    updateName: ($area, s) ->
      cur = $area.find(".fg").text()
      $fg = $("<div>").addClass("fg").append(s)
      $area.empty()
      unless cur is s
        $bg = $("<div>").addClass("bg")
        $area.append $bg, $fg
        $bg.fadeOut "slow", ->
          $(this).remove()
      else
        $area.append $fg

    selectMonth: (date) ->
      newMonth = new Date(date.getFullYear(), date.getMonth(), 1)
      if not @curMonth or not (@curMonth.getFullYear() is newMonth.getFullYear() and @curMonth.getMonth() is newMonth.getMonth())
        @curMonth = newMonth
        rangeStart = @rangeStart(date)
        rangeEnd = @rangeEnd(date)
        num_days = @daysBetween(rangeStart, rangeEnd)
        @$days.empty()
        ii = 0

        while ii <= num_days
          thisDay = new Date(rangeStart.getFullYear(), rangeStart.getMonth(), rangeStart.getDate() + ii, 12, 00)
          $day = $("<div>").attr("date", @format(thisDay))
          $day.text thisDay.getDate()
          $day.addClass "overlap"  unless thisDay.getMonth() is date.getMonth()
          @$days.append $day
          ii++
        @updateName @$month, @monthNames[date.getMonth()]
        @updateName @$year, @curMonth.getFullYear()
        $("div", @$days).click $.proxy((e) ->
          $targ = $(e.target)
          @update $targ.attr("date")
          @hide()  unless $targ.hasClass("overlap")
        , this)
        $("[date='" + @format(new Date()) + "']", @$days).addClass "today"
      $(".selected", @$days).removeClass "selected"
      $("[date=\"" + @selectedDateStr + "\"]", @$days).addClass "selected"

    selectDate: (date) ->
      date = @parse(@$el.val())  if typeof (date) is "undefined"
      date = new Date()  unless date
      @selectedDate = date
      @selectedDateStr = @format(@selectedDate)
      @selectMonth @selectedDate

    update: (s) ->
      @$el.val(s).change()

    show: (e) ->
      e and e.stopPropagation()
      clearDatePickers this
      offset = @$el.offset()
      @$picker.css(
        top: offset.top + @$el.outerHeight() + 2
        left: offset.left
      ).show()
      #$("html").on "keydown", @keyHandler

    hide: ->
      @$picker.hide()
      #$("html").off "keydown", @keyHandler

    keyHandler: (e) ->
      switch e.keyCode
        when 9, 27
          @hide()
          return
        when 13
          @update @selectedDateStr
          @hide()
        when 38
          @ahead 0, -7
        when 40
          @ahead 0, 7
        when 37
          @ahead 0, -1
        when 39
          @ahead 0, 1
        else
          return
      e.preventDefault()

    parse: (s) ->
      m = undefined
      if m = s.match(/^(\d{4,4})-(\d{2,2})-(\d{2,2})$/)
        new Date(m[1], m[2] - 1, m[3])
      else
        null

    format: (date) ->
      month = (date.getMonth() + 1).toString()
      dom = date.getDate().toString()
      month = "0" + month  if month.length is 1
      dom = "0" + dom  if dom.length is 1
      date.getFullYear() + "-" + month + "-" + dom

    ahead: (months, days) ->
      @selectDate new Date(@selectedDate.getFullYear(), @selectedDate.getMonth() + months, @selectedDate.getDate() + days)

    proxy: (meth) ->
      this[meth] = $.proxy(this[meth], this)
      this

    daysBetween: (start, end) ->
      start = Date.UTC(start.getFullYear(), start.getMonth(), start.getDate())
      end = Date.UTC(end.getFullYear(), end.getMonth(), end.getDate())
      (end - start) / 86400000

    findClosest: (dow, date, direction) ->
      difference = direction * (Math.abs(date.getDay() - dow - (direction * 7)) % 7)
      new Date(date.getFullYear(), date.getMonth(), date.getDate() + difference)

    rangeStart: (date) ->
      @findClosest @startOfWeek, new Date(date.getFullYear(), date.getMonth()), -1

    rangeEnd: (date) ->
      @findClosest (@startOfWeek - 1) % 7, new Date(date.getFullYear(), date.getMonth() + 1, 0), 1

  $.fn.datepicker = (options) ->
    @each ->
      new DatePicker(this, options)

  $ ->
    $(selector).datepicker()
    $("html").click clearDatePickers

  $.fn.datepicker.DatePicker = DatePicker
  $.fn.datepicker.defaults =
    monthNames: [ "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro" ]
    shortDayNames: [ "Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab" ]
    startOfWeek: 1
(window.jQuery or window.ender)

$ ->
  $.extend $.fn.datepicker.defaults,
    parse: (string) ->
      matches = undefined
      if matches = string.match(/^(\d{2,2})\/(\d{2,2})\/(\d{4,4})$/)
        new Date(matches[3], matches[2] - 1, matches[1])
      else
        null

    format: (date) ->
      month = (date.getMonth() + 1).toString()
      dom = date.getDate().toString()
      month = "0" + month  if month.length is 1
      dom = "0" + dom  if dom.length is 1
      dom + "/" + month + "/" + date.getFullYear()
