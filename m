Return-Path: <linux-efi+bounces-5533-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB690C66037
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 20:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC04C35D42A
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 19:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4F2302CD1;
	Mon, 17 Nov 2025 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0+9yTlQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154492FB602;
	Mon, 17 Nov 2025 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408751; cv=fail; b=ML2awpEhbW2Ea7PFuwNWMT2q+nBW+WXy2iYB8b8ahaLR2BRHSrjpI4i9Z4EMHdvtxSPiMTyw5itEMouo1oNp7bNzqe0NgrdbDq7Sam8yf4ewADHVXilm79Lpia3JlmdJ7ZGeJDZ9h8qOzcK/ySfVdB6vbAe1hbI77iZP9ovPLYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408751; c=relaxed/simple;
	bh=FOjr1U+2U+pi9XguSQ5VTjjP0aBOe8Azt+8nB+nDRCw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJkyNqQYG7NPdMGOg698UO9ErX/Yjice40YABULe4CoYcfGUjFsnrVOEESApqCsVBTUwOVLNY4MLb0IlF11CDxfpZ9pkuH5qM4PGK2cVXTorit7IUxpFscRIONXqX5xpzgFBX6/5Vs9cPso4AVbn4NDfizwtQEnYfgK28rIvsa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0+9yTlQ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763408750; x=1794944750;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FOjr1U+2U+pi9XguSQ5VTjjP0aBOe8Azt+8nB+nDRCw=;
  b=K0+9yTlQofFcSynefw6NflZwy07sYFmhK2/1paxCThc9sEcH7DvcH3zV
   EoME0n6GfhQvQxe0HJZ0qhqf+sbQ9rzy5cAreWIuuKcPLf2NncFCkXtFs
   A3rDOysG69prMJ77GRmbskbOWUmWKwWykWAzBZVsBjOcWPmw/aSpxEY19
   CYifr3qPqt9Yi0dnCYNwQ9xfLWWsGwOflJJiOZuX34lh7WX355V6ObQYO
   PaYuZmAvKbwEkdIaRF53Ngqb8ZXH1JQa0UUoG278uYON4k+dmbRFctUs9
   1b5biWFzpz6pY7liVzrY2G+va2b+y9xaIDV8lSdUtEykVqP9NSwxN887a
   w==;
X-CSE-ConnectionGUID: q7ET5WoWR9OZJ9rBH2sUhw==
X-CSE-MsgGUID: acZKjHPtQPm4bjaVfUIMAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68025105"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="68025105"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 11:45:49 -0800
X-CSE-ConnectionGUID: 4AFLQ9KKR0q81GTWXATTYw==
X-CSE-MsgGUID: nIwJP1fGS1SREf0RimwKGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="221449494"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 11:45:49 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 11:45:48 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 11:45:48 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 11:45:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyL8fmT0BO2jjg7GYyyl/f7byEnhGUDxAkYYX7ZHgiBqFefbvz3Q0fylB9eRj4KUU4dyH+S0akANtbAZrv4z9ieqenDH4dWQahDPBC8cXw31kAqnZ1GCL2O9SgH5nFD4Y7Vd2OyjQuY6kczO6SO1VEHtdwifrKRkkcGIc/jOacn8SvnE71dhcnTLFQVlOqwB8tcAg+cCiLB0Ly9UhzB6L3JuPqvngx+JPLhL+PoCzYya2rLGsR1GM7CuzwnLWZU0Cb+9CK5RveBswM1X5W10mvSZNiJJ87rp6Uj/P1RM7jj45F0NZcGTP6m3KphMiekc203SuPfY1+zU7EzSXC021w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BBG194OUTn17KgJwT8UkhPCMq3E3QdgVQ6XwxSHsQU=;
 b=JWOdI6y2NS0P47YtZqKjADc0ZJWrRvl+JN6IgcsukGq2TTrhUUh7k86UAL9z8tIddLJmfAy45SLwZF76DedmSn9zgqdOTniCoJDJ+/RGD7atT79Pi7ltBnSLs45FNam7N2SBiGKQSaq2PyloU96kF/E9CDp11TvB8gh2VpMTPZM/cFGwhyg1RMWfyP63djAiC4jLUlSsUqMKWYijzBrYvOR42Q97ss0HAVd61usg2fx59UTm8ixFnJFG64icpTHoyKDdfZ49jvKgJ8DGK1lkqLk915P3qqq+xLm3s4rax6nAlEnlBwYgsDg0/VVfN4uExVN/DmcU69iuSHhrlzZcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13)
 by PH0PR11MB4808.namprd11.prod.outlook.com (2603:10b6:510:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 17 Nov
 2025 19:45:41 +0000
Received: from PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba]) by PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba%7]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 19:45:41 +0000
Message-ID: <ff8564b5-8b64-4228-84cc-7e3c0156a886@intel.com>
Date: Mon, 17 Nov 2025 11:45:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 6/8] x86/traps: Communicate a LASS violation in #GP
 message
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Kirill A .
 Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, Randy Dunlap
	<rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook
	<kees@kernel.org>, Tony Luck <tony.luck@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
