$(document).ready ->
	timezone = $.fn.get_timezone();
	$('#timezone_name').text(timezone)

	delay = (ms, func) -> setTimeout func, ms

	insertZero = (item) ->
		item = '0' + item if item < 10
		return item

	showTime = ->
		time_now = new Date()
		hour = time_now.getHours()
		min = time_now.getMinutes()
		sec = time_now.getSeconds()
		$('#clock').text([insertZero(hour),insertZero(min),insertZero(sec)].join(':'))
		delay 500, -> showTime()

	showTime()