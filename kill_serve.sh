#!/bin/bash

ps aux | grep jekyll 
kill -9 $(ps aux | grep jekyll | head -1 | awk '{print $2}')

