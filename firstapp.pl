#!/usr/bin/env perl
use Mojolicious::Lite;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

get '/' => sub {
  my $c = shift;
  $c->render(template => 'index');
};

# データを受け取って処理
post '/' => sub {
  my $self = shift;

  # パラメーターの取得
  sub judgment{
    my $arg = shift;
    my $number;

    if (scalar(() = $arg =~ /好き/g) < 5 and scalar(() = $arg =~ /好き/g) > 0){
      $number = 50;
    	if (scalar(() = $arg =~ /おっぱい/g ) < 5 and scalar(() = $arg =~ /おっぱい/g ) > 0) {
    	  $number += 50;
    	}
    }

    return $number;
  }

  my $name = &judgment($self->param('name'));

  # メッセージがない場合はトップページを表示
  # フラッシュに保存
  $self->flash(name => $name);

  $self->redirect_to('/');
};

app->start;


__DATA__

@@ index.html.ep
<title>おっぱい好き度判定器</title>
<%
  my $error = stash('error');
%>

% if ($error) {
  <div style="color:red">
    <%= $error %>
  </div>
% }

<p>おっぱい好き度を判定できるよ</p>
<form action="<%= url_for %>" method="post" style="border:1px solid gray">
  <b>テキスト:</b> <%= text_field 'name' %><br>
  <input type="submit" value="Post">
</form>

<div>
  <b>判定結果</b>: <%= flash('name') // '' %><br>
</div>
