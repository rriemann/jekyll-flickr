# Jekyll::Flickr

[![Gem Version](https://badge.fury.io/rb/jekyll-flickr.svg)](https://badge.fury.io/rb/jekyll-flickr)

Liquid tag for responsive [Flickr] images using [HTML5 srcset](http://alistapart.com/article/responsive-images-in-practice): `{% flickr %}`.

## Installation

Add this line to your application's Gemfile:

    $ gem 'jekyll-flickr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jekyll-flickr

Then add the following to your site's `_config.yml`:

```yaml
plugins:
  - jekyll-flickr
```

💡 If you are using a Jekyll version less than 3.5.0, use the `gems` key instead of `plugins`.

You must further provide two [Flickr API credentials](https://www.flickr.com/services/api/keys/). You can either use environment variables `FLICKR_API_KEY` and `FLICKR_API_SECRET` or the `_config.yml`:

```yml
flickr:
  api_key: <flickr_api_key>
  api_secret: <flickr_shared_secret>
```

💡 API requests are cached in `.jekyll-cache/flickr` for faster builds.

## Usage

Use the tag as follows in your Jekyll pages, posts and collections:

```liquid
{% flickr photo_id "Caption" img_attributes %}
```
- The `photo_id` is required and determines the photo from Flickr. In the URL <http://alistapart.com/article/responsive-images-in-practice>, the photo_id is the number in the path after the author (here also a number), i.e. `38285149681`.
- The `Caption` is optional and must be enclosed by double quotation marks. So far, double quotation marks in captions are not supported.
- The `img_attributes` are any optional text that will be included in the `<img>` tag.

Example:

```liquid
{% flickr 38285149681 "My favourite photo of the month." style="float: right;"}
```

This will create the following HTML output:

```html
<figure>
  <img src="https://farm5.staticflickr.com/4570/38285149681_f7323259a3_c.jpg" srcset="https://farm5.staticflickr.com/4570/38285149681_f7323259a3_n.jpg 320w, https://farm5.staticflickr.com/4570/38285149681_f7323259a3_z.jpg 640w, https://farm5.staticflickr.com/4570/38285149681_f7323259a3_c.jpg 800w, https://farm5.staticflickr.com/4570/38285149681_f7323259a3_b.jpg 1024w, https://farm5.staticflickr.com/4570/38285149681_2436f15109_h.jpg 1600w" sizes="100vw" style="float: right;" alt="My favourite photo of the month.">
  <figcaption>
    <div class="caption">My favourite photo of the month.</div>
    <div class="license">
      © Flickr/<a href="https://www.flickr.com/photos/140750848@N04/38285149681/">moulichoudari</a>
      <a href="https://creativecommons.org/licenses/by/2.0/">CC Attribution License</a>
    </div>
  </figcaption>
</figure>
```

## Configuration

```yml
flickr:
  api_key: <flickr_api_key>
  api_secret: <flickr_shared_secret>
  widths: [320, 640, 800, 1024, 1600]
  width_legacy: 800
  width_viewport: 100vw
  figcaption: true
  license: true
  caption: true
```

The Flickr API provides images in a [number of sizes](https://www.flickr.com/services/api/flickr.photos.getSizes.html) (e.g. 75, 150, 100, 240, 320, 500, 640, 1024, 3648). The `widths` allows to filter for sizes to be included in the `srcset` attribute. The size `width_legacy` chosen from the supported sizes is used by [browsers with no support](https://caniuse.com/#feat=srcset) for the `srcset` attribute.

The configuration option `width_viewport` allows to define the occupying width of the photos. It is used to set the `sizes` attribute. [More Information](http://alistapart.com/article/responsive-images-in-practice)

## TODO

- add css class "flickr" somewhere
- add option to enable a link from the image to the Flickr photo page or just a larger version of the image
- allow more control on cache expiration
- allow for custom templates globally configured
- allow for templates per tag via some arguments
- block version (`Liquid::Block`) that allows to enclosure the caption
- use a more sophisticated RegExp to allow for captions with quotation marks

## Similar Projects

- [jekyll-flickresponsive.rb](https://gist.github.com/mikka2061/e8ddb2566d90b00f990d6a39b0fd1346) using the `<picture>` tag for responsive images.
- <https://github.com/j0k3r/jekyll-flickr-photoset>
- <https://github.com/cnunciato/jekyll-flickr>
- <https://github.com/lawmurray/indii-jekyll-flickr>
- <https://github.com/tsmango/jekyll_flickr_set_tag>


## Contributing

1. Fork it ( https://github.com/rriemann/jekyll-flickr/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


[Flickr]: https://www.flickr.com/
