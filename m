Return-Path: <linux-efi+bounces-4196-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF46AFDCC2
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 03:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBA11C24508
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 01:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076E71411DE;
	Wed,  9 Jul 2025 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ej9xRYEZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879F13E41A;
	Wed,  9 Jul 2025 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752023313; cv=fail; b=UYs3URBbiJGbbShVZSrb9CLRb2SzugVpF28ACXBVndxfTNnFDV5uGT4PzqKnOVBC7uIMEipRgPgW3kRvRcfUAH7S0mmkmVA2FlvzvH7q35DqklqOApNWG6NTykWFWH8FvPSP9Ky+TE/JffIRRFNJoD63LjG/7QWidd0wYD9mxho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752023313; c=relaxed/simple;
	bh=g1/ywzcEP1OQEVbvCGWRLeGwWKyGKLc9Fds/tR320i0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OspI8izLFVtMHcYhJ19E0BRsAcFWlpaN37+N7fdYNxBLdweg73+0rbT+szefjQfmj+G7gVSbz55yEKfHw5MuaK23tR7uKno66PmaRAQnNBKWhHrOCUaEynKXD91REkDWdcrwe3YLomVH+Rj+FvjB6RRfPPEAEsKlwikR/Mj+lVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ej9xRYEZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752023312; x=1783559312;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g1/ywzcEP1OQEVbvCGWRLeGwWKyGKLc9Fds/tR320i0=;
  b=Ej9xRYEZ9cs8jwSHUEyIH4SodB6/+efF2mPYFPJi+eIDMGk2fdrdplgL
   zGASM0q5PNmUAn8FiS/We0jhLDDvtGB80oPAoLSLWRPKaYre+HMNRdvlk
   g4UALE+YYo6BZ1eHayB6sWUESL88WXYLbw/zyIpKw8UDLCNiXVDwa7B6l
   F7WNWxGWrnb/5+ofOotAPw3cXubvA7KopLcJDPp2iuyb7DmgBySMKED4r
   FG9UlDrF/W2GP6OTQWWBkYQgXz7oku4FF8+uT4p42V0aG3G8Dcr2iPKmE
   ZZnqy1+W+AWfO6NxLct5skKJWrYQV8PJLMAhbvNg6x3I7hu4aOQEmol1X
   g==;
X-CSE-ConnectionGUID: T6nm+f+mRMOLyRWERiY+4Q==
X-CSE-MsgGUID: oj/AjbmgQHepPS6Tqfgzaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71856484"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71856484"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:08:31 -0700
X-CSE-ConnectionGUID: UtnAm4aFRVCwAEd8kYBUoA==
X-CSE-MsgGUID: Rx3YDU/VRuSmGedDBpNkVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156118722"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:08:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:08:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 18:08:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOCIRjWMJ8dT3JJy9H+kdtAIK/D1gC2gZGC4NEe6taxHAgBoRTh7QPwP/mZXMsPF93pVjwxlMKa1edK0vhJfrOQCdRA1xJLi6vxS5h2VV7ON4IVHni5p9omvlXQJGd32Irghfc4TM4ezDCMj4oeg5rNFxw20pOOlCDaL6p1hjDJSnHZBrMAqyqd6fvOm980WCWztZavTxM/0AstFzPRl2GsIKF6J1Zcg+9tjRdu46KXfw+IBjUJ4adBU78qd9qtJklSNkylUPupJZCGEcDeH0+5zdcJM09/kndcNvAWbtGcrpKOKvnXNNMHWlF5zjJMXe6fn6fy+eX2WMkMK4fyibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UiNhEjJmQhy9PLqswOZftxi+Uj0c5kDITr7p3fZl8M=;
 b=A53qxPUc7AbkuaDXcuN0bHAjAhRmHGShZhAmSAG+rpFHII9teZ1SLq6bbZemZuyxSiFPSa0K1ca0+cgt6Vwmj4FhOPnmqxYBhql5s1HyvdF5ZbP6zMmNFOXz5QSV/b3PWWXi7nJPOHDgG8O2EUisgzIW5ifehM6zEW5BLLmh3UB99ML5s9x+MkrSb3lFP8SNpScRUPU++UMXw4l7UirYfm5BBTsscW7ytM11Z7gXQ/PanSrd/JXhYjnm/7KyBK/XQ5nHHUiJ5Zhey4X29AbyO4DUrBY4pXiUJMIGmsiETiUUSKxp1YtUmVcL/IwH9YvY/o1Y1nzZw6iPjZXLt20bKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 9 Jul
 2025 01:08:26 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 01:08:21 +0000
