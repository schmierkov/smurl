class LinksController < ApplicationController

  before_filter :clean_up

  def index
    @links = Link.last(100)
  end

  def create
    @link = Link.where(link_params).first_or_create

    if @link.persisted?
      render :show
    else
      redirect_to root_path
    end
  end

  def show
    @link = Link.where(link_token).first

    @link.update(hits: @link.hits + 1)
    render nothing: true, status: 301, location: @link.original_url, layout: false
  end

  private

  # prevent exceeding of herokus db limit
  def clean_up
    if Link.count >= 9000
      Link.first.destroy
    end
  end

  def link_params
    params.permit(:original_url)
  end

  def link_token
    params.permit(:token)
  end
end
