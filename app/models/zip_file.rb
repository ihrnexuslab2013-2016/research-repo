class ZipFile < Tempfile
  attr_accessor :mime_type
  def initialize(filename)
    super(filename)
    @mime_type = 'application/zip'
    @temp = super
  end
  def stream
    File.read(self.path)
  end   
end