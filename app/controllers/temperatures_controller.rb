class TemperaturesController < ApplicationController
  def create
    @temperature = Temperature.new(temperature_params)
    @temperature.user_id = params[:temperature][:user_id]  # user_idを設定

    # 日付と時間を結合
    recorded_at_date = params[:temperature][:recorded_at] # 日付
    recorded_at_time = params[:temperature][:recorded_at_time] # 時間

    # 日付と時間を結合して、recorded_atに設定
    if recorded_at_date.present? && recorded_at_time.present?
      @temperature.recorded_at = DateTime.parse("#{recorded_at_date} #{recorded_at_time}")
    end

    if @temperature.save
      # Additionモデルのインスタンスを作成
      @addition = Addition.new(addition_params)
      @addition.temperature_id = @temperature.id  # 体温レコードに関連付ける

      if @addition.save
        redirect_to some_path, notice: '体温と体調が記録されました。'
      else
        @temperature.destroy # 追加の保存に失敗した場合、体温データも削除
        redirect_to root_path, alert: '体調データの保存に失敗しました。'
      end
    else
      redirect_to root_path, alert: '体温の保存に失敗しました。'
    end
  end

  private

  def temperature_params
    params.require(:temperature).permit(:netu, :user_id, :recorded_at, addition_attributes: [:eat, :moisture, :puke, :memo])
  end

  def addition_params
    params.require(:temperature).require(:addition).permit(:eat, :moisture, :puke, :memo)
  end
end
