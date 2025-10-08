Return-Path: <linux-efi+bounces-5008-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2D4BC62C2
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 19:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4820034D8D1
	for <lists+linux-efi@lfdr.de>; Wed,  8 Oct 2025 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A302C029A;
	Wed,  8 Oct 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddsubkKc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FCA285052;
	Wed,  8 Oct 2025 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759945434; cv=fail; b=Y5CxxE1lKSdRALn+8u84KkANxXz/xT9tXptgDTpYg6jB5DZQIIbHoHpOTT2anhNRbY3W3pbE4OCdkLxTdiZ8xcitDXXWnofOPlGTYpfEnHilaXEI6kC3VNU0eAQQiWcK3sLG5wlDnhqr/et21wCOL41bBgV2NX5KEJZ3HzZco2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759945434; c=relaxed/simple;
	bh=qVzTEA1rLemZVN8MUp1hDY4PnpwHHZpnm5VX5OnwqiY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gGehr7u5qHrBUj6USoziI6c5AEUgzoeeFDyZWCZWPXMFGR8Z+VLVIQ0BKoZRNVSUWUDyRB031nMTutXsscC9NNBCQa/c3cBqyVDiqVj9ZaE2lOK0acjnP+iH9EP+Z9gQepgLoTBPp43sM6/lC+PCn1DujaMD/Omrc64IjfVGltc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddsubkKc; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759945434; x=1791481434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qVzTEA1rLemZVN8MUp1hDY4PnpwHHZpnm5VX5OnwqiY=;
  b=ddsubkKcjxbJt5k4/lc6ccb6FADn6SrYIsmSF6OVl/zAdIwLcH1UoFNd
   S3KBP0Kc0MUvaUbm1tEwscstfUgvgxq+km0U2zA6D7b4bam2pbxEZqwn1
   gb+8HsmpMKhEeaFvTCmj/xaPJy1859WKOLtFACpjimzWRzgPVCZaC/mwr
   NnpEvK/h1/Um7wsm2Iu1ZAO+g9mnAkW/sa4OQj1pxKLrHcszUMzF/vC/l
   eIa+D6ddnyTZew+0ygXKonSa73iyoBuJY3/TDNcccGeUQJ/ae/rb9E5eN
   PZETAXuAqeXgFoHs6Xf49vBsDenpmZhfJoesXseMVRwGvqszMrY8gJN2Q
   g==;
X-CSE-ConnectionGUID: liQ368CzQAet417+XREnjw==
X-CSE-MsgGUID: QOgVOqIcQhic3dLDpBN27Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65790694"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="scan'208";a="65790694"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 10:43:52 -0700
X-CSE-ConnectionGUID: KwgXYTJfRSS9g0ODUptSXg==
X-CSE-MsgGUID: zQJ6GsrbRoeY3Cm/SwGwsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="scan'208";a="180427748"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 10:43:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 10:43:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 10:43:50 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 10:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJRtsm+wFbwII99FfKQq+MeOaJ30exCnC+O0sy1gQYEMPuDHdjyoR6VYvbV0UYywtxFgo9A/Y+1SsuSpO/ISp9Sd7z21PRp7u7N0l+kQv5DM83mASvBMJlH2dX8McaaNdNw5kZxgxaS19crApt9RU7zenpNJ4RkOMQ24ON1FeexgqNckWSYJBodl40D6bngGzJUMWAzLG6IUIf85tHyieSy5FnMw0PlS3RrpydF1f9Ok43n3c955CF9V6r30d6C1pFkhn7y9zlCZPI/xYo6VHuZ/BATnmMsC5cv6kCBIFnDF4JZkC0/HuxmyUNAMQQBxQWDSTPxwKFPh4rLmdtxNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVzTEA1rLemZVN8MUp1hDY4PnpwHHZpnm5VX5OnwqiY=;
 b=ALMu3kHK95pp+my8V2kRaDRvrDGmUVDYQTSwLjmuJ9uoHijNqHctqjW/oMs9kVgZUHoXqDGbtW5PVAN/7veVHZRbRlHw/h+XGWrQJEGSkYKLkQA5Vr7XoyqMxyPbR6rbW+NcZNJ+5SDHfavxrQowfRzmcbbqxRFqTLX5OtFt49WjTO8mlcwxlh720dRWJDn5QFHGuCxfyKyv4WqeuHyJqZ2MYIlYSG2n7PpqD8lgrMy2RThYuLCBfFwp3oqvMQnR5fvQt0OKtJYcuNuOxHvetw0JXqh7/FeSKcSLvdBXk3fJzFAAZJZHDTS9evXzvcq70LNJ2A524BRh4Esz0qXquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) by
 PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Wed, 8 Oct 2025 17:43:43 +0000
