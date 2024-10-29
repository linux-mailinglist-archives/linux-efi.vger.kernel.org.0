Return-Path: <linux-efi+bounces-2051-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C11059B55CF
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 23:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464B31F2366C
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 22:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DF2209F33;
	Tue, 29 Oct 2024 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I765AGJc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547131E04A0;
	Tue, 29 Oct 2024 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241337; cv=fail; b=t6n/OGcA7RPEtg/b1B9TS3VG68H8we44jbLTaqt8I+DnQ+MxOzTKSVnAFeXuL+NQbiPoq3B7LoBMzWhfn0kW8eA1wz+oCxJ6VVAiagfvSCCYSxvU08u4vyxoLRdpTyqJAjp2aGbNczhAtU28ewEOhbHzHd7lHBMLoFaW72tMeKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241337; c=relaxed/simple;
	bh=WfZ4VZ1qZu2VacCVHbuBL4e3kUopXsG0INclhdzQEXo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FsLpdl/fOIJNObn58f373ELWj8EW4O4Vxuyrolh8eAZqsXMeC8ajQckfrwXt/TsgaeJU8U4naDADyhdET+pKd2mqNvtMxpmo4C0SQkv6I9HW7Fs+3vQBCoHo1Va0Pk08sgk2Yaes1Q/o1qGSmyxi0L5U++7l4LNKd9IZKueXGd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I765AGJc; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730241336; x=1761777336;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WfZ4VZ1qZu2VacCVHbuBL4e3kUopXsG0INclhdzQEXo=;
  b=I765AGJcoJpu4bHku9i0D4zkZHxmiSyku77kGtyMJX+cBEzmxTd2d/Ux
   5HXTpr34IRU8PzJVhbjc6F39yh6XB85hWDnV3xKwrXSzWKixqQR5DsHlW
   +0zwCwoKAmSPcTeD5E6XV+5fy/25UqLweggJc+/MBlHW7KiRMlzXwNns6
   mZUStjdTqWAsKlaQxWsqck9rfMYQsZ/WhPGcu5pKNXeqQ6XkQBI8kgHTw
   jSqneKFN1kdzX/1MnckvmyNZf8YkcdIrXVywg9iJf3KqeTvOxENNolsKr
   mYLeXBIvX9UGYEpGR02KMVGt/rFT0Nr4LHoRisUMm+44VNCQwGJzYxmxh
   A==;
