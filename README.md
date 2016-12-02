# docker-grunt-php-builder
An image to build PHP (5.6/7) applications with grunt task runner

## Usage
To run the build image, you must have already created a `Gruntfile.js` in a source directory.

You can create a Bash script for an easier access (PHP 7.0):

    #!/usr/bin/env bash
    
    docker run --rm \
        -v $(pwd)/src:/app \
        -v $(pwd)/reports:/reports \
        dockerizr/grunt-php-builder:7.0 "$@"

As you can see, you must define at least one volume to `/app` on container site, 
to inject the application source code. The `Gruntfile.js` file must be located there.

If you want to use an own build image (which will inherit from grunt-php-builder), you can 
extends the Bash script in this way:

    #!/usr/bin/env bash
    
    BUILD_IMAGE="my-grunt-php-builder:7.0"
    
    if [[ "$(docker images -q ${BUILD_IMAGE} 2> /dev/null)" == "" ]]; then
      echo "Build image not found. Building now..."
      docker build -t ${BUILD_IMAGE} path/to/build/context
    fi
    
    docker run --rm \
        -v $(pwd)/src:/app \
        -v $(pwd)/reports:/reports \
        ${BUILD_IMAGE} "$@"

