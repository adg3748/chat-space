class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_messages_path(@group.id), notice: "グループ作成に成功しました。"
    else
      flash.now[:alert] = "グループ作成に失敗しました。"
      render :new
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_messages_path(@group.id), notice: "グループ編集に成功しました。"
    else
      flash.now[:alert] = "グループ作成に失敗しました。"
      render :edit
    end
  end

  private

  def group_params
    params.require(:chat).permit(:name)
  end

end
