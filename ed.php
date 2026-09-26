<?php
$data = "Hello Students";

$key = "secretkey123456";
$method = "AES-128-CTR";
$iv = "1234567891011121";

// Encrypt
$encrypted = openssl_encrypt(
    $data,
    $method,
    $key,
    0,
    $iv
);

echo "Encrypted: " . $encrypted;

echo "<br>";

// Decrypt
$decrypted = openssl_decrypt(
    $encrypted,
    $method,
    $key,
    0,
    $iv
);

echo "Decrypted: " . $decrypted;
?>