class MessagesController < ApplicationController
  before_action :get_groups, only: [:index, :show, :create]

  def index
  end

  def show
    @message = current_user.messages.new
    @group = Group.includes(:users, :messages).find(params[:id])
    @messages = @group.messages.includes(:user, :group).sort_old
    respond_to do |format|
      format.html # 特に駆動なし
      format.json {
        @new_messages = @messages.where('id > ?', (params[:newest_msg_id] ||= 0))
        @messages_json = []
        @new_messages.each do |new_message|
          @messages_json << message_json(new_message)
        end
        render json: @messages_json
      }
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    @group = Group.includes(:users, :messages).find(params[:group_id])
    @messages = @group.messages.includes(:user, :group).sort_old
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
    params.require(:message).permit(:content, :image).merge(group_id: params[:group_id])
  end

  def get_groups
    @groups = current_user.groups.includes(:users, :messages).sort_new
  end

  def message_json(message)
    { id: message.id, name: message.user.name, content: message.content, image: message.image.to_s, user_id: message.user_id, group_id: message.group_id, created_at: message.created_at.strftime("%Y/%m/%d %H:%M:%S"), updated_at: message.updated_at.strftime("%Y/%m/%d %H:%M:%S") }
  end
end
