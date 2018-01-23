feature 'Display homepage' do
  scenario 'see the list of links' do
    Bookmark.create(url: 'bbc.co.uk', title: 'BBC')
    visit('/links')
    expect(page).to have_content('BBC')
  end
end
