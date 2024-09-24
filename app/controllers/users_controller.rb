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
    puts "Received parameters: #{params.inspect}"  # パラメータを出力
  
    # ユーザーの作成
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'ユーザーが作成されました。'
    else
      render :new
    end

    # 温度データの処理はここで行わないためコメントアウト
    # @temperature = Temperature.new(temperature_params)
    # @temperature.user_id = params[:temperature][:user_id]  # user_idを設定
  
    # 日付と時間を結合
    # recorded_at_date = params[:temperature][:recorded_at] # 日付
    # recorded_at_time = params[:temperature][:recorded_at_time] # 時間
  
    # 日付と時間を結合して、recorded_atに設定
    # if recorded_at_date.present? && recorded_at_time.present?
    #   @temperature.recorded_at = DateTime.parse("#{recorded_at_date} #{recorded_at_time}")
    # end
  
    # if @temperature.save
    #   addition = @temperature.build_addition(addition_params)  # build_additionを使用して関連付ける
    
    #   # Additionの保存を行う
    #   if addition.save
    #     redirect_to some_path, notice: '体温と体調が記録されました。'
    #   else
    #     @temperature.destroy # 追加の保存に失敗した場合、体温データも削除
    #     logger.error "Addition save failed: #{addition.errors.full_messages.join(', ')}" # エラーメッセージをログに記録
    #     redirect_to root_path, alert: '体調データの保存に失敗しました。'
    #   end
    # else
    #   redirect_to root_path, alert: '体温の保存に失敗しました。'
    # end
  end

  def edit
    @user = User.find(params[:id]) # ユーザーを取得
  end

  def show
    @user = User.find(params[:id]) # ユーザーを取得
    @temperatures = @user.temperatures # ユーザーに関連する体温を取得
  end

  def update
    @user = User.find(params[:id]) # 更新するユーザーを取得
  
    if @user.update(user_params)
      redirect_to users_path, notice: 'ユーザーが更新されました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :birthday)
  end

  def temperature_params
    params.require(:temperature).permit(:netu, :user_id, addition_attributes: [:eat, :moisture, :puke, :memo])
  end
  
  def addition_params
    params.require(:temperature).require(:addition).permit(:eat, :moisture, :puke, :memo)
  end
end
