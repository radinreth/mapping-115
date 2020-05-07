class CsvsController < ApplicationController
  def new; end

  def create
    tempfile = file_params[:file]
    ::CallerLogsImportService.process(tempfile.path)

    redirect_to root_path, notice: 'successfully imported'
  end

  private

  def file_params
    params.require(:call_logs).permit(:file)
  end
end
