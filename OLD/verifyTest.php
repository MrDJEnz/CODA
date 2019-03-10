
<?php
// See the password_hash() example to see where this came from.
$passValue = "test";
$passHashed = password_hash('test',PASSWORD_DEFAULT);
$hash = "$2y$07$BCryptRequires22Chrcte/VlQH0piJtjXl.0t1XkA8pw9dMXTpOq";
$hash2 = '$2y$10$bXg4ioaB7nmRM7IO0Rvz2OYuKb5uhxt5RwIWHkglvHekWQsHX52TW';

if (password_verify('rasmuslerdorf', $hash)) {
    echo 'Password is valid!';
} else {
    echo 'Invalid password.';
}

if (password_verify('testNRL', $hash2)) {
    echo 'Password is valid!';
} else {
    echo 'Invalid password.';
}
?>
