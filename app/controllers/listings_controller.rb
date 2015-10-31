class ListingsController < ApplicationController
  before_filter :authenticate

  def index
    @links = Link.order(hits: 'desc')
  end
end
