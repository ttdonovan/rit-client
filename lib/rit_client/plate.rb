require 'net/http'
require 'uri'
require 'benchmark'

module RitClient
  class Plate
    class << self

      def get(layout_name, instance_name, plate_name, publish_time = nil)
        path = published_plate_path(layout_name, instance_name, plate_name, publish_time)
        # Rails.logger.info "Publish from rit.: #{path.to_s}"
        res = http.send(:get, path)
        # ms = Benchmark.ms { res = http.send(:get, url.path) }
        # logger.info "--> %d %s (%d %.0fms)" % [result.code, result.message, result.body ? result.body.length : 0, ms]
        handle_response(res).body
      rescue Timeout::Error => e
        raise TimeoutError.new(e.message)
      end

      def published_plate_path(layout_name, instance_name, plate_name, publish_time = nil)
        if publish_time.nil? or RitClient.configuration.rails_env.call == 'production'
          '/published/' + [layout_name, instance_name, plate_name].compact.join('/')
        else
          '/published_on/' + [layout_name, instance_name, plate_name, publish_time.to_i].compact.join('/')
        end
      end

      def http
        configure_http(new_http)
      end

      def new_http
        Net::HTTP.new(RitClient.configuration.rit_host, RitClient.configuration.rit_port)
      end

      def configure_http(http)
        # Net::HTTP timeouts default to 60 seconds.
        timeout = RitClient.configuration.rit_timeout
        http.open_timeout = timeout
        http.read_timeout = timeout
        http
      end

      # Handles response and error codes from the remote service.
      def handle_response(response)
        case response.code.to_i
          when 200...400
            response
          when 404
            raise NotFoundError.new(response)
          else
            raise ConnectionError.new(response)
        end
      end
    end
  end
end