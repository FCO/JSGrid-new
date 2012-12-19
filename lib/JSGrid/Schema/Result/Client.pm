use utf8;
package JSGrid::Schema::Result::Client;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

JSGrid::Schema::Result::Client

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

=head1 TABLE: C<client>

=cut

__PACKAGE__->table("client");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 key

  data_type: 'char'
  is_nullable: 0
  size: 40

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "key",
  { data_type => "char", is_nullable => 0, size => 40 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 application_clients

Type: has_many

Related object: L<JSGrid::Schema::Result::ApplicationClient>

=cut

__PACKAGE__->has_many(
  "application_clients",
  "JSGrid::Schema::Result::ApplicationClient",
  { "foreign.client_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 apps

Type: many_to_many

Composing rels: L</application_clients> -> app

=cut

__PACKAGE__->many_to_many("apps", "application_clients", "app");


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-19 10:40:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:O7cYpMeTtlMN/PekwA6teA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
