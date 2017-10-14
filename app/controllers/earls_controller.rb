class EarlsController < ApplicationController
  def index
    render locals: { 
      earls: Earl.top_views.page(page_params[:page]).per(page_params[:per]), 
      new_earl: Earl.new 
    }
  end

  def show
    render_404 unless earl
    earl.increment(:view_count).save
    redirect_to earl.full_url
  end

  def create
    earl = Earl.find_or_create_by(earl_params)
    if earl.persisted?
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

  def page_params
    params.permit(:page, :per)
  end
end
