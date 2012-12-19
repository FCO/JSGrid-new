package JSGrid::Application;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub get_app {
	my $self    = shift;
	$self->app->log->debug("on get_app()");
	my $app_key = $self->param("app_key");
	my $apps = $self->model("Application");

	$self->stash->{app} = $apps->find({key => $app_key});
	$self->app->log->debug($self->stash->{app});
}

sub get_name {
	my $self = shift;
	$self->render_json({$self->stash->{app}->get_columns});
}

1;
