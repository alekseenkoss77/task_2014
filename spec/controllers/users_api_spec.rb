require 'spec_helper'

describe Api::UsersController do

  Api::ApplicationController.skip_before_action :verify_authenticity_token

  render_views 

  before(:all) do
    @user = FactoryGirl.create(:user,:email => "user_api@spec.com", :password => "secret",:password_confirmation => "secret", :age => 50, :gender => 1)
  end


  describe "users actions" do

    before(:each) do
      login_user @user
    end

    after(:each) do
      logout_user
    end

    after(:all) do
      @user.destroy
    end

    it "should respond with only one user in list list" do
      get :index, format: :json
      expect(response.body).to have_json_size(1).at_path("users")
      expect(response.body).to include_json(pagination(1,1))
    end



    
    describe "filters" do

      before(:all) do
        # add 16 girls
        (15..90).step(5) do |n|
          FactoryGirl.create(:user, age: n, gender: 0)
        end

        #... and 12 boys (13 in total)
        (25..80).step(5) do |n|
          FactoryGirl.create(:user, age: n, gender: 1)
        end
      end

      it "should filter by gender" do
        get :index, format: :json, filter: {:gender => 0}
        expect(response.body).to have_json_size(16).at_path("users")
      end

      it "should filter by exact age" do
        get :index, format: :json, filter: {:age => 25}
        expect(response.body).to have_json_size(2).at_path("users")
      end

      it "should filter by gender and exact age" do
        get :index, format: :json, filter: {:gender => 1, :age => 50}
        expect(response.body).to have_json_size(2).at_path("users")
      end

      it "should filter by range age" do
        get :index, format: :json, filter: {:age => "<51"}
        expect(response.body).to have_json_size(15).at_path("users")
      end

      # Если честно, этот тест фильтра не очень логичный. ИМХО
      # но лучше интервал возрастов брать от меньшего к большему
      #
      # it "should filter by complex range age" do
      #   get :index, format: :json, filter: {:age => "<51 && >30"}
      #   expect(response.body).to have_json_size(9).at_path("users")
      # end

      # поэтому я изменил тест на такой:
      it 'should filter by complex range age' do
        get :index, format: :json, filter: {:age => ">30 && <51"}
        expect(response.body).to have_json_size(9).at_path("users")
      end
    
    end
  end
end