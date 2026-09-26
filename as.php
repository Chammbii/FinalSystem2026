<?php

putenv("OPENSSL_CONF=C:\\xampp\\apache\\conf\\openssl.cnf");
putenv("TMP=C:\\xampp\\tmp");
putenv("TEMP=C:\\xampp\\tmp");

$config = [
    "private_key_bits" => 2048,
    "private_key_type" => OPENSSL_KEYTYPE_RSA,
];

$res = openssl_pkey_new($config);

if ($res === false) {
    die("Key generation failed: " . openssl_error_string());
}

openssl_pkey_export($res, $privateKey);

$keyDetails = openssl_pkey_get_details($res);
$publicKey = $keyDetails["key"];

$message = "Hello Students";

openssl_public_encrypt($message, $encrypted, $publicKey);

echo base64_encode($encrypted);

?>