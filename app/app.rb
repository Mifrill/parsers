require_relative '../settings/capybara'

module DNSParser
  class Parser
    include Capybara::DSL
    def get_report
      page.driver.browser.manage.window.resize_to(1280, 1024)

      def get_price
        sleep(0.5)
        find("input[class='form-control ui-autocomplete-input'").set("5\" Смартфон Huawei Honor 5A 16 ГБ золотистый").native.send_keys(:enter)
        price = find(".price_g span:first-child").text
        puts price
      end

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
          sleep(0.5)
        end

        @regions_of_federal_regions.each do |region|
          find("ul[class='regions']").find("li a[data-region-id='#{region}']").click

          @city_of_regions_of_federal_regions = []
          find("ul[class='cities']").all('li').drop(1).each do |city|
            @city_of_regions_of_federal_regions << city.find('a')['rel']
            sleep(0.5)
          end

          @city_of_regions_of_federal_regions.each do |city|
            sleep(0.5)
            find("ul[class='cities']").find("li a[rel='#{city}']").click
            sleep(0.5)
            get_price
            sleep(0.5)
            find("a[class='city-select w-choose-city-widget']").click
            sleep(0.5)
          end
        end
      end
    end
  end
end
