
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Format Changelogs using CPAN::Changes",
  "dist_author" => [
    "Ioan Rogers <ioan.rogers\@gmail.com>"
  ],
  "dist_name" => "Dist-Zilla-Plugin-ChangelogFromGit-CPAN-Changes",
  "dist_version" => "0.0.1",
  "license" => "perl",
  "module_name" => "Dist::Zilla::Plugin::ChangelogFromGit::CPAN::Changes",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "CPAN::Changes" => 0,
    "CPAN::Changes::Release" => 0,
    "Dist::Zilla::Plugin::ChangelogFromGit" => 0,
    "Moose" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