Message-ID: <53b8d516-5d19-4b3b-b7fa-99f1066f79fe@intel.com>
Date: Tue, 8 Jul 2025 18:08:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 02/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
	<xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
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
	<linux-efi@vger.kernel.org>, <linux-mm@kvack.org>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-3-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250707080317.3791624-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CY8PR11MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad5ebfa-64e7-4efd-7313-08ddbe85184f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXdsQlkzNWlIa3JnbCtmb1hUMVVueTEybmhneGtYQ2RFbWJsb3JaS2g5WFYw?=
 =?utf-8?B?RXZnQ25WK3NTcE5lZTBwdmpKK1E1ZTFvSzlGQWVONnBhYk9nRHNBUWs1ek5w?=
 =?utf-8?B?K1hoR3F3SGdVZUlMVzd2b3d1VG5JekVRQ1p4UWpkcnE0QWZuSUJRT2JoQ1hP?=
 =?utf-8?B?T2tMNXFqcXVEemRVNTBtT3B4VWN6WHI5RFlpR0k0VzkweEkxWXNoUGtBajRP?=
 =?utf-8?B?RE83U0Fxek1FSFhiTGlGYzNDcEVHSnJ1NXlVUnpTc20zcGpOMkxZQW5uK1Br?=
 =?utf-8?B?Tzlmalo4WEtlTFVzMXFDNnNtT0lwWE5RTVp5VFJVWENXNmcwemlNUUQyK2gw?=
 =?utf-8?B?SC9FaUg5N2VGZHV1VTJ1VWxwcjFFbXd1dml5aldHRGkrVWdqUWlqVTZja2JU?=
 =?utf-8?B?TFlZQ01HY0tQQytoUWRJMXRPc2ZodWRoU0lMKzFYVFNUTUhpeGlXaWN2NkFn?=
 =?utf-8?B?VFFSQStoM2ZJVUVFc2Y5eDg4UytBeDJndWNXZ2xFbGxJNElkWTk3am5mbnYy?=
 =?utf-8?B?UTdQajhPYU9BT29CTzdxVEdFVm5sM0FJaUMrZHJYaG9KZHdJdm8zeTg0TnZ3?=
 =?utf-8?B?MzVsc1dLLy9zZHhyL3NrSVFTeFFtckNjbHVZMnU5MW81NDRkL1hpTVR3bzdx?=
 =?utf-8?B?bWx5bVh2LzFRamxpM2E4UFlGZzVlRlVrcXA3YVVOc2l1VEZuR3lwQ1lMN2dO?=
 =?utf-8?B?WnpWMTR5UkR1MDk3QnRUTGI2Nm4yQkgydTlHUlZKcDF4RWNrMXJIRnArVGRs?=
 =?utf-8?B?VlVtbXJVNzY2WFBIUlJPY0RqcFFoZjVKSExlS0VidGUvdStFd2UvWjNWRFB1?=
 =?utf-8?B?R2R5RlJyREdlK04wVlJVU1ROVmthVFZjM25GcG56NjlxOG5KZ2dYLzlMREZa?=
 =?utf-8?B?ZFV5V1hwTUVLUEROVmJIbmxOZjVUZkhOSmIxZS9zTU5CQTFHaE1TWHVwYi9Z?=
 =?utf-8?B?UUVzeFRrOW5GYTlhMDlBbUNGeXpGOVBvZ1d6d0xROERJckZzSmdYUVlXVFVy?=
 =?utf-8?B?aXB6OXdQU2dsbjlxOWRyVGlyZmRXODJWNE1GeEVneEhVRjJWeTdZWXNFWWNW?=
 =?utf-8?B?bzNhZ2trcjJ0QW5Sem94TCtVT21DZko2bnREeDRGOEd4QmtkZC84VjJNdlE0?=
 =?utf-8?B?dlRYbEhNcXI2OEhCRldnaDRyRlNIVkxYc2FBaGlUd21YdHlrbW5OMGh1SDlt?=
 =?utf-8?B?LzFrOXIyT2lqdlZhVVVuZEFjQUFTU21jUHBLZmozS1NiWHhRTnFkMEpUb2Jr?=
 =?utf-8?B?YUx4NS9LWnJIRFRHN0tGUUFxQWY5UUlWZjRPYnVCOSs4ZVNkekdpdFJhd2RD?=
 =?utf-8?B?WnZYaFFWZm56OWZSZUhqY3lYbDRDcGxKMlFIQitQSEFyc29ISEdKaHNFUHlj?=
 =?utf-8?B?dEJMWHVhNk1vSnROQlQxVTZKMTVOR2grZVgvcFB5MWZxa1VDVUlvYWZnaDRM?=
 =?utf-8?B?MzNVZzJmN1dSME5wVnprTDk1cEQ2L1MraFg0dmZwSUJHZ0lpWlZhT2lmbVUr?=
 =?utf-8?B?dVYvRU0xSUF5S1lHYW1ZWk9MRFVQeVo4elZiQWRVcjhFMEgrdm1RMWJoaEpP?=
 =?utf-8?B?ZXd0MWJiRUROejlQSU5temlmUXN1RWlhdmRCWEpVYXhaNENUZDZoUWdEdVVD?=
 =?utf-8?B?Vjg0N0Y3M1ZNbEs0RC95cFBWNTk4T2M5dFdGS1hrZ01LaDBRQU9wbHdBS0R6?=
 =?utf-8?B?TlVYanpsTVg2YmJxcVd5eXJHdnJGeHVFbEdvUmMzWFl0dFNUdEswQVBrUmZi?=
 =?utf-8?B?ekJHL2lYTFZJak5GZnJKaGpSWUY4aUxGdXQ5eWNVVnVmRTdyUEZsdjFuNFJW?=
 =?utf-8?B?RjUrcHlhV211RzR1WS9xSTBFQ0lxclRxcy9SNnk3VzhWSFcvZFc3MUxmWE9z?=
 =?utf-8?B?UjREV2RlKzAzc3FhWXF2citCVWJ0TjR6YUdVYU1qcU1uTEFQNVNKOU95bXpr?=
 =?utf-8?Q?CTXpHicTiJ24dJLtHr8WrcQ65jgzNW5y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1k1QnVvT2N3OEMxTnZrTUIyR21TZjRlSkZwdFFNME5Cbm8yZFBBUnNDK3dk?=
 =?utf-8?B?MlNnM09SWWJTZnZmUytFTDVZVzhYQ01qWXZkOVVOM1YzenFBWmhEbmNRUjRj?=
 =?utf-8?B?dVN4WmtYQXBoa1U5Y2IvcDMrWDB6dzJSdWora0pXdkpjVXh1dTNnNllvK3Iw?=
 =?utf-8?B?dDQ0d2pnWGROQVhKWXJIWnYrQjcxekYzdE15SkNzL1gwT0FwcW1XWFRheTVp?=
 =?utf-8?B?dkRYTnFoSjhFQS9Ma3lXVTdQdFkvNnkwa0FzTTJEK2lvV0hUNk8yQyswcmhD?=
 =?utf-8?B?dmJDOGliM3BOU2VyQkZFRUxOWnBBWVJRRWJzZXF4dWpFbDFTd3JmZHBYOXFR?=
 =?utf-8?B?SmVrSmliYjZMc3QvT0tFc2hVTm9YdUJLQXZkQmxvNkVnWHdsSmVjaDhtdERN?=
 =?utf-8?B?NEliMWY2c2VXOVUrekpvNEVlV1VxRGdKUTJZMWszaXZBdE0zall4SHQwTmtn?=
 =?utf-8?B?NUsvdHpocUo4Ym1QYmxaY0srNVNHY2tqUmh3YVNRSWszL3NycTJKaHA5cmcv?=
 =?utf-8?B?dmVwcE5YV1h3cHd1M2MyUWsrK09XdzZMK1J5MEUweFdBRjBwMUFaTlFTSnNX?=
 =?utf-8?B?NG1jc0pMK2tEY1Y1dHpqWjJkWENKL2s5aU1aYUwvc0JBWjA0MlhKV3lhMEVq?=
 =?utf-8?B?ZGdwOEp3WW1HMUNjU0hMM3hjWnJQTk4vK21ERDg4dUs3dDRLWnRXQ1VIZGV3?=
 =?utf-8?B?LzlhWHN1STdNRFoxeElKazNXK1krQ1J5UmVVV3RPbGpXNU1BdEZYWXFDb2lj?=
 =?utf-8?B?NDNIYVhQckRENDVvRzFIbmxIZlJJWEtjOGNadEI3cXI2NzV4c0xvUFNsS2FU?=
 =?utf-8?B?YjZnbzlRK1FsMGtOWEVLL2FSeTBVZlplUHBCZzRWY2NqTG8ySXl3NjlDRmRT?=
 =?utf-8?B?eUNoWE1LYzgydE9RVlFxMDdCZkIvbnkrdktaaWs2Z3JoaHFxbWRGSitOcC9J?=
 =?utf-8?B?a1JCblI0U1dSMGRZUFF1aEhHblI0Skhpay9rdGVINmFqS0FEU2MwNWxEMzBY?=
 =?utf-8?B?VTE3aTlteUpsNExjakVUQnRNQVBkU3FDMTlVeWQ0b2pmcDdIZzhrNG9BYkc2?=
 =?utf-8?B?L1BmaVQxT1dMTDNwdStGQ0ZDeXhIK0RPVmVrMGlMZDN1cVdKVTdHdnJTWGtN?=
 =?utf-8?B?eXBJVHBYWUpGZ0JDQWdCYmp1ekt3aDlscFVUb3lsWU1SblZac2RrdkFXTkxD?=
 =?utf-8?B?dHpRb1dmcEtIMG1idDkzY2tjeHMyV2ZIcnFjWE51endiUE8rWk56dWx3YUx2?=
 =?utf-8?B?OFcvaFFPQlN6MHVYeUJEaHpLdGo1SmQxek8vbHNGMnZBbTU0eWNtWHAvaC9y?=
 =?utf-8?B?Z2pOazFTY3lESEhuVVUxT0I3Vk1jUHVLanlsazk0UjdZeVVybGFsWkJjZHhY?=
 =?utf-8?B?WUpOZDB2SEcyanRyN0pGTXNLU0ZnQlJBOUpqZklvWDRTYWtoZEZZb2xXSFpw?=
 =?utf-8?B?UVdqeWxHbWxpdk1MZHVkVFFQNWx3ckhDUzVmVWprNlVLeU92YkN4Um9WeWZR?=
 =?utf-8?B?TWhMSE9IOFZjcWQvWGR0VWlBNTlQRC9ZMytsS2d3QUhZUzUyamRXbmt1L2o1?=
 =?utf-8?B?TnQ2dWQreUJYaVRZVS9PS0NacGVaV1lhWDBHR09YM0hQeCsxcU0vbXVucVE1?=
 =?utf-8?B?a1ZEMy9TR0dzQzFreVBTWHVpR25mcTY3aEt1dWc5aUNOVUlqa1F1SzBnVElW?=
 =?utf-8?B?TnNydG5KZkZNcXBlc2NzaUhxR1NyNDZrV2lGa0dSNWx4OGc3Y1gra2lCZUk3?=
 =?utf-8?B?ZDZMSThsMm1lZ1JFbUZlS1lVdlVqOWFPU2tHZmpGMytBK2NTM1dtNlpTZjJE?=
 =?utf-8?B?OElxUkdsR0VkZU44UmxMSXRsWDQxWXlhMlpRSTUvN0lGeGpwT25rM1JVNVhQ?=
 =?utf-8?B?TXFlVlpGMnprUVRwKzJNQWlPa3YzRmZqbllvWEtpcHRtQURjR2UreHBwTHdE?=
 =?utf-8?B?amtiaCtNUFd1RUFYZEdpMDhobEFHSFFSNEJMaEhCbGRBL1VVcGt6b0wvOXMv?=
 =?utf-8?B?TS9wYi9Gd0ErMzVkT2ZoZTYwaFJkY0ZZQklSaW5uU0dHWHlvNWtxRXE4UExr?=
 =?utf-8?B?QmhudG1QSE9GOC8xSExwRU5oLzA3QUNkMEFBeFcxTjVEQXRjOVFBWnJBdWZY?=
 =?utf-8?Q?i8h7Tk9hW92dJ2CmxPVi5BpIM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad5ebfa-64e7-4efd-7313-08ddbe85184f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:08:21.0491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/I/hG8px+4gHC8S4NdCVRyPizIARz54QdwcdXPxgA1JMykU0hkwnB/7OVt8MxbXJrBo8JOfDpeAMqremEBxqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-OriginatorOrg: intel.com

On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:
> From: Sohil Mehta <sohil.mehta@intel.com>
> 
> For patching, the kernel initializes a temporary mm area in the lower
> half of the address range. See commit 4fc19708b165 ("x86/alternatives:
> Initialize temporary mm for patching").
> 
> Disable LASS enforcement during patching to avoid triggering a #GP
> fault.
> 
> The objtool warns due to a call to a non-allowed function that exists
> outside of the stac/clac guard, or references to any function with a
> dynamic function pointer inside the guard. See the Objtool warnings
> section #9 in the document tools/objtool/Documentation/objtool.txt.
> 
> Considering that patching is usually small, replace the memcpy() and
> memset() functions in the text poking functions with their open coded
> versions.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Kirill, it might be worth adding your co-developed-by tag. The patch has
more changes than I can claim credit for.

> ---
>  arch/x86/include/asm/smap.h   | 33 +++++++++++++++++++++++++++++++--
>  arch/x86/kernel/alternative.c | 28 ++++++++++++++++++++++++++--
>  2 files changed, 57 insertions(+), 4 deletions(-)
> 

