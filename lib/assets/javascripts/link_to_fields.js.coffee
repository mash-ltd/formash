$ ->
  $('body').on 'click', '[data-link-to-fields]', (e) ->
    self = $(this)
    
    switch self.data('link-to-fields')
      when 'add'
        $(self.data('fields').replace(new RegExp("new_#{self.data('name')}", 'g'), new Date().getTime()).replace(/\\+n/g, '').replace(/\\+"/g, '"'))
        .appendTo(self.data('append-to'))
        .find('input:first').focus()
      when 'remove'
        self.prev('input[type=hidden]').val(1).closest(self.data('for')).hide()
    
    e.preventDefault()
