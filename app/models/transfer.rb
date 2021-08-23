class Transfer < ApplicationRecord
  include AASM
  serialize :products, Array

  belongs_to :product, optional: true
  belongs_to :src, class_name: 'Sklad', :foreign_key => 'src_sklad'
  belongs_to :dst, class_name: 'Sklad', :foreign_key => 'dst_sklad'

  aasm do
    state :created, initial: true
    state :inprocess
    state :transferred
    state :failed

    event :process do
      transitions from: [:created], to: :inprocess
    end

    event :transfer do
      transitions from: [:created,:inprocess], to: :transferred
    end

    event :fail do
      transitions from: [:created, :inprocess], to: :failed
    end
  end
end
