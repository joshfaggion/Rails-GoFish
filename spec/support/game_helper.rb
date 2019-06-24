module GameHelper
  def self.login_users(sessions)
    sessions.each_with_index do |session, index|
      session.visit '/'
      session.fill_in 'Name', with: "Charlos#{index + 1}"
      session.click_on 'Play'
    end
  end

  def self.join_game(sessions)
    sessions.each do |session|
      session.driver.refresh
      session.click_on 'Join Game 1 - waiting for players'
    end
  end

  def self.initialize_sessions
    # Way to do this with mapping?
    return [
      Capybara::Session.new(:selenium_chrome_headless, Rails.application),
      Capybara::Session.new(:selenium_chrome_headless, Rails.application),
      Capybara::Session.new(:selenium_chrome_headless, Rails.application),
      Capybara::Session.new(:selenium_chrome_headless, Rails.application)
    ]
  end
end
