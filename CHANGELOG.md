# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [4.0.0] - 2023-11-27

- Updated various internally used packages:
  - node version from 16 to 20
  - other dependencies like sonar, python
- Rename `Inforit` with `Frontliners`
- Remove `npm ci`,  `npm run build:prod`,  `npm run test:prod`, `npm run zipdist` from build image

## [3.1.0] - 2023-03-31

- Changed to normal node buster image instead of slim variant

## [3.0.0] - 2023-03-31

- Reverted to older NodeJS version

## [2.0.0] - 2023-03-28

- Installed python 3.10
- Linked python 3.10 to `python3`
- moved testrail-cli to be in the same layer as ^

## [1.4.0] - 2023-03-23

- Added testrail-cli to Dockerfile

## [1.3.0] - 2022-10-04

- Added docker-compose to Dockerfile to be able to run dependencies in a build pipeline.

## [1.2.0] - 2022-07-19

- Added dependencies for cypress
