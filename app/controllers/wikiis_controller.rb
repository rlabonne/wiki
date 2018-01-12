class WikiisController < ApplicationController
  include Pundit
  protect_from_forgery

  def index
    @wikiis = policy_scope(Wikii.all)
  end

  def show
    @wikii = Wikii.find(params[:id])
  end

  def new
    @wikii = Wikii.new
  end

  def create
    @wikii = Wikii.new
    @wikii.title = params[:wikii][:title]
    @wikii.body = params[:wikii][:body]
    @wikii.private = params[:wikii][:private]
    @wikii.user = current_user

    if @wikii.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wikii
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wikii = Wikii.find(params[:id])
  end

  def update
    @wikii = Wikii.find(params[:id])
    authorize @wikii
    @wikii.title = params[:wikii][:title]
    @wikii.body = params[:wikii][:body]
    @wikii.private = params[:wikii][:private]

    if @wikii.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wikii
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wikii = Wikii.find(params[:id])
    authorize @wikii

    if @wikii.destroy
      flash[:notice] = "\"#{@wikii.title}\" was deleted successfully."
      redirect_to wikiis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end
end
