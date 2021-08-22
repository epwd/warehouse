class Delivery < ApplicationRecord
  include AASM

  belongs_to :product
  belongs_to :sklad

  aasm do
    state :inprocess, initial: true
    state :delivered

    event :deliver do
      transitions from: [:inprocess], to: :delivered
    end
  end

end
