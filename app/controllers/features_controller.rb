class FeaturesController < ApplicationController
  before_filter :login_required
  before_filter :admin_required, :except => [:index, :show]
  
  # GET /features/1
  def index
    @completed_features = Feature.find(:all, :conditions => [ "completed_at IS NOT NULL" ])
    @proposed_features = Feature.find_by_sql("SELECT features.id, features.name, features.description, features.completed_at, features.permalink, avg(rating) AS avg_rating 
                                              FROM features LEFT JOIN ratings ON ratings.rateable_id = features.id 
                                              WHERE features.completed_at IS NULL 
                                              GROUP BY rateable_id 
                                              ORDER BY avg_rating DESC")
    #@proposed_features = Feature.find(:all, :conditions => [ "completed_at IS NULL" ])
  end
  
  # GET /features/1
  # GET /features/1.xml
  def show
    @feature = Feature.find_by_permalink(params[:id])
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @feature.to_xml }
    end
  end

  # GET /features/new
  def new
    @feature = Feature.new
  end

  # POST /features
  # POST /features.xml
  def create
    @feature = Feature.new(params[:feature])

    respond_to do |format|
      if @feature.save
        flash[:notice] = "Feature Created"
        format.html { redirect_to features_url }
        format.xml  { head :created, :location => feature_url(@feature) }
      else
        format.html { render :action => feature_path(@feature) }
        format.xml  { render :xml => @feature.errors.to_xml }
      end
    end
  end
  
  # GET /features/1;edit
  def edit
    @feature = Feature.find_by_permalink(params[:id])
  end

  # PUT /features/1
  # PUT /features/1.xml
  def update
    @feature = Feature.find_by_permalink(params[:id])

    respond_to do |format|
      if @feature.update_attributes(params[:feature])
        flash[:success] = "#{@feature.name} Was Successfully Updated"
        format.html { redirect_to feature_url(@feature) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feature.errors.to_xml }
      end
    end
  end

  # DELETE /features/1
  # DELETE /features/1.xml
  def destroy
    @feature = Feature.find(params[:id])
    @feature.destroy

    respond_to do |format|
      format.html { redirect_to features_url }
      format.xml  { head :ok }
    end
  end
  
  def completed
    # Mark all selected as completed.
    Feature.update_all(["completed_at = ?", Time.now], :id => params[:feature_ids])
    redirect_to features_path
  end
end