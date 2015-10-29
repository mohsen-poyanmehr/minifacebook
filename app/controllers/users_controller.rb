class UsersController < ApplicationController

    before_action :authenticate_user!
    autocomplete :user, :name, :display_value => :display, :extra_data => [:email]


def test
    @user=User.where(email:  params[:name]).first
    if @user == nil
        redirect_to :back
    else
        redirect_to user_path(@user)
    end
end  
    
  def homepage
    @posts = Post.personal(current_user.id)
  end

 def start
      if user_signed_in?
          redirect_to "/homepage"
          #redirect_to new_user_registration_path
      else
        redirect_to new_user_session_path
      end
  end

  def index
  	@users= User.all
  end

  def show
    #@autocomplete=User.find(params[:name]).first
  	@user= User.find(params[:id])
    @posts = Post.where(friend_id: @user.id)
    @my_friends = User.where(id: current_user.friendships.map{|v| [v.friend_id]})
    @my_friends.each do |f|
      if f.id == @user.id
        @we_are_friends = 1
      end
    end
  end

  def friends
    @user= User.find(params[:id])
    render :json => @user.friends.to_json
  end

  def create
    @user = User.find(params[:id])
    if @user.save
        UserMailer.registration_confirmation(@user).deliver
        flash[:success] = "Please confirm your email address to continue"
        redirect_to root_url
    else
        flash[:error] = "Ooooppss, something went wrong!"
        render 'new'
    end

    @post = Post.new
      @post.content = params[:content]
      @post.user_id = current_user.id
      @post.friend_id = @user.id
    @post.save
    redirect_to "/users/#{@user.id}"
  end
  
    def confirm_email
        user = User.find_by_confirm_token(params[:id])
        if user
            user.email_activate
            flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
            Please sign in to continue."
            redirect_to signin_url
        else
            flash[:error] = "Sorry. User does not exist"
            redirect_to root_url
        end
      end

  def befriend
    @user = User.find(params[:id])
    friendship = Friendship.new
      friendship.user_id = current_user.id
      friendship.friend_id = @user.id
    friendship.save
    #redirect_to "/users/#{@user.id}"
    render :nothing => true, :status => 200
  end

  def unfriend
    @user = User.find(params[:id]).friendships.where(friend_id: current_user.id)
    @user.first.destroy
    #redirect_to "/users/#{current_user.id}"
    render :nothing => true, :status => 200
  end
end
