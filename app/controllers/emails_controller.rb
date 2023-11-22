require 'faker'

class EmailsController < ApplicationController
  def index
    @emails = Email.all
    @selected_email = Email.find(params[:id]) if params[:id].present?
    respond_to do |format|
      format.html
      format.turbo_stream { @selected_email = Email.find(params[:id]) }
    end
  end

  def new
    @email = Email.new
  end

  def show
    @selected_email = Email.find(params[:id])
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    email = Email.create(object: Faker::Quote.famous_last_words, body: Faker::Quote.famous_last_words)
    @selected_email = email
    render turbo_stream: turbo_stream.append('email-list', partial: 'emails/email', locals: { email: email })
  end

  def destroy
    @selected_email.destroy
    redirect_to emails_path
  end

  def mark_as_unread
    @selected_email.update(read: false)
    redirect_to emails_path
  end
end