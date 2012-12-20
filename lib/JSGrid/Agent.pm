package JSGrid::Agent;
use Mojo::Base 'Mojolicious::Controller';

sub get_agent {
	my $self    = shift;
	my $agent_token = $self->session->{agent_token};
	my $agents = $self->model("Agent");

	$self->stash->{agent} = $agents->get_agent($agent_token);
	$self->session->{agent_token} ||= $self->stash->{agent}->token;
}

sub get_execs {
	my $self = shift;
	my @list = $self->stash->{agent}->get_execs;
	$self->render_json([ map {{func_id => $_->func_id, args => $_->args}} @list ]);
}

1;
