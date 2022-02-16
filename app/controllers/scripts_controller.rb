class ScriptsController < ApplicationController
  def index
    @script = Script.first
  end

  def show
    @script = Script.first
  end

  def update
    @script = Script.first

    ActiveRecord::Base.transaction do
      @script.update(script_params)
      @script.build_doc
    end

    ActiveRecord::Base.connection.execute("BEGIN TRANSACTION; END;")
    redirect_to scripts_path
  end

  private

  def script_params
    params.require(:script).permit(:text)
  end
end
