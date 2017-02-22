require "rails_helper"

RSpec.feature "Listing exercise" do 
  
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    
    
    @exercise = @john.exercises.create!( duration_in_min: 55,
                                  workout: "My body building activity",
                                  workout_date: Date.today)
                                  
    login_as(@john)
  end
  
  scenario  do
    visit "/"
    click_link "My Lounge"
    
    path = "/users/#{@john.id}/exercises/#{@exercise.id}"
    link = "//a[contains(@href,\'#{ path }\') and .//text()='Destroy']"
    
    find(:xpath, link).click 
    
    
    
    expect(page).to have_content("Exercise has been deleted")
    
  end
end