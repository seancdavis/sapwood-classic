class BuilderController < ApplicationController

  include Builder::SitesHelper, Builder::PageTypesHelper, Builder::PagesHelper

  before_filter :init_options

  private

    def init_options
      @options = {
        'sidebar' => true,
        'body_classes' => ''
      }
    end

end
