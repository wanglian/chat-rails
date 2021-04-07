# frozen_string_literal: true

class Api::ChannelsController < ApiController
  before_action :authenticate_user!
  before_action :find_channel, only: [:join]

  api :GET, '/channels', 'Get list of all channels'
  def index
    @channels = Channel.all

    render json: @channels.map(&:to_h), status: :ok
  end

  api :POST, '/channels/:id/join', 'Join a channel'
  param :id, :number, required: true, desc: 'id of requested channel'
  def join
    @channel.add_user current_user

    render json: @channel.to_h
  end

  private
  def find_channel
    @channel = Channel.find params[:id]
  rescue
    render json: { errors: ["Invalid channel #{params[:id]}"] }, status: :unprocessable_entity
  end
end
