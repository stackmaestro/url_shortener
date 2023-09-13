class Link < ApplicationRecord
  require 'uri'

  validates_presence_of :url
  validate :validate_url
  validates_uniqueness_of :short_url
  after_initialize :generate_short_url, if: :new_record?
  after_create :update_title!

  scope :top_100_urls, -> { order("clicked DESC").limit(100) }

  private

  def validate_url
    uri = URI.parse(url)

    unless uri.is_a?(URI::HTTP) && !uri.host.nil?
      errors.add(:url, 'is not a valid url')
    end
  end

  def generate_short_url
    short_slug = loop do
      generated_slug = rand(36**8).to_s(36)
      break generated_slug unless Link.exists?(short_url: generated_slug)
    end

    self.short_url = "#{URI(url).host}/#{short_slug}"
  end

  def update_title!
    UpdateTitleJob.perform_later(id)
  end
end
