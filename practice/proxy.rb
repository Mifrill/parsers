class Distil
  def parse
    driver  = Capybara::Mechanize::Driver.new("distil")

    driver.configure do |agent|
      agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
      agent.idle_timeout = 20
    end
  end

  def change_proxy(driver)
    proxy_url = Addressable::URI.parse("http://pubproxy.com/api/proxy")
    proxy_url.query_values = {
        "limit" => "20", "format" => "json", "HTTPS" => "true", "country" => "US",
        "POST" => "true", "USER_AGENT" => "true", "GOOGLE" => "true", "LAST_CHECK" => "1",
        "COOKIES" => "true", "REFERER" => "true"
    }

    @proxy_list ||= Net::HTTP.get(proxy_url)
    proxy = JSON.parse(@proxy_list)["data"].sample
    driver.browser.agent.set_proxy(proxy["ip"], proxy["port"])
  end
end
