class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :rememberable, :jwt_authenticatable, jwt_revocation_strategy: self



  enum role: { customer: 0, admin: 1 }
  
  has_many :reservations

  validates :role, presence: true

end
