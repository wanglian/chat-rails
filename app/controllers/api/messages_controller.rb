# frozen_string_literal: true

class Api::MessagesController < ApiController
  before_action :authenticate_user!
  before_action :find_channel

  api :GET, '/channels/:channel_id/messages', 'Send message to a channel'
  param :channel_id, :number, required: true, desc: 'id of requested channel'
  def index
    @messages = Message.where(channel_id: @channel.id).order(id: :desc)

    render json: @messages.map(&:to_h), status: :ok
  end

  api :POST, '/channels/:channel_id/messages', 'Get list of messages in a specific channel'
  param :channel_id, :number, required: true, desc: 'id of requested channel'
  param :content, String, required: true, desc: 'message content'
  def create
    @message = Message.new message_params
    @message.channel = @channel
    @message.user = current_user

    if @message.save
      render json: @message.to_h
    else
      render json: { errors: @message.errors }, status: :unprocessable_entity
    end
  end

  private
  def find_channel
    @channel = Channel.find params[:channel_id]
    unless @channel.has_user?(current_user)
      render json: { errors: ["Not allowed to channel #{params[:channel_id]}"] }, status: :unprocessable_entity
    end
  rescue
    render json: { errors: ["Invalid channel #{params[:channel_id]}"] }, status: :unprocessable_entity
  end

  def message_params
    params.permit :content
  end
end
