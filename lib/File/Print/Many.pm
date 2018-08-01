package File::Print::Many;

use warnings;
use strict;
use Carp;

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;

	return unless(defined($class));

	my %params;
	if(ref($_[0]) eq 'HASH') {
		%params = %{$_[0]};
	} elsif(ref($_[0])) {
		Carp::croak('Usage: new(fds => \@array)');
	} elsif(scalar(@_) % 2 == 0) {
		%params = @_;
	} else {
		$params{'fds'} = shift;
	}

	if(ref($params{fds}) ne 'ARRAY') {
		Carp::croak('Usage: new(fds => \@array)');
	}

	return bless {
		_fds => $params{'fds'}
	}, $class;
}

sub PRINT {
	my $self = shift;

	foreach my $fd(@{$self->{'_fds'}}) {
		print $fd @_;
	}
}
