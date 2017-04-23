class GroupsController < ApplicationController
  before_action :get_group, only:[:edit, :update]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
    #グループ作成・編集フォームの書き方を統一するため
    @users = []
    @users << current_user
  end

  def edit
    #get_groupで@group取得済み
    #グループ作成・編集フォームの書き方を統一するため    
    @users = @group.users
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      #ひとまずindexにリダイレクト
      redirect_to root_url, notice: "グループ作成に成功しました。"
    else
      redirect_to new_group_url, alert: "グループ作成に失敗しました。"
    end
  end

  def update
    #get_groupで@group取得済み
    if @group.update(group_params)
      #ひとまずindexにリダイレクト
      redirect_to root_url, notice: "グループ編集に成功しました。"
    else
      redirect_to edit_group_url(@group), alert: "グループ編集に失敗しました。"
    end
  end

  private

  def get_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

end
