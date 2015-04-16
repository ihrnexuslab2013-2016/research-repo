module Karkinos
  class KarkinosFileAuditService < Sufia::GenericFileAuditService
    
    def audit
      if !generic_file.attributes["data_files"].nil? 
        return audit_datafiles([])
      else
        return ["pass"]
      end
    end
    
    private
      def audit_datafiles(log)
        generic_file.data_files.each do |df|
          log << audit_file("content", df.content.uri, df.filename)
        end
        log
      end
  end
end