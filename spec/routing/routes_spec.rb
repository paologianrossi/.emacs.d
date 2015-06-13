describe "routes" do
  describe "User" do
    it "routes a named route" do
      expect(:get => thank_you_path).
        to route_to(:controller => "visitors", :action => "thank_you")
    end
  end
end
