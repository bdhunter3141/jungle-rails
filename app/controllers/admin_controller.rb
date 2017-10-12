class AdminController < ApplicationController
  http_basic_authenticate_with name: ENV['AUTHENTICATE_NAME'], password: ENV['AUTHENTICATE_PASSWORD']
end