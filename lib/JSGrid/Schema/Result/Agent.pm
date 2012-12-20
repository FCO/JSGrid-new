use utf8;
package JSGrid::Schema::Result::Agent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

JSGrid::Schema::Result::Agent

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<agent>

=cut

__PACKAGE__->table("agent");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 last_ip

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 last_answer_at

  data_type: 'datetime'
  is_nullable: 1

=head2 created_at

  data_type: 'datetime'
  is_nullable: 1

=head2 distrust

  data_type: 'real'
  default_value: 1
  is_nullable: 0

=head2 token

  data_type: 'char'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "last_ip",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "last_answer_at",
  { data_type => "datetime", is_nullable => 1 },
  "created_at",
  { data_type => "datetime", is_nullable => 1 },
  "distrust",
  { data_type => "real", default_value => 1, is_nullable => 0 },
  "token",
  { data_type => "char", is_nullable => 1, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<token_unique>

=over 4

=item * L</token>

=back

=cut

__PACKAGE__->add_unique_constraint("token_unique", ["token"]);

=head1 RELATIONS

=head2 queues

Type: has_many

Related object: L<JSGrid::Schema::Result::Queue>

=cut

__PACKAGE__->has_many(
  "queues",
  "JSGrid::Schema::Result::Queue",
  { "foreign.agent_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-20 11:26:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NZ+6x++ukHGs9/9ayqGM/A

__PACKAGE__->resultset_class('JSGrid::Agent::ResultSet');

use Digest::SHA1 qw/sha1_hex/;
use Carp;

sub should_believe {
	my $self  = shift;
	rand >= $self->distrust
}

sub get_test {
	my $self   = shift;
	my $schema = $self->result_source->schema;
	my @agents = $schema->resultset("Agent")->search({distrust => {">=" =>  0.001}})->all;
	my $agent  = $agents[rand @agents];
	my @tests  = $schema->resultset("Queue")
			->search({agent_id => $agent->id, done => ['false', 0, undef]})->all;
	my $test   = $tests[rand @tests];
	$test
}

sub get_execs {
	my $self  = shift;
	my @list;
	my $schema = $self->result_source->schema;
	$schema->txn_do(
		sub{
			my $list = $schema->resultset("Queue")->search({agent_id => undef, done => ['false', 0, undef]});
			@list = $list->all;
			$list->update({agent_id => $self->id});
		}
	);
	my $test = $self->get_test if $self->should_believe;
	push @list, $test ? $test : ();
	@list
}

## uncomment these
package JSGrid::Agent::ResultSet;
use base 'DBIx::Class::ResultSet';

sub get_agent {
        my $self  = shift;
        my $token = shift || sha1_hex(scalar(localtime time) . rand);

        $self->find_or_create({token => $token})
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
