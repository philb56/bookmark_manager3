feature 'Sorting the links by tags' do
  scenario 'user can see all the links with bubbles tag' do
    visit ('/links/new')
    fill_in 'title' , with: 'thelittleblogofA'
    fill_in 'url', with: 'thelittleblogofa.com'
    fill_in 'tags', with: 'bubbles'
    click_button 'Save'
    visit ('/tags/bubbles')
    expect(page).to have_content('thelittleblogofA')

  end
end
