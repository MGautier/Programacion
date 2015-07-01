#!/usr/bin/perl

use strict;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->agent("MyApp/0.1 ");

 my $req = HTTP::Request->new(POST => 'http://nnjt.wordpress.com/2011/11/22/capitulo-3-parte-1-fase-de-prueba-experimento-lr-100/');
$req->content_type('application/x-www-form-urlencoded');
$req->content('query=libwww-perl&mode=dist');

 # Pass request to the user agent and get a response back
         my $res = $ua->request($req);

         # Check the outcome of the response
         if ($res->is_success) {
		#if($res->content !~ s/^[<!].[>]$//)
		my $aux = $res->content;
		if($aux !~ s/<.*?<\/.*?>//sg)
		{
			if($aux !~ s/<.+?>//g)
			{
             			print $aux;
			}
		}
         }
         else {
             print $res->status_line, "\n";
         }

