Lodos.Task = DS.Model.extend
  primaryKey: '_id'
  description: DS.attr('string')
  done: DS.attr('boolean')
  created_at: DS.attr('date')
  
  doneChanged: (->
    Lodos.store.commit()
  ).observes('done')

  formattedCreatedAt: (->
    date = @get 'created_at'
    return "" unless date
    d = 
      year: date.getFullYear()
      month: date.getMonth().toString()
      day: date.getDate().toString()
      hours: date.getHours().toString()
      minutes: date.getMinutes().toString()

    keys = "month day hours minutes".w()
    for key in keys
      d[key] = "0#{d[key]}" if d[key].length is 1

    "#{d.year}-#{d.month}-#{d.day} #{d.hours}:#{d.minutes}"
  ).property('created_at')

  createdAt: (-> @created_at).property('created_at')
  
  delete: ->
    @deleteRecord()
    Lodos.store.commit()
