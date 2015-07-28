$Encryption = new \Aurora\Helper\Encryption("bVxPzeSMWd0AAJgyYDhoZG3Ui1ueEjWd0AAJgyYDho");

$characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_)*!";
$mem = [];
for ($t = 1; $t < 417; $t++) {
    $string = "";
    for ($i = 0; $i < $t; $i++) {
        $string .= $characters[mt_rand(0, strlen($characters) - 1)];
    }

    $encrypted = $Encryption->encrypt($string);
    $lenStr = strlen($string);
    $lenEnc = strlen($encrypted);

    $max = 0;
    if (($t % 32) === 0) {
        $max = $lenEnc;
    }
    $mem[] = [
        "enc" => $encrypted,
        "lenStr" => $lenStr,
        "lenEnc" => $lenEnc,
        "max"    => $max
    ];
}

foreach ($mem as $key => $value) {
    echo $value["max"]," - ",$value["enc"].PHP_EOL;
}
