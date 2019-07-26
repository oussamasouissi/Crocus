class User < ApplicationRecord
  has_many  :commandes
  validates :UserName, presence: true, length: {in: 2..20}, uniqueness: { case_sensitive: false} , :allow_blank => true
  validates :Name, presence: true, length: { in: 2..20 }
  validates :CIN, numericality: true ,length: { is: 8 }, uniqueness: { case_sensitive: false} ,:allow_blank => true
  validates :code_postal, numericality: true ,length: { is: 4 } ,:allow_blank => true
  validates :téléphone,  numericality: true ,length: { is: 8 } ,:allow_blank => true
  validates :adresse, length: {  mimimun: 10 , maximum: 30 } ,:allow_blank => true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
  :recoverable, :rememberable, :validatable ,:omniauthable, :omniauth_providers => [:facebook]

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?

        user.Name = data["name"] if user.Name.blank?

      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.Name = auth.info.name   # assuming the user model has a name
      user.UserName = auth.info.name
    end
  end  
end
