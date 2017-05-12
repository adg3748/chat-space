class MessagesController < ApplicationController
  before_action :move_to_sign_in
  before_action :get_groups, only: [:index, :show]

  def index
  end

  def show
    @group = Group.includes(:users).includes(:messages).find(params[:id])
    gon.group = @group # Gemのgonを用いてjs内でcontrollerで設定した変数を使えるように
    @message = current_user.messages.new
    @messages = @group.messages.includes(:user).includes(:group).order("created_at ASC")
  end

  def create
    @group = Group.find(params[:group_id])
    @message = current_user.messages.new(message_params)
    if @message.save!
      respond_to do |format|
        format.html { redirect_to message_url(@group) }
        format.json { render json: message_json(@message) }
      end
    else
      flash.now[:alert] = "メッセージの送信に失敗しました。"
      redirect_to message_url(@group)
    end
  end

  private

  def move_to_sign_in
    redirect_to new_user_session_url unless user_signed_in?
  end

  def message_params
    params.require(:message).permit(:content).merge(group_id: params[:group_id])
  end

  def get_groups
    @groups = current_user.groups.includes(:users).includes(:messages).order("created_at DESC")
  end

  def message_json(message)
    {
      id: message.id,
      name: message.user.name,
      content: message.content,
      user_id: message.user_id,
      group_id: message.group_id,
      created_at: message.created_at.strftime("%Y/%m/%d %H:%M:%S"),
      updated_at: message.updated_at
    }
  end

end
