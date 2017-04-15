class MessagesController < ApplicationController
  before_action :move_to_index

  def index
    # 一時的にid=1のレコードを代入
    @group = Group.find(1)
    @message = Message.new
  end

  def create
    @group = Group.find(params[:group_id])
    @message = Message.create(content: message_params[:content], user_id: current_user.id, group_id: @group.id)
    redirect_to root_path
  end

  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

end
