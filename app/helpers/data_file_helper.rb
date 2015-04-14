module DataFileHelper
  
   def render_datafile_download_icon title = nil, file
    if title.nil?
      link_to download_datafile_image_tag, sufia.download_path(file), { target: "_blank", title: "Download the document", id: "file_download", data: { label: file.id } }
    else
      link_to (download_datafile_image_tag(title) + title), sufia.download_path(file), { target: "_blank", title: title, id: "file_download", data: { label: file.id } }
    end
  end
  
  def download_datafile_image_tag title = nil
    if title.nil?
      image_tag "doc.png", { alt: "No preview available", class: "img-responsive" }
    else
      image_tag sufia.download_path(@generic_file, file: 'thumbnail'), { class: "img-responsive", alt: "#{title} of #{@generic_file.title.first}" }
    end
  end
  
end