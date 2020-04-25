/*
 * This file is part of node-toxcore.
 *
 * node-toxcore is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * node-toxcore is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with node-toxcore. If not, see <http://www.gnu.org/licenses/>.
 *
 */

var path = require("path");
var tox = require(path.join(__dirname, "tox"));
var toxencryptsave = require(path.join(__dirname, "toxencryptsave"));
var consts = require(path.join(__dirname, "consts"));

module.exports = {
  Tox: tox,
  ToxEncryptSave: toxencryptsave,
  Consts: consts,
};
