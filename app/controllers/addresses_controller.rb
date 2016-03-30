class AddressesController < ApplicationController
  def index
    @addresses.all
  end
end
