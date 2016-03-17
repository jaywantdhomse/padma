json.array!(@vacancies) do |vacancy|
  json.extract! vacancy, :id, :post, :experience, :skills
  json.url vacancy_url(vacancy, format: :json)
end
