# Модель события
class Event < ActiveRecord::Base
  # событие принадлежит юзеру
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photos, dependent: :destroy

  # юзера не может не быть
  validates :user, presence: true

  # заголовок должен быть, и не длиннее 255 букв
  validates :title, presence: true, length: {maximum: 255}

  # также у события должны быть место и время проведения
  validates :address, presence: true
  validates :datetime, presence: true

  def visitors
    (subscribers + [user]).uniq
  end

  def pincode_valid?(pin2check)
    pincode == pin2check
  end
end

