class Student < ActiveRecord::Base
  has_many :parents
  has_many :grades
  belongs_to :teachers
  has_secure_password
  validates :teacher_id, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true
end
