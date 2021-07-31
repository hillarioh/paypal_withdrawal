class User 
    @@token = ""
    APP_KEY = "254qwerty"

    def self.set_token(token)
        @@token = token
    end

    def self.authenticate
        result = @@token.split('.')
        mac = OpenSSL::HMAC.hexdigest("SHA256", APP_KEY, result[1])
        mac == result[0] ? true : false
    end

    def self.fetch_users
        url = URI("https://finplus.sandbox.mambu.com/api/users")
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request["Authorization"] = "Basic #{Rails.application.credentials.api_key}"

        response = https.request(request)

        return JSON[response.read_body.as_json]
    end

    def self.user_details
        result = @@token.split('.')
        user_info = JSON[Base64.decode64(result[1]).as_json]
        user_key = user_info["USER_KEY"]
        users = fetch_users()
        return users.select{ |user| user["encodedKey"] == user_key}

    end

end
