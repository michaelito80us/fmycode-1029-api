json.stories do
  json.array! @stories do |story|
    json.extract! story, :id, :title, :content
  end
end
