class SamsonIdentityService
  Result = Data.define(:success, :data, :error)

  MOCK_DATA = {
    "bvn" => {
      full_name: "Adewale Okonkwo",
      date_of_birth: "1990-03-15",
      phone_number: "08012345678",
      gender: "Male",
      image_url: "https://i.pravatar.cc/150?img=11",
      raw_response: { source: "mock" }
    },
    "nin" => {
      full_name: "Chidinma Eze",
      date_of_birth: "1988-07-22",
      phone_number: "08098765432",
      gender: "Female",
      image_url: "https://i.pravatar.cc/150?img=47",
      raw_response: { source: "mock" }
    }
  }.freeze

  def initialize(id_type:, id_number:)
    @id_type = id_type.to_s.downcase
    @id_number = id_number.to_s.strip
  end

  def call
    data = MOCK_DATA.fetch(@id_type, MOCK_DATA["bvn"]).dup
    data[:date_of_birth] = Date.parse(data[:date_of_birth])
    Result.new(success: true, data: data, error: nil)
  end
end
