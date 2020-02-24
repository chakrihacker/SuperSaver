class DealsController < ApplicationController
  before_action :authenticate_user_for_api, except: [:index]
  before_action :set_deal, only: [:show, :edit, :update, :destroy]
  after_action only: [:index] do
    set_pagination_header(:deals)
  end

  # GET /deals
  # GET /deals.json
  def index
    if params[:user_id]
      target = User.find(params[:user_id])
      @deals = target.deals.order(created_at: :desc).page(params[:page].to_i)
    elsif params[:category_id]
      category = Category.find(params[:category_id])
      @deals = category.deals.order(created_at: :desc).page(params[:page].to_i)
    else
      @deals = Deal.order(created_at: :desc).page(params[:page].to_i)
    end
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
  end

  # GET /deals/new
  def new
    @deal = Deal.new
  end

  # GET /deals/1/edit
  def edit
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = Deal.new(deal_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @deal.save
        format.html { redirect_to @deal, notice: 'Deal was successfully created.' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    respond_to do |format|
      if @deal.update(deal_params)
        format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
        format.json { render :show, status: :ok, location: @deal }
      else
        format.html { render :edit }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to deals_url, notice: 'Deal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def deal_params
      params.require(:deal).permit(:deal_type, :name, :description, :vendor, :is_local_deal, :latitude, :longitude, :status, :end_date, :min_price, :cash_back, :selling_price, :user_id, :category_id)
    end
end
