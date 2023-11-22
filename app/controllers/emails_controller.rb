require 'faker'

class EmailsController < ApplicationController
  def index
    @emails = Email.all
    @selected_email = Email.find(params[:id]) if params[:id].present?
    respond_to do |format|
      format.html
      format.turbo_stream do
        if params[:id].present?
          @selected_email = Email.find(params[:id])
        else
          @selected_email = nil
        end
        render turbo_stream: turbo_stream.replace(
          "selected-email",
          partial: "emails/email",
          locals: { email: @selected_email }
        )
      end
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
    email = Email.create(object: Faker::Quote.famous_last_words, body: Faker::Quote.matz)
    @selected_email = email
    render turbo_stream: turbo_stream.append('email-list', partial: 'emails/email', locals: { email: email })
  end

  def destroy
    @selected_email = Email.find(params[:id])
    @selected_email.destroy
    redirect_to emails_path
  end

  def update
    @selected_email = Email.find(params[:id])
    @selected_email.update(read: !@selected_email.read)
    redirect_to emails_path(id: @selected_email.id)
  end
end