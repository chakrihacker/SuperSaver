# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[show edit update destroy]
  before_action :authenticate_user_for_api
  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = @current_user.conversations
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @messages = @conversation.messages.order("created_at DESC").limit(150)
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_chat
    conversation_recipient = User.find(params[:user_id])
    slug = params[:deal_id].to_s + '/' + current_user.id.to_s
    conversation = Conversation.create_with_users(
      [current_user, conversation_recipient],
      slug
    )
    message = Message.new(
      user_id: current_user.id,
      conversation_id: conversation.id,
      content: params[:content]
    )
    conversation.messages.append(message)
    render json: { status: 'success', message: 'chat conversation created!' },
           status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def conversation_params
    params.require(:conversation).permit(:conversation_name, :conversation_type, :slug, :description, :status)
  end
end
