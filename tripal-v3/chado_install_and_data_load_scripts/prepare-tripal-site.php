<?php

//---------prepare this site---------
global $user;
$args = [];
$includes = [
module_load_include('inc', 'tripal_chado', 'includes/setup/tripal_chado.setup'),
];
tripal_add_job('Prepare Chado', 'tripal_chado',
'tripal_chado_prepare_chado', $args,
$user->uid, 10, $includes);