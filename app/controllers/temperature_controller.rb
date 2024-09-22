class TemperatureController < ApplicationController
  def new
    @temperature = Temperature.new
  end

  def create
    @temperature = Temperature.new(temperature_params)
    if @temperature.save
      redirect_to users_path, notice: 'Temperature was successfully recorded.'
    else
      render :new
    end
  end

  private

  def temperature_params
    params.require(:temperature).permit(:value, :recorded_at)
  end
end
