module SearchesHelper

  def show_availability?(record, scope)
    scope.try(:ils_adapter).present? &&
    !is_online_resource?(record) &&
    !is_journal?(record) &&
    !is_newspaper?(record)
  end

  def page_stats(scope, search_request, total_records)
    page_start = search_request.from + 1
    page_end   = search_request.from + search_request.size
    page_end   = total_records if page_end > total_records

    content_tag :span, class: "page-stats" do
      "#{page_start} – #{page_end} von #{total_records}"
    end
  end

  def amazon_image_url(record, format: "THUMBZZZ")
    if isbn = record.try(:isbn).try(:first)
      isbn = isbn.gsub("-", "")
      "https://images-na.ssl-images-amazon.com/images/P/#{isbn}.03.#{format}.jpg"
    end
  end

  def cover_image_url(record, size: "m")
    if isbn = record.try(:isbn).try(:first)
      isbn = isbn.gsub("-", "")
      api_v1_cover_image_path(isbn, size: size)
    end
  end

  def additional_record_info(record)
    parts = []
    parts << creators(record)
    parts << edition(record)
    parts << date_of_publication(record)

    parts.map(&:presence).compact.join(" - ")
  end

end
