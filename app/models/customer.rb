class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :tasks, dependent: :destroy
         has_many :task_comments, dependent: :destroy
          has_many :favorites, dependent: :destroy
          validates :name, length: { in: 1..20 }



  def update_level
    update(experience_point: experience_point + 2)
    result = LevelSetting.where("threshold <= ?", experience_point)
      if  result.any?
        self.level != result.last.level
        self.level = result.last.level
        self.save
      end
  end

  def update_task_level
    update(experience_point: experience_point + 5)
    result = LevelSetting.where("threshold <= ?", experience_point)
      if  result.any?
        self.level != result.last.level
        self.level = result.last.level
        self.save
      end
  end
end
