require 'rails_helper'

describe GroupsController, type: :controller do

  let(:user) { create(:user) }
  let(:group) { create(:group) }

  before do
    login_user user # letで格納したuserでログイン
  end

  describe 'GET #new' do

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end

  end

  describe 'GET #edit' do

    it "assigns the requested group to @group" do
      get :edit, params: { id: group }
      expect(assigns(:group)).to eq group
      # editアクションの中の@groupをassignsの引数にシンボルで指定
    end

    it "renders the :edit template" do
      get :edit, params: { id: group }
      expect(response).to render_template :edit
    end

  end

end
