feature 'Creating tags' do
  scenario 'Add a new bookmark with a tag' do
    visit ('/links/new')
    fill_in 'title' , with: 'Google'
    fill_in 'url', with: 'google.co.uk'
    fill_in 'tags' , with: 'food banana'
    click_button 'Save'
    expect(page).to have_content('"food", "banana"')
  end

  scenario 'Add the same bookmark with another tag' do
    visit ('/links/new')
    fill_in 'title' , with: 'Google'
    fill_in 'url', with: 'google.co.uk'
    fill_in 'tags' , with: 'food'
    click_button 'Save'
    visit ('/links/new')
    fill_in 'title' , with: 'Google'
    fill_in 'url', with: 'google.co.uk'
    fill_in 'tags' , with: 'news'
    click_button 'Save'
    bookmark = Bookmark.first(title: "Google" )
    expect(bookmark.tags.map(&:name)).to include('food', 'news')
  end
end
