class Teacher < ActiveRecord::Base
  has_many :students
  has_secure_password
  has_many :grades, through: :students
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true
  accepts_nested_attributes_for :students, reject_if: :all_blank, allow_destroy: :true

end
