class BusinessesController < ApplicationController
  before_filter :login_required
  before_filter :admin_required, :except => [:index, :new, :create, :show]
  
  # GET /businesses
  # GET /businesses.xml
  def index
  end

  # GET /businesses/1
  # GET /businesses/1.xml
  def show
    @business = Business.find_by_permalink(params[:id])
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @business.to_xml }
    end
  end

  # GET /businesses/new
  def new
    @business = Business.new
  end

  # POST /businesses
  # POST /businesses.xml
  def create
    @business = Business.new(params[:business])

    respond_to do |format|
      if @business.save
        flash[:notice] = "#{@business.name} Was Successfully Created"
        format.html { redirect_to business_path(@business) }
        format.xml  { head :created, :location => business_url(@business) }
      else
        format.html { render :action => business_path(@business) }
        format.xml  { render :xml => @business.errors.to_xml }
      end
    end
  end
  
  # GET /businesses/1;edit
  def edit
    @business = Business.find_by_permalink(params[:id])
  end

  # PUT /businesses/1
  # PUT /businesses/1.xml
  def update
    @business = Business.find_by_permalink(params[:id])

    respond_to do |format|
      if @business.update_attributes(params[:business])
        flash[:success] = "#{@business.name} Was Successfully Updated"
        format.html { redirect_to business_path(@business) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @business.errors.to_xml }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.xml
  def destroy
    @business = Business.find_by_permalink(params[:id])
    @business.destroy

    respond_to do |format|
      format.html { redirect_to businesses_url }
      format.xml  { head :ok }
    end
  end
end
