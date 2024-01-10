class PagesController < ApplicationController
  def index
    @flats = Flat.all
  end
end
