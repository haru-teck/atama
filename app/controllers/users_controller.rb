class UsersController < ApplicationController

  def index
      @user = User.first # 表示するユーザーを選択（ここでは最初のユーザーを表示）
      @temperatures = @user.temperatures # ユーザーの体温データを取得
      @temperature = Temperature.new # 新しい体温データを記録するためのインスタンス
  end

  # 設定ページでユーザー一覧と新規登録を表示するアクション
  def settings
    @users = User.all
    @user = User.new  # 新しいユーザー登録用のインスタンス
  end
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path(@user), notice: 'ユーザーが正常に登録されました。'
    else
      redirect_to root_path(@user), alert: 'ユーザーの登録に失敗しました。'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'ユーザーが削除されました。'
  end


  def show
    @user = User.find(params[:id])
    @temperatures = @user.temperatures  # ユーザーに関連する体温データを取得
  end

  

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to settings_path, notice: 'ユーザーが正常に更新されました。'
    else
      render :edit, alert: 'ユーザー更新に失敗しました。'
    end
  end

  
  private

  def user_params
    params.require(:user).permit(:name,:birthday)
  end
end

