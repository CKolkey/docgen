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

    @script.update(script_params)
    @doc.build_doc(script_params[:text])

    redirect_to scripts_path
  end

  private

  def script_params
    params.require(:script).permit(:text)
  end
end
