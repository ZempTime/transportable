class RideSchedulesController < ApplicationController
  def index
    @ride_schedules = ride_schedule_scope.all
  end

  def show
    load_ride_schedule
  end

  def new
    @ride_schedule = ride_schedule_scope.new
    @ride_schedule.build_week
  end

  def edit
    load_ride_schedule
  end

  def create
    @ride_schedule = ride_schedule_scope.new ride_schedule_params

    if @ride_schedule.save
      redirect_to @ride_schedule
    else
      render :new
    end
  end

  def update
    load_ride_schedule
    if @ride_schedule.update ride_schedule_params
      redirect_to @ride_schedule
    else
      render :edit
    end
  end

  def destroy
    load_ride_schedule

    if @ride_schedule.destroy
      redirect_to ride_schedules_path
    else
      render :edit, notice: "We were unable to process your request."
    end
  end

  private
    def ride_schedule_scope
      RideSchedule
    end

    def ride_schedule_params
      params.require(:ride_schedule).permit(:travel_method_id, :starts_at, :interval_minutes,
                                            week_attributes: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday])
    end

    def load_ride_schedule
      @ride_schedule = ride_schedule_scope.find(params[:id])
    end
end
