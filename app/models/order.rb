class Order < ApplicationRecord
  belongs_to :end_user
  has_many :order_details

  enum payment_method: { bank_transfer: 0, credit: 1 }
  enum sales_order_status: { wating_for_payment: 0, confirmation_of_payment: 1, in_production: 2, preparing_to_ship: 3, shipped: 4 }
end
