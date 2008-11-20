class UsersController < ApplicationController
  
  before_filter :login_required, :except => [:new, :create]
  
  # GET /users/1
  def index
    render "list"
  end
  
  # GET /businesses/1
  # GET /businesses/1.xml
  def show
    @user = User.find(params[:id])
    # List the last 5 businesses rated by a user.
    @businesses = Business.paginate_by_sql ["SELECT businesses.id, businesses.name, businesses.street, businesses.suburb, businesses.postcode, businesses.phone, businesses.email, businesses.url, businesses.permalink, businesses.checked, businesses.created_at, businesses.updated_at FROM businesses LEFT JOIN ratings ON ratings.rateable_id = businesses.id WHERE ratings.user_id = #{@user.id} ORDER BY ratings.created_at DESC"],
                                          :page => params[:page],
                                          :per_page => 5
    @pending_friends = @user.pending_friends_for_me
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @user.to_xml }
    end
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end
  
  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user.save!
    self.current_user = @user
    redirect_to user_path(current_user)
    flash[:notice] = "Thank You For Signing Up To MyNewFavourite.Biz"
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end
  
  # GET /users/1;edit
  def edit
    @user = User.find(self.current_user)
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(self.current_user)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:success] = 'You Have Successfully Updated Your Details'
        format.html { redirect_to user_url(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors.to_xml }
      end
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @users = Users.find(params[:id])
    @users.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.xml  { head :ok }
    end
  end
end