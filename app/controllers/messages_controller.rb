class MessagesController < ApplicationController
  before_action :get_groups, only: [:index, :show, :create]

  def index
  end

  def show
    @message = current_user.messages.new
    @group = Group.includes(:users, :messages).find(params[:id])
    @messages = @group.messages.includes(:user, :group).sort_ASC("created_at")
  end

  def create
    @message = current_user.messages.new(message_params)
    @group = Group.includes(:users, :messages).find(params[:group_id])
    @messages = @group.messages.includes(:user, :group).sort_ASC("created_at")
    if @message.save
      respond_to do |format|
        format.html { redirect_to message_url(@group) }
        format.json { render json: message_json(@message) }
      end
    else
      flash.now[:alert] = "メッセージの送信に失敗しました。"
      render :show
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(group_id: params[:group_id])
  end

  def get_groups
    @groups = current_user.groups.includes(:users, :messages).sort_DESC("created_at")
  end

  def message_json(message)
    { id: message.id, name: message.user.name, content: message.content, user_id: message.user_id, group_id: message.group_id, created_at: message.created_at.strftime("%Y/%m/%d %H:%M:%S"), updated_at: message.updated_at
    }
  end

end
