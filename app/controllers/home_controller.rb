class HomeController < ApplicationController
  def index
    @users_count = User.count
    @questions_count = Question.count
    @answers_count = Answer.count
    @tenants = Tenant.all
  end
end