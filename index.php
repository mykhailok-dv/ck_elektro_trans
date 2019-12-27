<?php
declare(strict_types=1);

include_once 'src/DateGenerator.php';
include_once 'src/Fixtures.php';
include_once 'src/Homework.php';
include_once 'src/Exec.php';

$execute = new Exec();
$execute->run();

$fixturesGenerator = new Fixtures();
$fixturesGenerator->generate();
