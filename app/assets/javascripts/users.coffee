$ ->
  overw = $('.overlay.light')
  overd = $('.overlay.dark')
  over_cont= $('.overlay-dark-container')
  list = $('.users-list ul')

  male_cb = $('.sidebar .male-cb')
  female_cb = $('.sidebar .female-cb')

  current_page = 1
  filter = {age:'',gender:''}

  show_popup  = (popup) ->
    overd.removeClass('is-hidden')
    over_cont.removeClass('is-hidden')
    over_cont.append(popup)
    popup.removeClass('is-hidden')
    popup.addClass('is-popup')
    $('body').addClass('is-overlayed')
    
  hide_popup = (popup) ->
    popup.addClass('is-hidden')
    over_cont.addClass('is-hidden')
    overd.addClass('is-hidden')
    popup.removeClass('is-popup')
    $('.popups-container').append(popup)
    

  load_users = ->
    return if current_page == 0
    q = $("#q_").val()
    $.ajax(url: '/api/users.json', type: "GET", dataType: "json", data: {q: q, page: current_page, per_page: 300, filter: {age: filter.age, gender: filter.gender}}, success: (data) ->
      list.append(JST['templates/users/user_item'](u)) for u in data.users
      
      current_page+=1
      if data.pagination.total_pages == current_page-1
        $('.main .load-more .link').hide()
        current_page = 0 
      )

  apply_filter = ->
    current_page = 1
    $('.main .load-more .link').show()
    list.empty()

    filter['age'] = $('.sidebar .age-field input').val()
    m = $('.sidebar .male-cb input').val()|0
    f = $('.sidebar .female-cb input').val()|0

    if m+f == 1
      filter['gender'] = if m>0 then 1 else 0
    else
      filter['gender'] = ''
   
    load_users()


  $('.main .load-more .link').on 'click', (e) ->
    load_users()
    return

  $('.sidebar .apply-btn').on 'click', ->
    apply_filter()

  $("#q_").on 'change', -> 
    list.empty()
    current_page=1
    load_users()

  male_cb.on 'click', (e) ->
    checkbox_input = male_cb.find('input')
    checked = checkbox_input.val()|0
    if checked
      male_cb.removeClass('is-selected')
      checkbox_input.val(0)
    else
      male_cb.addClass('is-selected')
      checkbox_input.val(1)

  female_cb.on 'click', (e) ->
    checkbox_input = female_cb.find('input')
    checked = checkbox_input.val()|0
    if checked
      female_cb.removeClass('is-selected')
      checkbox_input.val(0)
    else
      female_cb.addClass('is-selected')
      checkbox_input.val(1)

  load_users()