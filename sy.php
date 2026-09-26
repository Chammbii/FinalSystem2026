<?php

$message = "Confidential Data";
$key = "mypassword";

$encrypted = openssl_encrypt(
    $message,
    "AES-256-CBC",
    $key,
    0,
    "1234567890123456"
);

echo $encrypted;

?>