// Copyright 2016 The go-bitcoiin2g Authors
// This file is part of the go-bitcoiin2g library.
//
// The go-bitcoiin2g library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-bitcoiin2g library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-bitcoiin2g library. If not, see <http://www.gnu.org/licenses/>.

package ethclient

import "github.com/bitcoiinBT2/go-bitcoiin"

// Verify that Client implements the bitcoiin2g interfaces.
var (
	_ = bitcoiin2g.ChainReader(&Client{})
	_ = bitcoiin2g.TransactionReader(&Client{})
	_ = bitcoiin2g.ChainStateReader(&Client{})
	_ = bitcoiin2g.ChainSyncReader(&Client{})
	_ = bitcoiin2g.ContractCaller(&Client{})
	_ = bitcoiin2g.GasEstimator(&Client{})
	_ = bitcoiin2g.GasPricer(&Client{})
	_ = bitcoiin2g.LogFilterer(&Client{})
	_ = bitcoiin2g.PendingStateReader(&Client{})
	// _ = bitcoiin2g.PendingStateEventer(&Client{})
	_ = bitcoiin2g.PendingContractCaller(&Client{})
)
