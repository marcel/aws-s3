require_relative 'bucket'

module AWS
  class S3
    def initialize(options)
    end

    def buckets
      { 'exportspdf' => Bucket.new('exportspdf') }
    end

  end
end

