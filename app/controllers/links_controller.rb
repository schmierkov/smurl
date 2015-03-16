class LinksController < ApplicationController

  before_filter :clean_up

  def index
  end

  def create
    @link = Link.where(original_url: normalized_url).first_or_create

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

  def link_token
    params.permit(:token)
  end

  def normalized_url
    uri = URI.parse(params[:original_url])
    url = uri.normalize.to_s
    url = "http://#{url}" if uri.scheme.nil?
    url
  rescue URI::InvalidURIError
    nil
  end
end
