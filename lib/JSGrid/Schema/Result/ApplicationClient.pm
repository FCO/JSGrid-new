use utf8;
package JSGrid::Schema::Result::ApplicationClient;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

JSGrid::Schema::Result::ApplicationClient

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

=head1 TABLE: C<application_client>

=cut

__PACKAGE__->table("application_client");

=head1 ACCESSORS

=head2 app_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 client_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "app_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "client_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</app_id>

=item * L</client_id>

=back

=cut

__PACKAGE__->set_primary_key("app_id", "client_id");

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

=head2 client

Type: belongs_to

Related object: L<JSGrid::Schema::Result::Client>

=cut

__PACKAGE__->belongs_to(
  "client",
  "JSGrid::Schema::Result::Client",
  { id => "client_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-19 10:40:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NwM1jCALONosop3a0IXQzA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
