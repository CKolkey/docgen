class ScriptsController < ApplicationController
  def index
    @script = Script.first
  end

  def show
    @script = Script.first
  end

  def update
    @script = Script.first
    @doc    = Doc.create

    @doc.build_doc(script_params[:text])
    @script.update(script_params)

  rescue StandardError
    @failed = true
  ensure
    redirect_to scripts_path
  end

  private

  def script_params
    params.require(:script).permit(:text)
  end
end
