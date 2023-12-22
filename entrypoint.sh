#!/bin/bash

mutagen sync create --name=code-sync --sync-mode=one-way-replica /alpha $BETA
mutagen sync monitor
