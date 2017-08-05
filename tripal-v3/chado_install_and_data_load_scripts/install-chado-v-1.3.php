<?php

//--------install chado 1.3-----------
global $user;
$action_to_do = "Install Chado v1.3";
$args = ["Install Chado v1.3"];

$includes = [module_load_include('inc', 'tripal_chado', 'includes/tripal_chado.install')];
tripal_add_job($action_to_do, 'tripal_chado',
	'tripal_chado_install_chado', $args, $user->uid, 10, $includes);

