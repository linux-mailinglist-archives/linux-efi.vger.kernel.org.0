Return-Path: <linux-efi+bounces-4984-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B56BC2607
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 20:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B84B84F62DB
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 18:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A642A2E92C0;
	Tue,  7 Oct 2025 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iupx/JYC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2F45C0B;
	Tue,  7 Oct 2025 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861454; cv=fail; b=hvdBIC9iEc1nzEPcNbeKQpcNyFeRD9jHdUM3HAHC3O6UL7OpyCml5Oho/ehYoCeYTtwuJZlaLxQvcRwZu5Psvjnr92oGYVreQmsog1kZZhZBe5Wj/0Hdc7bUCa7WO2B85526aOnVbrUO3zlwYF5joT6CDjOtRM4+2EYs8RXukKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861454; c=relaxed/simple;
	bh=ujyCLkgJYIFTvTkqAK8LE+1zLUq470DJExdtdpdChTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CQ6lbY2wbHbeAy3UDSkkeBCzIdtjK31UDYuUAh21vG4ZeHjz0cKaPz1sUqWvKp509qoWbWAHkVmzZNkDThp2RbvaeACf4XSGgcgi9Q3Dj8uY/agrutJttGqQppBJQYLi6t31KoQU6IUKk9EPtmRCKOGu3ikJPrqMBqd493pGSxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iupx/JYC; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759861453; x=1791397453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ujyCLkgJYIFTvTkqAK8LE+1zLUq470DJExdtdpdChTE=;
  b=Iupx/JYCK3byrJNef+hI6vBuji+LIueVSBVhp7VTIyzDqMW1ORjDs8F6
   2TT/4r92/pNvDpOWhQB+qA48GHqlTGSEl8it92PS6EVlK00hT25mAyQKo
   M2V+soS442tu0+qm/4c+BuOmxbgjPf0aVxBlT7FEwfVqiVJc/NW6TP3u1
   9BROO0Mblv6HJYjEoZ5wCem+AwTsPTLCl9mABMD5PKMPh5j1Xo7h8I2pE
   egpAqseYm6Utr5G6yvA0j2L/KGq8XMUVkfaLZNgmUEaBsErCIpSkTRhte
   mhGYnEDk4tqJlk8lZFc1lqx+kVaD2O4BVVYV24KwzpsstNJBvELEG+TjZ
   Q==;
