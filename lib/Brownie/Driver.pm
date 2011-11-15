package Brownie::Driver;

use strict;
use warnings;
use Sub::Install;

use Brownie;

sub new {
    my ($class, %args) = @_;
    return bless { %args }, $class;
}

our @Navigation = qw(visit current_url current_path);
our @Headers    = qw(status_code response_headers);
our @Pages      = qw(title source document screenshot);
our @Finder     = qw(find_element find_elements);
our @Scripting  = qw(execute_script evaluate_script);

sub document { shift->find_element('/html') }

sub PROVIDED_METHODS {
    return (@Navigation, @Headers, @Pages, @Finder, @Scripting);
}

for ('browser', PROVIDED_METHODS) {
    next if __PACKAGE__->can($_);
    Sub::Install::install_sub({
        code => Brownie->can('not_implemented'),
        as   => $_,
    });
}

1;

=head1 NAME

Brownie::Driver - base class of Brownie::Driver series

=head1 SYNOPSIS

  use Brownie::Session;

  my $session = Brownie::Session->new;
  my $driver = $session->driver;

=head1 METHODS

=over 4

=item * C<new(%args)>

Returns a new instance.

  my $driver = Brownie::Driver->new(%args);

=item * C<browser>

Returns a driver specific browser object.

  my $browser = $driver->browser;

=item * C<visit($url)>

Go to $url.

  $driver->visit('http://example.com/');

=item * C<current_url>

Returns current page's URL.

  my $url = $driver->current_url;

=item * C<current_path>

Returns current page's path of URL.

  my $path = $driver->current_path;

=item * C<status_code>

Returns last request's HTTP status code.

  my $code = $driver->status_code;

=item * C<response_headers>

Returns last request's HTTP response headers L<HTTP::Headers>.

  my $headers = $driver->response_headers;

=item * C<title>

Returns current page's <title> text.

  my $title = $driver->title;

=item * C<source>

Returns current page's HTML source.

  my $source = $driver->source;

=item * C<document>

Returns current page's HTML root element.

  my $element = $driver->document;

=item * C<screenshot($filename)>

Takes current page's screenshot and saves to $filename as PNG.

  $driver->screenshot($filename);

=item * C<execute_script($javascript)>

Executes snippet of JavaScript into current page.

  $driver->execute_script('$("body").empty()');

=item * C<evaluate_script($javascript)>

Executes snipptes and returns result.

  my $result = $driver->evaluate_script('1 + 2');

If specified DOM element, it returns WebElement object.

  my $node = $driver->evaluate_script('document.getElementById("foo")');

=item * C<find_element($locator, %args)>

Find an element on the page, and return L<Brownie::Node> object.

  my $element = $driver->find_element($locator, %args)

C<$locator> is string of "CSS Selector" (e.g. "#id") or "XPath" (e.g. "//a[1]").

C<%args> are:

=over 8

=item * C<-base>: Brownie::Node object where you want to start finding

  my $parent = $driver->find_element('#where_to_parent');
  my $child  = $driver->find_element('a', -base => $parent);

=back

=item * C<find_elements($locator, %args)>

Find all elements on the page, and return L<Brownie::Node> object list.

  my @elements = $driver->find_elements($locator, %args)

C<$locator> is string of "CSS Selector" (e.g. "#id") or "XPath" (e.g. "//a[1]").

C<%args> are:

=over 8

=item * C<-base>: Brownie::Node object where you want to start finding

  my $parent   = $driver->find_element('#where_to_parent');
  my @children = $driver->find_elements('li', -base => $parent);

=back

=back

=head1 AUTHOR

NAKAGAWA Masaki E<lt>masaki@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Brownie::Node>, L<Brownie::Session>

L<Brownie::Driver::Selenium>, L<Brownie::Driver::Mechanize>

=cut
