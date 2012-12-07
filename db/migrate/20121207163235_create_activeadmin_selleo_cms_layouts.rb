class CreateActiveadminSelleoCmsLayouts < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_layouts do |t|
      t.string :name, :null => false
      t.text :template
      t.timestamps
    end
    ActiveadminSelleoCms::Layout.create_translation_table! template: :text
    ActiveadminSelleoCms::Layout.create(
        name: 'Hello, world!',
        template: %q{<!DOCTYPE html>
<html>
  <head>
    <title>Hello, world!</title>
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/css/bootstrap-combined.min.css" rel="stylesheet">
  </head>
  <body>
    {{ main }}
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/js/bootstrap.min.js"></script>
  </body>
</html>})
  end
end
