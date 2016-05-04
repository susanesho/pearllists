class AuthToken
  SECRET = Rails.application.secrets.secret_key_base
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET, "HS256")
  end

  def self.decode(token)
    payload = JWT.decode(token, SECRET, true, algorithm: "HS256")[0]
    payload
  rescue
    nil
  end
end
