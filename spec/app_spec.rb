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
    visit('/')
    find("a[class='city-select w-choose-city-widget']").click
    #count_regions_group = page.all("ul[class='regions-groups'").to_a.count
    #puts count_regions_group
    find("ul[class='regions-groups']").find(:css, 'li:nth-child(2)').find('a').click
    find("ul[class='regions']").find(:css, 'li:nth-child(2)').find('a').click
    find("ul[class='cities']").find(:css, 'li:nth-child(2)').find('a').click
    expect(page).to have_content('Белогорск')

    find("input[class='form-control ui-autocomplete-input'").set("5\" Смартфон Huawei Honor 5A 16 ГБ золотистый").native.send_keys(:enter)
    a = find(".price_g span:first-child").text
    puts a
    expect(page).to have_css('.price_g span:first-child', :text == '7 999\tp')
  end

  after(:all) do
  end
end
