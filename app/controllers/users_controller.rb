class UsersController < ApplicationController
  @nickname = current_user.nickname
  @tweets = current_user.tweets.page(params[:page]).per(5).order("created_at DESC")
  #元はこう@tweets = Tweet.where(user_id: current_user.id).page(params[:page]).per(5).order("created_at DESC")
end
