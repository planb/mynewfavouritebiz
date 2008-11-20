class TagsController < ApplicationController
  
  before_filter :get_business
  
  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        flash[:notice] = "#{@tag.name} Was Successfully Created"
        format.html { redirect_to tag_path(@business, @tag) }
        format.xml  { head :created, :location => tag_url(@business, @tag) }
      else
        format.html { render :action => tag_path(@tag) }
        format.xml  { render :xml => @tag.errors.to_xml }
      end
    end
  end
  
  # GET /tags/1;edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:business])
        flash[:success] = "#{@business.name} Was Successfully Updated"
        format.html { redirect_to business_path(@business) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @business.errors.to_xml }
      end
    end
  end
  
  private
  
  def get_business
    @business = Business.find_by_permalink(params[:business_id])
  end
end
