class Writer

  def initialize
  end

  def write(file, write_options)
    s3 = Aws::S3::Resource.new(region: 'us-west-1')
    s3.bucket('exportspdf').object('s3filename').upload_file(file.path)
  end

  def [](val)
    self
  end

end