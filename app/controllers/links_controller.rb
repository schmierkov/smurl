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
    if link = Link.where(link_token_param).first
      link.update(hits: link.hits + 1)
      render nothing: true, status: 301, location: link.original_url, layout: false
    else
      render nothing: true, status: 404
    end
  end

  private

  # prevent exceeding of herokus db limit
  def clean_up
    if Link.count >= 9000
      Link.first.destroy
    end
  end

  def link_token_param
    params.permit(:token)
  end

  def original_url_param
    params.require(:original_url)
  end

  def normalized_url
    uri = URI.parse(original_url_param)
    url = uri.normalize.to_s
    url = "http://#{url}" if uri.scheme.nil?
    url
  rescue URI::InvalidURIError
    nil
  end
end
