RSpec.describe "Users", type: :request do
  describe "#create" do
    it "doesn't create a user with invalid information" do
      get signup_path
      expect{
        post users_path, params: { user: { name: "",
                                    email: "address@invalid",
                                    password: "short",
                                    password_confirmtion: "rack"}}
      }.to_not change(User, :count)
    end
  end
