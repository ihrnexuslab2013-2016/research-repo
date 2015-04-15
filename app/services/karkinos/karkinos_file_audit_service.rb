module Karkinos
  class KarkinosFileAuditService < Sufia::GenericFileAuditService
    
    def audit
      audit_datafiles([])
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