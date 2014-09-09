require 'capybara/webkit'
require 'capybara/rspec'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'
require 'sinatra'

get '/' do
  <<-HTML
    <html>
      <head>
        <link rel='stylesheet' href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.1.0/css/font-awesome.css">
      </head>
      <body>
        Click me: <a href="/success"><i class='fa fa-times'></i></a>
      </body>
    </html>
  HTML
end

get '/success' do
  <<-HTML
    <html>
      <body>
        SUCCESS!
      </body>
    </html>
  HTML
end

Capybara.javascript_driver = :webkit
Capybara.run_server = true
Capybara.app = Sinatra::Application

Capybara::Screenshot.autosave_on_failure = true

feature 'Clicking a fontawesome icon', :js do
  it 'works' do
    visit '/'
    find('.fa-times').click
    expect(page).to have_content 'SUCCESS!'
  end
end
