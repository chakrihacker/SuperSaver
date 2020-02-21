class ConversationMembershipsController < ApplicationController
  before_action :set_conversation_membership, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user_for_api
  # before_action :authenticate_user_for_api, except: [:index]

  # GET /conversation_memberships
  # GET /conversation_memberships.json
  def index
    @conversation_memberships = ConversationMembership.all
  end

  # GET /conversation_memberships/1
  # GET /conversation_memberships/1.json
  def show
  end

  # GET /conversation_memberships/new
  def new
    @conversation_membership = ConversationMembership.new
  end

  # GET /conversation_memberships/1/edit
  def edit
  end

  # POST /conversation_memberships
  # POST /conversation_memberships.json
  def create
    @conversation_membership = ConversationMembership.new(conversation_membership_params)

    respond_to do |format|
      if @conversation_membership.save
        format.html { redirect_to @conversation_membership, notice: 'Conversation membership was successfully created.' }
        format.json { render :show, status: :created, location: @conversation_membership }
      else
        format.html { render :new }
        format.json { render json: @conversation_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversation_memberships/1
  # PATCH/PUT /conversation_memberships/1.json
  def update
    respond_to do |format|
      if @conversation_membership.update(conversation_membership_params)
        format.html { redirect_to @conversation_membership, notice: 'Conversation membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation_membership }
      else
        format.html { render :edit }
        format.json { render json: @conversation_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversation_memberships/1
  # DELETE /conversation_memberships/1.json
  def destroy
    @conversation_membership.destroy
    respond_to do |format|
      format.html { redirect_to conversation_memberships_url, notice: 'Conversation membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation_membership
      @conversation_membership = ConversationMembership.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def conversation_membership_params
      params.require(:conversation_membership).permit(:conversation_id, :user_id)
    end
end
