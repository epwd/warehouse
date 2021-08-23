class Delivery < ApplicationRecord
  include AASM

  belongs_to :product
  belongs_to :sklad

  aasm do
    state :inprocess, initial: true
    state :delivered
    state :failed

    event :deliver do
      transitions from: [:inprocess], to: :delivered
    end

    event :fail do
      transitions from: [:inprocess], to: :failed
    end
  end
end
