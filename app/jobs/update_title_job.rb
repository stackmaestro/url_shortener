class UpdateTitleJob < ApplicationJob
  queue_as :default
  require 'open-uri'

  def perform(link_id)
    link = Link.find_by(id: link_id)
    return unless link
    title = Nokogiri::HTML(open(link.url)).css('title').text
    link.title = title
    link.save
  end
end