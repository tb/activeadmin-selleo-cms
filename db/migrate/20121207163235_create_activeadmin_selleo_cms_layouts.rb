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
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>ActiveAdmin Sello CMS extension</title>

    <!-- Le styles -->
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/css/bootstrap-combined.min.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 20px;
        padding-bottom: 40px;
      }

      /* Custom container */
      .container-narrow {
        margin: 0 auto;
        max-width: 700px;
      }
      .container-narrow > hr {
        margin: 30px 0;
      }

      /* Main marketing message and sign up button */
      .jumbotron {
        margin: 60px 0;
        text-align: center;
      }
      .jumbotron h1 {
        font-size: 72px;
        line-height: 1;
      }
      .jumbotron .btn {
        font-size: 21px;
        padding: 14px 24px;
      }

      /* Supporting marketing content */
      .marketing {
        margin: 60px 0;
      }
      .marketing p + h4 {
        margin-top: 28px;
      }
    </style>

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

  </head>

  <body>

    <div class="container-narrow">

      <div class="masthead">
        <ul class="nav nav-pills pull-right">
          <li class="active"><a href="#">Home</a></li>
          <li><a href="#">About</a></li>
          <li><a href="#">Contact</a></li>
        </ul>
        <h3 class="muted">Project name</h3>
      </div>

      <hr>

      <div class="jumbotron">
        {{jumbotron_part}}
      </div>

      <hr>

      <div class="row-fluid marketing">
        {{marketing_part}}
      </div>

      <hr>

      <div class="footer">
        <p>&copy; Company 2012</p>
      </div>

    </div> <!-- /container -->

    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/js/bootstrap.min.js"></script>

  </body>
</html>})
    ActiveadminSelleoCms::Page.create(
        title: "Hello, world!",
        slug: "hello-world",
        layout: ActiveadminSelleoCms::Layout.first,
        page_parts: [
            ActiveadminSelleoCms::PagePart.new(name: "jumbotron_part", body: %q{<h1>Super awesome marketing speak!</h1>
<p class="lead">
	Cras justo odio, dapibus ac facilisis in, egestas eget quam. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
<p>
	<a class="btn btn-large btn-success" href="#">Sign up today</a></p>}),
            ActiveadminSelleoCms::PagePart.new(name: "marketing_part", body: %q{<div class="span6">
	<h4>
		Subheading</h4>
	<p>
		Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>
	<h4>
		Subheading</h4>
	<p>
		Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>
	<h4>
		Subheading</h4>
	<p>
		Maecenas sed diam eget risus varius blandit sit amet non magna.</p>
</div>
<div class="span6">
	<h4>
		Subheading</h4>
	<p>
		Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>
	<h4>
		Subheading</h4>
	<p>
		Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>
	<h4>
		Subheading</h4>
	<p>
		Maecenas sed diam eget risus varius blandit sit amet non magna.</p>
</div>} )])
  end
end
