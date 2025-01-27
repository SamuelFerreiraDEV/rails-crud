class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    if session[:user_id]
      redirect_to users_path
    end
    @user = User.new
    @is_login = request.path == login_path
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:alert] = "User created successfully. Please Log In."
      redirect_to login_path
    else
      flash.now[:alert] = "#{@user.errors.full_messages}"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash[:alert] = "User not found."
      redirect_to users_path
    end
  end

  def login
    @user = User.find_by(email: user_params[:email])

    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      redirect_to posts_path
    else
      flash[:alert] = "Wrong email or password."
      @user = User.new
      @is_login = true
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    reset_current_user
    redirect_back(fallback_location: posts_path)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
