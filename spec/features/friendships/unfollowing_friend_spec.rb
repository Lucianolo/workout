require "rails_helper"

RSpec.feature "Listing exercise" do 
  
  before do
    @john = User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    @sarah = User.create(first_name: "Sarah", last_name: "Jones", email: "sarah@example.com", password: "password")
    
    
    @e1 = @john.exercises.create( duration_in_min: 20,
                                  workout: "My body building activity",
                                  workout_date: Date.today)
  
    @e2 = @sarah.exercises.create( duration_in_min: 35,
                                  workout: "Weight lifting",
                                  workout_date: 2.days.ago)
    
    login_as(@john)
    @following = Friendship.create(user: @john, friend: @sarah)
    
  end
  
  scenario do
    visit "/"
    
    click_link "My Lounge"
    
    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click
    
    expect(page).to have_content(@sarah.full_name + ' unfollowed')
    
  end
end