class HistoryTransfer < ApplicationRecord
	belongs_to :src, class_name: 'Sklad', :foreign_key => 'src'
	belongs_to :dst, class_name: 'Sklad', :foreign_key => 'dst'
end
