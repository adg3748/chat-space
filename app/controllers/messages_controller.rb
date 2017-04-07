class MessagesController < ApplicationController

  before_action :move_to_index

  def index
    # 一時的にid=1のレコードを代入
    @group = Group.find(1)
  end

  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
  end

end
