require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SelfDrivePricesController do

  # This should return the minimal set of attributes required to create a valid
  # SelfDrivePrice. As you add validations to SelfDrivePrice, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "weekday" => "9.99" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SelfDrivePricesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all self_drive_prices as @self_drive_prices" do
      self_drive_price = SelfDrivePrice.create! valid_attributes
      get :index, {}, valid_session
      assigns(:self_drive_prices).should eq([self_drive_price])
    end
  end

  describe "GET show" do
    it "assigns the requested self_drive_price as @self_drive_price" do
      self_drive_price = SelfDrivePrice.create! valid_attributes
      get :show, {:id => self_drive_price.to_param}, valid_session
      assigns(:self_drive_price).should eq(self_drive_price)
    end
  end

  describe "GET new" do
    it "assigns a new self_drive_price as @self_drive_price" do
      get :new, {}, valid_session
      assigns(:self_drive_price).should be_a_new(SelfDrivePrice)
    end
  end

  describe "GET edit" do
    it "assigns the requested self_drive_price as @self_drive_price" do
      self_drive_price = SelfDrivePrice.create! valid_attributes
      get :edit, {:id => self_drive_price.to_param}, valid_session
      assigns(:self_drive_price).should eq(self_drive_price)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new SelfDrivePrice" do
        expect {
          post :create, {:self_drive_price => valid_attributes}, valid_session
        }.to change(SelfDrivePrice, :count).by(1)
      end

      it "assigns a newly created self_drive_price as @self_drive_price" do
        post :create, {:self_drive_price => valid_attributes}, valid_session
        assigns(:self_drive_price).should be_a(SelfDrivePrice)
        assigns(:self_drive_price).should be_persisted
      end

      it "redirects to the created self_drive_price" do
        post :create, {:self_drive_price => valid_attributes}, valid_session
        response.should redirect_to(SelfDrivePrice.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved self_drive_price as @self_drive_price" do
        # Trigger the behavior that occurs when invalid params are submitted
        SelfDrivePrice.any_instance.stub(:save).and_return(false)
        post :create, {:self_drive_price => { "weekday" => "invalid value" }}, valid_session
        assigns(:self_drive_price).should be_a_new(SelfDrivePrice)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        SelfDrivePrice.any_instance.stub(:save).and_return(false)
        post :create, {:self_drive_price => { "weekday" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested self_drive_price" do
        self_drive_price = SelfDrivePrice.create! valid_attributes
        # Assuming there are no other self_drive_prices in the database, this
        # specifies that the SelfDrivePrice created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        SelfDrivePrice.any_instance.should_receive(:update_attributes).with({ "weekday" => "9.99" })
        put :update, {:id => self_drive_price.to_param, :self_drive_price => { "weekday" => "9.99" }}, valid_session
      end

      it "assigns the requested self_drive_price as @self_drive_price" do
        self_drive_price = SelfDrivePrice.create! valid_attributes
        put :update, {:id => self_drive_price.to_param, :self_drive_price => valid_attributes}, valid_session
        assigns(:self_drive_price).should eq(self_drive_price)
      end

      it "redirects to the self_drive_price" do
        self_drive_price = SelfDrivePrice.create! valid_attributes
        put :update, {:id => self_drive_price.to_param, :self_drive_price => valid_attributes}, valid_session
        response.should redirect_to(self_drive_price)
      end
    end

    describe "with invalid params" do
      it "assigns the self_drive_price as @self_drive_price" do
        self_drive_price = SelfDrivePrice.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        SelfDrivePrice.any_instance.stub(:save).and_return(false)
        put :update, {:id => self_drive_price.to_param, :self_drive_price => { "weekday" => "invalid value" }}, valid_session
        assigns(:self_drive_price).should eq(self_drive_price)
      end

      it "re-renders the 'edit' template" do
        self_drive_price = SelfDrivePrice.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        SelfDrivePrice.any_instance.stub(:save).and_return(false)
        put :update, {:id => self_drive_price.to_param, :self_drive_price => { "weekday" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested self_drive_price" do
      self_drive_price = SelfDrivePrice.create! valid_attributes
      expect {
        delete :destroy, {:id => self_drive_price.to_param}, valid_session
      }.to change(SelfDrivePrice, :count).by(-1)
    end

    it "redirects to the self_drive_prices list" do
      self_drive_price = SelfDrivePrice.create! valid_attributes
      delete :destroy, {:id => self_drive_price.to_param}, valid_session
      response.should redirect_to(self_drive_prices_url)
    end
  end

end
