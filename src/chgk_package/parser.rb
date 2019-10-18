require_relative 'crawler'

module ChgkPackage

  class Parser

    XPATH_MAPPER = {
      package_element: '//div[@class="random_question"]',
      question_origin: './p/a[contains(@href, "/tour/")]',
      question_images: './strong[contains(., "Вопрос")]/following-sibling::img',
      question_text: './strong[contains(., "Вопрос")]/following-sibling::text()',
      answer_text: './/p[child::strong[contains(., "Ответ:")]]/text()',
      extra_text: './/div[@class="razdatka"]/text()',
      answer_comment: './/p[child::strong[contains(., "Комментарий:")]]/text()'
    }.freeze

    def self.get_package(params)
      page = Crawler.get_page(params)
      page.xpath(XPATH_MAPPER[:package_element]).map.with_index do |package_element, index|
        question           = {}
        question[:text]    = extract_text(package_element, :question_text)
        question[:extra]   = extract_text(package_element, :extra_text)
        question[:number]  = index.next
        question[:origin]  = extract_text(package_element, :question_origin)
        question[:images]  = extract_attributes(package_element, :question_images, 'src')
        question[:answer]  = extract_text(package_element, :answer_text)
        question[:comment] = extract_text(package_element, :answer_comment)
        question
      end
    end

    def self.extract_text(element, key)
      element.xpath(XPATH_MAPPER[key]).text.strip
    end

    def self.extract_attributes(element, key, attr)
      element.xpath(XPATH_MAPPER[key]).map { |el| el.attr(attr) }
    end
  end
end