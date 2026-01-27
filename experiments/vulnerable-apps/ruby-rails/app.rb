class UsersController < ApplicationController
  def show
    @user = User.find_by("name = '#{params[:name]}'")
    render inline: "<h1>#{params[:name]}</h1>"
  end
end
