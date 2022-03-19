require 'minitest/autorun'
require 'selenium-webdriver'

class TestPagesLinksTest < Minitest::Test

  service = Selenium::WebDriver::Service.chrome(path:'.\drivers\chromedriver.exe')
  driver = Selenium::WebDriver.for :chrome, service: service

  def setup
    driver.manage.timeouts.implicit_wait = 5000
  end

  def teardown
    # driver.quit
  end

  def test
    driver.get 'http://qa-web-test-task.s3-website.eu-central-1.amazonaws.com/'
    print driver.current_url
    print driver.find_element(tag_name: 'a').text

  end
end
