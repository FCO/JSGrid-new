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
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-19 10:40:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iV1IHSdYsTCPVS+KI7yYaA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
