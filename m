Return-Path: <linux-efi+bounces-4987-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7209EBC26C1
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 20:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31DAE4EC4E5
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 18:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0812E973C;
	Tue,  7 Oct 2025 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WM9fWmYR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD491E25F9;
	Tue,  7 Oct 2025 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862580; cv=fail; b=cUWWhFBwzV1FmM7JtnfwUfHA+LApPayFadvVxMNOylwLlZ/QnxoUKp3UltRe2PBQg82zgB+pWGGat7p2pfaO0mmYD5vfgMU4Vai6oHNcoltbD8P66F8MOJYiZ9Aq5xTN3PgDxnP0RM7ni/uxPAqO87KOL7yy+j2dS34Md8mOrgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862580; c=relaxed/simple;
	bh=yXFX/lGJNz22tfLvvsPWh4DrBJHnaqy4Mt4airCerr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e5rD48IPQ/5QQxkPlr3j76aokvnWxIamd7a+krxP78DUcBjCG7xVfi+fApxpV6Hs5sPCHA+zpnhvMOKFnx9IzRWGdMFBGgrpBMLiGHmVnVDDred0yESOqTrfyGBjbumm+X/7vthYpVtQWR4hlnmlwLaDHZY4hw83hbP7htS8vJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WM9fWmYR; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759862579; x=1791398579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yXFX/lGJNz22tfLvvsPWh4DrBJHnaqy4Mt4airCerr0=;
  b=WM9fWmYRsX+QyT79JFTvUtCDztRxUY/kJM4MX8pzQz6GVmRrHZH4yl0Y
   2MehiYrLuam3kXpcDx3RfH15779nu9oCjqDlNZxVK4Quk+Tm26FwYs4C5
   Co+6+f89t8/rRuV/hQlKLXlSBU6EUCEb1W+EcfD3M8DrYK5JvNChnBHXt
   9I/Xmqx93zrzhl0ogG6wmBbuARGW4nUjw1oSOvbBnsO/8i21K38TBt482
   g5kZo5le5MuWDmMRjiew3XLj4dzPh79uBqGSf/Ru+IedHporssLEq8DOQ
   HInE55LeXr3t2YrwqLXby1a7KArxkrsRgaop6BlCqfHwAJLfuh6cwH31V
   A==;
X-CSE-ConnectionGUID: MKu+lgNtTJ6eCtPJwGHCYQ==
X-CSE-MsgGUID: gJelxxc+RiC9nUhyPcVfUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="49607121"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="49607121"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:42:58 -0700
X-CSE-ConnectionGUID: 1xv2YwY2QS68YtjP18CI1A==
X-CSE-MsgGUID: eZzYA3mxT4C1jmwRKKkvsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="179485417"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:42:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:42:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 11:42:56 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:42:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np7AylfMh7B+VLFI4xpfQGjm03agBtHcAWqLo4TXgFhrERYpWxrTcsDwNglTOrrbvc7mpNF+UiKs3lCLmAdLqU9zeXJYUX0zAL/GsZ/pohEeDt/r5Z4LhRoBKNHie8gqShDPfY6F7CFR/bc4l+tgv+wGmbU8vDtyktYj601H1c902yHgVtp+RH2EjMN4s6wb0pCYmxR14p+Og97aFY9Ro9Y6/+Yk9eTv7AayyV5wHTUt2RUnCc6CzZm4V1OFW+7V+Zxs56dwDt2BhO47dwy/emwjcn2+oT3LyAfLk1iKh1MSUg4w7Gt87tAJ7scgekPSSTEJaphF9lxlwRWTHQP+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXFX/lGJNz22tfLvvsPWh4DrBJHnaqy4Mt4airCerr0=;
 b=TEmDneawM52VC1RnZvKSttQtcqPOKlU9FcynddabMjGypRa+vdSO74fikYXKZiGDHHaanPxSZd9iFtc88ZdYXH63XncohTZavjguYlmLFIFrSya/GZc1cNwbCuXiLfp367GsiL5AziWVnovvTHbKkV9rJkb/seNenifOSmjzMXmGBpKs9dGrVgO2/jmq7yzMGdmq6u60zL+3bZg5ePBiMltYw7dEUOeWCmhymlKxJMHUm4XOJlSE72P4NPYAuwhXFxoTTxXrib/5Re+4pZc+cG64TBN4kkaJzPNqZ5ymlVBdNY7Yjt2l256GEwi3uNWwtG/MHezipZVanAlrXKEoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB6370.namprd11.prod.outlook.com (2603:10b6:208:3ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 18:42:48 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 18:42:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"luto@kernel.org" <luto@kernel.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "Luck, Tony" <tony.luck@intel.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "vegard.nossum@oracle.com" <vegard.nossum@oracle.com>,
	"xin@zytor.com" <xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v10 15/15] x86/cpu: Enable LASS by default during CPU
 initialization
