class Parent < ActiveRecord::Base
  belongs_to :student
  has_many :teachers, through: :student
  has_many :grades, through: :student
  has_secure_password
  validates :student_id, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true
end
