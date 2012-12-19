package JSGrid;
use Mojo::Base 'Mojolicious';
use JSGrid::Schema;

has schema => sub {
  return JSGrid::Schema->connect('dbi:SQLite:' . ($ENV{TEST_DB} || 'grid.db'));
};

sub startup {
	my $self = shift;
	$self->helper(db    => sub { $self->app->schema });
	$self->helper(model => sub { shift()->db->resultset(shift) });

	my $r = $self->routes;

	my $app = $r->bridge('/:app_key', app_key => qr/\w{40}/)
		->to(controller => 'application', action => 'get_app');

	$app->get('/app')->to(action => 'get_name');

	my $client = $app->bridge('/:client_key', client_key => qr/\w{40}/)
		->to(controller => 'client', action => 'get_client');

	$client->get('/client')			->to(action => 'get_name');

	$client->get('/functions')		->to(controller => "function", action => 'list_functions');

	$client->put('/function/:func_name')	->to(controller => "function", action => 'create_function');

	my $func = $r->bridge('/function/:func_id', func_id => qr/\d+/)
		->to(controller => 'function', action => 'get_function');

	$func->get->to(action => 'return_function');
}

1;
