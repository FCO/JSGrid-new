use utf8;
package JSGrid::Schema::Result::Function;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

JSGrid::Schema::Result::Function

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

=head1 TABLE: C<function>

=cut

__PACKAGE__->table("function");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 app_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 code

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "app_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "code",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<app_id_name_unique>

=over 4

=item * L</app_id>

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("app_id_name_unique", ["app_id", "name"]);

=head1 RELATIONS

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

=head2 queues

Type: has_many

Related object: L<JSGrid::Schema::Result::Queue>

=cut

__PACKAGE__->has_many(
  "queues",
  "JSGrid::Schema::Result::Queue",
  { "foreign.func_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-19 10:40:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UyRVZXTuAQsHABhMzCW3FA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
