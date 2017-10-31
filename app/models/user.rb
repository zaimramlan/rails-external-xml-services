class User < ApplicationRecord
  validates :title, :name, :email,
            :presence => true
end
