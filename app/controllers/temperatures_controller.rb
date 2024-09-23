class TemperaturesController < ApplicationController
  def create
    @temperature = Temperature.new(temperature_params)
    if @temperature.save
      redirect_to users_path, notice: '体温が正常に記録されました。'
    else
      render :new
    end
  end

  private

  def temperature_params
    params.require(:temperature).permit(:netu)  # ここは正しい属性名に修正
  end
end