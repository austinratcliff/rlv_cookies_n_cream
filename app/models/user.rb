class User < ApplicationRecord
  has_secure_password

  def self.full_name(user)
    user.first_name.capitalize + ' ' + user.last_name.capitalize
  end
end
