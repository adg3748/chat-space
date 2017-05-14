class GroupsController < ApplicationController
  before_action :get_group, only: [:edit, :update]
  before_action :get_users_new, only: [:new, :create]
  before_action :get_users_edit, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to message_url(@group), notice: "グループ作成に成功しました。"
    else
      flash.now[:alert] = "グループ作成に失敗しました。"
      render :new
      # renderでは指定したactionが動いてるわけではないため、newフォームを表示する際に必要なインスタンス変数をget_users_newメソッドであらかじめ取得
    end
  end

  def update
    if @group.update(group_params)
      redirect_to message_url(@group), notice: "グループ編集に成功しました。"
    else
      render :edit
      # renderでは指定したactionが動いてるわけではないため、editフォームを表示する際に必要なインスタンス変数をget_users_editメソッドであらかじめ取得
    end
  end

  private

  def get_group
    @group = Group.includes(:users).find(params[:id])
  end

  def get_users_new
    @users = []
    @users << current_user
  end

  def get_users_edit
    @users = @group.users
  end

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

end
