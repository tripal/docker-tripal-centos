<?php


## install chado 1.3
$action_to_do = "Install Chado v1.3";
$args = array("Install Chado v1.3");
$uid = 1;

$includes = array(module_load_include('inc', 'tripal_chado', 'includes/tripal_chado.install'));

tripal_add_job($action_to_do, 'tripal_chado', 'tripal_chado_install_chado', $args, $uid->uid, 10, $includes);

## prepare this site
$args = array();
$includes = array(
	          module_load_include('inc', 'tripal_chado', 'includes/tripal_chado.setup'),
	          module_load_include('inc', 'tripal_chado', 'includes/loaders/tripal_chado.obo_loader'),
         	  );
tripal_add_job('Prepare Chado', 'tripal_chado', 'tripal_chado_prepare_chado', $args, $uid->uid, 10, $includes);
