require('spec_helper')

describe MyModel do
  it 'should be true' do
    expect(MyModel.new.the_truth).to be true
  end
end

describe 'some stuff which requires js', js: true do

  before(:all) do
    page.driver.browser.manage.window.resize_to(1280, 1024)
  end

  it 'will use the default js driver' do

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
    #puts @federal_regions
    #puts @federal_regions[0]

    @federal_regions.each do |federal_region|
      find("ul[class='regions-groups']").find("li a[data-group-id='#{federal_region}']").click

      @regions_of_federal_regions = []
      find("ul[class='regions']").all('li').drop(1).each do |region|
        @regions_of_federal_regions << region.find('a')['data-region-id']
        sleep(0.5)
      end
      #puts @regions_of_federal_regions

      @regions_of_federal_regions.each do |region|
        find("ul[class='regions']").find("li a[data-region-id='#{region}']").click
        #puts @city_of_regions_of_federal_regions

        @city_of_regions_of_federal_regions = []
        find("ul[class='cities']").all('li').drop(1).each do |city|
          @city_of_regions_of_federal_regions << city.find('a')['rel']
          sleep(0.5)
        end

        @city_of_regions_of_federal_regions.each do |city|
          sleep(0.5)
          find("ul[class='cities']").find("li a[rel='#{city}']").click
          sleep(0.5)
          #expect(page).to have_content(city.capitalize)
          get_price
          sleep(0.5)
          find("a[class='city-select w-choose-city-widget']").click
          sleep(0.5)
        end
      end
    end

=begin
    count_regions_group = find("ul[class='regions-groups']").all('li').size
    puts count_regions_group
    find("ul[class='regions-groups']").all('li').drop(1).each do |region_group|
      region_group.find('a').click
      find("ul[class='regions']").all('li').drop(1).each do |region|
        region.find('a').click
        find("ul[class='cities']").all('li').drop(1).each do |city|
          city.find('a').click
          sleep(0.15)

          find("a[class='city-select w-choose-city-widget']").click
        end
      end
    end
=end


    #find("ul[class='regions-groups']").find(:css, 'li:nth-child(2)').find('a').click

    #count_regions_amurskaya = find("ul[class='regions']").all('li').size
    #puts count_regions_amurskaya


=begin
    find("ul[class='regions']").find(:css, 'li:nth-child(2)').find('a').click
    find("ul[class='cities']").find(:css, 'li:nth-child(2)').find('a').click
    expect(page).to have_content('Белогорск')
    get_price
=end
=begin
    find("input[class='form-control ui-autocomplete-input'").set("5\" Смартфон Huawei Honor 5A 16 ГБ золотистый").native.send_keys(:enter)
    price = find(".price_g span:first-child").text
    puts price
=end
  end

  after(:all) do
  end
end
