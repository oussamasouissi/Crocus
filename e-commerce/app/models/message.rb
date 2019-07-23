class Message
    include ActiveModel::Model
    attr_accessor :sujet, :email, :body
    validates :sujet, :email, :body, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 


  end