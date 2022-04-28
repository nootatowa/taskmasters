class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :tasks, dependent: :destroy
         has_many :task_comments, dependent: :destroy
         has_many :favorites, dependent: :destroy
          validates :name, length: { in: 1..20 }
end
