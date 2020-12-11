require 'byebug'

class SmhwParser
  DATA = %w[7/SXMB 9/FLXN 11/NFEO]

  def initialize
    task(method: :first, url: 'http://lvh.me:4200', data: DATA)
  end

  def first
    page.find("//*[@id='school-selector-search-box']").set('Groupcall Academy')
    page.first("//*[contains(@class, 'suggested-school-address')]").click
    page.find("//*[@id='identification']").set('teacher')
    page.find("//*[@id='password']").set('Password1')
    page.first("//*[contains(@class, 'btn-brand')]").click
    data.each do |class_group|
      task(method: :second, url: "http://lvh.me:4200/homeworks/new?classGroups=#{class_group}", data: class_group)
    end
  end

  def second
    PP.pp(
      {
        class_group: page.first("//*[@id='classes-filter'] //*[contains(@class, 'ember-power-select-selected-item')]").text,
        students: page.first("//*[@id='students-filter'] //*[contains(@class, 'ember-power-select-selected-item')]").text
      })
  rescue
    PP.pp "CATCH YOU! #{data}"
  end
end
