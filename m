Return-Path: <linux-efi+bounces-4993-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA6FBC2A92
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 22:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EE919A203A
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 20:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C362264B0;
	Tue,  7 Oct 2025 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rg+dUeH7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505912264BA;
	Tue,  7 Oct 2025 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869509; cv=fail; b=exZqlPWXqgbW+zw9nm71VJ1vbt/qtWOi69wsOrM4Ba7tX1ZoIOXd8Gtym2EvPc2RxFEbBfwbnRV7/xZucVml6fU5A5nVKOsdQ/2F3EIb/MLpPJ6jXpG2+KGS6CeJ/iLn+AdE5sd1w3O5jGOqmk6mR4su3dq6snAQ7ONi+UN2AQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869509; c=relaxed/simple;
	bh=T82tR3YdUvzB4Aq24hyPJiVj+LrwmYPiWQ0FMzyBSRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DudFrQI6A5vmtXT7eNS5iXxUEOlqbUneBDkIrHNBvoe1LCNZaBeNSxiqRvBc9Yd5g7CDq5FlQKqP295eJYjaSbXScgUDjqkDODqQNMzUeQBrwSxIpInqsgwD/PVI4SuggE6gTNE3WA8vW4EOzgOv4NxIaOVOcw9CUgYNEqV/PEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rg+dUeH7; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759869508; x=1791405508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T82tR3YdUvzB4Aq24hyPJiVj+LrwmYPiWQ0FMzyBSRg=;
  b=Rg+dUeH7T/Lg4rPQ0BkDPkiW8cIfLfEItAQ9/6oWuneta1o/0oM7GEq3
   7HpHsciBc0zAiE4/iPi+0EpfugOxrm1vAbF10a9jNvDxXhB3vmakP/Nr/
   HdqzDAAPXYaaPfR6lhc6C4lWv9Ey+BDDpjihxXjLqgKGfebVvffD/Rrqp
   r1Ix3njZxfKZtkFxb1m0N79ezFBJG60/hp+jJbo7ffXLfxzto2JtEfR9Z
   Mpfdb11JqJRVy4wQJUbL9zb/panY7h3PukZhYWoaViDckTb3ByovjCLRI
   xLvcCGkOCrsUge2qXA1L/cNh42LeVXx2PQcijwYtF8ATHrG7xc681oWup
   g==;
X-CSE-ConnectionGUID: DMWPgavoTxSF19+eD9LbPQ==
X-CSE-MsgGUID: 9uVYAXnTSaKcCAQRG6+rHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61266872"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="61266872"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:38:27 -0700
X-CSE-ConnectionGUID: ZGWUGZU4TwKIC2b5sqRcoA==
X-CSE-MsgGUID: d8CZ2zi4QSKS1Fe99+TDew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="203972880"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:38:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 13:38:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 13:38:26 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 13:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjR9b1/NwcP93puByTlkEunZB8JxtT7F+vjqRH/Ipd73S45j5Fi/zVCMX5VAkhPXYyowvavnJGlKC18rr4zM5UF6O7xIjPvLFrggOmQ+8jexpESr+uYGKHwCpLqmd9rzOxiMaIAKsK2wwKxY0EPwUkziH88tzjxFiMamntxhef5Y17xLzAAu02jadJ2dN9VD/5+88RwValCnWatQPodCkJDB+n7+4tDEz7dewEZAZz4GzZxu/I1QlNMpnATeRAhxDVChAppY1RpxOAmOb0xzrvj9CjDs7y3NoqN9dpZrlL3wr18cNuevkl7txa4Em9a26NGhG790tpj29q26CySVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T82tR3YdUvzB4Aq24hyPJiVj+LrwmYPiWQ0FMzyBSRg=;
 b=KpeDpSYckXW9RH5Sv4Q6LObJtRFuD/Qgx71zMiWmEpEJtntmXteRgGaOKH/X8Uc8RNdRqAS1jon2+CSRQvB6QLjHIXEKVFntK3ivOwdoBhl//IBcL2ID9/MnbKnMwlXqPn89RwNtA/XE3cJC/MjU0CAomM1ABcF9e/zIvjZACcOgbnz5tQaL/ItLeIWrScTOKv0QqK7cJN2DpNQ2udehy+Yq87ly8VbthV3xVi1YoEMHf1DNT4LRl0Xjd9pbeuFOIggiP1AAlgTXBxM4MsNERDHI24CgUzQ62BLJCuL9RjihPHqBt0XAv8AdTy7/luPBtN9hu7v3Fo+35ZMSDNCtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB6915.namprd11.prod.outlook.com (2603:10b6:930:59::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Tue, 7 Oct
 2025 20:38:20 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 20:38:20 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"vegard.nossum@oracle.com" <vegard.nossum@oracle.com>, "xin@zytor.com"
	<xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
