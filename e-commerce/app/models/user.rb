class User < ApplicationRecord
  validates :UserName, presence: true, length: {in: 2..20}, uniqueness: { case_sensitive: false}
  validates :Name, presence: true, length: { in: 2..20 }
  validates :CIN, numericality: true ,length: { is: 8 }, uniqueness: { case_sensitive: false}
  validates :code_postal, numericality: true ,length: { is: 4 }   
  validates :téléphone,  numericality: true ,length: { is: 8 }
  validates :adresse, length: {  mimimun: 10 , maximum: 30 } 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  
end
