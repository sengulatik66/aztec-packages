use crate::{
    abis::function_selector::FunctionSelector, address::{EthAddress, AztecAddress},
    constants::GAS_LENGTH, hash::pedersen_hash, traits::{Deserialize, Hash, Serialize, Empty},
    abis::side_effect::Ordered, utils::reader::Reader, abis::gas_fees::GasFees
};

struct Gas {
    da_gas: u32,
    l2_gas: u32,
}

impl Gas {
    pub fn new(da_gas: u32, l2_gas: u32) -> Self {
        Self { da_gas, l2_gas }
    }

    pub fn add(self, other: Gas) -> Self {
        Gas::new(self.da_gas + other.da_gas, self.l2_gas + other.l2_gas)
    }

    pub fn sub(self, other: Gas) -> Self {
        Gas::new(self.da_gas - other.da_gas, self.l2_gas - other.l2_gas)
    }

    pub fn compute_fee(self, fees: GasFees) -> Field {
        (self.da_gas as Field) * fees.fee_per_da_gas + (self.l2_gas as Field) * fees.fee_per_l2_gas
    }

    pub fn is_empty(self) -> bool {
        (self.da_gas == 0) & (self.l2_gas == 0)
    }
}

impl Serialize<GAS_LENGTH> for Gas {
    fn serialize(self) -> [Field; GAS_LENGTH] {
        [self.da_gas as Field, self.l2_gas as Field]
    }
}

impl Deserialize<GAS_LENGTH> for Gas {
    fn deserialize(serialized: [Field; GAS_LENGTH]) -> Gas {
        Gas::new(serialized[0] as u32, serialized[1] as u32)
    }
}

impl Eq for Gas {
    fn eq(self, other : Gas) -> bool {
        (self.da_gas == other.da_gas) & (self.l2_gas == other.l2_gas)
    }
}

impl Empty for Gas {
    fn empty() -> Self {
        Gas::new(0, 0)
    }
}

