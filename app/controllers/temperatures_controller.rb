class TemperaturesController < ApplicationController
  def index
    @user = User.find(params[:id])  # ユーザーを取得
    @temperature = Temperature.new    # 新しい体温データのインスタンスを作成
  end
  
  def create
    logger.debug "Received parameters: #{params.inspect}"
  
    # 体温のパラメータを確認
    temperature_params = temperature_params()
    logger.debug "Temperature params: #{temperature_params.inspect}"
  
    # Temperatureインスタンスを作成
    @temperature = Temperature.new(temperature_params)
    @temperature.user_id = params[:temperature][:user_id]  # user_idを設定
  
    # 日付と時間を結合
    recorded_at_date = params[:temperature][:recorded_at] # 日付
    recorded_at_time = params[:temperature][:recorded_at_time] # 時間
  
    # 日付と時間を結合して、recorded_atに設定
    if recorded_at_date.present? && recorded_at_time.present?
      @temperature.recorded_at = DateTime.parse("#{recorded_at_date} #{recorded_at_time}")
    end
  
    # Temperatureを保存
    if @temperature.save
      @addition = @temperature.build_addition(addition_params)
  
      # user_idを設定
      @addition.user_id = @temperature.user_id 
  
      # Additionを保存
      if @addition.save
        redirect_to root_path, notice: '体温と体調が記録されました。'
      else
        @temperature.destroy # 追加の保存に失敗した場合、体温データも削除
        logger.error "Addition save failed: #{@addition.errors.full_messages.join(', ')}"
        redirect_to root_path, alert: '体調データの保存に失敗しました。'
      end
    else
      redirect_to root_path, alert: '体温の保存に失敗しました。'
    end
  end
  
  

  private

  def temperature_params
    params.require(:temperature).permit(:netu, :user_id, :recorded_at, :recorded_at_time)
  end

  def addition_params
    params.require(:temperature).require(:addition).permit(:eat, :moisture, :puke, :memo)
  end
end
