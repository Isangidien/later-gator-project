class UsersController < ApplicationController
  def new
   end

   def show
     if current_user.present?
       @user = params[:id] ? User.find(params[:id]) : current_user
       @user_bookmarks = @user.bookmarks
       @liked_bookmarks = @user.likes
     else
       redirect_to new_user_registration_path
     end
   end

   def index
     @users = User.all
   end
end
