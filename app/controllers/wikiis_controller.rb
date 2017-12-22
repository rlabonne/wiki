class WikiisController < ApplicationController
  def index
    @wikiis = Wikii.all
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
  end
end
