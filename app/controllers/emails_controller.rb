class EmailsController < ApplicationController
  def index
    @emails = Email.all
  end

  def create
    Email.create(object: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
    redirect_to emails_path, notice: "Nouvel email !"
  end
end
