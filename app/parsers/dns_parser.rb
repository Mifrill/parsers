# TODO: refactoring
class DNSParser
  attr_reader :item

  def initialize
    @config ||= begin
      page.driver.browser.manage.window.resize_to(1280, 1024)
    end

    @item ||= '5" Смартфон Huawei Honor 5A 16 ГБ золотистый'
  end

  def start_parser
    visit('http://www.dns-shop.ru/')
    find("a[class='city-select w-choose-city-widget']").click

    federal_regions = []
    find("ul[class='regions-groups']").all('li').drop(1).each do |region_group|
      federal_regions << region_group.find('a')['data-group-id']
    end

    federal_regions.each do |federal_region|
      find("ul[class='regions-groups']").find("li a[data-group-id='#{federal_region}']").click

      regions_of_federal_regions = []
      find("ul[class='regions']").all('li').drop(1).each do |region|
        regions_of_federal_regions << region.find('a')['data-region-id']
      end

      regions_of_federal_regions.each do |region|
        find("ul[class='regions']").find("li a[data-region-id='#{region}']").click

        city_of_regions_of_federal_regions = []
        find("ul[class='cities']").all('li').drop(1).each do |city|
          city_of_regions_of_federal_regions << city.find('a')['rel']
        end

        city_of_regions_of_federal_regions.each do |city|
          get_report(federal_region, region, city)
          sleep(0.5)
          find("ul[class='cities']").find("li a[rel='#{city}']").click

          puts price
          screenshot(city)

          find("a[class='city-select w-choose-city-widget']").click
        end
      end
    end
  end

  private

  def price
    find("input[class='form-control ui-autocomplete-input'").set(item).native.send_keys(:enter)
    find('.price_g span:first-child').text
  end

  def get_report(fed_reg, reg, city)
    # TODO: record JSON file report
    puts find("ul[class='regions-groups']").find("li a[data-group-id='#{fed_reg}']").text
    puts find("ul[class='regions']").find("li a[data-region-id='#{reg}']").text
    puts city
  end

  def screenshot(city)
    time = Time.now.strftime('%d.%m.%Y %H:%M')
    screenshot_path = city + '_screen_' + time + '.png'
    page.save_screenshot(screenshot_path, full: true)
  end
end
