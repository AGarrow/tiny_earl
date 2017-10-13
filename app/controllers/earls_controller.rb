class EarlsController < ApplicationController

  def index
    render locals: { earls: Earl.all, new_earl: Earl.new }
  end

  def show
    render_404 unless earl
    earl.increment(:view_count).save
    redirect_to earl.full_url
  end

  def create
    earl = Earl.new(earl_params)

    if earl.save
      render json: earl
    else
      render json: earl.errors, status: :unprocessable_entity
    end
  end

  private

    def earl
      @_earl ||= Earl.find_by(short_url: params[:short_url])
    end

    def earl_params
      params.require(:earl).permit(:full_url)
    end
end
