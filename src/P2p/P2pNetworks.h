// Copyright (c) 2012-2016, The CryptoNote developers, The Bytecoin developers, The Karbowanec developers
// Copyright (c) 2017 The HashCash developers
//
// This file is part of Bytecoin.
//
// Bytecoin is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Bytecoin is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with Bytecoin.  If not, see <http://www.gnu.org/licenses/>.

#include <boost/uuid/uuid.hpp>
#include <boost/uuid/uuid_generators.hpp>
#include <boost/uuid/uuid_io.hpp>
#include "../CryptoNoteConfig.h"

#pragma once

namespace CryptoNote
{
	namespace
	{
		boost::uuids::uuid u = { { 0x69, 0x72, 0x69, 0x64, 0x64, 0x79, 0x3f, 0x20, 0x69, 0x74, 0x73, 0x20, 0x79, 0x75, 0x6f, 0x3f } };
	}
	const static boost::uuids::uuid BYTECOIN_NETWORK = u;
}

