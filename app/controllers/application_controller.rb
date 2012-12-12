class ApplicationController < ActionController::Base
  protect_from_forgery

  DIGEST = OpenSSL::Digest::Digest.new('sha1')
  HACKPAD_SERVER = URI.parse(ENV['HACKPAD_SERVER'])
  HACKPAD_CLIENT_ID = ENV['HACKPAD_CLIENT_ID']
  HACKPAD_SECRET = ENV['HACKPAD_SECRET']
  
  def escape_param p
    p.to_s.gsub("%", "%25").gsub("&", "%26").gsub("=", "%3D");
  end

  def signature_data method, path, content_type, opts
    query_string = opts.keys.sort.reject { |k|
      k == :clientId || k == :timestamp
    }.collect { |k|
      "#{escape_param k}=#{escape_param opts[k]}"
    }.join '&'
    query_string = "?#{query_string}" unless query_string.empty?
    "#{method}\n\n#{content_type}\n#{opts[:timestamp]}\n#{path}#{query_string}"
  end

  def request_signature_data req
    headers = req.to_hash.select { |k,v|
      k.downcase.starts_with? 'x-hkpd-'
    }.keys.collect { |k|
      "#{k.downcase}:#{req[k]}\n"
    }.sort.join
    "#{req.method}\n#{req['Content-MD5']}\n#{req['Content-Type']}\n#{req['Date']}\n#{headers}#{req.path}"
  end

  def embed_signature_data opts
    signature_data 'GET', '/ep/api/embed-pad', nil, opts
  end

  def hackpad_sign data
    logger.info "signing: #{data}"
    Base64.encode64(OpenSSL::HMAC.digest(DIGEST, HACKPAD_SECRET, data)).gsub("\n", "")
  end

  def set_hackpad_authorization req
    req['x-hkpd-date'] = Time.now.rfc2822 unless req['Date'] || req['x-hkpd-date']
    req['Authorization'] = "HKPD #{HACKPAD_CLIENT_ID}:#{hackpad_sign request_signature_data req}"
  end

  def hackpad_http
    Net::HTTP.new HACKPAD_SERVER.host, HACKPAD_SERVER.port
  end
end