X-CSE-ConnectionGUID: 6LzOYYivQCO43/2J17j8ng==
X-CSE-MsgGUID: jypN3a4yTyOWM6Vx0V/vyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="79699775"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="79699775"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:24:12 -0700
X-CSE-ConnectionGUID: uNwVeEFpQg67OMKflvUCpA==
X-CSE-MsgGUID: FJa5SexhRr6jGm5mAMFRXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="180035588"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:24:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:24:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 11:24:11 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:24:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsYq1pKyjqS/gZNKlzj2H8Rf5HLpuPVQexnGKvFrRp25ea3VxYQ51rvQVeSK82ei4S9k2/k2UqNd21c8WIpMctIQWg175RVCuIJHZNwgZE7bBIkDNZL1MjQkH/XdKncZYAUS2y5lBkMCdLStVdCELuciMzT+If31YDKp6q+lBOXWCMl7y/lVPp646JgKg7bJJys5PDxdS0URbusyh5zY50H3zxG76iHimjOxHVrWSBQ4ZnDtWjb/AMQm/1N4d+p0Me58eFzMjgQ4XLym5aoeyIKcuqmzXgwBHL3h5t6TwnJr1PDlUgvD7JtxtknCsMv9Tbr3taH758Wqb66FJHUAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujyCLkgJYIFTvTkqAK8LE+1zLUq470DJExdtdpdChTE=;
 b=J5j9vl6zw5nyPTq2Q7aK8nvff05QcC6SMDnpCinAkaoc/ipyR5zdtoz6md73pZkXjh86DjPri8pvyIceJTGZ0JCWdwbjlsQKTSF9QdXvpTAjpVEeVJEpzdzek9hLvRr5QSGjYY7BBrN6SeH+AQHZJRcgycPpl51Gqd4CvIWWjI716y3bv2ktf0lF1l9SqmgT7tZuLoNtwpwtYxNmo+uuxJwyNph3xkiKa4P1HTrE5tbZRXHAatMt3yTtFjXysXpr3bfslrXKmN5FdhnsyCLtplRdn7cBbwKrpabT9ty80+eTYlDjzZNflpyFWFbTWGaSQIFn2LYbVSX60VqhyX+NHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB6262.namprd11.prod.outlook.com (2603:10b6:8:a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 18:24:04 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 18:24:04 +0000
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
Subject: Re: [PATCH v10 04/15] x86/cpu: Set LASS CR4 bit as pinning sensitive
Thread-Topic: [PATCH v10 04/15] x86/cpu: Set LASS CR4 bit as pinning sensitive
Thread-Index: AQHcN1cw4DZ66oVJo0SQ3van2Zqe3LS3AG+A
Date: Tue, 7 Oct 2025 18:24:04 +0000
Message-ID: <e873d2b06a18b69e246f8011c556259d21c7e022.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-5-sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-5-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB6262:EE_
x-ms-office365-filtering-correlation-id: c4a7965c-9af7-4c5a-98da-08de05ceb22d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eTg1TWJiRklzY0FQTGJBenBSMjNZZHoveUlndkVvUExHMXRCQVEyd1Urc3Vn?=
 =?utf-8?B?SWRZZ0x5LzhRenhPenpYaTJFWWh6Y1lrR0dQVitqSFI5VXJYakVvK08yWVEw?=
 =?utf-8?B?L3pTZGVvbXZQbnVSYysrT1FoMmtnS3g3Slk0czRraS9LSWRNZG5tM0lPQzg2?=
 =?utf-8?B?NGhTRXZoWGhXWUdlMnIxM0lnK2c4djlaM1FmYVBpdVlSMVFkOUFzVHB1eXdW?=
 =?utf-8?B?SDZxd1o3TGhjZnZiSXBRa0VsczdXQUF2ZURoL0dGak5nRXo2UUxtbkRnNVB3?=
 =?utf-8?B?dFQxOExVWXlDcFVoN2Z5b0NBSHNydGYraXczNzA0WDNseVZmTXJsa3VIcGtG?=
 =?utf-8?B?d2pyL3A2bjVVYytvR1hpODJxM1B4eXhZSllMVFZBOUR6SXpqSCtxNWR4eHhs?=
 =?utf-8?B?ZzVqeFpMVWlWSW9GeGVCQXZjZnNSNDZVYmh5R3V0TGtiTlFFdlFYcWJvQlo5?=
 =?utf-8?B?NFZIY0ZNZjZoRERTbkpPMm0wV25DUkJWZ01VcVp2SiswcEUzcW9BWWpuSFdq?=
 =?utf-8?B?eDBaaFhFUGN6WHdhUTZWSkg1eE95dzg1S1pkSHpwVTRHeUYrYm55WE5IMEdM?=
 =?utf-8?B?bUI3eVNucEFjK3JabjhRbmdEZzE1bmVCdHlGanJXcFRONjlPY2xSeTllRDg4?=
 =?utf-8?B?STU1NnExdDFCK1hJSm1OUlpBVjZlR3JUdTBEeHNkYVRCMTVkRFY2K0hMZUor?=
 =?utf-8?B?SXdBdEJPbGhOVlYzU0UzQXZ6VFIzaXNtUVpzazRMR0NwRis1bGgyM3Vlcm91?=
 =?utf-8?B?S2c5S1AvZytUZG56YnhTTHgrekp0UE5mVjZVUEFzWlRWbXlnSzJXSDRFL3FI?=
 =?utf-8?B?Y0ozNXc0NWRWZ3V5ZTVZT3diazM5NkFIZDU1TXk1eEFiNllPMGpOQkgvclRC?=
 =?utf-8?B?K3lLQmU5R09Ja2k5bnBRV2FtRVFwQVhMK3MyeXVPZDRySTN1VmtXTWh3UnBq?=
 =?utf-8?B?dGZtTVRVQlUzeVU1Qlk4eDlzSGM5VG9ZSVEzemprQWNyb2RKdUlrbnppWERN?=
 =?utf-8?B?WCtJbVZFaS9TaklNc01jUGFzMlN2RWROMm5jRFVpMVB0d25tcnN1MEcraWtL?=
 =?utf-8?B?MVZjSnpZM2hyM3hXdUhSNWNodUt1ZXp3VzBRYiswSlp6dnl0eFhtRTE2cHJy?=
 =?utf-8?B?dCtjQThVTzlJSzFhT3lGMVJMUjhXWXU1ZGI0V2lhdTliMU9PbXdYenNuYVUv?=
 =?utf-8?B?U3hKTUhOdGhTVU9XeUxaK2RyNTVmajZXY3NhbWMyS2E2dFBxTmhsTWo5ZHhV?=
 =?utf-8?B?TmltbTMvU01GQTlLd0hCU2V0UTdKVnB1RmdHakoxRldEc0JJcENOaHlOTmRJ?=
 =?utf-8?B?TFlqVGdnaFI5TUNSd1ZWYmk1eEorNzlScnU1bERLU2JCcTZBSmkrZkZSWmtY?=
 =?utf-8?B?RzVmQ2xwNXcwdlFBOTlNQ0h4NmZjM3dZdlUyc2h6ZzVVWWdmK0hlL2VlU05V?=
 =?utf-8?B?Y1ZlT3BUd2JKWElvVzlMWG4vVlptZnVZbGhjTjZpSUpBZ2pQYmJjZFR5SVVW?=
 =?utf-8?B?ekRIaldweStKSGVna0h2czBXT2l2RW5qbGQrZC9NWS9MR0RBZHJRcHB3djRV?=
 =?utf-8?B?MGV0Qk9uZFN0UnJaV3VoTEJmQVAwMWx4NXZKeXA4NGNaUGppSVFNVE9tUUJL?=
 =?utf-8?B?THhvOWU5eVFvUm5UZHhUbnRmeFFuOUJjL3p5WHRhcVhOS3RtOXhHWjhXdUZN?=
 =?utf-8?B?V0RFU1kxVXd3b1BFQ0ZQY2JUQVB5NUg5aWlLbmcrckJnNEpoMVhneUU1RXNT?=
 =?utf-8?B?SXNPU0MrWm02NVdjT1Jkclk3MGl4cDFRTit6bzkvQityWlR3THR3dG10MmVh?=
 =?utf-8?B?Y0NrZU5GTEZTNHVjeXk1UUN5RGIyQUlIQWpOTURxL1VvOUtlOXAvV0U4cDNG?=
 =?utf-8?B?ZVJOYzZFU2VNWHlIZitCd1Fld1M0SFZlRnpoNHBSR3NQYTIrSy80MTRzeUlR?=
 =?utf-8?B?SkVzRzZNcjV5M3U1NUtFK0w5MTBTYTMwaGZQWWFOVzA1a2VBWStZRGpKeE1O?=
 =?utf-8?B?K0QrZVhLZDB4WUtCV3FaSkRHWnJUSUg1NzlNL20wTldWMGV3VmU3NkhWeXB4?=
 =?utf-8?Q?UVJAWC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1BBVXd2RWhRUEk3TVlKRjFZWVlzMStrRUkvTXVRb0ZBLyt1V3E5Tlc2YTN5?=
 =?utf-8?B?V1NHekJ0d3FweXZhQWZ4OExhSFVYVmliaFVpZzdHakg1UmF3YnArNU5EaE5t?=
 =?utf-8?B?aDZBTy9wZk5qVHNoNXI3NFlDZWlLdUdvaHpXZ2dvcm0vSktRUThmdHdJclF2?=
 =?utf-8?B?dDF6TVQ5QndyaGFGRFBIa015YmIwSEllcnpJZ2IxTzlMRE1COG9vajJKV0xU?=
 =?utf-8?B?bXR0RFEyYkZjMC9YTHErQ0NheFdxY3J2Lzg2SWVZZlEzcGdJZTFXT25HSkgz?=
 =?utf-8?B?dFNWSStka1Q1WnQ5ZDR0Rk9DSTBUQlNCcEdTcEdiOWFjYkMyeDNyeCtPb2Nh?=
 =?utf-8?B?SnhlNytQZXBTdDFlMHhicTdFanF6Q29DRzhqOVVZOXRwNEQzRDZuWCtuVmFX?=
 =?utf-8?B?bzYwdmY3RHpJV1Y1aFdmYXpjVXpNcWNsKytHNmR1TDFSQU1ob0k2YjFtSVFP?=
 =?utf-8?B?eXRZMEdBME5SRmdIQnJZSCtwWnlzT3BvelVCVjJHdXE3TWZhVm5PRk1xS2kv?=
 =?utf-8?B?OVpyU05YVkdHc3YvV0I4ZGNMQzFBbHhUSVMzNFJOZ21QQmVxTDRDTlpnYnpV?=
 =?utf-8?B?OFFKc3VRdWhlVDJ6djdiZEd0TGExWTluTitSR21rTjUwOFhtMDFyb2hwNThV?=
 =?utf-8?B?ZkhSYUpoUVZyNzczc3YzOVpRV2Z5aVBEQ2ZwVGJGS1RuMm91ZDJTaE9YMGpC?=
 =?utf-8?B?UTVibFB0R0prRDZ0YmtJc09jV0FjZncyQkFJbkVxNVpXdEFFRWVueEtjYXVh?=
 =?utf-8?B?SWVHYnR2TkVVVVhDVEIwbm8zeENidnpESGJDNDRkbGxTbGpPc2YzS3BmckJS?=
 =?utf-8?B?RjlZOWQzSENVL0tQTi9Fb2llSnFtbVB1bmljallna2tObjIyKzNrWmRzWktB?=
 =?utf-8?B?eTU2N2FKT1IxeVRmcnFSUFkyNzJUYjd2SWU2b0FTVTIvejlBbnpiQlRrOVZa?=
 =?utf-8?B?OCt4bmFIRlIrbVhJVzhoRnR0S1B4YmQzK3FpWEYxVXl6dXNjZzdrN1pINTN0?=
 =?utf-8?B?dFZXTHFpYUc5Qld1ZEw2VjRxR01wZk1wOHREYXFLblNzci80cFd5clRzWUJL?=
 =?utf-8?B?b2ZWeStMd2wvN0YvL25tUjNVK3lpN0oxVkRDUkYrSDhqTXpZYTNtcVV6aTA2?=
 =?utf-8?B?NnJiekxHU2Y2SEJZMnB3NCtNREJaaVJkdk5sVEU4VUcwR08vVXV0alp1NWhB?=
 =?utf-8?B?Tm1yRTJVWFRGa01GNTJNbSsvdWNzR3ZtamxReko2ZnhveUs0TUszUlRlMUh6?=
 =?utf-8?B?am1NeHZWU1Z1UVp5V0w1WFBnaHh5MVJxVVR4MEVwTSswcG9qTHAxMDZjVGU1?=
 =?utf-8?B?R1lJdXdab21IQ2U2VWV1VjFrd2VYUG0wVVhBQWticlYxSDZ0d2RZVlNHdm5Q?=
 =?utf-8?B?MDVscm93OHNGVjhCL0hvN21aMEdaQyt3bTdvMEVNRUZSVmJTTFRhdlN5RkJW?=
 =?utf-8?B?OG5uR0lKZDRKMDZuQW1nR1QxSjVGK0hheHU0Mmc4VFZTLytKK3RickFqdkxL?=
 =?utf-8?B?Ui9zZzh2STEyS3ZhQXExMG9rWXRmZzBBNEZZV1RtVVVMeUdxbnJVdTR6MUdT?=
 =?utf-8?B?Q2Q4VzRVVEdiakVmNk4wdXZLVWI0QjFrSlQ5cTF2TjFsTkM3RGpwcExHRHc0?=
 =?utf-8?B?Rzd0VjZETVY3WGYwakdVYmUraGkxbTZQY3ZacVgwalQrcVlsQU53WjdYNGNX?=
 =?utf-8?B?dWttN2M1bUlQWWlJOHlYWEp5MURQKys2eHozZ2ZnV244eWVmZmRMU2lhMWQ3?=
 =?utf-8?B?Z0pYazQrLytaUTd4UDExVlp5NkhVYy82REZoeGFDWWJkMjlNSGhRbXJTUmpM?=
 =?utf-8?B?SHBxcUtEbElqWjYyZlZYVGp1c2o1Y2JEOHVOS2JnRkZLS05TSHNWdTFpcE5n?=
 =?utf-8?B?ZjBaQWtZQ0NsSU9DbDk0UWZTQWtIcFVlNFlIcFJmSWg3ampRV0xvZW5tRVFR?=
 =?utf-8?B?N0ExbWs4RGhPNnk3SWZXM3VZRm45bHNSbTNabzdOajZTQUNocnFheGZvcEJm?=
 =?utf-8?B?YWRoU3JuQlVhUHJzakZQNGc0dFRTT3JiRzNXK3krU1R1OEIxUTRaSVhocUNj?=
 =?utf-8?B?YnkyTkdDRVVJL1FBZGRzbVpKNG1YK002NWtmRzFlRyttSUtDMS9NOUFqSi82?=
 =?utf-8?B?YlNBUUUvcmRFRnpnVGd6bVN0Zll3YzhkbFJqRG1sU1ZFZ2Y1TkhPSE1OaE9y?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AF7895B0CBD0B409ED5E19918E061F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a7965c-9af7-4c5a-98da-08de05ceb22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 18:24:04.3633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fBXhsB6ico/vAp9jcgW9mG0mHPZAMlgiGlCQBnEYJbondOj1qS2gsn3ZffR/qyOe4OcAltWRLC31yKt96z2ngII1jqIN6uJNWPiOnS1fww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6262
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDIzOjUxIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
RnJvbTogWWlhbiBDaGVuIDx5aWFuLmNoZW5AaW50ZWwuY29tPg0KPiANCj4gU2VjdXJpdHkgZmVh
dHVyZXMgc3VjaCBhcyBMQVNTIGFyZSBub3QgZXhwZWN0ZWQgdG8gYmUgZGlzYWJsZWQgb25jZQ0K
PiBpbml0aWFsaXplZC4gQWRkIExBU1MgdG8gdGhlIENSNCBwaW5uZWQgbWFzay4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFlpYW4gQ2hlbiA8eWlhbi5jaGVuQGludGVsLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogU29oaWwgTWVodGEgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCg0KSSB3YXMgZGViYXRp
bmcgd2hldGhlciB3ZSByZWFsbHkgbmVlZCB0aGlzLCBnaXZlbiB0aGUgTEFTUyBhbmQgQ1IgcGlu
bmluZyB0aHJlYXQNCm1vZGVscy4gQ1IgcGlubmluZyBzZWVtcyB0byBiZSBhYm91dCBhZnRlciBh
biBhdHRhY2tlciBoYXMgYWxyZWFkeSBoaWphY2tlZCBhDQpjb250cm9sIGZsb3cgYW5kIGlzIGxv
b2tpbmcgdG8gZXNjYWxhdGUgaXQgaW50byBtb3JlIGNvbnRyb2wuIFdlIGNvdWxkIG1heWJlIGdl
dA0KYXdheSB3aXRoIGRyb3BwaW5nIHRoaXMgYW5kIHRoZSBmb2xsb3dpbmcgcGF0Y2guIEJ1dCBp
dCB3b3VsZCBzdGlsbCBiZSBnb29kIHRvDQpnZXQgYSB3YXJuaW5nIGlmIGl0IGdldHMgdHVybmVk
IG9mZiBpbmFkdmVydGVudGx5IEkgdGhpbmsuIEl0IG1pZ2h0IGJlIHdvcnRoDQphZGRpbmcganVz
dGlmaWNhdGlvbiBsaWtlIHRoYXQgdG8gdGhlIGxvZy4NCg==

