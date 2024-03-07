<?php
/**
 * The base configuration for WordPress
 *
 * This file uses environment variables for the main configurations.
 */

// ** MySQL settings ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('WORDPRESS_DB_NAME') );

/** MySQL database username */
define( 'DB_USER', getenv('WORDPRESS_DB_USER') );

/** MySQL database password */
define( 'DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD') );

/** MySQL hostname */
define( 'DB_HOST', getenv('WORDPRESS_DB_HOST') );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define('AUTH_KEY',         'xMRartrRHIbl7lg--F4wxx,y;!HGs?vbN4PtA~P^MQpqVN8?C_H(At`qV^aqc;?6');
define('SECURE_AUTH_KEY',  'VPZbLk&dC>niXYDH6Kj)Xn7j:i|Pv)WO>zx)$dEk<;O5PdK/!~5]=t[mmLFww-vd');
define('LOGGED_IN_KEY',    '1g;(2Ko=b@|l5FCVwsFFAr|6U2YK}4|C%y!uzo)-<ns-K# 9zs{ff(zO+fS[FnvX');
define('NONCE_KEY',        'ClQ50p 43:^c`rZ^3F%`d1Iz.U^g4^`(/,bDh*<jX v/M:d{IJ&@$}guC$tGQ<kb');
define('AUTH_SALT',        'rTyO<CBO]1:%gF+urHUb=(Gs0hIKGgK<)VxH$zY{L|+nvMqDp^#.pz(F%U61X-<Y');
define('SECURE_AUTH_SALT', '35JwE}`9.ham%+x+FSD+%Ix:*>#GbLs}/_gjm_(eC|&k+1&@jDe(ApN@qs;?4pY4');
define('LOGGED_IN_SALT',   'IXI*)xl2:^M3nIT:_v(`R*LFzp~WSvbM=J$tcw*-k!<eYt8sb+vj;Lm.8I9@/HL~');
define('NONCE_SALT',       '`-Ez@5e^?<iHSVVx`V68!YcBlOHeqp1XvaMpOlH?mUfCIRA[eG4Wd+=]cD`Z,N*H');

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
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
