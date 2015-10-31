module ApplicationHelper
  def link_link(url)
    link_to url, url, target: '_blank'
  end
end
