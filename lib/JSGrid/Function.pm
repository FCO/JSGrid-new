package JSGrid::Function;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub get_function {
	my $self    = shift;
	my $func_id = $self->param("func_id");
	my $functions = $self->model("Function");

	$self->stash->{function} = $functions->find($func_id);
}

sub return_function {
	my $self    = shift;
	my $func = $self->stash->{function};
	$self->render_json({name => $func->name, code => $func->code})
}

sub run_function {
	my $self = shift;
	my $args = $self->param("args");
	my $ret = $self->stash->{function}->create_related(queues => {
		app  => $self->stash->{app},
		args => $args,
	});
	return $self->render_json(Mojo::JSON::true) if $ret;
	$self->render_json(Mojo::JSON::false)
}

sub create_function {
	my $self      = shift;
	my $func_name = $self->param("func_name");
	my $code      = $self->param("code");
	my $ret = $self->stash->{app}->create_related(functions => {name => $func_name, code => $code});
	return $self->render_json(Mojo::JSON::true) if $ret;
	$self->render_json(Mojo::JSON::false)
}

sub list_functions {
	my $self      = shift;
	my $functions = $self->stash->{app}->search_related("functions");
	$self->render_json([map {$_->name} $functions->all]);
}

1;
