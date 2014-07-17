json.array!(@tasks) do |task|
  json.extract! task, :id, :title, :deadline, :content, :contributor_id
  json.url task_url(task, format: :json)
end
