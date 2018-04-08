# frozen_string_literal: true

require 'flickraw-cached'
require 'jekyll-cache'

module Jekyll
  module Flickr
    class FlickrTag < Liquid::Tag

      # selection of sizes from those offered by Flickr API
      DEFAULT_CONFIG = {
        'widths' => [320, 640, 800, 1024, 1600],
        'width_legacy' => 1024,
        'figcaption' => true,
        'license' => true,
        'caption' => true,
        'width_viewport' => '100vw'
      }

      # Flickr licenses from (added CC myself)
      # https://www.flickr.com/services/api/flickr.photos.licenses.getInfo.html
      LICENSES = [
        {
          name: "All Rights Reserved", url: ""
        },
        {
          name: "CC Attribution-NonCommercial-ShareAlike License",
          url: "https://creativecommons.org/licenses/by-nc-sa/2.0/"
        },
        {
          name: "CC Attribution-NonCommercial License",
          url: "https://creativecommons.org/licenses/by-nc/2.0/"
        },
        {
          name: "CC Attribution-NonCommercial-NoDerivs License",
          url: "https://creativecommons.org/licenses/by-nc-nd/2.0/"
        },
        {
          name: "CC Attribution License",
          url: "https://creativecommons.org/licenses/by/2.0/"
        },
        {
          name: "CC Attribution-ShareAlike License",
          url: "https://creativecommons.org/licenses/by-sa/2.0/"
        },
        {
          name: "CC Attribution-NoDerivs License",
          url: "https://creativecommons.org/licenses/by-nd/2.0/",
        },
        {
          name: "No known copyright restrictions",
          url: "https://www.flickr.com/commons/usage/"
        },
        {
          name: "United States Government Work",
          url: "http://www.usa.gov/copyright.shtml"
        },
        {
          name: "Public Domain Dedication (CC0)",
          url: "https://creativecommons.org/publicdomain/zero/1.0/"
        },
        {
          name: "Public Domain Mark",
          url: "https://creativecommons.org/publicdomain/mark/1.0/"
        }
      ]

      def initialize(tag_name, text, tokens)
        super

        @text = text.strip
      end

      def render(context)
        config = DEFAULT_CONFIG.merge(context.registers[:site].config['flickr'])

        match = /(?<photo_id>\d+)(\s(\"(?<caption>[^"]+)\"))?(?<attr>.*)/.match @text

        photo_id = match.named_captures['photo_id']
        photo_caption = match.named_captures['caption']
        photo_attr = match.named_captures['attr']

        cache = Jekyll::Cache::FileStore.new 'flickr'
        photo_data = cache.fetch photo_id do
          FlickRaw.api_key = ENV['FLICKR_API_KEY'] || config['api_key']
          FlickRaw.shared_secret = ENV['FLICKR_API_SECRET'] || config['api_secret']
          {
            info:  flickr.photos.getInfo(photo_id: photo_id),
            sizes: flickr.photos.getSizes(photo_id: photo_id)
          }
        end

        widths = config['widths'] + [config['width_legacy']]
        photo_sizes = photo_data[:sizes].select{ |photo| widths.include?(photo['width'].to_i) }
        photo_legacy = photo_data[:sizes].find{ |photo| photo['width'].to_i == config['width_legacy']} || photo_data[:sizes].find{ |photo| photo['label'] == 'Original'}

        srcset = photo_sizes.map{|photo| "#{photo['source']} #{photo['width']}w"}.join(", ")

        sizes = unless photo_attr.include?('sizes=') then
          context.registers[:site].config['flickr']['width_viewport']
        else
          ""
        end

        if photo_caption and not photo_attr.include?('alt=') then
          photo_attr += " alt=\"#{photo_caption}\""
        end

        img_tag = "<img class=\"flickr\" src=\"#{photo_legacy.source}\" srcset=\"#{srcset}\" sizes=\"#{sizes}\" #{photo_attr}>"

        return img_tag if not config['figcaption']

        photo_license = if config['license'] then
          license = LICENSES[photo_data[:info].license.to_i]

          owner_link = "&copy; Flickr/<a href=\"#{photo_data[:info]['urls'].first['_content']}\">#{photo_data[:info]['owner']['username']}</a>"

          license_link = if license[:url]
            "<a href=\"#{license[:url]}\">#{license[:name]}</a>"
          else
            license[:name]
          end
          "<div class=\"license\">#{owner_link} #{license_link}</div>"
        else
          ""
        end

        photo_caption = if config['caption'] and photo_caption then
          "<div class=\"caption\">#{photo_caption}</div>"
        else
          ""
        end

        return img_tag if photo_license.empty? and photo_caption.empty?

        return <<-HTML
<figure class="flickr">
  #{img_tag}
  <figcaption>#{photo_caption}#{photo_license}</figcaption>
</figure>
        HTML
      end
    end
  end
end

Liquid::Template.register_tag('flickr', Jekyll::Flickr::FlickrTag)
