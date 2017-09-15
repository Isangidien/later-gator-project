class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user =  User.find_by(email: params[:sender])
    @topic = Topic.find_by(title: params[:subject])

    @url = params["body-plain"]

    if @user.nil?
      @user = User.create(email: params[:sender], password: 'mycode2017')
    end

    if @topic.nil?
      @topic = Topic.create(title: params[:subject], user_id: @user)
    end

    @bookmark = @topic.bookmarks.create(url: @url)


    head 200
  end
end
