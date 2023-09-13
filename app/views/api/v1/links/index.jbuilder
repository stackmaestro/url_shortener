json.links do
  json.partial! "link", collection: @links, as: :link
end