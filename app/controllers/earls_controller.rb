class EarlsController < ApplicationController
  before_action :set_earl, only: [:show, :edit, :update, :destroy]

  # GET /earls
  # GET /earls.json
  def index
    @earls = Earl.all
  end

  # GET /earls/1
  # GET /earls/1.json
  def show
  end

  # GET /earls/new
  def new
    @earl = Earl.new
  end

  # POST /earls
  # POST /earls.json
  def create
    @earl = Earl.new(earl_params)

    respond_to do |format|
      if @earl.save
        format.html { redirect_to @earl, notice: 'Earl was successfully created.' }
        format.json { render :show, status: :created, location: @earl }
      else
        format.html { render :new }
        format.json { render json: @earl.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_earl
      @earl = Earl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def earl_params
      params.require(:earl).permit(:full_url, :short_url, :view_count)
    end
end
