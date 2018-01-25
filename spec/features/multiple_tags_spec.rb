feature 'Creating tags' do
  scenario 'Add a new bookmark with a tag' do
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
    # bookmark = Bookmark.first
    # expect(bookmark.tags.map(&:name)).to include('food')
    # expect(bookmark.tags.map(&:name)).to include('news')
    expect(page).to have_content('food')
    expect(page).to have_content('news')
    end

    scenario 'Add a new bookmark with a tag' do
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
      # expect(bookmark.tags[0].map(&:name)).to include('food')
      p bookmark.tags[0][:name]
      p bookmark
      expect(bookmark.tags[0][:name]).to eq('food')
      expect(bookmark.tags[1][:name]).to eq('news')
      end
end
