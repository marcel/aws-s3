require_relative 'writer'

class Bucket
  def initialize(bucket_name)
  end

  def objects(name = nil, options = {})
    Writer.new
  end

end