﻿package com.asd{	import flash.display.Sprite;	import flash.display.MovieClip;	import flash.display.Shape;	import flash.display.Stage;	import flash.display.BlendMode;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.AntiAliasType;	import memorphic.xpath.XPathQuery;	import gs.*;	import gs.easing.*;	import gs.plugins.*;		public class Focuses extends MovieClip	{		private var focusXML:XML = new XML( );		private var focusLoader:URLLoader = new URLLoader( );		private var key:String = "";		private var focusList:XMLList;		private var programList:XMLList;		private var tf:TextFormat;		private var tf2:TextFormat;		private var par;		private var focusMC:MovieClip;		private var degrees:MovieClip;		private var clickedFocus:String;		private var thePane:String;				public function Focuses( p, pane:String )		{			// activate TweenLite			TweenPlugin.activate([EndArrayPlugin, DropShadowFilterPlugin, VolumePlugin, TintPlugin, FramePlugin, AutoAlphaPlugin, RemoveTintPlugin, VisiblePlugin]);						// set the parent			par = p;						// which pane is it supposed to be?			thePane = pane						// text formatter			tf = new TextFormat( );			tf.font = "Helvetica";			tf.color = "0xffffff";			tf.align = "center";			tf.bold = true;			tf.size = 14;						tf2 = new TextFormat( );			tf2.font = "Helvetica";			tf2.color = "0x003366";			tf2.size = 30;			tf2.bold = true;						// set up listeners			focusLoader.addEventListener( Event.COMPLETE, loadFocusXML );			focusLoader.load( new URLRequest( "flash/homewidget/focuses.xml" ) );						degrees = new MovieClip( );			degrees.alpha = 0;			this.addChild( degrees );						focusMC = new MovieClip( );			this.addChild( focusMC );		}				function loadFocusXML(e:Event):void		{			focusXML = new XML(e.target.data);						if ( thePane == "focus" )			{				if ( par.theState == "" )				{					q = new XPathQuery( "//school" );					par.stateKeys = q.exec( par.statesXML );									//trace( "sk " + par.stateKeys.length( ) + " ::\n" + par.stateKeys.toString( ) );				}								showFocus( );			}		}				// shows the initial set of programs		public function showFocus( ):void		{			var fCopy:TextField = new TextField( );			fCopy.width = 427;			fCopy.x = 10;			fCopy.y = 20;			fCopy.multiline = true;			fCopy.wordWrap = true;			fCopy.antiAliasType = AntiAliasType.ADVANCED;			fCopy.selectable = false;			fCopy.embedFonts = true			fCopy.text = "What program are you looking for?";			fCopy.setTextFormat( tf2 );			fCopy.height = fCopy.textHeight + 5;			focusMC.addChild( fCopy );						var programArr:Array = new Array( );			var i, j;			var tmpObj:Object;						//trace( par.stateKeys.toString( ) );						// check to see if a state has been selected, if it has, then we need to widdle down the programs			if ( par.theState != "" )			{				for ( i in par.stateKeys )				{					var tmpLen:uint = par.stateKeys[ i ].children( ).length( );					var tmpSchool:XMLList = par.stateKeys[ i ].children( );										for ( var f in tmpSchool )					{						var found:Boolean = false;						var tmpProgram:String = tmpSchool[ f ];												for ( j in programArr )						{							if ( programArr[ j ].theID == tmpProgram )								found = true;						}												if ( !found )						{							// add the node from the XML to the new array							for ( var k in focusXML.children( ) )							{								if ( focusXML.children( )[ k ].attribute( "id" ) == tmpProgram )									programArr.push( { theID:focusXML.children( )[ k ].attribute( "id" ), theName:focusXML.children( )[ k ].attribute( "name" ) } );							}						}					}				}						// if a state hasn't been selected, show em all			} else {				for ( i in focusXML.children( ) )				{					programArr.push( { theID:focusXML.children( )[ i ].attribute( "id" ), theName:focusXML.children( )[ i ].attribute( "name" ) } );				}			}						// row height			var rowH:uint = Math.ceil( programArr.length / 2 );			var startY:uint = ( stage.stageHeight - ( rowH * 35 ) ) / 2 + 45;						for ( i in programArr )			{				var sp:Sprite = new Sprite( );				sp.name = "sp" + programArr[ i ].theID;				sp.graphics.beginFill( 0x336699, .8 );				sp.graphics.lineStyle( 6, 0xffffff, .5 );				sp.graphics.drawRoundRect(0, 0, 200, 30, 10, 10 );				sp.graphics.endFill( );				sp.y = ( i % rowH ) * 35 + startY;				sp.x = Math.floor( i / rowH ) * 205 + 20;				sp.alpha = 1;				sp.buttonMode = true;				sp.mouseChildren = false;				sp.blendMode = BlendMode.LAYER;								sp.addEventListener( MouseEvent.ROLL_OVER, spOver );				sp.addEventListener( MouseEvent.ROLL_OUT, spOut );				sp.addEventListener( MouseEvent.CLICK, clickFocus );								var txt:TextField = new TextField( );				txt.name = "txt";				txt.width = 200;				txt.antiAliasType = AntiAliasType.ADVANCED;				txt.text = programArr[ i ].theName;				txt.setTextFormat( tf );				txt.multiline = false;				txt.wordWrap = false;				txt.selectable = false;				txt.embedFonts = true;				txt.height = txt.textHeight + 5;				txt.blendMode = BlendMode.ERASE;				txt.y = 7;								sp.addChild( txt );								focusMC.addChild( sp );			}		}				private function spOver( e:MouseEvent ):void		{			var tgt = e.target;						TweenLite.to( tgt, .5, { alpha:1, tint:0x339966 } );		}				private function spOut( e:MouseEvent ):void		{			var tgt = e.target;						TweenLite.to( tgt, .75, { alpha:1, removeTint:true } );		}				private function clickFocus( e:MouseEvent ):void		{			var tgt = e.target;			if ( tgt.name.indexOf( "sp" ) < 0 )			{				tgt = tgt.parent;			}						par.theProgram = tgt.name.substr( 2 );			par.gotoNextSection( );		}	}}