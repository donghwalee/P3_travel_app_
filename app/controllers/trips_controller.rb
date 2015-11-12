class TripsController < ApplicationController
  include TripsHelper
  before_action :require_current_user

  def new
    @trip = Trip.new
  end

  def create
    @trip = current_user.trips.new(trip_params)

    if @trip.save
      # redirect_to trips_path
    else
      # flash[:message] = @trip.errors.full_messages.to_sentence
      # render :new
      render json: {
        error: {
          message:
          @trip.errors.full_messages.to_sentence
        }
      }
    end

  end

  def edit
    # --- below is from Monday morning change
    @trip = Trip.find(params[:id])
    # --- end
  end

  def update
    # --- below is from Monday morning change
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    flash[:message] = "Trip '#{@trip.title}' Updated!"
    redirect_to trip_path(@trip)
    # --- end
  end

  def show
    # --- below is from Monday morning change
    @trip = Trip.find(params[:id])
    @comment = Comment.new
    @comment.trip_id = @trip.id
    # --- end
  end

  def index
    @trips = current_user.trips.includes(:comments)
  end

  def delete
  end

  def destroy
    # --- below is from Monday morning change
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to trips_path
    # --- end
  end

  private

  def comment_params
    return params.require(:comment)
      .permit(:entry)
  end

end
