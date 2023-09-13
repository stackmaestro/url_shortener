json.link do
  json.partial! "link", link: @link if @link.present?
end
