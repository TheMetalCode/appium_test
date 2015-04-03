require_relative 'requires'

describe 'Home Screen Navigation' do

  it 'First cell' do
    cell_title = home.first_cell.title
    home.first_cell.click
    inner_screen.has_text? cell_title
  end
end