X-CSE-ConnectionGUID: 6+TWkqzRT9GbgwXC04cLJg==
X-CSE-MsgGUID: ZoHXvqlnTCScxidwBCAQiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40445113"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40445113"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:35:32 -0700
X-CSE-ConnectionGUID: LytbRU2AQxKLcQsxl5hmhg==
X-CSE-MsgGUID: hc4bF8cdTm2COWMGG5XB8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82530356"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 15:35:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 15:35:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 15:35:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 15:35:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMRwQzInOYMxtgOVLcwPh5q7psFNuSO2s8CUBituhBEjsYtExcNbhmK84MJF5HCv5uvtpxqGksDYoJyXG+tpCUy8bjcr3aVI/dOnW4fiGcRhWYfelOuLGIcznaPJJb3tTIUMtPq0fl2DgKWBFd75/DPpkDSQ+1U3Jw2L1AlK5G+DgR/NwE8kIbLuRHmFmaiXB47xgsAL1U1ArlnIralxaa2BxeMvc86I3YrmsYxHD786WHLLN8Lse4FGINBbNs6oY+9ZXX6LObj5odlDWYaY54tShGqvkbHLIAENKuv5FwNaLtQHEuV2FBmqitgSfDhNuzp1RGqS88zxVJPovfuAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hsQWXwXAoPw0OK0B8lAa0GhockOv2YPrNHig7EKjbA=;
 b=X43NYpWDXVAuTWNtr19GDzA0+TGR/vCi/AdqFhhvOPMWoDKlmA54vX7uIOtNvYGJLf6UrUcciPa/S+3tVMwLYNX4OAb0bq5MEGWZuo1dzfLHQQPhhYYKkxfGOnpMsKdEKoO1nH4T0oYxOT8/TVLNcKdvjEawrh6lcDZR0LOfmxwXOdgJbPAi7O+v9qH9KAHdXG8hCvUlgrYTRwpr1COOm1/zoeLni8RuKSHqFhwKFPaFbgbqQQz3t4kloBcWZdHxa3AX6Qp6+AC2iTnLmSee73BgwRbPndwcLR3jjXS6fpeprkOzJTu0RBz7f5GQ2Z5y52wDjBrnYeVsJDZebNkNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB5181.namprd11.prod.outlook.com (2603:10b6:a03:2de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 22:35:26 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 22:35:23 +0000
Message-ID: <da941ec5-32dc-4e46-ab1f-b6dfba266467@intel.com>
Date: Tue, 29 Oct 2024 15:35:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/16] init/main.c: Move EFI runtime service
 initialization to x86/cpu
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
	<xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Alexey Kardashevskiy <aik@amd.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, "Sandipan
 Das" <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, Hou Tao
	<houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, Vegard Nossum
	<vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers
	<ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu
 (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
	"Rasmus Villemoes" <linux@rasmusvillemoes.dk>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du
	<changbin.du@huawei.com>, Huang Shijie <shijie@os.amperecomputing.com>,
	"Geert Uytterhoeven" <geert+renesas@glider.be>, Namhyung Kim
	<namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-5-alexander.shishkin@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241028160917.1380714-5-alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b0c67b-f14c-40cd-d9d4-08dcf869fa2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0VwbnlybTlUU0JZQ1RFcldpN3l1dHNyc0txbmRwMTRpUXloWGpXcVJHUEkv?=
 =?utf-8?B?dC9wMzZLTVZmSEIvTDFpTUVjTEkrQnMwSDQzMU9saUY2NnFSYk1MQTB3a2cz?=
 =?utf-8?B?cGorcjBPUk1XbDhCWEZsbUFPTEhHMWIvbW5ZTEVuaElGL3JIelhFSHV2eUJm?=
 =?utf-8?B?dDVGOWxrdlpOZDRsc282SzRtQ01ld016UEsxUFFyV2F0OEkyU3l0SWRCSy9r?=
 =?utf-8?B?U0JHcHJ4T1lDS1ROQzJvKzJkL29wd0JNQ3Fpb1FtQkpLcXNVSXdNaFNmTVhT?=
 =?utf-8?B?MFpWYkNsaURmZnNPdXpneForZlFwd3VsdEpadjBXTjZpR3BZeUhIWE50ZmR2?=
 =?utf-8?B?eUxOWStjRVFERDhKQ0dJbCtRWmhOdjFBbEdGZjNmMjRDNlRsbjh4N0x4YzMy?=
 =?utf-8?B?WVI0cDY5REdTWElJMHA5cmc4NDZVUDlmM2tCTEtwZVBZNWVua0JWRnRTVWJF?=
 =?utf-8?B?Nlp0Z3VkNTZJaUFVZGVhYVA0djMyRkdjNHNvRkw0R0s1QXRLcnAzTXNoU3Vt?=
 =?utf-8?B?eVBDSlQ3c2VKVHl5eG4zN2dxejVBeDZtRXoxRE9tb0k1dG9xZnQ5aVZHa2dV?=
 =?utf-8?B?VGpTdFBwRDR4ZFFCQ3o0RTU3QUNSOVorRlozZzAwT0Q1YVhxNE5YMzcxLzQx?=
 =?utf-8?B?TWVGZTUvbFVLVStwVkhQMHZJRGJkWFJMamhUeUY2YTZnU3pRUURWZTBLd3JG?=
 =?utf-8?B?YUNjQUkvV3kyNjF0RFhMQTdEdzRzNEgrV2NnbjlaWUJCR2VYMi8rbWkwSFVz?=
 =?utf-8?B?Yy9rbEgxV3k0Qi92RXBtWHZTa0pwcWFxZ0NkclNuZERUdUZ3SytYWmpwNGoz?=
 =?utf-8?B?bXRISVR2bG1vWENBR0N5SzNkbStUWW1KNU5BbHJkdVM1TU1oK2h1Smw4R2xQ?=
 =?utf-8?B?ZEFneCtyaHBiZHNLeVdvMnNOQ0hVRmNtWFUvbno1RC9ESktpMFcxTG1pOC9Q?=
 =?utf-8?B?dEpnSHM0ZjgvTWVHWUVIcXU3Nkt4Q0lVRCt3Wkc0WXE2dndvdEtENWh1eVNN?=
 =?utf-8?B?K2VJcEE2SlRYWklYdTdsRjZKRGVoMTFBMHVZYjlSWDJrSDJTVlpwUFdOL0V2?=
 =?utf-8?B?K3B2YnZHV3QwcWYzZUpVZVFScFhZVUxZQ0JoYnJnTmMwbUg0dVI4cjdlS0Er?=
 =?utf-8?B?clRCMVFvMWIwWjgvdEVHY0Q1T2pUbkJCa1I4c3B4dmRMVFZ5YmFyZ3NKeFRx?=
 =?utf-8?B?UzFQa2JqdzQxRFZLOU91SU0vNHhqa2FPVzVnTFNIZjArWmtKREE0ajZ1S1NS?=
 =?utf-8?B?Nk1DdEZwajJpdXR6c1JGVzV5cWJzZVhzcHZrTCtadEMrNkFRQWRRMWRkV1Jm?=
 =?utf-8?B?ejZRMzJoMmY2NFBBcng2R2NkeHhvQjJwZm1waS9qVitqV2tvWDY1QmJvVU9p?=
 =?utf-8?B?R0pBRHFwcW1BR1hRa0liTDFnWlFyZHkyOGVhZ05lWWV5WW9VRHBSUTFDbWRZ?=
 =?utf-8?B?Rzd6OGFMT3hRZGJsRk1MZjZvSGVOd3V6T0daTjd1L3dWY1NYTFFjS1ovb2lN?=
 =?utf-8?B?ckZTd1ptbVcxSy8rQnY1MUpGTHpRMjVJUUxyWUU5RkJpWXRBaStGdEgxbEd0?=
 =?utf-8?B?RVM2ckZHMlBoWGVybmw0azVhWlJmc25SUzN4eEZPVW84S0Fjdk1tN0F0Ukxz?=
 =?utf-8?B?WTRhM2I1cjVSVWxYMk0yZFBpNWZMZHNKRTNmTFpBVm5QK29vN1h3S2YzcjNo?=
 =?utf-8?B?QlZ4NW43OWZnS2l2enFWRGRHMFlVSktCMFNUSEpaam1oK2tBR1J1QVcwbzVw?=
 =?utf-8?B?aldzMHlmVUdlT0t4b2FuanpFaFlxVmYwTStOYVYvRjYyeEhNL2ZXSGxpN2ly?=
 =?utf-8?Q?CpfAYtwehPRLPHPQk0uOlB7L1DAmkHAYsalCc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkVqMmIyMDNQV052NTVHYm5EV1gySzdvTTc2a0s3MEpPb0ZwVU8rSVl4QmtP?=
 =?utf-8?B?Ky9oZ0V0T01LMEptc3RGdnFlcmRPNlUvQXp0cTlZVnFWcHZJSCtVeEpUeTNY?=
 =?utf-8?B?anlYcU55eXllVjhRWmlleHQvN0NEdTIwS0M3TjhrTmUyQkRXMnRoYUw2NE9H?=
 =?utf-8?B?czBJS1NhbVZMWGN5Nnp0b0t3bm9ZbXRGdE03NU1CYmI1QjZDZ3NNeHBQaXNB?=
 =?utf-8?B?bG5lR3NIWUdkNUFyaEJZWVIxQU1BTWpHTzE3QzF3UGJMUXB6cDR0RmhqOFpR?=
 =?utf-8?B?QlpKWTZBN3RHR1NkRmF2UUY5Wmx1Zm5oRE5Fb0xSRm10MUsycHpKU09TaG44?=
 =?utf-8?B?SzNrbnZlSEZnaDE5c1VqcThUT1A1U0RpWnRlTTh5OTh5YXZ2SHhkSHhzeEw2?=
 =?utf-8?B?cUQrMlI2eUZRY1hIbGNNVXp0c0FORnhPYjBoVThEVEJVeTIvenIyQ3d6UWRz?=
 =?utf-8?B?RmJHRWI2dUoxQVpMN0tPQkRWWFAyVWoyYU8yWHV6YkcrMkVYQlo5bkFhRG1r?=
 =?utf-8?B?U3JKaTF5MjdLQnlPZ3F1ZEgyZW9GY3dENnh6N0FobXBjck1HTXBQWlpkUWFU?=
 =?utf-8?B?bmMzVy9ZNHowOFRBWUdBQXVHeTZwaEx3L0ZHa1o1YTdsYVpaY3pScWxjZjJ3?=
 =?utf-8?B?SFdhL2xXbTJBOTNOT0p4Ym5WbzJuY0R6SE9oLzRaNWYvZi93VVAyai9Yc2E5?=
 =?utf-8?B?WEFaLzZ6VnN0M1NmaitFT1NBcDd0YndDaGNyeVBTQlh2VnNMWFNOYTdYMmdE?=
 =?utf-8?B?SDlkLzQ4K2poNkxJTXlvbHZITWNBb09kOFZjMk9ad1N3d25ka3d3VElBbW5l?=
 =?utf-8?B?S2tnWHd1czJqYnkvVVFGbCthUzgyUStGSTJZcTQvMmZ6K281QUhmTFFBaVFS?=
 =?utf-8?B?ZU85T0k1a0FBTnpJZzBmcDlOYU91bVhWRE1kVWtvRjhmMkh3NnNwNWlVL0RP?=
 =?utf-8?B?YkhBUEJkVzNITCsxQklVRUtaK1IrbUtiamJSZmFlSG5HT0xHOXlNRDg5SXVC?=
 =?utf-8?B?VkNVV25LZlFxNnY5Wit5NEdCRGVza0lTS1JxVU9Cc0czUW80NHR3M0xJdVlB?=
 =?utf-8?B?eEtkL2ZoWEdwbEV1Q1AzR1N3NkVBaFlXeFQ1YWJYdmlCbkpwUmxCK1hlZkVH?=
 =?utf-8?B?VXJRKzUvNUQ0SHg0Y1VLcElML1JLS1U4UHJWNmFudE0rQmtFaDNWUGFPTzV0?=
 =?utf-8?B?R3B4NzRPb2xTUko3VHZNWTNuQm9WbWo4eWk1b0hCU3BZdWVZWnd0WXBIc0Fv?=
 =?utf-8?B?SVZ0SGwzKzhmMTZXb1hJc0NJZnlRVThUS2htblI3aHlFVXM2QlVVN3pvY1Bw?=
 =?utf-8?B?RTNmOExQNFk5NFhtdTc5SXVqdzFVOTRURXJkSU95V094d3BWZ1diL21UOVE1?=
 =?utf-8?B?NUhuT3RNTHZyVVJ6ZFd6RFU3RFRFdy9OeFAvZGJWTHpva0c5OGsxbXlhSkoz?=
 =?utf-8?B?bWFJeGh4NHFOWXF0ZzNnOWpJOUVUVzZwbVRvOUl4U2tGV2I4Vk5Tcjd4aWxw?=
 =?utf-8?B?b0lLd2dTOUtuS3pWUDM1M0RvT0NFWmJxOVFSNER2ZU5YYWtSSzZ5d1NCTENj?=
 =?utf-8?B?VWs2eC9wVmRqMzNQMHVRa1RobHNWcEt3OWY2Z0tGWkhvK05lVi8xRlE0ZGIx?=
 =?utf-8?B?VjFTbGRaN3hYQ05EQS94ajU5aVJIRmdwTW5Ub3VrSERhZW82R1FtMDdzOEVT?=
 =?utf-8?B?VWkxT1hKNUQrdE9jZkc4dzB6Ykc2VTBxRU1zOURJUmFHSTJVWDdjaXpWT0pY?=
 =?utf-8?B?cjdGelpHUytFdWVWM2pOS2hhODRXL25HVERYUFFDb25MYUtwRzhHUm9mUDNu?=
 =?utf-8?B?WW5KejN0alFZRElWdnZNQXphZzkybDExZGg3RnozQis0Z2FlcURMckd2Q3Rh?=
 =?utf-8?B?ZFBHalVNUFVyTWRQeDNVckxuaFg4V1FqVy9ZTmVsVm85TFRxeElzVUVqSEJU?=
 =?utf-8?B?TWg3U1pMQTRLbDdNVUVSbzVIL0JSTFdwZXZwR1FHMTdZRHVhdkwrcFdEeWJh?=
 =?utf-8?B?TnZwd3pJb1VlZnBsSEh1OXlCWXpjSHVqbFdhYk8zQTJmVGt1S3ZJZVFBZERL?=
 =?utf-8?B?RWxPVDcyaHNDZzdFaVcxclJjcXN6UXVNQTNyTGlIOUxHemQwRWExT0JFSWth?=
 =?utf-8?Q?0yh8vJrMC6qQ1ts7r3RgdCcAQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b0c67b-f14c-40cd-d9d4-08dcf869fa2f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 22:35:23.3719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2JCpvwU7+cwOtgv7jDjPKxmnQWkys2dkKKviiveGw9x6tfYrLVPD0KQcrFOXkAU9F8Dh0FtRzk86d4uS88c5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5181
X-OriginatorOrg: intel.com

Would a better title be?

x86/efi: Move runtime service initialization to arch/x86


On 10/28/2024 9:07 AM, Alexander Shishkin wrote:
> The EFI call in start_kernel() is guarded by #ifdef CONFIG_X86. Move
> the thing to the arch_cpu_finalize_init() path on x86 and get rid of
> the #ifdef in start_kernel().
> 
> No functional change intended.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/common.c | 7 +++++++
>  init/main.c                  | 5 -----
>  2 files changed, 7 insertions(+), 5 deletions(-)


Other than that,
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

