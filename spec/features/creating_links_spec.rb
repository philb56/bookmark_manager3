feature 'Creating links' do
  scenario 'Add a new bookmark with title and url' do
    visit ('/links/new')
    fill_in 'title' , with: 'Google'
    fill_in 'url', with: 'google.co.uk'
    click_button 'Save'
    expect(page).to have_content('Google')
    expect(page).to have_content('google.co.uk')
  end

end
