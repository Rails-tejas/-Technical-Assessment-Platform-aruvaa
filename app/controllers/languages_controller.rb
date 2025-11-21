class LanguagesController < ApplicationController
    def index
    	@languages = Language.order(:name)
    end
end
