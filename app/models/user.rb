class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :posts
  has_many :friendships

  has_many :follows, through: :friendships, source: :friend

  has_many :followers_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :followers, through: :followers_friendships, source: :user

  def follow!(friend_id)
    friendships.create!(friend_id: friend_id)
  end

  def can_follow?(friend_id)
    not friend_id == self.id or friendships.where(friend_id: friend_id).size > 0
  end

  # el email ya no es necesario para crear un usuario
  def email_required?
    false
  end

  validates :username, presence: true, uniqueness: true,
  length: { in: 5..20,
    too_short: "El usuario debe tener al menos 5 caracteres",
    too_long: "El usuario no debe superar los 20 caracteres" },
    format: { with: /([A-Za-z0-9\-\_]+)/, message: "El usuario puede contener solo letras, numeros y guiones" }

  #validación personalizada
  #validate: :validacion_personalizada, on: :create


  def self.find_or_create_by_omniauth(auth)
    user = User.where(provider: auth[:provider], uid: auth[:uid]).first

    unless user
      usuario = User.create(
        firstname: auth[:firstname],
        lastname:  auth[:lastname],
        username:  auth[:username],
        email:     auth[:email],
        uid:       auth[:uid],
        provider:  auth[:provider],
        password:  Devise.friendly_token[0,20]
      )
    end
    user
  end

=begin
  private
  def validacion_personalizada
    if true

    else
      errors.add(:username, "Tu usuario no es valido")
    end
  end
=end
end
