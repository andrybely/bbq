# Модель пользователя
class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # юзер может создавать много событий
  has_many :events

  # имя юзера должно быть, и не длиннее 35 букв
  validates :name, presence: true, length: {maximum: 35}

  before_validation :set_name, on: :create

  private

  def set_name
    self.name = "User #{rand(777)}" if self.name.blank?
  end
end
