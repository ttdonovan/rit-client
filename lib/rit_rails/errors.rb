if defined?(ActionController)
  module ActionController
    class ConnectionError < StandardError
      def initialize(response=nil)
        @response = response
      end

      def to_s
        message = "Failed."
        unless @response.nil?
          message << "  Response code = #{@response.code}." if @response.respond_to?(:code)
          message << "  Response message = #{@response.message}." if @response.respond_to?(:message)
        end
        message
      end
    end

    class NotFoundError < ConnectionError; end
    class TimeoutError < ConnectionError; end
  end
end