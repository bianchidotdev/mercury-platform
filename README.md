# Mercury Platform

Mercury is a financial analysis platform that facilitates quick and easy algorithmic analysis of market data. Named (at least temporarily) after the Roman God of Commerce.

The initial implementation aims to provide a way to provide burstable quantitative analysis with no/minimal permanent infrastructure costs.

## Decisions

Project decisions are being tracked in [Architecture Decision Records](https://adr.github.io/) located [within this repo](docs/adr/)

## Goals
1. Create a platform that provides an easy interface for testing hypotheses about financial market trends utilizing EOD data
1. Process existing algorithms on a daily basis analyzing the most recent EOD data
1. Allow for new theories to be tested on a larger historical data set in a distributed and parallel manner
1. Accomplish the above using cloud-native tooling

## Constraints
- Minimal permanent infrastructure

## Testing
Full testing of the platform can be done by calling `./bin/test`. This starts each service with necessary dependencies and runs through each test suite one at a time. This is not a proper test of the platform, since it does not have the concept of GCP Tasks and because it uses a mock of the GCP Storage platform.

Individual services can be tested by entering that services directory and running `./bin/test`. 

## Roadmap
[x] Brainstorm potential architecture patterns

- First attempt will be using GCP Cloud Run to host our infrastructure, Storage for the persistence of files and data triggers, and Tasks to execute those triggers.

[ ] Build a system for retrieving and storing financial data in an economical and sustainable way

- Parquet was the first plan, though we have switched to just using CSV until it becomes prohibitive for some reason

[ ] (If necessary) Clean data from sources and output a format consumable by our analysis tools

[ ] Design an extensible system that can execute new algorithms and analyses against market data

[ ] Develop the infrastructure patterns necessary to handle distributed workloads

