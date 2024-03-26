<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv_docker('WORDPRESS_DB_NAME') );

/** Database username */
define( 'DB_USER', getenv_docker('WORDPRESS_DB_USER') );

/** Database password */
define( 'DB_PASSWORD', getenv_docker('WORDPRESS_DB_PASSWORD') );

/** Database hostname */
define( 'DB_HOST', getenv_docker('WORDPRESS_DB_HOST') );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'N8i(h-mcXwE$g^)bfQQam*?HTvD#K1^=7B>>E*NT2)5D$*t~HE8.qL^xiD36#m-K');
define('SECURE_AUTH_KEY',  't=O9YHg@kq|nJsa*+22hU|M!+>wwB/I4X.Vu4%p{UpZ(X(/osx<0nc.|Kye7d(iM');
define('LOGGED_IN_KEY',    ',pANYXaQSg]^kTwMRC^(XWj6&5$fV0-d!T5:h@f4)M@qxc2hE7@RA~)3})|2g%~K');
define('NONCE_KEY',        'M0JFgXk$%st+4S|km}%lyZ=#gYeAc+#W48DG2#U>$&z[^3`Q$#F;;pVq60-?x[KV');
define('AUTH_SALT',        '(uNvNPc[+.x=kRvO~RB1,MmNJRDUXAdTs?hSo;lvImk&M9d[&-s070A^s6r9d$M<');
define('SECURE_AUTH_SALT', 'aKc<p}`Si%2L}Yu*8);y3C<7 o=IX&K35xa2O7%2[eMfXVw-lDX?Mw0}-7|j ~[T');
define('LOGGED_IN_SALT',   'H0lcm=eVv!xrww$p:vc-/.4IUD^AL2-x.8+iN7$z^!/=cf)&)^DRUgAe){j@Z+/x');
define('NONCE_SALT',       '0jd_VAD%St-qHkZRsD#oS+D$?-`Ku!:++cYq^9b$b%,5q|zCqm`nnXO|)$U(jm0_');
/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
