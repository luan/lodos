Lodos.Task = DS.Model.extend
  primaryKey: '_id'
  description: DS.attr('string')
  done: DS.attr('boolean')
  deadline: DS.attr('date')
  created_at: DS.attr('date')

  formattedCreatedAt: (->
    date = @get 'created_at'
    @formatDate(date)
  ).property('created_at')

  formattedDeadline: (->
    date = @get 'deadline'
    @formatDate(date)
  ).property('deadline')

  createdAt: (-> @created_at).property('created_at')

  deadlineChanged: (->
    [date, time] = @formatDate(@get 'deadline').split(' ')
    @set 'deadlineDate', date
    @set 'deadlineTime', time
  ).observes('deadline')

  formatDate: (date) ->
    return "" unless date
    d = 
      year: date.getFullYear()
      month: (date.getMonth() + 1).toString()
      day: date.getDate().toString()
      hours: date.getHours().toString()
      minutes: date.getMinutes().toString()

    keys = "month day hours minutes".w()
    for key in keys
      d[key] = "0#{d[key]}" if d[key].length is 1

    "#{d.month}/#{d.day}/#{d.year} #{d.hours}:#{d.minutes}"
  
  delete: ->
    @deleteRecord()
    Lodos.store.commit()
