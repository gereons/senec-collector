require 'influxdb-client'

class FluxWriter
  def self.push(record)
    new.push(record)
  end

  def push(record)
    return unless record

    write_api.write(
      data: point(record),
      bucket: influx_bucket,
      org: influx_org
    )
  end

  private

  def point(record)
    InfluxDB2::Point.new(
      name: influx_measurement,
      time: record.measure_time,
      fields: record.to_hash
    )
  end

  def influx_host
    @influx_host ||= ENV.fetch('INFLUX_HOST')
  end

  def influx_token
    @influx_token ||= ENV.fetch('INFLUX_TOKEN')
  end

  def influx_org
    @influx_org ||= ENV.fetch('INFLUX_ORG')
  end

  def influx_schema
    @influx_schema ||= ENV.fetch('INFLUX_SCHEMA', 'http')
  end

  def influx_port
    @influx_port ||= ENV.fetch('INFLUX_PORT', 8086)
  end

  def influx_bucket
    @influx_bucket ||= ENV.fetch('INFLUX_BUCKET')
  end

  def influx_measurement
    'SENEC'
  end

  def influx_client
    @influx_client ||= InfluxDB2::Client.new(
      "#{influx_schema}://#{influx_host}:#{influx_port}",
      influx_token,
      use_ssl: influx_schema == 'https',
      precision: InfluxDB2::WritePrecision::SECOND
    )
  end

  def write_api
    @write_api ||= influx_client.create_write_api
  end
end
