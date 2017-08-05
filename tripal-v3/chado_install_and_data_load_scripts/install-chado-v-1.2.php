<?php

$action_to_do = "Install Chado v1.2";
$args = array("Install Chado v1.2");
$uid = 1;

tripal_add_job($action_to_do, 'tripal_chado', 'tripal_chado_install_chado', $args, $uid);
