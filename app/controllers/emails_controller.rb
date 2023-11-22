require 'faker'

class EmailsController < ApplicationController
  def index
    @emails = Email.all
  end

  def new
    @email = Email.new
  end

  def show
    @email = Email.find(params[:id])
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @email = Email.create(object: Faker::Quote.famous_last_words, body: Faker::Quote.famous_last_words)
    render turbo_stream: turbo_stream.append('email-list', partial: 'emails/email', locals: { email: @email })
  end
end