# Controller for creating, rendering, and redirecting to earls
class EarlsController < ApplicationController
  # list top earls and display earl form, responds to pagination params
  def index
    respond_to do |format|
      format.html do
        render locals: {
          earls: Earl.top_views.page(page).per(per),
          new_earl: Earl.new
        }
      end
      format.js do
        render locals: { earls: Earl.top_views.page(page).per(per) }
      end
    end
  end

  # render 404 or redirect to full url
  def show
    render_404 unless earl
    earl.increment(:view_count).save
    redirect_to earl.full_url
  end

  # create earl and return json of errors or short_url
  def create
    earl = Earl.find_or_create_by(earl_params)
    if earl.persisted?
      render json: { short_url: earl_url(earl) }
    else
      render json: earl.errors, status: :unprocessable_entity
    end
  end

  private

    # fetch and memoize earl
    def earl
      @_earl ||= Earl.find_by(short_url: params[:short_url])
    end

    # allowed params for earl creation
    def earl_params
      params.require(:earl).permit(:full_url)
    end

    # allowed pagination params
    def page_params
      params.permit(:page, :per)
    end

    def page
      page_params[:page] || 1
    end

    def per
      page_params[:per] || 25
    end
end
