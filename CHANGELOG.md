# CHANGELOG

## v0.2.0 (2017-06-17)

**Warnings:**

- Use with caution the formats *ico*, *jp2* and the family *pnm*. They are implemented without following other libraries (just reading the specs - sometimes working with old drafts like *jp2*). You can support this library by providing more tests and image *fixtures* or requesting other variants to be tested.

**Enhancements:**

- The guessing function is ordered by global usage [usage of image file formats](https://w3techs.com/technologies/overview/image_format/all), but still keeping *png* as the first one.
- Added support for *ico*, *jp2* (*jpeg 2000*) and the collection of *pnm* (*pbm*, *pgm* and *ppm*)
- *ico* gets the dimensions of the largest image contained (not the first found)

**Statistics:**

- 54 TDD Tests
- Code coverage of 98.3%
- 10 image formats supported

**News:**

- New minor version (`0.2.0`) due to the three new image formats supported.

## v0.1.1 (2016-08-12)

**Enhancements:**

- Warnings corrected (compiling)

**Statistics:**

- 34 TDD Tests
- Code coverage of 97.6%
- 7 image formats supported

**News:**

- Initial release (published) + Docs (gh-pages)

## v0.1.0 (2016-08-11)

**News:**

- Initial release (pre-publish)
