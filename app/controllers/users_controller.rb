class UsersController < ApplicationController
  def index
    # 最初のユーザーを取得
    @user = User.first
    
    # そのユーザーに関連する体温のみ取得
    @temperatures = @user.temperatures
    
    # 新しい体温入力フォーム用のインスタンス
    @temperature = Temperature.new
    # 新しいユーザー登録フォーム用のインスタンス
    @new_user = User.new
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

  def show
    @user = User.find(params[:id])
    @temperatures = @user.temperatures  # ユーザーに関連する体温データを取得
  end

  def next_user
    current_user = User.find(params[:id])
    @next_user = User.where('id > ?', current_user.id).order(:id).first || User.first
    redirect_to user_path(@next_user)  # 次のユーザーの詳細ページにリダイレクト
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to settings_path, notice: 'ユーザーが正常に削除されました。'
  end

  private

  def user_params
    params.require(:user).permit(:name,:birthday)
  end
end