Received: from DM4PR11MB5970.namprd11.prod.outlook.com
 ([fe80::e9b1:6f0f:1a91:2c79]) by DM4PR11MB5970.namprd11.prod.outlook.com
 ([fe80::e9b1:6f0f:1a91:2c79%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 17:43:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
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
	<peterz@infradead.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v10 09/15] x86/traps: Consolidate user fixups in
 exc_general_protection()
Thread-Topic: [PATCH v10 09/15] x86/traps: Consolidate user fixups in
 exc_general_protection()
Thread-Index: AQHcN1cx4GvzyB6BEU6xTer8KxhLLrS29eAAgABSdgCAAT8oAA==
Date: Wed, 8 Oct 2025 17:43:43 +0000
Message-ID: <75df4d00c009c60043b0c3edb8990342d9b9b9b3.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-10-sohil.mehta@intel.com>
	 <e314fabf0597e3ca4acc549e33fd483e64809dc6.camel@intel.com>
	 <92da314d-b523-4ace-9b09-eaf263b263bd@intel.com>
In-Reply-To: <92da314d-b523-4ace-9b09-eaf263b263bd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5970:EE_|PH0PR11MB4872:EE_
x-ms-office365-filtering-correlation-id: 6218c910-67ea-48d6-3dd1-08de06923964
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NVZpcTNCN3VZSWdDbUZueEt2TGRFWnA4MUJadUlGcWZTMWVibjh0MWFXaEda?=
 =?utf-8?B?My9MTWgvc2xPMG9JVkpjMlUwNFhWdjlNYldsRndNWGlNTWdZZStFamk2eXRm?=
 =?utf-8?B?ZDNZZloraEJSNC9wVksxUmV5QnVKOWc3Ti9SK2tDVGhMMk9nekRjenNxbzZ4?=
 =?utf-8?B?YW94aVZjYmpGZFhYT3J0VVRNTDhNNVlWdnVUZyt4NXVabm8veEtKcmpGSWRt?=
 =?utf-8?B?TFJBd0EzY1pUcThwL3dWRWlnTnZ1K0tpUHY2YnFCRmxyV01TdDZUSURLOWc4?=
 =?utf-8?B?Q3o1bkQ1M0NUTHpqWEpPbWxJU0RPenJIck93bEFxQnhkR1c3OXNnWFpOeE9v?=
 =?utf-8?B?S0JaOEFHanF6Smo4eDFTSTBWSVdvRzhGSnZ2cThTME1VMTltT1oyRWJiS2Nq?=
 =?utf-8?B?bFFyUmUyYzlmZ05kdFJQa1E2alZoM2FtMWIrOGFDTm9ZdEFua29ZV0NPUFRF?=
 =?utf-8?B?cmRoazBDV2NkSWpuVEtQNlo2Q2JpQ2J0VzJseGlvR1RGOFJHN0ZoamNMN1Jh?=
 =?utf-8?B?emRrTWJ6WlhQS25JcU9pYkFWbmg2T2YwUXF3azZmUUpyak9EWVRsYkVXUEJp?=
 =?utf-8?B?dUcwdHpxUEFCZVB3Rk8xQ2h5Ujd6eUs4Nm80cERzSUhqaTR2NktNODlHMHU3?=
 =?utf-8?B?NmJubEpqWitxaDhVZnU0TmVJMlp1b3gveGg0SUliaTcrMUtQdmY3dGNKdnF2?=
 =?utf-8?B?blVabnhHWFNMUnBNYXNqL1FWTEh0c3VEVDhJQzk4eDBkMEZwZFZ0WE0vTzJu?=
 =?utf-8?B?R0l1TExYblRIeWpjZnJpbUUycW1IZVNBenpzdWdZK251Qk5icVVsQk1PUmNF?=
 =?utf-8?B?RVozaGMwTXBWK1NZOWQyZWtMQ0thMXFYc1NhRkpleEQzRTJST1pTVFhMK0dm?=
 =?utf-8?B?RnllczgyanZRRkRtRXJESUoxeWdrRjBiekpVd1d3VWNqbVczS04vYXpIczNv?=
 =?utf-8?B?ZWRLODNXZUxIUy9SaW5CZmNPY2hBUkU4QVJYRy85bGNPOWFsMlR4K2dWTlRC?=
 =?utf-8?B?V2xRZVd5MEdLQmZ4OXdibTU3ZFVyZzFPZ1lNSGF1NW4yVUk3TzdqbGtVd0p4?=
 =?utf-8?B?UjUwUTV5dFZsYmlDLytmbUdOUSs5NWhtT3R4OUdEdVp3NmpsVTlVcU1nbTd2?=
 =?utf-8?B?NU50TXM4b3lxSmVJTllvYVRhWHVIcE5hU2JOdERzVE1EQ0lHMGpreldEeEdv?=
 =?utf-8?B?WTFNMmErK3NoeXU1d29BcmZ6ZTJ0UGw4WTBKZkZCQ1BJc1JCVFZVRDJxNHNG?=
 =?utf-8?B?YVorYVNQTmNHbGQ4NWZDYTlpalRkdGxUcTZnbjJ4SmpNcFl6Znl3Um5TaGNr?=
 =?utf-8?B?YWp6RUw2YTRrWjF2OWlDcy9IWk5DY3p3WDRGbXZic1VRbGJXeU9LR0QxNno0?=
 =?utf-8?B?N0RpNlVMTzNrTzlqQ09DQnVIUjZFQWw4aGZnSlJ4cWRQY3p2LzJKemRRTE5h?=
 =?utf-8?B?cVFDbENzKzZselhvU0JoejNhbko0OFVSUHdOSDVkWXFQSC9ZaWdONkpyc202?=
 =?utf-8?B?c0VBY2NwTWkzZVZlbE8vOExRNm8rZDEvSEhadVQ1aUt0Q1lmMTJ2dFd1UDg4?=
 =?utf-8?B?dFJTNkd4S1lSRHEyZ3FaY2FkOUZHWmRLVFE1MG1jRDh5K0g2NlpEVUR6RUQ3?=
 =?utf-8?B?QWI5c1lGcXc2RTdpTDVMdUtCZ0RPSkNhSE1SWnBsR2VJYXp5SVJCUmRZYjBO?=
 =?utf-8?B?VW9GZkN1ZFhOUGRUdnJmZHJWUXpMSWk2YXl5RktRZU5ucTNTQkRydXIrcnhG?=
 =?utf-8?B?UUV4c3ZseEhvSkFTK2JaQmFSR3Q2dlVSTFJmclg2T0FtNkFMRnZnSGMwTHlQ?=
 =?utf-8?B?NzFUenVWN1ptOXBOZzZHUW9oUDhreG1YN0Y3ZndDbGVHTW5GODY3MmxFN2RL?=
 =?utf-8?B?VkErRCt1WlVPcmNyeEl3MjArcXBLME9xcGxBSDAyVHhYbmtOZkVKU1ExaXpE?=
 =?utf-8?B?dVVxR2lGQmlaZXFtL2N3WmxJU2pzelNXN0ozMEZreXZhdDVXNjNwYzBaYkpH?=
 =?utf-8?B?c2t6V1RieXNKRWFCbWE3MjA0Vnd6dUJXTFJUZHlFa3lob2tDVy9VMWo2RVpG?=
 =?utf-8?Q?w2VJXt?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5970.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2U5OXd1TUl3UkhvcUZzVDBLZ3J5R0dIUWVaWTdoZUtlVlZ4SXhIdWNkWFZV?=
 =?utf-8?B?eDJXM0g3QVhRQTZiU3NyNm94TDh3ZkpzRjMwRVBaQmJjMm5MNzg5MGsrWmVa?=
 =?utf-8?B?QjlRUC85K2plUHlSeC9wM3g3Tm9IblhWSFlXVjFnYmc1WEJQS3FPZy9NOGNl?=
 =?utf-8?B?bWhsMXR0Zi9XZStxZUY5S08rdm83REh4OXBOa0FxbVlPRUJFOVVQYWZFUXAx?=
 =?utf-8?B?STV6SGZOVkVMZ28yUWhNbEhaRVE4Z3RCWVZRcHRnQnNKT3RFV25lTDRsT3JV?=
 =?utf-8?B?WExraERkRVg5d21hZDl2bnFiZUo5NWdQR0txRkthdldUbHNMeFhqdVYrY0R2?=
 =?utf-8?B?WllEQmtJSUJVMVZKWjlQbU9CTXgwbkhNSyt5OSsyY2dtZi9VSCt4THBYdnM2?=
 =?utf-8?B?eUcyUVA3WThCamZHL0h5WTZmOFplZkhhNXFqM2tDTU5xeW0yTW42RUVSTWsv?=
 =?utf-8?B?L1YzcDhMOFV6U1pRYlFpNDNUS3JWaEh1NnN5bEJVSU9KZzlmZnVJT3pQQm84?=
 =?utf-8?B?QTdLVWh6T0EvMjB4V1JqbHN1V1dWU2hCaWp3SXlqOVRWT2l0VFVCUUovbysy?=
 =?utf-8?B?TncvTHVzYXJIVzNRZ3hFWkIyTmtHVUlTbGZXVmFGTGJkM3hXV0U4a25zbnA0?=
 =?utf-8?B?cTEvK2NYVEJ2RlVXUkFUQVNaZ212eTlUazZtMVNmUDloWkpBT2laR1V6MWpO?=
 =?utf-8?B?WVphMkpZaW5UUkRyRDM0cGtjSEdDUXJ4YzBWSExod0VpTWUzQnJPaWNsSmFS?=
 =?utf-8?B?WUFidC8yZjA0cjM3d05GWCtoem94TVlJaDFmbWFLQjlvNy91SFdYOVR0VTU5?=
 =?utf-8?B?d0E1M3lQaHRhZTRRWFdxYW82VHI1UDBCVCtVeHRpVGhtR1FrczJyRHBlT3FX?=
 =?utf-8?B?QlZTd0lIWTJIcDdMQmk5UGlzYi9TT0NQNEZRcTljWGxKMmFMSGJraTZLSHlk?=
 =?utf-8?B?RzFQTTZSMVV4Nm41UHkrWk8zdWUvQzUxRG5QdHFlYS9veWMyeEh5TUxrZHNW?=
 =?utf-8?B?VStLSE9zT050enRtS20wcWZ0RldqRm9lTVloNWwwMVZRekNJUUxjenRVRi9n?=
 =?utf-8?B?Z3B1d2ZWQmN3MXdYcjg0TmM4eVFUVStTS3F6VlpUd3MydkwwQWVrY2RscnBx?=
 =?utf-8?B?d1ZWWmN5MWljQldybVpaa2NOTjJRNUNsYlA0Y29URkxlTVdnM3JwNGhsRFhl?=
 =?utf-8?B?VUc0Tm5ucGpOMVVqeHpuY05VTXBOQ0pGZWlSUGpmUEUvYzlpanoxLytxWEZ6?=
 =?utf-8?B?NEY4eUt5NWVRUkJPVW10Q0tOaDFMbFR4eXdQTjhScnA4U0RndElxUVVIWXVE?=
 =?utf-8?B?Q09ycTdHUjJaRjJLTlM2ZzBmMWRhUVF3cE96cERqWmRpREtIZklOcXlNMU9m?=
 =?utf-8?B?Y1dLNHhPUDNQUDJid1hyTGVjRXlhOFU0ZStka3h0VExCOUtSZmFZSjllcGF1?=
 =?utf-8?B?Y3I1SStraEdBOUoyVTQrT2xQRTdUSmIyYW9MeHRLNmx2czJCR3hwencrY3VH?=
 =?utf-8?B?RGRGR0VvZi9mVE54eFpKeGU2c0JDcmJRZFRNdDlNbFNVTHk3ajB3QzQ0dGtl?=
 =?utf-8?B?eUhta3pGZEpZYWhwZzl3ajF5S0dRNGpuQlhmM0VoU0ZOSG5ab0hJM2lHTWxN?=
 =?utf-8?B?UkcxSnh5TGRsa1l0SHhBc3A5RkIrZWNsSzVib2p3RUV4c0tUcFppbjFqS05B?=
 =?utf-8?B?RjVXOTlzN0hYVXpKSDA0OWdXT2VPajdkMWZ3c0JkTm92aEx2VzFjSGtVTXdk?=
 =?utf-8?B?TS9EUmI3U2M1b3ArV2VEbmJpdHdjMXQxZWhPR2tRN05uRFcvMFM1YnFNMFZj?=
 =?utf-8?B?ZXl0V2VSWjY0ajBsTDI5Nlc0dDFjc2NCZjRIK0x5UVpWOE1sak5qYlFOY2RF?=
 =?utf-8?B?NXBKZXZnaG9NbFVoNC9wYVlqS1hiSUNDWVNMRTZRa2VlZG1YQTNabWI3eXoz?=
 =?utf-8?B?QVo5aXViQzN5WkduZ2dodUxJckt1cUU2cG00VWJabllUd0N2dEFSV1ZFd0tP?=
 =?utf-8?B?QWZBTTRrMUcyMW5OaUkyVUFvYTU3Z2FXa0VxbkovNTVGRzM4RU4zMVVCTEhy?=
 =?utf-8?B?dlJoTUdtYytKbGhSMmVJZU8vZFdoVzVxUXZZdkpDTld1UEQ2aFhJVEZYditY?=
 =?utf-8?B?UWRWM0cweisvbVlLSktIenhZamtscjQzNnV2ZU9mMFhMa1lhNDQrKzFPVFpL?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8B621235DEA45429D599E0C2764CC0C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5970.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6218c910-67ea-48d6-3dd1-08de06923964
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 17:43:43.0665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhcFbf+qFVAJL49dV38x9HlINDB+GW5dfp/SkMxBrsk5JnXghIn3c0TKLdu7z7v04gHnQIak6ehGmyqEEArNXjekt6vDS8GRoADgjbVrdpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4872
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTEwLTA3IGF0IDE1OjQxIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
T24gMTAvNy8yMDI1IDEwOjQ2IEFNLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToNCj4gPiBPbiBN
b24sIDIwMjUtMTAtMDYgYXQgMjM6NTEgLTA3MDAsIFNvaGlsIE1laHRhIHdyb3RlOg0KPiA+ID4g
TW92ZSB0aGUgVU1JUCBleGNlcHRpb24gZml4dXAgYWxvbmcgd2l0aCB0aGUgb3RoZXIgdXNlciBt
b2RlIGZpeHVwcywNCj4gPiA+IHRoYXQgaXMsIHVuZGVyIHRoZSBjb21tb24gImlmICh1c2VyX21v
ZGUocmVncykpIiBjb25kaXRpb24gd2hlcmUgdGhlDQo+ID4gPiByZXN0IG9mIHRoZSBmaXh1cHMg
cmVzaWRlLg0KPiA+IA0KPiA+IENhbiB5b3UgbWVudGlvbiB0aGF0IGl0IGFsc28gZHJvcHMgc3Rh
dGljX2NwdV9oYXMoWDg2X0ZFQVRVUkVfVU1JUCkgY2hlY2sNCj4gPiBiZWNhdXNlIGZpeHVwX3Vt
aXBfZXhjZXB0aW9uKCkgYWxyZWFkeSBjaGVja3MNCj4gPiBjcHVfZmVhdHVyZV9lbmFibGVkKFg4
Nl9GRUFUVVJFX1VNSVApPw0KPiA+IA0KPiANCj4gVGhlcmUgaXMgbm8gZXhpc3RpbmcgY2hlY2su
IFRoZSBjdXJyZW50IHBhdGNoIG1vdmVzIHRoZSBYODZfRkVBVFVSRV9VTUlQDQo+IGNoZWNrIHRv
IGZpeHVwX3VtaXBfZXhjZXB0aW9uKCkuDQoNCkRvaCENCg0KPiANCj4gSSBjYW4gYWRkIGEgc2Vu
dGVuY2UgdG8gc2F5IHRoYXQgdGhlIGN1cnJlbnQgY2hlY2sgaXMgc3BsaXQgaW50byB0d28NCj4g
c2VwYXJhdGUgbG9jYXRpb25zLiBCdXQsIGlzIGl0IG5vdCBvYnZpb3VzIGZyb20gdGhlIGRpZmY/
DQoNClRoZSBsb2cgaXMgcHJldHR5IHRoaW4sIEknZCBhZGQgaXQuDQo=

