require 'rails_helper'

RSpec.describe Userparam, type: :model do
  let!(:user){create(:user)}

  subject{
     build(:userparam, user: user)
  }

  context "validation" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
    
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
    it { should validate_presence_of(:age) }

  end

  context "association" do
    it { should belong_to(:user) }
  end


 context "when user nickname is already taken" do
   before do 
    profile_dub = create(:userparam, user: user)
   end
   
   it { should_not be_valid }  
 end
 
end
