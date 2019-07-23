class MessageMailer < ApplicationMailer

  def contact_me(message)
      @body = message.body

      mail(:to => "admin@gmail.com" ,  from: message.email , :subject => message.sujet)

    end
  
end

