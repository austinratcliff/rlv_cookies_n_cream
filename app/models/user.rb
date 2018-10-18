class User < ApplicationRecord
  def self.full_name(user)
    user.first_name.capitalize + ' ' + user.last_name.capitalize
  end
end
