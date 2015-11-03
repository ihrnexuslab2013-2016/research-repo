class ZipFile < Tempfile
  attr_accessor :mime_type
  def initialize(filename)
    super(filename)
    @mime_type = 'application/zip'
    @temp = super
  end
  def stream
    fd = IO.sysopen(self.path,'r')
    s = IO.new(fd)
    print "---------stream----------"
    s
  ensure
    self.close  
  end   
end