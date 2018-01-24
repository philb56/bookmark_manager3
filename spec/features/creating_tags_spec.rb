feature 'Creating tags' do
  scenario 'Add a new bookmark with a tag' do
    visit ('/links/new')
    fill_in 'title' , with: 'Google'
    fill_in 'url', with: 'google.co.uk'
    fill_in 'tags' , with: 'food'
    click_button 'Save'
    bookmark = Bookmark.first
    expect(bookmark.tags.map(&:name)).to include('food')
    # expect(page).to have_content('food')
    end
end
