class ScriptsController < ApplicationController
  def index
    @script = Script.first
  end

  def show
    @script = Script.first
  end

  def update
    Doc.delete_all
    Doc.create.build_doc(script_params[:text])
    Script.first.update(script_params)
  rescue StandardError => e
    flash.alert = e
  ensure
    redirect_to scripts_path
  end

  private

  def script_params
    params.require(:script).permit(:text)
  end
end
