class SubscribesController < ApplicationController
  # GET /subscribes
  # GET /subscribes.xml
  def index
    @subscribes = Subscribe.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subscribes }
    end
  end

  # GET /subscribes/1
  # GET /subscribes/1.xml
  def show
    @subscribe = Subscribe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subscribe }
    end
  end

  # GET /subscribes/new
  # GET /subscribes/new.xml
  def new
    @subscribe = Subscribe.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subscribe }
    end
  end

  # GET /subscribes/1/edit
  def edit
    @subscribe = Subscribe.find(params[:id])
  end

  # POST /subscribes
  # POST /subscribes.xml
  def create
    @subscribe = Subscribe.new(params[:subscribe])

    respond_to do |format|
      if @subscribe.save
        format.html { redirect_to(@subscribe, :notice => 'Subscribe was successfully created.') }
        format.xml  { render :xml => @subscribe, :status => :created, :location => @subscribe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subscribe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subscribes/1
  # PUT /subscribes/1.xml
  def update
    @subscribe = Subscribe.find(params[:id])

    respond_to do |format|
      if @subscribe.update_attributes(params[:subscribe])
        format.html { redirect_to(@subscribe, :notice => 'Subscribe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subscribe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subscribes/1
  # DELETE /subscribes/1.xml
  def destroy
    @subscribe = Subscribe.find(params[:id])
    @subscribe.destroy

    respond_to do |format|
      format.html { redirect_to(subscribes_url) }
      format.xml  { head :ok }
    end
  end
end
