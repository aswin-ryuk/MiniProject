class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: [:google_oauth2]

  validates :username, presence: true, uniqueness: true

  validates :role, presence: true

  has_many :reports

  ROLES=[['Admin', 'admin'],['Guest','guest']]

  def admin?
  	self.role == 'admin'
  end

  def guest?
    self.role == 'guest'
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(username: data['name'],
           email: data['email'],
           role: 'admin',
           password: Devise.friendly_token[0,20]
        )
    end
    user
end


end
