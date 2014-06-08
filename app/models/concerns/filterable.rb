# coding: utf-8

# поскольку с английским хреновато на письмо (пока только читаю тех.лит.)
# развернутые комментарии напишу на русском.
# Первоначальный фильтр был в контроллере, после недолгих размышлений был перенесен 
# модель, а затем и воовсе в concern - дабы не засорять модель.
# собственно описаны вспомогательные скоупы на разныве случаи жизни
# метод filter_age - сложный фильтр по возрасту (задание по тестам)
# принимает на вход строку, например ">50" - и выводит всех юзеров с возрастом больше 50
# собственно так же работает и "<50" и например "< 30 && > 50". Работает через парсинг шаблонов
# так как времени не особо много было, сделал все оч просто.
#
# Метод filter - непосредственно все фильтрует, он используется сейчас напрямую в контроллере
# users_controller в экшене index
# по сути берет параметры, проверяет есть ли значения, и если значения из фильтра не пустые
# вызывает нужный scope

module Filterable
	extend ActiveSupport::Concern
	
	included do
	  scope :gender, 			-> (gender) { where gender: gender }
	  scope :age, 				-> (age) { where age: age }
	  scope :age_more,  		-> (age) { where("age > ?", age.to_i) }
	  scope :age_less,  		-> (age) { where('age < ?', age.to_i) }
	  #scope :age_less_and_more, -> (age_less, age_more) { where(age: age_less.to_i..age_more.to_i) }
	  scope :age_more_and_less, -> (age_less, age_more) { where("age > ? AND age < ?", age_less.to_i, age_more.to_i) }
	  scope :male, 				-> { self.gender(MALE) }
	  scope :female, 			-> { self.gender(FEMALE) }
	end

	module ClassMethods
		def filter(filter_params)
		  	users = self.all
		  	users = users.gender(filter_params[:gender].to_i) unless filter_params[:gender].blank?
		  	users = users.filter_age(filter_params[:age].to_s) unless filter_params[:age].blank?
		  	return users
	    end

	    def filter_age(age_params)
		  	params = age_params.to_s.gsub(/\s*/,'')
		  	case params
		  		when /^\d+$/
		  			self.age(params[/\d+/])
		  		when /^<\d+$/ 
		  			self.age_less(params[/\d+/].to_i)
		  		when /^>\d+$/
					self.age_more(params[/\d+/].to_i)
		  		when /^>\d+&&<\d+$/
		  			range = params.split('&&')
		  			self.age_more_and_less(range[0][/\d+/].to_i, range[1][/\d+/].to_i)
			end
  		end
	end
end