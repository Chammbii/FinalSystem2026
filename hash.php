<!-- hash -->
<!-- <?php

$password = "admin123";

$hash = password_hash(
    $password,
    PASSWORD_DEFAULT
);

echo $hash;

?> -->

<!-- password verification -->

<!-- <?php

$password = "admin123";

$hash = password_hash(
    $password,
    PASSWORD_DEFAULT
);

if(password_verify(
    $password,
    $hash
)){
    echo "Correct Password";
}

?> -->

<!-- Data at rest security -->

<!-- <?php

$data = "Grade: 98";
$key = "secretkey";

$encryptedData =
openssl_encrypt(
    $data,
    "AES-256-CBC",
    $key,
    0,
    "1234567890123456"
);

echo $encryptedData;

?> -->

<!-- data masking -->

<?php

$card =
"1234567890123456";

$masked =
str_repeat("*", 12)
. substr($card, -4);

echo $masked;

?>

