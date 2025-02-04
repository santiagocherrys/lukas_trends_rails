class HomeController < ApplicationController
  before_action :set_new_chat, only: :index
  before_action :set_active_chat, only: :index

  def index
    return render :index unless user_signed_in?

    @chats = current_user.chats.order(created_at: :desc)
  end

  private

  def active_chat_params
    params.permit(:active_chat_id)
  end

  def set_active_chat
    return @active_chat = Chat.new unless user_signed_in?

    @active_chat = current_user.chats.find(active_chat_params[:active_chat_id])
  rescue ActiveRecord::RecordNotFound
    last_empty_chat = current_user.chats.where(question: nil).last
    @active_chat = last_empty_chat || current_user.chats.create
  end

  def set_new_chat
    return @new_chat = Chat.new unless user_signed_in?

    @new_chat = current_user.chats.build
  end
end
