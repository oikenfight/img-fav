class ImagesController < ApplicationController
  before_action :login?, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
    if @image.user_id != @current_user.id
      redirect_to image_url, notice: '他のユーザの投稿は編集できません'
    end

  end

  # POST /images
  # POST /images.json
  def create
    @image = @current_user.images.build(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    if @image.user_id == @current_user.id
      respond_to do |format|
        if @image.update(image_params)
          format.html { redirect_to @image, notice: 'Image was successfully updated.' }
          format.json { render :show, status: :ok, location: @image }
        else
          format.html { render :edit }
          format.json { render json: @image.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to image_url, nortice: 'この操作は投稿者しかできません'
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    if @image.user_id == @current_user.id
      @image.destroy
      respond_to do |format|
        format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to image_url,  notice: '他のユーザの投稿は削除できません'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:title, :data)
    end
end
