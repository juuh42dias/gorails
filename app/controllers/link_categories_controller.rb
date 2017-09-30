class LinkCategoriesController < ApplicationController
  before_action :set_link_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  # GET /link_categories
  # GET /link_categories.json
  def index
    @link_categories = LinkCategory.all
  end

  # GET /link_categories/1
  # GET /link_categories/1.json
  def show
  end

  # GET /link_categories/new
  def new
    @link_category = LinkCategory.new
  end

  # GET /link_categories/1/edit
  def edit
  end

  # POST /link_categories
  # POST /link_categories.json
  def create
    @link_category = LinkCategory.new(link_category_params)

    respond_to do |format|
      if @link_category.save
        format.html { redirect_to @link_category, notice: 'Link category was successfully created.' }
        format.json { render :show, status: :created, location: @link_category }
      else
        format.html { render :new }
        format.json { render json: @link_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /link_categories/1
  # PATCH/PUT /link_categories/1.json
  def update
    respond_to do |format|
      if @link_category.update(link_category_params)
        format.html { redirect_to @link_category, notice: 'Link category was successfully updated.' }
        format.json { render :show, status: :ok, location: @link_category }
      else
        format.html { render :edit }
        format.json { render json: @link_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /link_categories/1
  # DELETE /link_categories/1.json
  def destroy
    @link_category.destroy
    respond_to do |format|
      format.html { redirect_to link_categories_url, notice: 'Link category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
  def set_link_category
    @link_category = LinkCategory.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def link_category_params
    params.require(:link_category).permit(:name)
  end
end
