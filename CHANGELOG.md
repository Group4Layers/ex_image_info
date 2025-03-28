# CHANGELOG

## v1.0.0 (2025-03-28)

**Enhancements:**

- Full support for ISOBMFF image formats (box-type): HEIF, HEIC and AVIF.
- Reordering types being checked in guessing functions (`{seems?,type,info}/1`), focusing on recent trends.
- Documentation and testing improvements.

**API status and breaking changes:**

- `seems?/1`: returns the image type found (e.g., `:bmp`, `:tiff`), or `nil` if it is not recognized.
  For JPEG images, it returns `:jpeg` instead of the alias `:jpg`. However, the alias `:jpg` can be used in `{seems?,type,info}/2` functions.
- `seems?/2`, `type/2`, and `info/2`: these functions will **raise an error if an unsupported image type is provided**.
- `seems?/2`: **fully boolean**.

**News:**

- First major release of ExImageInfo, after years working without issues and really stable.
 
**Statistics:**

- 79 TDD Tests:
  - including 32 images being tested, also fetching external images on-the-fly.
  - supporting partial streams and including many binary mocks/fixtures (up to 50 tests to verify edge cases).
- Code coverage of 98.3%.
- Supports 13 image formats and 23 variants.
- No dependencies.

**Acknowledgments:**

- @bu6n for the first attempts about heic/heif/avif support and starting as a reviewer.

## v0.2.7 (2025-03-05)

**Enhancements:**

- Support for Elixir 1.18 (removing warnings).
 
**News:**

- Removed GitHub pages (/docs/) as hexdocs.pm is the official documentation site.
- Bumping versions to all dev/test dependencies.
- Improving CI pipelines and fixing HTML-generated docs (badges).
- Removing unneeded docs tasks.

**Acknowledgments:**

- Andrew Bruce (@camelpunch) for notifying about 1.18 warnings and starting as a reviewer.

## v0.2.6 (2024-01-18)

**Enhancements:**

- Improving a parsing case for the PNM format. If its signature is not fully formed, it skips parsing the size.

**News:**

- Adding `styler` to format and solve credo styling issues automatically.

## v0.2.5 (2024-06-09)

**News:**

- Added CI pipelines (test, lint, build).
- Formatting code with `mix format`.
- Bumping versions to all dev/test dependencies.

**Types:**

- Rest case for `seems?/2` returns a boolean (`false`) instead of `nil`.

**Acknowledgments:**

- Matthew Johnston (@warmwaffles) for all these changes and starting as a reviewer/contributor.

## v0.2.4 (2018-11-24)

**Enhancements:**

- By request of a GitHub user: support for another variant of webp.
- Studied and integrated the webpVP8X format (bitstream animated).
- Added 2 new tests for animated photos: gif and webp vp8x.

## v0.2.3 (2018-05-21)

**Enhancements:**

- By request of a GitHub user: added the type *jpg* as an alias of *jpeg*.

## v0.2.2 (2017-11-04)

**News:**

- Docs are in the official repo, not in gh-pages branch.
- Added inch-ci and ebertapp static analysis online tools (0 issues).
- Repository promoted to the Group4Layers organization.
- New "patch" version to include the changes.

## v0.2.1 (2017-11-03)

**Enhancements:**

- Code is improved following credo, solving:
  - 5 software design suggestions.
  - 34 code readability issues.
  - 2 refactoring opportunities.
  - 2 consistency issues.
- Clean code: removed superfluous comments and refactored def to defp when applicable.

**News:**

- Benchmarks are performed. An image with charts is included to compare famous elixir libraries. ExImageInfo always outperforms.
- Online tools applied (TravisCI and Coveralls). Badges included.
- Added ebertapp static analysis online tool.
- Repository promoted to Group4Layers organization.
- New "patch" version to include the changes.

## v0.2.0 (2017-06-17)

**Warnings:**

- Use with caution the formats *ico*, *jp2* and the family *pnm*. They are implemented without following other libraries (just reading the specs - sometimes working with old drafts like *jp2*). You can support this library by providing more tests and image *fixtures* or requesting other variants to be tested.

**Enhancements:**

- The guessing function is ordered by global usage [usage of image file formats](https://w3techs.com/technologies/overview/image_format/all), but still keeping *png* as the first one.
- Added support for *ico*, *jp2* (*jpeg 2000*) and the collection of *pnm* (*pbm*, *pgm* and *ppm*).
- *ico* gets the dimensions of the largest image contained (not the first found).

**Statistics:**

- 54 TDD Tests.
- Code coverage of 98.3%.
- 10 image formats supported.

**News:**

- New minor version (`0.2.0`) due to the three new image formats supported.

## v0.1.1 (2016-08-12)

**Enhancements:**

- Warnings corrected (compiling).

**Statistics:**

- 34 TDD Tests.
- Code coverage of 97.6%.
- 7 image formats supported.

**News:**

- Initial release (published) + Docs (gh-pages).

## v0.1.0 (2016-08-11)

**News:**

- Initial release (pre-publish).
