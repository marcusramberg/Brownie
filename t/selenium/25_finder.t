use Test::More;
use Test::Brownie;
use Brownie::Driver::Selenium;
use Brownie::Node::Selenium;

my $driver = Brownie::Driver::Selenium->new;
my $httpd = test_httpd();
$driver->visit($httpd->endpoint);

sub elem ($) { $driver->find_element($_[0]) }

describe 'Brownie::Node::Selenium#find_elements' => sub {
    it 'should get elements under specified element' => sub {
        my @children = elem('p#parent')->find_elements('a');
        is scalar(@children) => 2;
        is $children[0]->text => 'child3';
        is $children[1]->text => 'child4';

        my @anchors = $driver->find_elements('a');
        cmp_ok scalar(@anchors), '>', scalar(@children);
    };
};

describe 'Brownie::Node::Selenium#find_element' => sub {
    it 'should get an element under specified element' => sub {
        my $child = elem('p#parent')->find_elements('a');
        is $child->text => 'child3';
    };
};

undef $driver;
done_testing;
