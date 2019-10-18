require 'curb'
require 'nokogiri'

module ChgkPackage


  # Params not used now
  # maybe in future implementations
  class Crawler
    PARAMS_MAPPER = {
      type_chgk: 'question_type[1]',
      type_brain_ring: 'question_type[2]',
      type_internet: 'question_type[3]',
      type_wingless: 'question_type[4]',
      type_my_game: 'question_type[5]',
      type_erudite: 'question_type[6]',
      complexity: 'complexity',
      limit: 'limit',
      from_date_day: 'from_date[day]',
      from_date_month: 'from_date[month]',
      frome_date_year: 'from_date[year]',
      to_date_day: 'to_date[day]',
      to_date_month: 'to_date[month]',
      to_date_year: 'to_date[year]'
    }.freeze
    RANDOM_PACKAGE_POST_URL = 'https://db.chgk.info/random'.freeze
    def self.get_page(params)
      params = formatted_params(params)
      page   = Curl::Easy.http_post(TEST_URL, params)
      Nokogiri::HTML(page.body_str)
    end

    def self.formatted_params(params)
      params.map do |k, v|
        Curl::PostField.content(PARAMS_MAPPER[k], v)
      end << Curl::PostField.content('op', 'Получить пакет')
    end
  end

end