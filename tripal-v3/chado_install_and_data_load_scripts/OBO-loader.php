<?php


/*
 *       3 | Chado CV Properties      | {tripal_cv}/files/cv_property.obo
 *             4 | Taxonomic Rank           
 *             | http://purl.obolibrary.org/obo/taxrank.obo
 *                   5 | Chado Feature Properties 
 *                   | {tripal_feature}/files/feature_property.obo
 *                         2 | Gene Ontology            
 *                         | http://purl.obolibrary.org/obo/go.obo
 *                               1 | Sequence Ontology        
 *                               | http://purl.obolibrary.org/obo/so.obo
 *                               */

tripal_submit_obo_job(array('obo_id' => 1));
tripal_submit_obo_job(array('obo_id' => 2));
tripal_submit_obo_job(array('obo_id' => 3));
