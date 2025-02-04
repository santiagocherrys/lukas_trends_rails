class ChatsController < ApplicationController
  before_action :set_chat, only: [:create]

  def create
    redirect_to root_path
  end

  private

  def render_chat
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('chat', partial: 'home/chat', locals: { chat: @chat })
      end
    end
  end

  def chat_params
    params.require(:chat).permit(:question)
  end

  def set_chat
    @chat = user_signed_in? ? current_user.chats.build(chat_params) : Chat.new(chat_params)
  end
end
