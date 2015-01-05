class ApiController < ApplicationController

  def missing
    fail "Unauthorized."
  end

end
