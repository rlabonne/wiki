class WikiisController < ApplicationController
  def index
    @wikiis = Wikii.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
