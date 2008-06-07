module AWS
  module S3
    class FakeResponse < String
      attr_reader :code, :body, :headers
      def initialize(options = {})
        @code    = options.delete(:code)  || 200 
        @body    = options.delete(:body)  || ''
        @headers = {'content-type' => 'application/xml'}.merge(options.delete(:headers) || {})
        super(@body)
      end

      # For ErrorResponse
      def response
        self
      end
      
      def [](header)
        headers[header]
      end
      
      def each(&block)
        headers.each(&block)
      end
      alias_method :each_header, :each
    end
  end
end