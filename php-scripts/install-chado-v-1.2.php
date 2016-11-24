<?php

$action_to_do = "Install Chado v1.2";
$args = array("Install Chado v1.2");
$uid = 1;

tripal_add_job($action_to_do, 'tripal_core', 'tripal_core_install_chado', $args, $uid);
