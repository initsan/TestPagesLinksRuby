require 'selenium-webdriver'

class StandartPage

  @driver
  @page_number
  @has_link
  @is_last

  attr_accessor :has_link, :is_last, :page_number

  def initialize(driver)
    @driver = driver
  end

  def set_has_link
    begin
      link = @driver.find_element(tag_name: 'a')
      @has_link = link.attribute("href").include? ".html"
    rescue Selenium::WebDriver::Error::NoSuchElementError
      @has_link = false
    end
  end

  def set_is_last
    begin
      last = @driver.find_element(xpath: "//*[contains(text(), 'последняя')]")
      @is_last = last.text.include? "последняя"
    rescue Selenium::WebDriver::Error::NoSuchElementError
      @is_last = false
    end
  end

  def setPage (num)
    @page_number = num
  end

end
