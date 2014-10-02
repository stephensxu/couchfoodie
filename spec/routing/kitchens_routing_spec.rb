require "rails_helper"

RSpec.describe KitchensController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/kitchens").to route_to("kitchens#index")
    end

    it "routes to #new" do
      expect(:get => "/kitchens/new").to route_to("kitchens#new")
    end

    it "routes to #show" do
      expect(:get => "/kitchens/1").to route_to("kitchens#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/kitchens").to route_to("kitchens#create")
    end
  end
end