Thread-Topic: [PATCH v10 15/15] x86/cpu: Enable LASS by default during CPU
 initialization
Thread-Index: AQHcN1c0OLEDTnvJ/k652zTPTQbHLrS3BauA
Date: Tue, 7 Oct 2025 18:42:48 +0000
Message-ID: <d34857c2f90bf57db491c89118c9e759abf0fb2c.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-16-sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-16-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB6370:EE_
x-ms-office365-filtering-correlation-id: 6a0a89f2-154d-4e07-5f43-08de05d15019
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bTFVdU1TVjk3Z1BvSCtQVTNUdm82OEtHdzNXZTZPcmNNS0JhdDJEWmdIYnJv?=
 =?utf-8?B?NVEzd0FkS3BrYlgvOWdPbTIzdmErTEF6YWJBbFAxWEg1Znh5N0dQVWJTNGI0?=
 =?utf-8?B?d2haeDgxUXFYekpZNWd5bHNOZnRHU0EybVdlT1lvQXVBQ09VcUNnL0tnUnZR?=
 =?utf-8?B?eHlZSVB6eEd1bm5mK2pqY3NNVWRrL1V0ZzJLdmhJYzZpcG8wbVd6Qm4wZmZa?=
 =?utf-8?B?UDBjNGpjTElvdlZHOVdlSk16aDFmV3RvWlZWODVVdDZESzQwNzFwV29VbHFt?=
 =?utf-8?B?TG1uSVJxaXJXaktpbWpmTTkvN0gzL01IRWIyYTZkanlaUUd2VEZCVHlDd0JR?=
 =?utf-8?B?QzJrZFRwdFNpQjFRem82cG5nTmx6aFF4bTFYYXpJYkJocmF4YklSVS94a0FL?=
 =?utf-8?B?ZTNNUVFyRjluZWV4UHVQR2tGeDVHby83ZGdEUjVtNXM4K2JCbEJEZ1RXenNT?=
 =?utf-8?B?ZFpKK0dEWW00NEhCRFI5TXZCbkRNZGE2WmZlNTJZOEZwbENPdXJuaDdjUzN1?=
 =?utf-8?B?M09mVGdRbys0ZW9hQmVnWkhha3l6SDRETm45Vi96alR0VEtpWFIwNHFCcUJh?=
 =?utf-8?B?cjB2cDM5dkZxS0U4K1ZSaWsyMjk5V1o5eXY2S1ExM3VHQTBnbEtBeGZwM09X?=
 =?utf-8?B?SCtvaEgwSWhVSWpLYklHemdXZ3pXUnpONGxUM2xqcEptcEtDbkpUeFdpdWk5?=
 =?utf-8?B?b3FWamZraGJjTHZiQWdHWkJBZnIyTHpObnF0bnByMWNUVW1VNzZGb20xKzJH?=
 =?utf-8?B?L3RSVUpkVy9tc05obmYrUURLL2NZaVA0TE9pOTRMNTJvZTJjY0dNOFlkNU1V?=
 =?utf-8?B?Z0t6R0ZYRm83Q2duSmdYcit3d3lCYnJud2d2dmgvbCtISlRhY0w5UitJclRS?=
 =?utf-8?B?bkZEWHNJN2F4NVRYa1NVZmFzLzdLRWQ0S2gvSyt1NXlYVTJ4Y2c1TmplRURB?=
 =?utf-8?B?WEFvN1hRVHlmZ3hKdmF6N0lGdk5xNVJRazZBM1BxMkNUV21Qa2xGcEtGcnN2?=
 =?utf-8?B?bTZIU1FVeUk0Sy9sVGI0eXcxTjFZcVBkWXUwRjJIbk8vM0lFY202VlNjREFY?=
 =?utf-8?B?YzdIR0N6YVp3Z1V4aHhEUDQyUnVaVWhFWmNkaWFpSThIRENKQzN0TGpXbkZM?=
 =?utf-8?B?WUtFNHNKSTdwV1BDQUZVa0ZHSkxmLzkzZTVXVFNkbVk4cHVJVjlFcVBlL0w1?=
 =?utf-8?B?WDVmaWczVEpHOU53ajhGTDhRdERlemxUaDBEalFIazYvcHpLNHc4WktEcDVq?=
 =?utf-8?B?cXpJd0VRSjlqcUxOMjVDc2g0YlJTQVFBWFR4ZytaSW9PTnJVNU1kTHd6N2Jk?=
 =?utf-8?B?NnNSZmZ2bGNGUFpBTGI4OVVlUzVTMDFLZ2lzaUgrbUVVVG9HVVRCMjVRblN3?=
 =?utf-8?B?K2loZkZ6VysvdFlDNUNkUGo5SjVTZjc3Rk45S3YxM1h1RkRiN1BXWnR6TVpq?=
 =?utf-8?B?VTkzbE9BSHB4dzZDWG1aNExGMzBkYlpwSklEUEladXlOY3gzSTJNWmc0Uk1Y?=
 =?utf-8?B?NTRQMVhCNFpKSmZTSmQ5bytncTAwMStaaFRKdDNmVSthMzFvVmx5dUlTTndv?=
 =?utf-8?B?ajdMUUE1UUlVYW1Tc21JL1Q4VXo4bk1vTFhHeHUrbEhNcU5SVCt0UVBaamJX?=
 =?utf-8?B?aGw2SlV0U2gvenc2NWltQXBCR0F0cm9wQm1XNXlXSE52QnpTcFplQnpScUtC?=
 =?utf-8?B?SWRmb0lQWG12Y2hkbUVxdlNiVGNpS201cWlxUnhWS0M0UWRqTm9CdFlhUjht?=
 =?utf-8?B?SWtQWDcrbXVMSVhvZ1B0Y1ZtRWdBcjcrQVc0ajdqOGYyQko3STdNMU1tN05S?=
 =?utf-8?B?RDN5c21INTlYRkZyM1pJVmdIa0ZvUTlJSFVUQ05yb0dUZmdKTHN0VzhrRGVs?=
 =?utf-8?B?akYvNFhwemxaMno0U20wT1QxL0tyeW1QQ2R3WkphTGZ4bWdRZ0dEZWNSMWZU?=
 =?utf-8?B?cGtIRjlLUVhXanJuaFpQZGkxM1cxcHdZT1N5SUdlQXZsWjByc3l6U0ZJMEtj?=
 =?utf-8?B?UDZ4Mis0T0YxSFhPd3dvTy9OWk1NTG1wWG5WRDN2UUJra2E2Tm5nLzkzR3Bh?=
 =?utf-8?Q?XXZ9ec?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXo1NFRncVl5a3Q1amxFWGVZM3NOYmY0QTBRK3pOVlk4UklVUUV6Mytackpz?=
 =?utf-8?B?cmMwaitWcU52NEl6QTZDTmhLalJrajNyeVB2TlBWb0s1c2FWcnlyOVFWS1kw?=
 =?utf-8?B?RjhVOWF2dGZwTGsvNE1aNlVwUE8vc1FVald0UGtOKzBpUmVuRkdjYmNrTDBz?=
 =?utf-8?B?QnV4U0Z5cHlTcklSTHgwTklwSWR0alNUQVVZV1FWYmYrRGZvUW5RQ3NFNysw?=
 =?utf-8?B?b2RFamkxVFBMUFlOdTkzRVljY3M2YzJxYlk2SStvbWpBTVl3N05zMisyTktr?=
 =?utf-8?B?MWlvSkYvNUdmdFpPMkY5U0c4UDNTaC9ZanJHRVZYU3dDdkhzb2psOUZDSHlx?=
 =?utf-8?B?S0drZS9HR0dQa3AxWGhPWWFJMnRaSHNEbzFoZERQa09JL3VId25Zb1Y0TVJ2?=
 =?utf-8?B?K1BlMEF4NGRMem93cnc4c3N2U05CeHpia2c1TUZJNUw2d2pBZFJxOXRscnhY?=
 =?utf-8?B?bWJGTE5QSTRZS0xZd3lQUG5OTVR5cXh5c3RSS3lZNkVNNCttTWtPVGE2V2FQ?=
 =?utf-8?B?YWNNWURUZmVmd0VQMDBBbTBBTUgySmtlK3EwUVJxL2N2dDZYQVI0Z09ucVFx?=
 =?utf-8?B?T0t4ZGx0dmtoNUxaVXJYNFlyTW5pVDYxNUQwVTJqK0Z0NStHQS91RzJXSU42?=
 =?utf-8?B?WFRuSTlpUjl6WXRaUkRKQkx0aTR0MGF0RFZsUHdIODdybGNzOE5FcVE3K3BV?=
 =?utf-8?B?NHVlaytxUnRaaWZ6d2hiQmJ4dGtJOVlDVktjazNhbmM4VHk4cUgvTFdxNWds?=
 =?utf-8?B?Y3YrSnBrRGUrUjhWNExKM1FiVTY4T0VFdXJrWU8yNzJhTytkNjV2OUVJa1Vv?=
 =?utf-8?B?dDVhNUJEaURFUlZ1MkNzUWRMd3dJSS9ISm9PYTMxendWWEV2cGd4Nm9Sd21F?=
 =?utf-8?B?UFlHZnh0emg5aGN5MXVna1hDWkxsV0Mvb3VJS3NKQjBFRE1kRml4MEp6ZGUx?=
 =?utf-8?B?SzJ5OUhON1dKUy9TRVVReG5ZSFFTKzBkYmlXSDhQaWdCaklKckxoQjFldDRo?=
 =?utf-8?B?azIzN1J3Y2lLSlJ2a0JZbWtkK3BJTG1Sd3pGSzdlRVQwVnNoa2xxdmlydEo0?=
 =?utf-8?B?bVRNcmZaV0EzMGZYWUZ5ODdUYjEzVEtMZmkzNDhvUndIWkR5eG8rK01DT3Zp?=
 =?utf-8?B?MTB0cURxQ2VrODFJUVRwYjJBYXJNS0ptaml3RWhycVpXMW1RUXhVL012WXJT?=
 =?utf-8?B?bVRFQ2FPY2NVYUQrVkp4Z0VXdDFGNkVkd2s1UFBTTmhWRkdlMnFUMnllL0lG?=
 =?utf-8?B?bXVBMUlMdC9KMmlJc1VucWJKUW9IRkJuczZwK0YyK1lHZUVNaHlrK0FCMi82?=
 =?utf-8?B?RkN5Wnp1VEhqVXludlhaVlhuRU4xZjNZNlBkazRWT0VqeFBWdVRIM2g3cTlT?=
 =?utf-8?B?NHBzOVN1YmppK05UZmRlMHZ4TU9iam90bkJhMVVCTTJoQ014QnErTmhTbVBN?=
 =?utf-8?B?VFEzamJTQ1JvdjJCaEw4VzRFY0VwUk0zR0pQL0xYMmZoajZLNlRneWZwWis1?=
 =?utf-8?B?ek9iUEZ3ZytNMU9NZjdQdmh2eUd2ZFo0YVh5dlN4QnEyWUFNUVRNblpLVlBP?=
 =?utf-8?B?QTA2bzMzL2I0cjdXNjQ2Um9xckVhYWNSTGEvN2Z3T3NXMnc1RkVJcFdUcG5C?=
 =?utf-8?B?RXBHckpzRktCbWhDMnhFZU95S0RTeDZNVE01RjhCQmxVQmxvTXhQc3dEM2kv?=
 =?utf-8?B?cVFnNXo5M0F1MW1DeGxHNERqbjE0MnpHRWVhUll6T01OR29SVkxCblVnVHJD?=
 =?utf-8?B?MVBkM2V0MSt4c3JIYWNjUEpGZG1IODFTbHFQaDBQU0FGYWE2WjJzbE4yY08v?=
 =?utf-8?B?aTYxcTFwY29iMmNtU1ZHUjZQN2pYMDh0c0hNejQ5UWNtT0VhVGQzdHpOMzd4?=
 =?utf-8?B?VnI4YldqSTZ1ZkwvOHFNV1paem1MZEppOWxjMHllcFAyUnNtSFRpaC93UG5p?=
 =?utf-8?B?RDZEMXBwaCs3Q2FKMmp3MVJQRER1U3FNZ2tRV0dNaTJ6RW42UVBVMGtPaHkv?=
 =?utf-8?B?Y2hzRXAvT2RwMHhTRXpXQnlGV2RBSXpZRnVveXQyaWU2RzlWQ0lMN09JTW50?=
 =?utf-8?B?SU1sNldKS2k3b2gwSFhJdEhVOENlUXQ0Ni9yMno1dU9XLzJxckFTekRJZ0NS?=
 =?utf-8?B?UnI5cTZkREdldWUrU0pqOG9YajJBM2dmZGUxTy9BYkhsV0M4d0dpb1M5dnlH?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D394683053BF347ACB6CE0257864056@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0a89f2-154d-4e07-5f43-08de05d15019
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 18:42:48.2919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkxez10JKwYVdSM7m75TmRXGDbvmoRgmh4fuKuiuXOXXchBZs0//U6CcbKFnKzKpB0aCD/KcmLefT0i+hkTeDWBVBCzdcGnBHVyHDjqbA9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6370
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDIzOjUxIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
TGluZWFyIEFkZHJlc3MgU3BhY2UgU2VwYXJhdGlvbiAoTEFTUykgbWl0aWdhdGVzIGEgY2xhc3Mg
b2Ygc2lkZS1jaGFubmVsDQo+IGF0dGFja3MgdGhhdCByZWx5IG9uIHNwZWN1bGF0aXZlIGFjY2Vz
cyBhY3Jvc3MgdGhlIHVzZXIva2VybmVsIGJvdW5kYXJ5Lg0KPiBFbmFibGUgaXQgYnkgZGVmYXVs
dCBpZiB0aGUgcGxhdGZvcm0gc3VwcG9ydHMgaXQuDQo+IA0KPiBXaGlsZSBhdCBpdCwgcmVtb3Zl
IHRoZSBjb21tZW50IGFib3ZlIHRoZSBTTUFQL1NNRVAvVU1JUC9MQVNTIHNldHVwDQo+IGluc3Rl
YWQgb2YgdXBkYXRpbmcgaXQsIGFzIHRoZSB3aG9sZSBzZXF1ZW5jZSBpcyBxdWl0ZSBzZWxmLWV4
cGxhbmF0b3J5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU29oaWwgTWVodGEgPHNvaGlsLm1laHRh
QGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNv
bWJlQGludGVsLmNvbT4NCg==

