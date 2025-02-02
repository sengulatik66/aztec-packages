# Aztec.nr compiler

The Aztec.nr compiler compiles Aztec.nr contracts using nargo and outputs Aztec formatted contract ABIs.
The compiler can also generate typescript classes for each contract, as well as Aztec.nr interfaces for calling external functions.
It can also be used to update aztec project dependencies.

## Installation

To install the package, run: 

```bash
yarn add @aztec/builder
```

## Usage

To run the compiler as a CLI tool, first install the package and then run: 

```bash
yarn aztec-builder compile --help
```

You can also run the compiler from the [main Aztec CLI](../cli/README.md), which includes several other features for interacting with the Aztec Network:

```bash
yarn add @aztec/cli
yarn aztec-cli compile --help
```