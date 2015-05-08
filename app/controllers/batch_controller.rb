class BatchController < ApplicationController
  include Sufia::BatchControllerBehavior

  self.edit_form_class = KarkinosBatchEditForm
  
   def update
      authenticate_user!
      @batch = Batch.find_or_create(params[:id])
      @batch.status = ["processing"]
      @batch.save
      
      file_attributes = edit_form_class.model_attributes(params[:generic_file])
      job = KarkinosBatchUpdateJob.new(current_user.user_key, params[:id], params[:title], file_attributes, params[:visibility])
      job.creation=true
      Sufia.queue.push(job)
      flash[:notice] = 'Your files are being processed by ' + t('sufia.product_name') + ' in the background. The metadata and access controls you specified are being applied. Files will be marked <span class="label label-danger" title="Private">Private</span> until this process is complete (shouldn\'t take too long, hang in there!). You may need to refresh your dashboard to see these updates.'
      if uploading_on_behalf_of? @batch
        redirect_to sufia.dashboard_shares_path
      else
        redirect_to sufia.dashboard_files_path
      end
  end
end