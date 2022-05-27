#!/bin/env bash

acpi | grep -Eo '[0-9]{1,3}%' | sed 's/%//'
