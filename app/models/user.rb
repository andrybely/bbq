# Модель Пользователя
class User < ActiveRecord::Base
  # добавляем к юзеру функции Девайза, перечисляем конкретные наборы функций
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:vkontakte]

  # юзер может создавать много событий
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  # имя юзера должно быть, и не длиннее 35 букв
  validates :name, presence: true, length: {maximum: 35}

  # при создании нового юзера (create), перед валидацией объекта выполнить метод set_name
  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  def self.find_for_vkontakte_oauth(access_token)
    url = access_token.info.urls.Vkontakte
    provider = access_token.provider

    where(url: url, provider: provider).first_or_create! do |user|
      user.name = access_token.info.name
      user.email = "#{access_token.uid}@vk.com"
      user.password = Devise.friendly_token[0,20]
    end
  end

  private

  # задаем юзеру случайное имя, если оно пустое
  def set_name
    self.name = "User #{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end
end