References: <20251113224204.50391-1-sohil.mehta@intel.com>
 <20251113224204.50391-7-sohil.mehta@intel.com>
 <20251117144840.GIaRs1yNEYjdNF0SHu@fat_crate.local>
 <bfce23cc-bf7f-494e-a443-baea41f33381@intel.com>
 <20251117182958.GBaRtppoY2uANW2JI8@fat_crate.local>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20251117182958.GBaRtppoY2uANW2JI8@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To PH8PR11MB7989.namprd11.prod.outlook.com
 (2603:10b6:510:258::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7989:EE_|PH0PR11MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a04452-299d-4710-f533-08de2611e3dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm81Y0lqeitHeUpCL1h5RHFQazdWUGpNWFlaTmtnTk9iZEtRMUNYQ0ZBV0Yr?=
 =?utf-8?B?aXNnYmpsUmhKYU9TV2ZTOTZ4TFBZNk1EOGZMWTFVbjJQbklOTHlPekdHbGM3?=
 =?utf-8?B?TDgvTzF6UTQzVHN5Ky9ZMmpXdWNQcVM3RkRYZERLTDJ0N2MwUTBvVjVsSGtQ?=
 =?utf-8?B?aU8zd2RSR0UrU1BMTVhpZStpam1BRCtRRXBLOWNKbmYwZ2VaWHRiUnJRRjd1?=
 =?utf-8?B?UHJHZWNjbHVnZ09HRkIrQzFzc1VtQ1BUTzkrb1VGZEVnR0ZtRXFGNHdGS3FQ?=
 =?utf-8?B?TDNQdUFMdFpwUVZLUmxTNGZSaWloc1RPYXkxNlR1SjUyZmh4Mm9lSk82SWVs?=
 =?utf-8?B?QXlSa2d3OVRtRmVxZjJ4bzBkNjd0TlJOaE5iUHhhaGVRUmEvaDIybkc2dU1o?=
 =?utf-8?B?bFYwQlFDOXgxY2tJVVVCNlF1NGYvN0szUnRtME1idkhXbUJtaXFwd25lT0da?=
 =?utf-8?B?K2ErYWt4R002VTRyQ3NrcmU5cmQyUnBIcXQ2aEJhWjR3T1lTdFRNOENEWS9Z?=
 =?utf-8?B?a1J4Qmc3dFhtczJRWjVIWWFjdkJoVi9HeVpCRURybTBFbTlGRkRaSnNyOVI0?=
 =?utf-8?B?U0pabDJFc1E4QmExa0RlQlBIdXFoVWlWYVdVZW9sS3RlSnVDdk1sUGVBMHJE?=
 =?utf-8?B?ZVFkR1kzU0FmaWxEVVhtWDI0N01zdGoraFlDK2tzZXh1T0NsZDVrMDVzVGpw?=
 =?utf-8?B?RlpJZWNCVElqc1F1VEEzQXBUVWlaQ2hJV2lUNTNxc1FpaUU1aEpoWkRqc1pP?=
 =?utf-8?B?ZmJRV04yK1Iyc1pucXNwdE9mQUtPWktNYktUSnN0bVQ2OVQ1UUZiZFUrdER4?=
 =?utf-8?B?ZzRuS0IvSzNOUnhyaCtna3ZCS2xPVUUweVJwekRDSzFUVkx5Y1lFTW9MQTVq?=
 =?utf-8?B?Tm1USDdBcGhkK1ZEcVBIaUxvTDhrQ1hWbU1WTFFtRUdNeXRER0JBN3l1QUIv?=
 =?utf-8?B?OHBOWHZTOGdKNVJFRTdsVWJDbUNQU1VvOFR6N1FwZlR1YSszV0NWUlB5NU5Y?=
 =?utf-8?B?emlZVWVnQUkzM2NJc25vTndDR2Y3SUxTcVgxeDExaGxMbGZBdTIyQ0daRGNK?=
 =?utf-8?B?dG1Jc1RXTFBoZ1lQZHM2SGI0VG93WEI3cjI0UlpvZW5CRDM0T2lwWjMzU1ln?=
 =?utf-8?B?YjlIR0NsN202dTJJSUh4c0dWUVc4VEY1NHd4c2RUb0ppMUFMSDc0M1NuK3p4?=
 =?utf-8?B?OUVOTGR5VVN4YS9QbjVZMjYxdEhNOVN1NWlUUXByUEJIK3BjVUNkNk0xRU5U?=
 =?utf-8?B?TWJ6ZXRicFJjc0lzZThNUUJ3MmRzdS9kV1FTUDJPYmhoTUg4NHdGcHpxQVJN?=
 =?utf-8?B?cWlOazFBbHpPVFVwRzNiWmhjRVZFS1hueWlSYzUwTmZUMUZwZkoyVkFFblRh?=
 =?utf-8?B?MlFpTmVWREoxOWt4QXk4WDl6aVBlV0NEbTlnSzdMeFZYOWxkaVZIdjNEZndE?=
 =?utf-8?B?aGhIYk5TKyt3VHc0YWhLTmN3STlCTnVGSVRqenRPcGlnVDdFa3pJWkN5bXVY?=
 =?utf-8?B?KzJsY3RKaC8xRWxESmEyM0twSFpUS3RERGJ2TXdraFhONTJRc1RjRjlGbFFI?=
 =?utf-8?B?SmtwaXBYL0lZYnJoV2RNTkxFRityaTl2c0x2Qm5JYUpVYnBiUkRoOURaSm9s?=
 =?utf-8?B?YnkrTk5zbWlBME0vNEZOOWlZZDJPSTI0M0RQdFkwc09Tb0VOUFRFcUdKL0g2?=
 =?utf-8?B?N3BCWEd0dEJOcDljWVZNZkluWDA0VmFWVFVVTnBvTCtOZisvMHFXWEdDMWJR?=
 =?utf-8?B?U2pweFcwTFd0SmRkNWVEU0ZUZGdwaWdWYmluUURNbmNZeldqS0FNUlN4TlBF?=
 =?utf-8?B?QnY5ZVJIazBKamo1TzZkdmNHLzFhWG5xcURTeHNvTU16ZmVubHpHVWlJOE9p?=
 =?utf-8?B?S1VOOVR6MEw2ZktKNmQ4TXUzRHRsQkFnK2hTVXBoZUFwSy91VTZaL2F4VjBt?=
 =?utf-8?Q?Rv9cCvEKq3PjrfGIibL5ewGyoXLFSqqm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnZYL21WbHBTc2RQQTZNRHZuaC9hQmQrSUdXWDhZNTh0VzZhM3dTeDlKTkFJ?=
 =?utf-8?B?c0pIVVM1YjJCT2MzeFFqK0o4YjUyUUpZcUhzR2pwQ3hEMmhlMXNHajJ2bFls?=
 =?utf-8?B?dFEzU2EwOVRweTNESTEyN1NlME1nNjZvSFA1a2s0OWYvQXBXckdsYk1aVmEr?=
 =?utf-8?B?Ky9MZDl1REY5dGwvaFNtR1ZPbTNjNHMrNnYyRDIvWGNMS1hyZ1JPdUN4anBS?=
 =?utf-8?B?YThqbHBsOTBQV2tPbHdJNWErYWxoSk5uMzVscnd2cE5aU2l0MVJzM2Y2eUY0?=
 =?utf-8?B?S0l5Nldvak5YNGlUYlYvUlZ3YlFySm5XcmQxaGgzT0VlTmNVZlNVMUlQV3FK?=
 =?utf-8?B?elhEUjY0SEsvd2tacFRKU2pCdG1SVHBMdklUODR3ck1LNUlBL0tGRnhwc0Uz?=
 =?utf-8?B?NkhXTnBMRGdOYUFaN0tVaFpYTFdyM3lmY3Q3WWJoeWRiMUVLOTh6RkZBdGRl?=
 =?utf-8?B?MXRjd2RtS1Q5WjUxeXhXMjRUSlordjJ2ZDVwUHdxTlJPSGhDcTd3TTI0MjRU?=
 =?utf-8?B?MGxDTG5YZ0Z5VEQ0WExGdHpIUTBGM1RqdUVPTHF1djhmUHZtVUJ0MjRrMUJw?=
 =?utf-8?B?Z2ladWRjaW10TmEzQmRhQVBEcVZRNVNacXE2NUtwWTh0dG1IV3U1enBUMCti?=
 =?utf-8?B?TmZlaVVzMUV2RjdjUmZ5ZEZEM1ZvellyMUh3V1N5T3c5eHd5d1ZheVFKQ29z?=
 =?utf-8?B?a3BZMnJhak5uaXN2cXZXQ09ueXpIWS9mTWE1aXVoamZ4WmJKRUx1Qk9oTXYx?=
 =?utf-8?B?U2lONENHRmRpYlpNcE1FTXNpMnZkVUpqV3RqNVFqRElsYkdUTkRGQXNTRnFD?=
 =?utf-8?B?QUR4c0xaL3ptOUVlbWpvWG1ZekUzVFljS0dzM2tNem4vUFVUTUZnNEhJYnRv?=
 =?utf-8?B?WllpK093MG5NT0xOMmYxRWtMR1hpY1NrUVozNjlMOWtOd0ZVYXBHYUdCTUN6?=
 =?utf-8?B?ZDhGRVFBN3V6NnpXeHJudWlhM1IrUHdDOEkzbHFxN014OFNpaWVEQzd3WGN5?=
 =?utf-8?B?dVAzVWU4TUNQZ3pURllVZ29VQURqYzVMbDk5elU1UzFvVVd5dDJXNUU4Rnpp?=
 =?utf-8?B?MGJCSXVmblFSQjE4YUZ1VTMyUm5IaWhPMVZyOVQyUUsrNnFUTW8wOE5td3Bo?=
 =?utf-8?B?QStHOU43WnV0b0lhMEFPVXJjMkN3N1R6TWsvSmNnS1JGeWZuRlduWnY1ODVT?=
 =?utf-8?B?TFJZRTdLVWVOSUFvVldkNmZPWE9XbEpKMGpnWHhYVlZMK0NielcvWlFjZWM3?=
 =?utf-8?B?UWw4MER5Q1M2T1ZoMzVsL2JqWEhDenRNamFEVW0rV3gzMnNIOWViaVNDeGUz?=
 =?utf-8?B?R2pESUFxa1FjR2VESmZmbHVWWXdSVlFRcHdKKzJJQlFUMnlhcTVJOTlDb2xj?=
 =?utf-8?B?MloyVXdUdURrZExxN0R2VGRQakpCd3d2aVhHU2VmdXIrbFdxUzdCS0dxY1ZJ?=
 =?utf-8?B?SjVaRjA5VFJMMlhYYmptd0U3OUwvay9tUW9QbFM1bFVIU3B5bVBkdWJCRGJr?=
 =?utf-8?B?L01lQldwOVQvSFJESTJtNXNJbUFSeTN5cE5kdDFYbUk4WE9UK3NPYktiRGZB?=
 =?utf-8?B?MUZnSENGR0hlREU3QjhxbXRsVDN0RGJmYWtpZ25ITGNkSVRqcy92VXl3MEth?=
 =?utf-8?B?NzlDZmt4MWNVZjNMN2lEek1uZDdLYzZvY0tBZ3dvTVlOVkhvem5MRVFZRzQv?=
 =?utf-8?B?d3RISE1CakNoY285WEdVWDUydk9tWUpHbXQyYnlmMWYxOEpTWE14b2ZBYVZI?=
 =?utf-8?B?aHdVQkpqU2RPN2Q1Q3NuU2tHV1AzS3YxRFVlQmtOaDdlVUxkZENOK0dSNm4w?=
 =?utf-8?B?ZlRYR0M5aE9ZSUswQUYvNGJ1UlpWVkdtLzk4K055ZnhaZVY1RlNoWlloY3By?=
 =?utf-8?B?MG1RL3RpWWx3TlYyUzRNVkswemhtRllGQ29RNlFWMjZEbmQzbHcvMmlyTW5X?=
 =?utf-8?B?bE9iZnBKRHBXYkpYVVl3MTlSY3JDQVdKRjR6V25mK2ZvMmg2cGhXdGtOSnEv?=
 =?utf-8?B?ZmJiUWRUZTBnRTVNNFlEbnB0eU1kcXZsdDFTUDN2aUF0eWl0UlY4aTlMRGR4?=
 =?utf-8?B?SVRhUDBpOEh3elliMVRYem42N2dwTVZEM1pGTE43SmQ3WXVBZllESUQzcDRp?=
 =?utf-8?Q?vH9C3IgEYIDRCUWifNGHfyb9b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a04452-299d-4710-f533-08de2611e3dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 19:45:41.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOVLg6cSht+j3XcuQqVWwGeTA6kVcDztzQSqroCPrO5pgJyWefs/cCQnwbM/zI3j5NZjiTRhCX5WRIKLVtE/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-OriginatorOrg: intel.com

On 11/17/2025 10:29 AM, Borislav Petkov wrote:
> 
> Ah ok, that makes sense. That comment still reads weird:
> 

I see. The idea with the comment was to clarify why the check is outside
cpu_feature_enabled(X86_FEATURE_LASS). That clearly failed! :)

 > I guess you want to have
