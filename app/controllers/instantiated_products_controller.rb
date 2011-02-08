class InstantiatedProductsController < ApplicationController
  # GET /instantiated_products
  # GET /instantiated_products.xml
  def index
    @instantiated_products = InstantiatedProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @instantiated_products }
    end
  end

  # GET /instantiated_products/1
  # GET /instantiated_products/1.xml
  def show
    @instantiated_product = InstantiatedProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @instantiated_product }
    end
  end

  # GET /instantiated_products/new
  # GET /instantiated_products/new.xml
  def new
    @instantiated_product = InstantiatedProduct.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @instantiated_product }
    end
  end

  # GET /instantiated_products/1/edit
  def edit
    @instantiated_product = InstantiatedProduct.find(params[:id])
  end

  # POST /instantiated_products
  # POST /instantiated_products.xml
  def create
    @instantiated_product = InstantiatedProduct.new(params[:instantiated_product])

    respond_to do |format|
      if @instantiated_product.save
        format.html { redirect_to(@instantiated_product, :notice => 'Instantiated product was successfully created.') }
        format.xml  { render :xml => @instantiated_product, :status => :created, :location => @instantiated_product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @instantiated_product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /instantiated_products/1
  # PUT /instantiated_products/1.xml
  def update
    @instantiated_product = InstantiatedProduct.find(params[:id])

    respond_to do |format|
      if @instantiated_product.update_attributes(params[:instantiated_product])
        format.html { redirect_to(@instantiated_product, :notice => 'Instantiated product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @instantiated_product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /instantiated_products/1
  # DELETE /instantiated_products/1.xml
  def destroy
    @instantiated_product = InstantiatedProduct.find(params[:id])
    @instantiated_product.destroy

    respond_to do |format|
      format.html { redirect_to(instantiated_products_url) }
      format.xml  { head :ok }
    end
  end
end
