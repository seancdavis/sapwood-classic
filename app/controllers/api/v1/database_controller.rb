class Api::V1::DatabaseController < Api::V1::AuthController

  def dump
    authenticate_public_api_key!
    TaprootDatabase.new.backup
    render :text => 'Ok.', :status => 200
  end

end
