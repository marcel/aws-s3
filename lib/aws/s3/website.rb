require File.dirname(__FILE__) + "/content"  
module AWS
  module S3
    # To enable a bucket as a website you just specify its name.
    # 
    #   # Pick a existing bucket name, or else you'll get an error 
    #   Website.create('jukebox')
    #   By default index document is "index.html" and error document is "error.html" 
    #
    #   If Its different you can do
    #   Website.create('jukebox', "about.html", "404.html")
    #
    # 
    # Once you have succesfully enabled as website you can you can fetch it by name using Website.find.
    #
    #   music_website = Website.find('jukebox')
    #
    # The bucket that is not website enabled will will throw an error.
    # 
    # You can remove website from bucket using Website.delete.
    #
    #   Website.delete('jukebox')

    class Website < Base

		  class Builder < XmlGenerator #:nodoc:
		    attr_reader :index_page, :error_page
		    def initialize(index_page, error_page)
					@index_page  = index_page
					@error_page = error_page
					super()
		    end

		    def build
					xml.tag!('WebsiteConfiguration', 'xmlns' => 'http://s3.amazonaws.com/doc/2006-03-01/') do
						xml.IndexDocument do
					  	xml.Suffix index_page
						end
						xml.ErrorDocument do
					  	xml.Key error_page
						end
					end
  	    end
	    end

      class << self
        # To enable a bucket as a website you just specify its name.
        # 
        #   # Pick a existing bucket name, or else you'll get an error 
        #   Website.create('jukebox')
        #   By default index document is "index.html" and error document is "error.html" 
        #
        #   If Its different you can do
        #   Website.create('jukebox', "about.html", "404.html")
        
        def create(name=nil, index_page="index.html", error_page="error.html")
          put(path(name), {}, Builder.new(index_page, error_page).to_s).success?
        end
        
        # Fetches if a bucket is website enabled. 
        #
        #   website=Website.find('jukebox')
        #
        #   website.index_doc
        #   => 'index.html'
        #   website.error_doc
        #   => 'error.html'
        def find(name = nil)
          new(get(path(name)).website)
        end
        
        # disables a bucket aswebsite.
        #   Website.delete('photos')
        def delete(name = nil, options = {})
          Base.delete(path(name)).success?
        end
        
        private
          
          def path(name, options = {})
            if name.is_a?(Hash)
              options = name
              name    = nil
            end
            # "/#{website_name(name)}#{RequestOptions.process(options).to_query_string}"
            "/#{name}/?website"
          end
          
        include Content
      end
      
      def index_doc
        self.index_document["suffix"]
      end
      
      def error_doc
        self.error_document["key"]
      end
      
    end
  end
end
