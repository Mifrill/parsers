require_relative '../settings/capybara'

module DNSParser
  class Parser
    include Capybara::DSL

    def get_price
      find("input[class='form-control ui-autocomplete-input'").set(@site).native.send_keys(:enter)
      find(".price_g span:first-child").text
    end

    def get_report
      page.driver.browser.manage.window.resize_to(1280, 1024)

      @site = "5\" Смартфон Huawei Honor 5A 16 ГБ золотистый"

      visit('/')

      find("a[class='city-select w-choose-city-widget']").click

      @federal_regions = []
      find("ul[class='regions-groups']").all('li').drop(1).each do |region_group|
        @federal_regions << region_group.find('a')['data-group-id']
      end

      @federal_regions.each do |federal_region|
        find("ul[class='regions-groups']").find("li a[data-group-id='#{federal_region}']").click

        @regions_of_federal_regions = []
        find("ul[class='regions']").all('li').drop(1).each do |region|
          @regions_of_federal_regions << region.find('a')['data-region-id']
        end

        @regions_of_federal_regions.each do |region|
          find("ul[class='regions']").find("li a[data-region-id='#{region}']").click

          @city_of_regions_of_federal_regions = []
          find("ul[class='cities']").all('li').drop(1).each do |city|
            @city_of_regions_of_federal_regions << city.find('a')['rel']
          end

          @city_of_regions_of_federal_regions.each do |city|

            #TODO record JSON file report
            puts find("ul[class='regions-groups']").find("li a[data-group-id='#{federal_region}']").text
            puts find("ul[class='regions']").find("li a[data-region-id='#{region}']").text
            puts city

            find("ul[class='cities']").find("li a[rel='#{city}']").click

            puts get_price

            find("a[class='city-select w-choose-city-widget']").click
          end
        end
      end
    end
  end
end
