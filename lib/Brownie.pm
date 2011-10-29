package Brownie;

use 5.008001;
use strict;
use warnings;
use Carp ();
use HTML::Selector::XPath ();

our $VERSION = '0.01';

sub not_implemented { Carp::croak('Not implemented') }

sub to_xpath {
    my $locator = shift;
    # taken from Web::Scraper
    return $locator =~ m!^(?:/|id\()!
        ? $locator # XPath
        : HTML::Selector::XPath::selector_to_xpath($locator); # CSS to XPath
}

1;

=head1 NAME

Brownie - Browser integration framework nspired by Capybara

=head1 SYNOPSIS

    use Brownie;

=head1 DESCRIPTION

Brownie is browser integrtion framework. It is inspired by Capybara at Ruby.

=head1 DSL

=head2 Navigation

=over 4

=item visit( $url_or_path )

=item current_url

=item current_path

=back

=head2 Pages

=over 4

=item title

=item source

=item screenshot( $file_name_to_save )

=back

=head2 Links and Buttons

=over 4

=item click_link( $id_or_xpath_or_text )

=item click_button( $id_or_xpath_or_text )

=item click_on( $id_or_xpath_or_text )

=back

=head2 Forms

=over 4

=item fill_in( $id_or_xpath_or_label, with => $value )

=item choose( $id_or_xpath_or_label )

=item check( $id_or_xpath_or_label )

=item uncheck( $id_or_xpath_or_label )

=item select( $value, from => $id_or_xpath_or_label )

=back

=head2 Matchers

NOT YET

=head2 Finder

NOT YET

=head2 Scripting

=over 4

=item execute_script( $javascript_code_string, @javascript_args )

=back

=head1 AUTHOR

NAKAGAWA Masaki E<lt>masaki@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

Capybara

L<Brownie::Driver::Selenium>, L<Brownie::Driver::Mechanize>

=cut
