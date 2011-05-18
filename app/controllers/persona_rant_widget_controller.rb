class PersonaRantWidgetController < ApplicationController
  def update_widget
    @persona = Persona.find params[:id]
  end
end
