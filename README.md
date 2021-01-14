# bitbucket-pipelines front-end-build

[![logo](./logo.jpg)](https://inforit.nl)

Docker image to automate front-end builds on bitbucket (and local)

Comes preinstalled with Firefox and Chromium for (unit)-testing during build.
Also sonar-scanner is installed to enable sonar analyzing 

## Instructions

1. update dockerfile
2. build local version:

    ```sh
    npm run build
    ```

3. push new version to dockerhub:

    ```sh
    npm run push
    ```

4. tag and push again (optional but recommended):

    ```sh
    npm run publish
    ```

## Usage

```sh
image: inforitnl/front-end-build

pipelines:
  default:
    - step:
        script:
          - /front-end-build.sh
```

## scripts

| Command | Description                         |
| ------- | ----------------------------------- |
| build   | build the container with latest tag |
| push    | pushes the container                |
