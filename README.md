# Central Authentication Service (CAS) [![License](https://img.shields.io/hexpm/l/plug.svg)](https://github.com/Jasig/cas/blob/master/LICENSE)

## Introduction

This repository hosts the [Docker](https://www.docker.com/) build configuration necessary to build a [CAS](https://github.com/apereo/cas) image. 
See the `Dockerfile` for more info. 

## Versions

A docker image for CAS server. Images are tagged to match CAS server releases.

## Requirements

* Docker version `1.9.x` ~ `1.13.x`

## Configuration

* Add custom CAS configuration in `etc/cas`
* Add custom configuration for demo SSL certificates in `cert/req-cert.json`
* The build auto-copy configuration files under the `etc/cas` directory to the corresponding locations inside the image.

### Image

* The image will be available on the host via ports `9090` and `9443`
* You must check the `Dockerfile` to ensure the right branch from the [CAS overlay project](https://github.com/apereo/cas-overlay-template) is pulled/cloned.
* Check the [CAS overlay project](https://github.com/apereo/cas-overlay-template) itself to figure out the targetted CAS release.

### SSL

* Update the `thekeystore` file with the server certificate and chain if you need access the CAS server via HTTPS. You can configure your servers details in `cert/req-cert.json` to obtain demo-certificates signed by the Liferay CA.
* The password for the keystore is `changeit`.
* The build will update and copy the keystore file to the image. The embedded container packaged in the overlay is pre-configured to use that keystore for HTTPS requests.

## Build

**Make sure** that both `build.sh` and `run.sh` are updated to build the appropriate tag. Docker tags **MUST** correspond
to CAS server versions.

**NOTE:** On windows, you may want to run `bash` first so you can execute shell scripts.

```bash
./build.sh $CasVersion
```

The image will be built as `$docker_user/cas:v$CasVersion`.

## Run

```bash
./run.sh $CasVersion
```

## Release

* New images shall be released at the time of a new CAS server release.
* Image versions are reflected in the `build|run.sh` files and need to be updated per CAS/Image release.


```bash
./push.sh $CasVersion
```
