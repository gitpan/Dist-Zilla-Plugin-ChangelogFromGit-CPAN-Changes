package Dist::Zilla::Plugin::ChangelogFromGit::CPAN::Changes;
{
    $Dist::Zilla::Plugin::ChangelogFromGit::CPAN::Changes::VERSION = '0.0.2';
}

# ABSTRACT: Format Changelogs using CPAN::Changes

use Moose;
use CPAN::Changes;
use CPAN::Changes::Release;

extends 'Dist::Zilla::Plugin::ChangelogFromGit';

sub render_changelog {
    my ($self) = @_;

    my $cpan_changes = CPAN::Changes->new( preamble => 'Changelog for ' . $self->zilla->name, );

    foreach my $release ( reverse $self->all_releases ) {
        next if $release->has_no_changes;    # no empties

        my $version = $release->version;
        if ( $version eq 'HEAD' ) {
            $version = $self->zilla->version;
        }

        my $cpan_release = CPAN::Changes::Release->new(
            version => $version,
            date    => $release->date,
        );

        foreach my $change ( @{ $release->changes } ) {
            next if ( $change->description =~ /^\s/ );    # no empties
            my $group = $change->author_name;

            # sometimes author_name contains the "Full Name <email@address.com>"
            # sometimes not, so do a lazy check
            if ( $change->author_name !~ m/@/ ) {
                $group .= ' <' . $change->author_email . '>';
            }

            # XXX: do we want the change_id?
            # $group .= ' ' .  $change->change_id;

            $cpan_release->add_changes( { group => $group }, $change->description, );
        }

        $cpan_changes->add_release($cpan_release);
    }

    return $cpan_changes->serialize;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::ChangelogFromGit::CPAN::Changes - Format Changelogs using CPAN::Changes

=head1 VERSION

version 0.0.2

=head1 SEE ALSO

L<Dist::Zilla::Plugin::ChangelogFromGit::Debian> which was used as a template for this

=head1 BUGS AND LIMITATIONS

You can make new bug reports, and view existing ones, through the
web interface at L<https://github.com/ioanrogers/Dist-Zilla-Plugin-ChangelogFromGit-CPAN-Changes/issues>.

=head1 SOURCE

The development version is on github at L<http://github.com/ioanrogers/Dist-Zilla-Plugin-ChangelogFromGit-CPAN-Changes>
and may be cloned from L<git://github.com/ioanrogers/Dist-Zilla-Plugin-ChangelogFromGit-CPAN-Changes.git>

=head1 AUTHOR

Ioan Rogers <ioanr@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Ioan Rogers.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
