require './config/boot'
require './config/environment'

file        = File.open("#{Rails.root}/public/health_centers.json")
center_json = JSON.parse file.read

center_json.each do |center|
  HealthCenter.create!(
    name:      center['Name'],
    operator:  center['Operator'],
    status:    center['Status_1'],
    latitude:  center['Y'],
    longitude: center['X'],
    street:    center['ARC_Addres'],
    city:      center['ARC_City'],
    state:     center['ARC_State'],
    zip:       center['ARC_Zip']
  )
end
