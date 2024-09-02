# QEDFeynman.jl

[![Build Status](https://github.com/GraphComputing-jl/QEDFeynman.jl/actions/workflows/unit_tests.yml/badge.svg?branch=main)](https://github.com/GraphComputing-jl/QEDFeynman.jl/actions/workflows/unit_tests.yml/)
[![Doc Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://graphcomputing-jl.github.io/QEDFeynman.jl/dev/)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

A QED model scattering process calculator, using QED.jl and GraphComputing.jl.

## Usage

For all the julia calls, use `-t n` to give julia `n` threads.

Instantiate the project first:

`julia --project=./ -e 'import Pkg; Pkg.instantiate()'`

### Run Tests

To run all tests, run

`julia --project=./ -e 'import Pkg; Pkg.test()' -O0`
