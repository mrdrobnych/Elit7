require 'rails_helper'

RSpec.describe UserparamsController, type: :controller do
    let!(:user) { build(:user, email: "somemail@gmail.com") }

login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe 'GET #new' do
    it "should find current_user and open form for create Profile" do
      get :new
      expect(subject.current_user.email).to eq("somemail@gmail.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)     
    end
  end

  describe 'POST #create' do
    it "should create profile and redirect to index page" do
      post :create, params: {profile: {firstname:"Marek", lastname:"Droptop"}}
      expect(subject.current_user.profile.nickname).to eq("Marek")
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET #edit' do
    it "should find current_user and open form for edit Profile" do
      get :edit, xhr: true, format: :js, params: {id: subject.current_user.id}
      expect(subject.current_user.email).to eq("somemail@gmail.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)
    end
  end
  
  describe 'PATCH #update' do
  	before do
      @userparam = create(:profile, user_id: subject.current_user.id)
    end  
    it "should update userparam and redirect to profile" do
      patch :update, params: { id: subject.current_user.id, profile: {firstname:"Marik", lastname:"Droppop"}}
      expect(subject.current_user.profile.nickname).to eq("Tester2")
      expect(response).to redirect_to profile_index_path
    end
  end

end