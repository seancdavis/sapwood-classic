class Api::V1::AuthController < ApplicationController

  private

    def authenticate_public_api_key!
      unless params[:public_key] == TaprootSetting.api.public_key
        fail "Unauthorized."
      end
    end

end
