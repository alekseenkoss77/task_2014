# Concern для поиска. Поиск является полнотекстовым (postgresql Tsearch)
# gem textacular
# Поскольку используется для поиска в названии как в Meetings, так и в Users
# то сделан wrap scope для метода search по полю name.
# Модуль подключается в моделях Meeting and User

module Searchable
	extend ActiveSupport::Concern

	included do 
		default_scope {order('created_at DESC')}

  		scope :fulltext_search, -> (q){ self.search(name: q)}
	end
end