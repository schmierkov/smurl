module ApplicationHelper
  def link_link(url)
    link_to truncate(url, length: 100), url, target: '_blank'
  end
end
