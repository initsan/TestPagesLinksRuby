require 'minitest/autorun'
require 'selenium-webdriver'
require './tests/StandartTestPage'



class TestPagesLinksTest < Minitest::Test

  @driver
  @base_url

  def setup
    service = Selenium::WebDriver::Service.chrome(path:'.\drivers\chromedriver.exe')
    @driver = Selenium::WebDriver.for :chrome, service: service
    @driver.manage.timeouts.implicit_wait = 5000
    @base_url = 'http://qa-web-test-task.s3-website.eu-central-1.amazonaws.com/'
  end

  def teardown
    @driver.quit
  end

  def go_through_all_pages
    pages = Array.new
    num_page = 8540

    until pages.find { |item| item.is_last == true } do
      current_page = StandartTestPage.new(@driver)
      current_page.set_page num_page
      current_page.set_has_link
      pages << current_page
      unless current_page.has_link
        current_page.set_is_last
      end
      num_page += 1
      @driver.get(@base_url + num_page.to_s + ".html")
    end
    pages
  end

  def print_pages_without_links(pages)
    result = pages.select { |page| page.has_link == false }
    result.each { |page|
      puts("Page #{page.page_number} has link = #{page.has_link} is last = #{page.is_last}")
    }
  end

  def test
    @driver.get @base_url
    print driver.current_url
    list_pages = go_through_all_pages
    print_pages_without_links(list_pages)

  end
end
