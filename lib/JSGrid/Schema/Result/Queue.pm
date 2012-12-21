use utf8;
package JSGrid::Schema::Result::Queue;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

JSGrid::Schema::Result::Queue

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

=head1 TABLE: C<queue>

=cut

__PACKAGE__->table("queue");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 app_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 func_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 args

  data_type: 'text'
  default_value: '[]'
  is_nullable: 0

=head2 agent_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 done

  data_type: 'bool'
  default_value: false
  is_nullable: 1

=head2 answer

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "app_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "func_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "args",
  { data_type => "text", default_value => "[]", is_nullable => 0 },
  "agent_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "done",
  { data_type => "bool", default_value => \"false", is_nullable => 1 },
  "answer",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 agent

Type: belongs_to

Related object: L<JSGrid::Schema::Result::Agent>

=cut

__PACKAGE__->belongs_to(
  "agent",
  "JSGrid::Schema::Result::Agent",
  { id => "agent_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 app

Type: belongs_to

Related object: L<JSGrid::Schema::Result::Application>

=cut

__PACKAGE__->belongs_to(
  "app",
  "JSGrid::Schema::Result::Application",
  { id => "app_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 func

Type: belongs_to

Related object: L<JSGrid::Schema::Result::Function>

=cut

__PACKAGE__->belongs_to(
  "func",
  "JSGrid::Schema::Result::Function",
  { id => "func_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-21 13:50:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HuzZKHC9XfkU7rYXHqOPug

__PACKAGE__->load_components("InflateColumn::DateTime", "InflateColumn::Serializer");

__PACKAGE__->add_column(
	args => { data_type => "text", default_value => "[]", is_nullable => 0, 'serializer_class'   => 'JSON' }
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
