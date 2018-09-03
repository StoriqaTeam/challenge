class User < ApplicationRecord
  has_many :suite_solutions, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[github]

  def self.from_omniauth(data)
    if data["provider"] == "github"
      u = User.new
      u.email = data.dig("info", "email")
      u.provider = "github"
      u.uid = data["uid"]
      u
    end
  end
end