Thread-Topic: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
Thread-Index: AQHcN1ctIPgyjz2Uhk2A2Ka753Z4xbS2/zEAgAACgwCAAB9MgIAABPKA
Date: Tue, 7 Oct 2025 20:38:20 +0000
Message-ID: <8cc8306a5608f68d6de7ed367afb50fc382e1cf4.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-2-sohil.mehta@intel.com>
	 <47fb7efd89698f46a305ca446d0e4471d1f24fbb.camel@intel.com>
	 <5d95d421-1413-46de-a578-c2a0e44e3aa1@intel.com>
	 <ea578640-c02e-4ba9-b0b1-e9a5c9c313a9@intel.com>
In-Reply-To: <ea578640-c02e-4ba9-b0b1-e9a5c9c313a9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB6915:EE_
x-ms-office365-filtering-correlation-id: df4e467b-7c87-46a4-08bc-08de05e173f2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RTBvSlFFalRwZU9ER1JBS1hvTXQwcnAxL2NYWkUzMW1tbGRhSXlNUW9KMkVZ?=
 =?utf-8?B?SnFrYjcySTZWM0M3L3Qzam5rOUN1NXRiM1lpd3k1SzY0MXdNZ08wM1BmUWtt?=
 =?utf-8?B?Q21idjlPNnNCQndJMDQ0ZE1vMTA0NVg5SlBGaGIybmtXRVhhMWc1RUFFVFo1?=
 =?utf-8?B?R2VVTlBGYm55Z1lWR1Rha1JMak10M1FaNkdNb0wzbHdpRGRKR2s4ZVpEd3Jr?=
 =?utf-8?B?NjRoY1Fxcm1YLzJVUGp0dGxaNlB0WjNmMlpYTC9iYVFSM2puL3k3S3k0akUz?=
 =?utf-8?B?cEptRGFKbUFuQ2V2em1QQUhzMzZMTzFsd3g5UzRtU3JDb3FiN1JnNGd1SnYx?=
 =?utf-8?B?QWtFejVxT3M1YmhyMllYbEJhTHd4OEJWMjhhTVVmbCtxeFlDUS9tTHV0VVpG?=
 =?utf-8?B?UU9oc2FIeHpxU3NKeEx6aEIxbkh1SW8wUGFTaVFTWkFlTkJXZ1F4bnJaeFp0?=
 =?utf-8?B?K0tvMjkvRGh2WDlwREYwUkNvaExTWEVYRDhSV0thYUJEV0ZCa0tsSE84OGxP?=
 =?utf-8?B?Wk5MczdTZnAvbVFtWGJIeWc5Zk5odVNNdDNCSXd1bUlPRmZ0SDdkTUZpai9l?=
 =?utf-8?B?bWh0QWhkZ2dRWFd0bUlaT2FpTDJzeDV3NlJab3NQc25pTjhkbWJ6ZjVHNzBV?=
 =?utf-8?B?SGRxQlNpTFBEWkd2emQ2d1BJdkVzdllGWUZjZGdCZmdHMXV4UG5PTlROMDJI?=
 =?utf-8?B?TThEcVBEYjg3Z3o1WEpjak1hZEZGdUJ1dzF6VForUGV5Qkw5eG1Zc0pXQkNm?=
 =?utf-8?B?a0VvYS9HekxFd0FHc3pOVWZ5Tjg5S3B5TjY2ZlRubndVN05sS24xejR3aVpY?=
 =?utf-8?B?Q2RwanEvN2x0UktpZVZQTXRkWmFvUDZ2VlU3Ykh3YUhlb3JSVWdIOVhyUjBR?=
 =?utf-8?B?T2x1L3U3M3NOSEtZWlpmQ3VoSzVhU2xXQjg3czlCMU9RenZ1MENxeWNUWXRS?=
 =?utf-8?B?MTlKRWxGYXNrQTd2eUpLMTl3Z2RRYlRTTTlkc2ozMU85czZSRzRyeVdiai8z?=
 =?utf-8?B?dXRQeGlQWkl5WCtGT0cweGEvZG1ReDA0ZWRHcUozUStPdE9kcWp2NXlsaER3?=
 =?utf-8?B?dzI2N3NLbWkyMjRIM2VOTmlaNW5Idm1SNWkyb05IYmtnMFFlQkF4ZlBkK3JM?=
 =?utf-8?B?cGhLeFVqdWR2TCttOTVOY3IwS0tUclV6VGlwU0lTMnd2aWNiOUtMMnl2REUy?=
 =?utf-8?B?ejdsZ2ZUWGw5TU5aZ0dWbVdGU2ErVWlWRlJ4YTRnUGY3L1Q0ZExNL0FrSzQ1?=
 =?utf-8?B?clVMUllPMXI3WHZtWTd0MzNlVUZ5dVMrOHl5eVcxdjF5c2p1WVJlakt6cWlS?=
 =?utf-8?B?bmNjNU9YOG5tbmtpVzlqdnNQbDdERG9DTWMxdU5TbEF3RmhlelAvbnEwTVdM?=
 =?utf-8?B?UENNelFkQnY0bERvU05vM3ZGRUxLNTRlWm15YWdXV3JZemxuTTQvKytHUGpz?=
 =?utf-8?B?Q20zOHU0TWpJdjZQWlVDWVdiaHdaQUFpS0p3WTNFenNIMTFKRCs0NkhmejAr?=
 =?utf-8?B?UzNKaXdzRytXRDBWa3hQUXNaK2dVYjB6ZG5UOU1LbGVLQ1JHbDBGRjRaMVlk?=
 =?utf-8?B?MkpiSFBhZW5YT25ySDVMU2VuMHNscmRvT2RIWGkxYnUrN3JRaTR4NHBaYUJW?=
 =?utf-8?B?MEZucmVldUM3Y1JLbmhubGFVdWREalk5eU5kQk9JOHhOWUQxSGd5ZS84em05?=
 =?utf-8?B?elpmbzEvb2ttQ0ZVejBla2JlekdyTzRqcHEvb0R5SlM4cWQvbXJ6ZjJvaVdS?=
 =?utf-8?B?VHRNSkZzMEJaSnBwazhSRzN0QUtDcTVuVVUxVkpFLytRc0lJcFlrTGhGYlEz?=
 =?utf-8?B?UnJCVFVXb09BR3BpVHRUNThkcXVmdDBNSmMreEJ5VXVVRU91aEVsUG1ZQ1Bp?=
 =?utf-8?B?bms1V1hkdExpQmN0d0hXWHBjcTBQek5Kc0NDKzBncnNlZVNvTFMvc0FMUFZl?=
 =?utf-8?B?Rm5rY09TZk5KeFYxaUZyK0R3bzVUTjhHN1FpajNsZWRtWmtqZXRTclRaOEhi?=
 =?utf-8?B?c2tjNTZwbWI2eW1mMjY0Y3BRdFIxaC9aTldJM2FpTHY5RTN0cHBVVkwrSTFC?=
 =?utf-8?Q?qFsEmT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE9xb09qcHc4YW11WXpiQ0RnVDlBelBaQzc4SGo4a05hSHI5TkkyRmNITDIy?=
 =?utf-8?B?c0RWdjhkZGEyMHNjUzE0TjFXeXNzMSszMENQOEUrQ1BSd0lOdW1HZTFlV1Uw?=
 =?utf-8?B?alQ3MGpGNklhSjNoMm5PWm02WjRCc3YxMUgvYnp0ZlFzSEIrbnBtV3RoQk9D?=
 =?utf-8?B?M0l4cmJzeEpNakhNWkdsZDFIRzBvSHhlbTd5K2Q1ZWFKT2RjTTEvYUsxTUlt?=
 =?utf-8?B?MzIxckNaTjVySGc3QWRUakpTK2Y4VFg4S0l1VWMxUVhxYVhmVzRETFFVVkJV?=
 =?utf-8?B?WjhPLzFPZU54WFFIbGNPVjJ2RHZuL3hpNXBmblJNeGs1R1NVMVlUcVAzVG5z?=
 =?utf-8?B?RVZwdkJLVTlRYXV0a0plNGNXTUI0blF4NGRna2ZhczlMUjVrR1pGNGlWbGxh?=
 =?utf-8?B?WWxWemFOYXM4RlF3ZFFwUGx6Z2I0RkN2NUVySy8vVkJwTUcvcGMzVS8zMlRm?=
 =?utf-8?B?ZThzMFBGRXUyYUpBMzBLLzBxS0NLUU4xODUvQU5kUW1PU3ZLUEtsWWZHQ0Vr?=
 =?utf-8?B?Wi8rVFpKVDJKV3BKalNRcjFKQU1xd3NCeTlacWVuSEI5SmZ3aFA0NzVydnV5?=
 =?utf-8?B?SzlSUjhtR3BoWUFUNm5XcXVXSG40Yi9vSTJ1RmZFWjdPMDR2V1g3TWFjYmQ0?=
 =?utf-8?B?MkxyQ25zUXp3WUNod2pYRVUyUW12KzhWQitVUG5SMTk2NXZ4c21rdkd0Vmdi?=
 =?utf-8?B?NEJLQTlNTFpBN0NFTW1KVEFMNitkUFNDTnNEU1pXNi9va0o0KzB3UTN6MFI0?=
 =?utf-8?B?blNPbFExYmdrcmxFZ0srRHpqbUtuU0lEVlk2eWpEUG1QTEZWSzlSbStwV1NK?=
 =?utf-8?B?OVhqNkF3M2c5UEN5a2ZvdnRnVHI5Wk5ZZUFVNWZINkFNUWF1NTlRUFUvc0Q1?=
 =?utf-8?B?czJuNkdXM015VmFQbWpLdUwySDhBR1lEbmc2TDdzMGQ5cVlXTXdSbll4NjNE?=
 =?utf-8?B?UGxCeW9Sak9LZmtxdXkrTFB1d1ppVXozbXI0NU5nMUV6MnRJN1ltdFlhcGls?=
 =?utf-8?B?S3Z3UnM1OG85akJwQnU3cG5iMUdHYnlOcFhCR05MalZQYmhuditLcmtoK0Rp?=
 =?utf-8?B?bDZuWVpTYUxhS2FMRkFnemNMbEtDcW1iTmRpRlJ2ZFQyYkJSSjY1Vnc5aUlX?=
 =?utf-8?B?cHRiMXJTOGkvRnpQZ1pDWXBwSEcyQSszb0N2SmhTdURURnRZMy9XWGt6ZHZP?=
 =?utf-8?B?SzR6WUluMXdLSXNYbFFhVGtrSitMRTg2RCtIb0l2dXZlVGYzUURqQ1g2eFMz?=
 =?utf-8?B?bEtQemh6bjNJeHlSenowcVZJbmx5ZzZFdE8veVBwdnpVQnFiOFNVWGZwQk1C?=
 =?utf-8?B?VUZwZG9tQVhNZ2ZDRHVFZEsvNHRiVXJTNVBrMjdyaEJnbkNleXhManRlLzE0?=
 =?utf-8?B?U2V6MS9aNU9BcFlDNTlWWms5eU4wWkVzRklKdGVuUThoelY1U01yTWJ6eTVj?=
 =?utf-8?B?UVdDV0hSL2RyN0ZaS1doK1NHeFgyMXhLY3BqQWpJeThWZmRjcldBNnNqbTNy?=
 =?utf-8?B?TFQraWpyUXFETk95VGZIK04zYzE2ZkNkbUtWaHNtSkU2NTZVZXFkMnZZdlZx?=
 =?utf-8?B?czk0RVpyZTFrTCtUdWJ2SVRMcWZ3V2lTS2hlWUxQQnM4T0F2WmhOenNQUHps?=
 =?utf-8?B?QTRuRysveWk5NnBBK243eGdoSDJ0SW5sOGllTkE0ZFZnVDB3MFJBcmpSekps?=
 =?utf-8?B?NTZhYk9IaitUY1dRcjFHSW1GZnZ6TXNMRGh3V1pHNmY3Nm9Xc01WMGZLOVg3?=
 =?utf-8?B?UWRHY2s4cW1yVU00YjNMRXB2TCttRkc3Zmo3OEtGcGRleFlycm1za0hxQWla?=
 =?utf-8?B?Uk82a2JJNjVrNEtHTWNFZ0phRVdINDJtdFNyRUVEYW5LT2F6cmx1YUphbnRN?=
 =?utf-8?B?UlFTc09KcnQ1eDVwNHdkZ2MrT3N4b2pFQVMvcnhncXdOLy80SjhEbWFUM1Nz?=
 =?utf-8?B?V04wQVpsTy9hUGNwY3RqR1hKTTBLLzNWSkZxRWZDa29yOHVza3JiTUZpT1p6?=
 =?utf-8?B?U3VJV0lpWm13S3haVDF5b1VNd0YwM0hQcVBjQWx1QnRnOTZnbnNUY0h5a0Jp?=
 =?utf-8?B?bm5GckNIM2pQVmE4Mmw5MGlOMDdLZ3RnV1JRc1N4Lyt4a2ZVQ3JKdlV4ZDJ3?=
 =?utf-8?B?WWJxa3lrVTNuVFB2ZUc5c29sdnRjRHY1ejBnZFVaa0JHUE9MbWNpTU1qZXkw?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5879C252BA1A442B5671A2147782B66@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4e467b-7c87-46a4-08bc-08de05e173f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 20:38:20.3831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5whQ8PoRANHif2uQ8GnZnS5F3F+JSAmHBDJ6k9PlbAcYOMFr6ui8xxcvinkGvcbD78fnqAj5Vg1bnVXdYnTHPN7IO+nUnZhWI45HghFeoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6915
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTEwLTA3IGF0IDEzOjIwIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
PiBTVEFDL0NMQUMgYXJlIGFsc28gYXJjaGl0ZWN0ZWQgdG86DQo+ID4gDQo+ID4gwqAJI1VEIC0g
SWYgQ1BVSUQuKEVBWD0wN0gsIEVDWD0wSCk6RUJYLlNNQVBbYml0IDIwXSA9IDAuDQo+ID4gDQo+
ID4gU28sIGV2ZW4gdGhvdWdoIExBU1MgX3RlY2huaWNhbGx5XyBkb2Vzbid0IHJlcXVpcmUgU01B
UCwgaXQgd291bGQgYmUgYQ0KPiA+IHJlYWwgcGFpbiB3aXRob3V0IFNNQVAgYW5kIFNUQUMvQ0xB
Qy4gVGh1cywgdGhpcyBzZXJpZXMgcmVsaWVzIG9uIFNNQVANCj4gPiBiZWluZyBwcmVzZW50Lg0K
DQpBaCwgb2suDQoNCj4gDQo+IA0KPiBUaGUgc3BlYyBzYXlzLA0KPiAiQSBzdXBlcnZpc29yLW1v
ZGUgZGF0YSBhY2Nlc3MgY2F1c2VzIGEgTEFTUyB2aW9sYXRpb24gaWYgaXQgd291bGQNCj4gYWNj
ZXNzIGEgbGluZWFyIGFkZHJlc3Mgb2Ygd2hpY2ggYml0IDYzIGlzIDAsIHN1cGVydmlzb3ItbW9k
ZSBhY2Nlc3MNCj4gcHJvdGVjdGlvbiBpcyBlbmFibGVkIChieSBzZXR0aW5nIENSNC5TTUFQKSwg
YW5kIGVpdGhlciBSRkxBR1MuQUMgPSAwIG9yDQo+IHRoZSBhY2Nlc3MgaXMgYW4gaW1wbGljaXQg
c3VwZXJ2aXNvci1tb2RlIGFjY2Vzcy4iDQo+IA0KPiBPbmUgY291bGQgYXJndWUgdGhhdCB0aGUg
TEFTUyBoYXJkd2FyZSBlbmZvcmNlbWVudCBvZiB0aGUga2VybmVsIGRhdGENCj4gYWNjZXNzZXMg
KmRlcGVuZHMqIG9uIFNNQVAgYmVpbmcgZW5hYmxlZC4NCg0KVGhlIGZldGNoIHBhcnQgZG9lc24n
dCB0aG91Z2g/DQo=

