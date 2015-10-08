class Parent < ActiveRecord::Base
  has_one :student
  has_secure_password
  validates :student_id, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true
end
