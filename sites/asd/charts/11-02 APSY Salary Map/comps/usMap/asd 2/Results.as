﻿package com.asd{	import flash.display.Sprite;	import flash.display.Stage;	import flash.display.Loader;	import flash.net.URLRequest;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.AntiAliasType;	import flash.net.navigateToURL;	import flash.net.URLRequest;	import flash.net.URLVariables;	import memorphic.xpath.XPathQuery;	import com.utility.vScroll3;	import gs.*;	import gs.easing.*;	import gs.plugins.*;		public class Results extends Sprite	{		private var par;		private var tf:TextFormat;		private var tf2:TextFormat;		private var tf3:TextFormat;		private var tf4:TextFormat;				public function Results( p )		{			// activate TweenLite			TweenPlugin.activate([EndArrayPlugin, DropShadowFilterPlugin, VolumePlugin, TintPlugin, FramePlugin, AutoAlphaPlugin, RemoveTintPlugin, VisiblePlugin]);						// set the parent			par = p;						// text formatter			tf = new TextFormat( );			tf.font = "Helvetica";			tf.color = "0x003366";			tf.bold = true;			tf.size = 18;						tf2 = new TextFormat( );			tf2.font = "Helvetica";			tf2.color = "0x003366";			tf2.size = 24;			tf2.bold = true;						tf3 = new TextFormat( );			tf3.font = "Helvetica";			tf3.color = "0xff6500";			tf3.align = "center";			tf3.bold = true;			tf3.size = 18;						tf4 = new TextFormat( );			tf4.font = "Helvetica";			tf4.color = "0x003366";			tf4.bold = true;						//trace( par.theState + "  " + par.theProgram + "_" + par.theDegree );						// show the results			showResults( );		}				public function returnResults( ):XMLList		{			var q:XPathQuery = new XPathQuery( "//key[@id='" + par.theProgram + "_" + par.theDegree + "']/.." );			return q.exec( par.statesXML );		}				private function showResults( ):void		{			var res:XMLList = returnResults( );			var yPos:uint = 0;			var tally:uint = 0;						var scrollMask:Sprite = new Sprite( );			scrollMask.graphics.beginFill( 0xffffff );			scrollMask.graphics.drawRect(0, 90, 410, 199 );			scrollMask.graphics.endFill( );			scrollMask.alpha = 0;			addChild( scrollMask );						var scrollMC:Sprite = new Sprite( );			scrollMC.y = 90;			addChild( scrollMC );						for ( var i in res )			{				if ( res[ i ].attribute( "state" ) == par.theState )				{					tally += 1;										var school:Sprite = new Sprite( );					school.name = "s" + res[ i ].attribute( "id" );					school.mouseChildren = false;					school.y = yPos;										school.addEventListener( MouseEvent.ROLL_OVER, mOver );					school.addEventListener( MouseEvent.ROLL_OUT, mOut );					school.addEventListener( MouseEvent.CLICK, toForm );										scrollMC.addChild( school );										var logo:Sprite = new Sprite( );					logo.graphics.beginFill( 0x336699, .5 );					logo.graphics.drawRect( 16, 0, 104, 40 );					logo.graphics.endFill( );					logo.name = "l" + res[ i ].attribute( "id" );										school.addChild( logo );										var loader:Loader = new Loader( );					//loader.load( new URLRequest( "http://www.mymedicalassistingdegree.com/ahswidget/" + res[ i ].attribute( "logo" ) ) );					loader.load( new URLRequest( "ahswidget/" + res[ i ].attribute( "logo" ) ) );					xy( loader, 18, 2 );					school.addChild( loader );										var txt:TextField = new TextField( );					txt.name = "t" + res[ i ].attribute( "id" );					txt.x = 124;					txt.width = 350;					txt.multiline = true;					txt.wordWrap = true;					txt.antiAliasType = AntiAliasType.ADVANCED;					txt.text = res[ i ].attribute( "name" ) ;					txt.selectable = false;					txt.embedFonts = true;					txt.setTextFormat( tf );					txt.width = txt.textWidth + 10;					txt.height = txt.textHeight + 5;										if ( txt.height > 25 )						txt.y = 0;					else						txt.y = 6;										school.addChild( txt );										yPos += 50;				}			}						var fCopy:TextField = new TextField( );			fCopy.width = 420;			fCopy.x = 10;			fCopy.y = 20;			fCopy.multiline = true;			fCopy.wordWrap = true;			fCopy.antiAliasType = AntiAliasType.ADVANCED;			fCopy.selectable = false;			fCopy.embedFonts = true			if ( tally > 1 )			{				tf2.size = 24;				fCopy.text = "Here Are Your Top School Matches!";			} 			else			{				tf2.size = 28;				fCopy.text = "Here's Your Top School Match!"			}			fCopy.setTextFormat( tf2 );			fCopy.height = fCopy.textHeight + 5;			addChild( fCopy );						var subLine:TextField = new TextField( );			subLine.x = 16;			subLine.y = 55;			subLine.width = 420;			subLine.multiline = false;			subLine.wordWrap = false;			subLine.antiAliasType = AntiAliasType.ADVANCED;			subLine.selectable = false;			subLine.embedFonts = true;			subLine.text = "Click a school now for more information";			subLine.setTextFormat( tf3 );			subLine.height = subLine.textHeight + 2;			addChild( subLine );						if ( yPos > scrollMask.height )			{								scrollMC.mask = scrollMask;								// add in the scroll bar				var scroller:vScroll3 = new vScroll3( );				scroller.kickIt({tgt:scrollMC, startHeight:199, tgtBaseY:90, hh:0x336699, gc:0xcccccc});				xy(scroller, 420, scrollMC.y);				addChild( scroller );								//TweenLite.from( scroller, .5, { alpha:0, delay:.5 } );				TweenLite.from( scrollMC, .5, { alpha:0, delay:.25 } );			}		}				// event listeners		private function mOver( e:MouseEvent ):void		{			var tgt = e.target;			TweenLite.to( tgt, .25, { dropShadowFilter:{ color:0x000000, blurX:20, blurY:20, alpha:.7, distance:5 } } );		}				private function mOut( e:MouseEvent ):void		{			var tgt = e.target;			TweenLite.to( tgt, .5, { dropShadowFilter:{ alpha:0 } } );		}				private function toForm( e:MouseEvent ):void		{			var url:String = "http://www.allalliedhealthschools.com/requestinfo/?schoolID=" + e.target.name.substr( 1 );			navigateToURL( new URLRequest( url ), "_self" );		}				private function xy( tgt, xPos:int, yPos:int ):void		{			tgt.x = xPos;			tgt.y = yPos;		}			}}