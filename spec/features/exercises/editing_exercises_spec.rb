require "rails_helper"

RSpec.feature "Listing exercise" do 
  
  before do
    @john = User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    
    
    @exercise = @john.exercises.create!( duration_in_min: 55,
                                  workout: "My body building activity",
                                  workout_date: Date.today)
                                  
    login_as(@john)
  end
  
  scenario "with valid data succeeds" do
    visit "/"
    click_link "My Lounge"
    
    path = "/users/#{@john.id}/exercises/#{@exercise.id}/edit"
    link = "a[href=\'#{ path }\']"
    find(link).click 
    
    fill_in "Duration", with: 45
    click_button "Update Exercise"
    
    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(45)
    expect(page).not_to have_content(55)
  end
end