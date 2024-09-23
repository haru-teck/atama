class UsersController < ApplicationController
    def index
      @users = User.all
      @temperatures = Temperature.all
      @temperature = Temperature.new  # 新しい体温インスタンスを初期化
      @user = User.new  # 新しいユーザーインスタンスを初期化
    end
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:birthday)
  end
end

