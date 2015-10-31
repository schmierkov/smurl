class ListingsController < ApplicationController

  def index
    @links = Link.order(hits: 'desc')
  end
end
