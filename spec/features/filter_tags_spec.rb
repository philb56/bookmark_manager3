feature 'Sorting the links by tags' do
  before(:each) do
     Bookmark.create(url: 'http://www.food.com', title: 'Makers Academy', tags: [Tag.first_or_create(name: 'education')])
     Bookmark.create(url: 'http://www.littlewritings.com', title: 'Google', tags: [Tag.first_or_create(name: 'bubbles')])
     Bookmark.create(url: 'http://www.fox.com', title: 'This is Zombocom', tags: [Tag.first_or_create(name: 'bubbles')])
     Bookmark.create(url: 'http://www.bubble-bobble.com', title: 'Bubble Bobble', tags: [Tag.first_or_create(name: 'bubbles')])
   end

  scenario 'user can see all the links with bubbles tag' do
    visit ('/tags/bubbles')

    within 'ul#links' do
     expect(page).not_to have_content('Makers Academy')
     expect(page).to have_content('Google')
     expect(page).to have_content('This is Zombocom')
     expect(page).to have_content('Bubble Bobble')
  end
end
end
