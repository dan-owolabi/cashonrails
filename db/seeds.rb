admin = AdminUser.find_or_create_by!(email: "admin@cashonrails.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
  u.compliance_access = true
end

puts "Admin: #{admin.email} / password123"

merchants_data = [
  { business_name: "Collins Echefu Concepts", status: "approved", business_id_number: 590, reviewed_by: "Ayomide Bankole", confidence_score: 85, attempts: 3 },
  { business_name: "Zenith Tech Solutions", status: "pending", business_id_number: 591, reviewed_by: nil, confidence_score: nil, attempts: 1 },
  { business_name: "Apex Fintech Nigeria", status: "approved", business_id_number: 592, reviewed_by: "Chidi Okafor", confidence_score: 92, attempts: 2 },
  { business_name: "BlueStar Logistics", status: "rejected", business_id_number: 593, reviewed_by: "Fatima Hassan", confidence_score: 45, attempts: 5 },
]

merchants_data.each do |data|
  Merchant.find_or_create_by!(business_name: data[:business_name]) do |m|
    m.assign_attributes(data)
  end
end

puts "Seeded #{Merchant.count} merchants"
