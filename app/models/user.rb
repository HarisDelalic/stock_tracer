class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end

  def self.search(search_param)
    search_param.strip!
    search_param.downcase!
    found_users = (first_name_matches(search_param) + last_name_matches(search_param) + email_matches(search_param)).uniq
    return nil unless found_users
    found_users
  end

  def self.first_name_matches(search_param)
    matches('first_name', search_param)
  end

  def self.last_name_matches(search_param)
    matches('last_name', search_param)
  end

  def self.email_matches(search_param)
    matches('email', search_param)
  end

  def self.matches(field_name, search_param)
    User.where("#{field_name} like ?", "%#{search_param}%")
  end

  def except_current_user(users)
   users.reject { |user| user.id == self.id }
  end

  def not_friends_with?(friend_id)
    Friendship.where(friend_id: friend_id).count < 1
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    # unless user
    #     user = User.create(name: data['name'],
    #        email: data['email'],
    #        password: Devise.friendly_token[0,20]
    #     )
    # end
    user
  end
end
