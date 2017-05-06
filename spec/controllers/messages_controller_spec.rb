require 'rails_helper'
describe MessagesController do

  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:message) { { message: attributes_for(:message), user_id: user.id, group_id: group.id } }
  let(:message) { { message: attributes_for(:message), user_id: user.id, group_id: group.id } }


  before do
    login_user user
    #letで格納したuserでログイン
  end

  describe 'GET #index' do

    it "renders the edit template" do
      get :index
      expect(response).to render_template :index
    end

  end

  describe 'GET #show' do

    it "assigns the requested group to @group" do
      get :show, params: { id: group }
      expect(assigns(:group)).to eq group
      #editアクションの中の@groupをassignsの引数にシンボルで指定
    end

    it "renders the :show template" do
      get :show, params: { id: group }
      expect(response).to render_template :show
    end

  end

  describe "POST #create" do

    it "saves the new contact in the database" do
      expect{
        post :create, params: message
      }.to change( Message, :count ).by(1)
    end

    it "redirects to messages#show" do
      post :create, params: message
      expect(response).to redirect_to message_url(group)
    end
  end
end
