# await-experiments
Examples of how async/await works in unusual cases I've encountered

## Running

`dart run main.dart`

Remove or add comments for individual tests. Only run one at a time, since the
tests themselves aren't asynchronous.

## Conclusions

Functions `dontReturnPrintTest` and `dontReturnNestedDataTest` revealed the
most to me. The race conditions and unusual behavior I was seeing on another
project were caused by **not returning a future in functions that should**,
even if it's `Future<void>`.

## References

* https://dart.dev/codelabs/async-await
* https://dart.dev/guides/language/concurrency
