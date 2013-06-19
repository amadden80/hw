class WelcomeController < ApplicationController
  def index
    render text: 'Welcome Home Dear...'
  end
end