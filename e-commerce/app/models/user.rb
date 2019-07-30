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
  :recoverable, :rememberable, :validatable ,:omniauthable, :omniauth_providers => [:facebook]
  scope :countUserAnnee, -> (y) { where("cast(strftime('%Y',created_at) as int) = ?", y).count()}
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

  def has_required_fields?
    self.description && self.nomSociete && self.numFournisseur
  end



  def self.calculPourcentageCreationComptes (countCurrentYear,countLastYear)
    ((countCurrentYear.to_f/countLastYear.to_f)-1 ) *100
  end

end
