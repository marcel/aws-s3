module Content
  attr_reader :object_cache #:nodoc:
  
  include Enumerable
  
  def initialize(attributes = {}) #:nodoc:
    super
    @object_cache = []
    build_contents!
  end
  
  private        
    def build_contents!
      return unless has_contents?
      attributes.delete('contents').each do |content|
        add new_object(content)
      end
    end
    
    def has_contents?
      attributes.has_key?('contents')
    end      
end