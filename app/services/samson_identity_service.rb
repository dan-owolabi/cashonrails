class SamsonIdentityService
  SAMSON_API_URL = ENV.fetch("SAMSON_API_URL", "https://api.samson.example.com")
  SAMSON_API_KEY = ENV.fetch("SAMSON_API_KEY", "")

  Result = Data.define(:success, :data, :error)

  def initialize(id_type:, id_number:)
    @id_type = id_type.to_s.downcase
    @id_number = id_number.to_s.strip
  end

  def call
    response = make_request
    parse_response(response)
  rescue => e
    Result.new(success: false, data: nil, error: e.message)
  end

  private

  def make_request
    require "net/http"
    uri = URI("#{SAMSON_API_URL}/v1/#{@id_type}/verify")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == "https"
    http.read_timeout = 30

    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{SAMSON_API_KEY}"
    request["Content-Type"] = "application/json"
    request.body = { id_number: @id_number }.to_json

    http.request(request)
  end

  def parse_response(response)
    body = JSON.parse(response.body)

    if response.is_a?(Net::HTTPSuccess) && body["status"] == "success"
      Result.new(success: true, data: normalize_data(body["data"]), error: nil)
    else
      Result.new(success: false, data: nil, error: body["message"] || "Verification failed")
    end
  rescue JSON::ParserError
    Result.new(success: false, data: nil, error: "Invalid response from provider")
  end

  def normalize_data(data)
    {
      full_name: data["full_name"] || data["name"],
      date_of_birth: data["date_of_birth"] || data["dob"],
      phone_number: data["phone_number"] || data["mobile"],
      gender: data["gender"],
      image_url: data["image"] || data["photo_url"],
      raw_response: data
    }
  end
end
