xhost +
docker run --gpus all --rm -it --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" gl_test bash

