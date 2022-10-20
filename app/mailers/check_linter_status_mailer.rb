# frozen_string_literal: true

class CheckLinterStatusMailer < ApplicationMailer
  def send_mail
    @check = params[:check]
    @user = params[:user]

    mail(to: @user.email, subject: t('.subject'))
  end
end
