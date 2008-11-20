module ActiveRecord
  module Acts #:nodoc:
    module Taggable #:nodoc:
      module SingletonMethods
        # Return the number of time this class has been tagged with this tag
        def tagging_counts(tag)
          count_by_sql("select count(*) FROM tags, taggings WHERE " + sanitize_sql(['tags.name = ? AND tags.id = taggings.tag_id AND taggings.taggable_type = ?', tag, name]))
        end

        # paginate a call to find_tagged_with
        # tag is the tag to find
        # options is the option to use for pagination (:page, :per_page) and for find_tagged_with
        def paginate_by_tag(tag, options = {})
          options, page, per_page = wp_parse_options!(options)
          offset = (page.to_i - 1) * per_page
          options.merge!(:offset => offset, :limit => per_page)
          items = find_tagged_with(tag, options)
          count = tagging_counts(tag)
          returning WillPaginate::Collection.new(page, per_page, count) do |p|
            p.replace items
          end
        end
      end
    end
  end
end