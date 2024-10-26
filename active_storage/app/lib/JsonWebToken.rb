class JsonWebToken
  @rsa_private ||= OpenSSL::PKey::RSA.generate 1024
  @rsa_public = @rsa_private.public_key

  def self.encode(payload, exp = 1.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode payload, @rsa_private, "RS256"
  end

  def self.decode(token)
    decoded = JWT.decode token, @rsa_public, true, { algorithm: "RS256" }
    HashWithIndifferentAccess.new(decoded[0])
  end
end
