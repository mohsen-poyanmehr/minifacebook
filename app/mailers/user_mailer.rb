class UserMailer < ApplicationMailer
    default :from => "moh_phar@yahoo.com"

def registration_confirmation(user)
    @user = user
        mail(:to => "#{user.name} <#{user.email}>", :subject => "Registration Confirmation")
    end
end
