{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, ecdsa
, coincurve
, pynacl
, crcmod
, ed25519-blake2b
, py-sr25519-bindings
, cbor2
, pycryptodome
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "bip-utils";
  version = "2.8.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "ebellocchia";
    repo = "bip_utils";
    rev = "refs/tags/v${version}";
    hash = "sha256-FW3ni7kPB0VeVK/uWjDEeWgilP9dNiuvSaboUpG5DLo=";
  };

  postPatch = ''
    substituteInPlace requirements.txt \
      --replace "coincurve>=15.0.1,<18.0.0" "coincurve"
  '';

  propagatedBuildInputs = [
    ecdsa
    cbor2
    pynacl
    coincurve
    crcmod
    ed25519-blake2b
    py-sr25519-bindings
    pycryptodome
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "bip_utils"
  ];

  meta = with lib; {
    description = "Implementation of BIP39, BIP32, BIP44, BIP49 and BIP84 for wallet seeds, keys and addresses generation";
    homepage = "https://github.com/ebellocchia/bip_utils";
    changelog = "https://github.com/ebellocchia/bip_utils/blob/v${version}/CHANGELOG.md";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ prusnak stargate01 ];
  };
}
