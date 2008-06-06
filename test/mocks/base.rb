require_library_or_gem 'flexmock'

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
    
    class Base
      class << self
        @@responses          = []
        @@in_test_mode       = false
        @@catch_all_response = nil
        
        def in_test_mode=(boolean)
          @@in_test_mode = boolean
        end
        
        def responses
          @@responses
        end
        
        def catch_all_response
          @@catch_all_response
        end

        def reset!
          responses.clear
        end
        
        def request_returns(response_data)
          responses.concat [response_data].flatten.map {|data| FakeResponse.new(data)}
        end
        
        def request_always_returns(response_data, &block)
          in_test_mode do
            @@catch_all_response = FakeResponse.new(response_data)
            yield
            @@catch_all_response = nil
          end
        end
        
        def in_test_mode(&block)
          self.in_test_mode = true
          yield
        ensure
          self.in_test_mode = false
        end
        
        alias_method :old_connection, :connection
        def connection
          if @@in_test_mode
            @mock_connection ||= 
              begin
                mock_connection = FlexMock.new
                mock_connection.mock_handle(:request) do
                  raise 'No responses left' unless response = catch_all_response || responses.shift
                  response
                end
                mock_connection
              end
          else
            old_connection
          end
        end
      end
    end
  end
end