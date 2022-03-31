class Address < ApplicationRecord
  belongs_to :end_user

  def full_address
    self.postal_code + self.address + self.name
  end

end