> 
> 	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> 		if (*addr < PAGE_SIZE)
> 			return GP_NULL_POINTER;
> 		else
> 			return GP_LASS_VIOLATION;
> 	}
> 
> so that it is perfectly clear.
> 

You are right. The condition would typically hit only with LASS enabled.
But since we are adding an extra hint for NULL pointers, I figured it
would be helpful even without LASS (even though it is unlikely to happen).

Therefore, the printed message isn't LASS specific either:
Oops: general protection fault, kernel NULL pointer dereference 0x0:

Also, it makes the code a tiny bit prettier (aesthetically, without the
nested if). We now have 4 hints and a check for each:

if (condition1)
	return HINT_1;
...

if (condition4)
	return HINT_4;


Would this update to the comment help clarify?

	/*
	 * A NULL pointer dereference usually causes a #PF. However, it
	 * can result in a #GP when LASS is active. Provide the same
	 * hint in the rare case that the condition is hit without LASS.
	 */
	if (*addr < PAGE_SIZE)
		return GP_NULL_POINTER;

	/*
	 * Assume that LASS caused the exception, because the address is
	 * canonical and in the user half.
	 */
	if (cpu_feature_enabled(X86_FEATURE_LASS))
		return GP_LASS_VIOLATION;


Though, I won't push for it further. Code clarity is more important than
reducing indentation.



