class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # el email ya no es necesario para crear un usuario
  def email_required?
    false
  end

  devise :omniauthable, omniauth_providers: [:facebook, :twitter]

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
