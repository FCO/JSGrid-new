package JSGrid::Client;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub get_client {
	my $self    = shift;
	my $client_key = $self->param("client_key");
	my $clients = $self->model("Client");

	$self->stash->{client_key} = $client_key;
	$self->stash->{client} = $clients->find({key => $client_key});
}

sub get_name {
	my $self = shift;
	$self->render_json({$self->stash->{client}->get_columns});
}

sub create_function {
	my $self      = shift;
	my $func_name = $self->param("func_name");
	my $code      = $self->param("code");
	$self->stash->{app}->create_related(functions => {name => $func_name, code => $code});
	$self->render_json(1);
}

sub list_functions {
	my $self      = shift;
	my $functions = $self->stash->{app}->search_related("functions");
	$self->render_json([map {$_->name} $functions->all]);
}

1;
