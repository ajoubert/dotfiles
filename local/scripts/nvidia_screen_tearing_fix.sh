#!/bin/sh
# Put as a separate script, as not garanteed to run on an nvidia computer
nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
