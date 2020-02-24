# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

---

## [0.9.0] - 2020-02-24
### Fixed
- [#56](https://github.com/walkersumida/dynamodb-api/pull/56) Make the `begins_with` and `between` available

## [0.8.1] - 2019-06-03
### Fixed
- [#49](https://github.com/walkersumida/dynamodb-api/pull/49) not be added table name prefix
- [#48](https://github.com/walkersumida/dynamodb-api/pull/48) Improvement DX

## [0.8.0] - 2019-03-03
### Added
- [#39](https://github.com/walkersumida/dynamodb-api/pull/39) `next` method

## [0.7.0] - 2018-12-23
### Added
- [#34](https://github.com/walkersumida/dynamodb-api/pull/34) `scan` method

## [0.6.2] - 2018-12-13
### Added
- [#32](https://github.com/walkersumida/dynamodb-api/pull/32) `remove_attributes` method

## [0.6.1] - 2018-11-22
### Added
- [#30](https://github.com/walkersumida/dynamodb-api/pull/30) `retry_limit` option(default: 10)

## [0.6.0] - 2018-11-03
### Added
- [#25](https://github.com/walkersumida/dynamodb-api/pull/25) `update` method
- [#24](https://github.com/walkersumida/dynamodb-api/pull/24) `delete` method
- [#23](https://github.com/walkersumida/dynamodb-api/pull/23) `query` method

## [0.5.0] - 2018-09-30
### Added
- [#21](https://github.com/walkersumida/dynamodb-api/pull/21) Automatically add Expression Attribute Names

### Removed
- [#21](https://github.com/walkersumida/dynamodb-api/pull/21) `ex_attr` method
