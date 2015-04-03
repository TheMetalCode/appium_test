require_relative 'requires'

describe 'Home Screen Navigation' do

  it 'First cell' do
    home.first_cell.click
    inner_screen.has_text? 'Accessibility Node Provider'
  end
end