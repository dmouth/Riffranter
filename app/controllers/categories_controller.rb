class CategoriesController < ApplicationController
  before_filter :is_admin?, :except => [:index, :show]
  before_filter :logged_in?
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.order("categories.name").select("distinct categories.*").joins(:personas => :rants).all

    # keep track of currently selected category via a cookie
    if cookies[:cat_index_cat_id].nil?
      @category = @categories.first
      cookies[:cat_index_cat_id] = @category.id if @category
    else
      cookies[:cat_index_cat_id] = params[:category_id] if !params[:category_id].nil?
      @category = Category.find cookies[:cat_index_cat_id]
    end

    # All rants for personas that exist in this category
    if @categories.count > 0
      @rants = Rant.order(:created_at.desc).where({:persona_id.in => @category.persona_ids}).includes([:persona,:user, :votes]).page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(@category, :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(@category, :notice => 'Category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    cookies.delete :cat_index_cat_id

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
end
