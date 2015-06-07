describe "routes" do
  describe "User" do
    it "routes a named route" do
      expect(:get => new_user_path).
        to route_to(:controller => "users", :action => "new")
    end
  end
end
