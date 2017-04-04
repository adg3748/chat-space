class GroupsController < ApplicationController
  def new
  end
  def edit
  end
  def create
    @group = Group.create(name: group_params[:name])
    redirect_to root_path
  end
  private
  def group_params
    params.require(:chat).permit(:name)
  end
end
