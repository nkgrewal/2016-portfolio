﻿package com.asd{	import flash.display.Sprite;	import flash.display.MovieClip;	import flash.display.Shape;	import flash.geom.Vector3D;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.AntiAliasType;	import memorphic.xpath.XPathQuery;	import gs.*;	import gs.easing.*;	import gs.plugins.*;		public class US_Map extends MovieClip	{		public var online:MovieClip;		public var ak:MovieClip;		public var al:MovieClip;		public var ar:MovieClip;		public var az:MovieClip;		public var ca:MovieClip;		public var co:MovieClip;		public var ct:MovieClip;		public var dc:MovieClip;		public var de:MovieClip;		public var flo:MovieClip;		public var ga:MovieClip;		public var hi:MovieClip;		public var ia:MovieClip;		public var id:MovieClip;		public var il:MovieClip;		public var ind:MovieClip;		public var ks:MovieClip;		public var ky:MovieClip;		public var la:MovieClip;		public var ma:MovieClip;		public var md:MovieClip;		public var me:MovieClip;		public var mi:MovieClip;		public var mn:MovieClip;		public var mo:MovieClip;		public var ms:MovieClip;		public var mt:MovieClip;		public var nc:MovieClip;		public var nd:MovieClip;		public var neb:MovieClip;		public var nh:MovieClip;		public var nj:MovieClip;		public var nm:MovieClip;		public var nv:MovieClip;		public var ny:MovieClip;		public var oh:MovieClip;		public var ok:MovieClip;		public var ore:MovieClip;		public var pa:MovieClip;		public var ri:MovieClip;		public var sc:MovieClip;		public var sd:MovieClip;		public var tn:MovieClip;		public var tx:MovieClip;		public var ut:MovieClip;		public var va:MovieClip;		public var vt:MovieClip;		public var wa:MovieClip;		public var wi:MovieClip;		public var wv:MovieClip;		public var wy:MovieClip;				private var stateArr:Array;		private var statesXML:XML;		private var par;		private var stateList:XMLList;				public function US_Map( p, stArr, stXML, stList )		{			// activate TweenLite			TweenPlugin.activate([EndArrayPlugin, DropShadowFilterPlugin, VolumePlugin, TintPlugin, FramePlugin, AutoAlphaPlugin, RemoveTintPlugin, VisiblePlugin]);						// set the arguments			par = p;			stateArr = stArr;			statesXML = stXML;			stateList = stList;						var tf2 = new TextFormat( );			tf2.font = "Helvetica";			tf2.color = "0x003366";			tf2.size = 50;			tf2.bold = true;						for ( var i in stateArr )			{				var mc:MovieClip = this[ stateArr[ i ] ];				mc.alpha = .25;				addChild( mc );			}		}				public function showStates( ):void		{			for ( var i in stateArr )			{				var tmp:MovieClip = this[ stateArr[ i ] ];				setChildIndex( tmp, i );				TweenLite.to( tmp, .5, { alpha:.25, z:0, removeTint:true } );			}						for ( i in stateList )			{				var tmp2:MovieClip = this[ stateList[ i ] ];				tmp2.buttonMode = true;				tmp2.addEventListener( MouseEvent.ROLL_OVER, overState, false, 0, true );				tmp2.addEventListener( MouseEvent.ROLL_OUT, outState, false, 0, true );				tmp2.addEventListener( MouseEvent.CLICK, clickState, false, 0, true );				setChildIndex( tmp2, stateArr.length - 1 );				TweenLite.to( tmp2, 1, { alpha:.8, z:-20, delay:.5, removeTint:true, overWrite:0 } );			}		}				private function overState( e:MouseEvent ):void		{			var tgt = e.target;						if ( tgt.alpha < .7 )				return;							setChildIndex ( tgt, stateArr.length - 1 );						for ( var i=0; i<tgt.numChildren; i++ )			{				if ( tgt.getChildAt( i ).toString( ).indexOf( "Shape" ) > 0 )					TweenLite.to( tgt.getChildAt( i ), .25, { tint:0x339966 } );			}						TweenLite.to( tgt, .25, { z:-30, dropShadowFilter:{ color:0x000000, blurX:20, blurY:20, alpha:1, distance:5 } } );		}				private function outState( e:MouseEvent ):void		{			var tgt = e.target;			if ( tgt.alpha < .7 )				return;			for ( var i=0; i<tgt.numChildren; i++ )			{				if ( tgt.getChildAt( i ).toString( ).indexOf( "Shape" ) > 0 )					TweenLite.to( tgt.getChildAt( i ), .25, { removeTint:true } );			}						setChildIndex ( tgt, stateArr.length - 1 );							TweenLite.to( tgt, .5, { z:-20, dropShadowFilter:{ alpha:0 } } );		}				private function clickState( e:MouseEvent ):void		{			// set up the state keys so that if the states are picked first, the programs can show properly			par.theState = e.target.name;						var q:XPathQuery = new XPathQuery( "//school[@state='" + par.theState + "']/key" );			par.stateKeys = q.exec( statesXML );						par.gotoNextSection( );		}	}}