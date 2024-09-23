class TemperaturesController < ApplicationController
  def create
    @temperature = Temperature.new(temperature_params)
    @temperature.user_id = params[:temperature][:user_id]  # user_idを設定

    if @temperature.save
      redirect_to users_path, notice: '体温が正常に記録されました。'
    else
      @users = User.all  # ここで@usersを設定
      @temperatures = Temperature.all  # ここで@temperaturesを設定
      render 'users/index'  # users/indexを明示的にレンダリング
    end
  end

  private

  def temperature_params
    params.require(:temperature).permit(:netu, :user_id)
  end
end
