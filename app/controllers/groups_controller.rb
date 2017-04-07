class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.create(name: group_params[:name])
    redirect_to root_path
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    redirect_to root_path
  end

  private

  def group_params
    params.require(:chat).permit(:name)
  end

end
