class TweetsController < ApplicationController
  #5/4追記！！
  before_action :move_to_index, except: :index

  def index
    @tweets = Tweet.all.order("created_at DESC")
  end

  def new
    #勝手に追記したけど、意味なかった。→ @tweet = Tweet.new  
  end


  #↓新たに追記！
  def confirm
    @tweet = Tweet.new(tweet_params)
    #消してみたらうまくいったよ！！！！！→　render :new if @tweet.invalid?
  end
  #↑新たに追記！

  
  def create
    Tweet.create(text: tweet_params[:text], user_id: current_user.id)
    #pictweet上はTweet.create(name: tweet_params[:name], image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
    #もともとは　Tweet.create(tweet_params)
  end


  def destroy
    tweet = Tweet.find(params[:id]) ###tweet_paramsをparamsに変えてらうまくいったよ！！！！
    tweet.destroy if tweet.user_id == current_user.id
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update(tweet_params)   #(tweet_params)無いとうまく動かない！！！！
    end
  end

  private
  def tweet_params
    params.permit(:text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
  
end