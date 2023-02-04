Config =
  Struct.new(
    :senec_host,
    :senec_interval,
    :influx_schema,
    :influx_host,
    :influx_port,
    :influx_token,
    :influx_org,
    :influx_bucket,
    keyword_init: true,
  ) do
    def initialize(*options)
      super

      validate_url!(senec_url)
      validate_url!(influx_url)
      validate_interval!(senec_interval)
    end

    def influx_url
      "#{influx_schema}://#{influx_host}:#{influx_port}"
    end

    def senec_state_names
      @senec_state_names ||=
        begin
          puts 'Getting state names from SENEC by parsing source code...'
          names = Senec::State.new(host: senec_host).names
          puts "OK, got #{names.length} state names"
          names
        end
    end

    private

    def senec_url
      "http://#{senec_host}"
    end

    def validate_interval!(interval)
      return if interval.is_a?(Integer) && interval.positive?

      throw "Interval is invalid: #{interval}"
    end

    def validate_url!(url)
      uri = URI.parse(url)
      return if uri.is_a?(URI::HTTP) && !uri.host.nil?

      throw "URL is invalid: #{url}"
    end

    def self.from_env(options = {})
      new(
        {
          senec_host: ENV.fetch('SENEC_HOST'),
          senec_interval: ENV.fetch('SENEC_INTERVAL').to_i,
          influx_host: ENV.fetch('INFLUX_HOST'),
          influx_schema: ENV.fetch('INFLUX_SCHEMA', 'http'),
          influx_port: ENV.fetch('INFLUX_PORT', '8086'),
          influx_token: ENV.fetch('INFLUX_TOKEN'),
          influx_org: ENV.fetch('INFLUX_ORG'),
          influx_bucket: ENV.fetch('INFLUX_BUCKET'),
        }.merge(options),
      )
    end
  end
