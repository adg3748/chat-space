class MessagesController < ApplicationController
  before_action :move_to_index

  def index
    # 一時的にid=1のレコードを代入
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    @groups = current_user.groups
    @message = Message.new
    @messages = @group.messages
  end

  def create
    @group = Group.find(params[:group_id])
    @message = Message.new(content: message_params[:content], user_id: current_user.id, group_id: @group.id)
    if @message.save
      redirect_to message_url(@group)
    else
      flash.now[:alert] = "メッセージの送信に失敗しました。"
      redirect_to message_url(@group)
    end
  end

  private

  def move_to_index
    redirect_to new_user_session_url unless user_signed_in?
  end

  def message_params
    params.require(:message).permit(:content)
  end

end
