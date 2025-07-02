Return-Path: <linux-efi+bounces-4079-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67082AF0810
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 03:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6728C3AD3BD
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 01:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E3E15C158;
	Wed,  2 Jul 2025 01:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnEJ3pzS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACE51527B4;
	Wed,  2 Jul 2025 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751420193; cv=fail; b=fmbDtZllkxtQRuN1Apltq02pDSLef82yLlzIObZuKBQud9IYrPZLZoum9bBjrLMOdaYqbuxYsETPdIgWeLM6BT9dIC94ueWgkQJOwu0jMel9ssArhn3bmggCI9ZuEGBUCO5Exj4pCGek2KiPv5E6mgNhSCaoy3SWc5EwZBWATcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751420193; c=relaxed/simple;
	bh=3WRsvAkSrwQX+5WHS5c93b+mupnnNklqKQGDP0DheQQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PcNNZZHXMc4zEphS8FCqwlxvhu8uSHpIryx1X74aCdPPeD8xFUv5okrpg0pwfmHFXnpgmwPDfqk76ZZ3WyL1UQlJYVuAiVwmqq254tjszNET4ZUxZgVZ55v8k0FlEWC8OdHafGoFig8csrllFdSvlcLKTaFZ29QrZ2BQ5uTGC+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnEJ3pzS; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751420191; x=1782956191;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3WRsvAkSrwQX+5WHS5c93b+mupnnNklqKQGDP0DheQQ=;
  b=jnEJ3pzSpOandsoSKQXYy8fdTwukGOH3I6jSDRdACzJTd5sGSRHvBIL0
   yimv+TjcEuQiPGmpln3UZcFA+ldEMErlFahZExel7qI2hELV+afzcF99d
   x2+/oYnyNT3r6mCEJB+dSBsePreUcxO1iVkgPbmD68P96X7OV+7XCcGIm
   DaNP6esZgwtMInL4YgdgdkTc2BeRxgOwQQW2IunMTL/Pb7teaOIyxOZL5
   obQ0vSvAlKD8YI3kAHhV7MHeN92Toz4zdDZM+uExAVyC7C+hTlnbLi7Ph
   O2x/SILZ6ooRqkQ17r6LalE6GgK4OilRW7Q8OJghjBjFU2NkRV2qiKMnE
   w==;
X-CSE-ConnectionGUID: c0S3FZlhQaapvzY/bpXxJA==
X-CSE-MsgGUID: uLQFhMk5QEC6aTBC1WQWNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53812939"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="53812939"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 18:36:27 -0700
X-CSE-ConnectionGUID: wWBXaRB7R0CSQw5fdXWfHA==
X-CSE-MsgGUID: NPMeoOaZS12tz8MpnbJJ2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="158196189"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 18:36:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 18:35:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 18:35:48 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.63)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 18:35:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBFRmIbpRP68d5ISU/4rH+VJSy/LYg6oL/HcDav3YDdGZ3IdIHkHC9VErfUXLd8J3C2UT508G9sjwgmpieo9kTz4n56KvfT40vGFZHPHFHuYeW4adXF6vmM1WWyFZrXk5Z1PnshUa02DIQF3Z5+tSdmq6NgZYBnpfgiQhWDc4cKpVE2yPlUd2APxWGL6T47RjjXSkdW7dD07eQ2S3MEL+gPvFc6A6xgIYIoSXbI7tTlnrwQr2wEsVl1+noNbg61iLSpeIdmYSRrs6oeDHgTKF3VJY1xz5mTZJ8MZTHfGG5jGb8P+4XXpc0rsM+QchOSvwYmwOXFWMk6XfPWmhWvl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgC65EAy8SVUk6GCQhQRxG7ajdXwVkX0WMtX2mwMZX0=;
 b=LhGkMma7IT1CC5xjcLxQjZprPaJnLMdmwnJtPnefKIyvsFML9qsbdBNUPFr+6Njar1J9enX5qjCw0rZo2JKaO9qSgIyk6PZyyWvB4avXt3AcQrslLqjQx244/lJuSCutq0rpZYqGSXkSJ+M+r8Xo0ceswniFTaZ2qVJUsUzAZU0FCMRi36ENzIXc/UK89WfvSO81n+TqMZKRTmA3z+sAgyxB/URdkr3V83FJjC+KbMMKrTW4z+cmTacR2wOlik3JIKwDUHmGzzC/rO3z5Pl7VIQ0p6mJFs4Bcw7Ay0LUwPBIuuMSeMBUJXAU/TvAGX11Obht1BcRFnDef2eh3/FXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS7PR11MB7833.namprd11.prod.outlook.com (2603:10b6:8:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 2 Jul
 2025 01:35:45 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 01:35:44 +0000
Message-ID: <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
Date: Tue, 1 Jul 2025 18:35:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
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
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:303:83::31) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS7PR11MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: a11a03d9-72af-4595-58a6-08ddb908c2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3hCZTVKTlE5MzNSSlVScFdINXhDQ2tEaEdIaXNZa3NOa0k4OStDZk9nclBP?=
 =?utf-8?B?dzg0UFQ4YVZla0dOMlJha0ExNWlLSGRHQmVUbE5LVVFYbUd2K2dMSHAzRkQ1?=
 =?utf-8?B?Y2NIbEZCcnNkN2U0dFhscml2T3UrU3I2Nkl5MTN2VHozZXc3cWJUL1lCcGtY?=
 =?utf-8?B?VWtLTThtZWtzaG5Ec3d2cUJJTG8rQzJnc3NZUlFBWG14Yyt3T3BneTZLM04r?=
 =?utf-8?B?ZGlDNmEvQnZERDlLK29YLzc1ZlRsMU1vZlU0ZVJVVmJ1MTdSVVNiZUtjZm0x?=
 =?utf-8?B?dzBhWFF4RzViU1R5WEM4UGtVZjN1QnFJWW4wQXZzVlBjUVRyTlkyd3VtcnBh?=
 =?utf-8?B?ZUI1R0hSekFZWHo0aU83ZmdFNmZEODBCV01FVW54dmZkd0ZtTU5BWU9yaFhZ?=
 =?utf-8?B?R2JSNkpNZFhMSXpySXdSZzdOQkpURVFRK1ZHT25DQW5sNnVEWDNVVEs3bVVY?=
 =?utf-8?B?YXpabCtkTHRQVjBtaU83N1Y5aE5IQUYySXBKdGpnOXBWamdXeU5XU1Z3dndH?=
 =?utf-8?B?Qk1Ra0JjTkovTkE4dnFCWVpxU3JOaEl5MFNUbXEzWVJjbk5teVIvTkRQb2Fh?=
 =?utf-8?B?QUdjcERHOTVjV0NRRWlGOWVuWVpaVWtRUThXai9TTnVUSXdSc2VGaUJmemlk?=
 =?utf-8?B?Y0lwVkt2VnZ6TGxpOGFHdFFHV3BBWlQrU2lRV2pERSsrdldId1cwM2tNTTlJ?=
 =?utf-8?B?cnN0YkQ1QU9wN3Q1U2p6dVRVRU9CaUk0cnU1ODdHK3F3dHZSUml2aE8zbEZF?=
 =?utf-8?B?eFJwMThzanJieU9QbnV6cjVTRHA3ME5KTzZqTUtVVzVHSWx3VitGbUVJazNq?=
 =?utf-8?B?VTZsNkh2SDFHbVhQOGF0dE1VSndOZDJnbC9YbEhlWVVmS05tUlJSYXpTaVdF?=
 =?utf-8?B?Q1FoK1VFam9uck8wS1JZSVFBR2tQVzE1eG9DaUtVWWhpSW5CZ0xLY0lBZmdK?=
 =?utf-8?B?bGlPTVFwcCtXNXlnVDBOelpaK1kwbHNTbzBiV0o1L1BlZEwySzc0bzRmUTVu?=
 =?utf-8?B?bGI5cHlnUWQzQkFXalBKL0kxdTlwZURIaXJSSTJYWk9PMlpZYmxocVlKRjVT?=
 =?utf-8?B?M3RxQ1RDN1RBcTZud1QydVJ3OEIyTkUvSGM1MlJ6MkdmVE8rVmozUk5lcHNL?=
 =?utf-8?B?aVlLVEhiL0RlaXQvVnlJVGVzZ0UyUmRtT1lzVTRUaWJlZElNd3M0NUxPK1dw?=
 =?utf-8?B?MXc5cHk4bmI1Wkx1R1VIc0tHKzlMWTVJTXFZSWc5OG9WaE9ZRnIzK0FPWEhT?=
 =?utf-8?B?cCtaaEMrMjBSNGxzQVpiNUlNbDNtbE0zVHdXSjBSVStBaVArN1JEQ3l3bU1r?=
 =?utf-8?B?aUtMbkU5dHFsVjNPWisySUlERlg3WUhPeGJpR002UUlaTnBVeXA0ZmJSOXo1?=
 =?utf-8?B?SG9YcE55aEhueXdkeGJhMkZoS3BTY0k4Vk45aVFOQlRvVWJMV2RucGFnTVJ2?=
 =?utf-8?B?NzVLZHBYN0R1N1ZQOVcvWjZjR1BYSEMwRkhiY2Q0Vnh6Z2Q2QVFTTFIvd0hF?=
 =?utf-8?B?ckJqSGcweHVKSkhxakttNkdibWtmNWpVa290c3VTdmhyanZacXc1dFhZeGFK?=
 =?utf-8?B?S3REcTVBRDJsbFQ5eFFwWEF0RjE0cE9LOHhxQzlUYjNFbEdtWGpPRnZudXNR?=
 =?utf-8?B?a2FEeXV0OFJDWG5BYm5OeHh6QktDcndjZFlIbW1OT0Y1eUo0UzRaNFEyUjdP?=
 =?utf-8?B?Ukl4dkpWVjk5MmFueU5nYTBndCt6bnh4QkJVd2c3NnkwL1BmY29uRjUwejFL?=
 =?utf-8?B?WDdTNWFTOUJSMkxxSkRPS1Z0OWZiTWluYjRYVlhWcTJrS1lLN0NycmZmV2hz?=
 =?utf-8?B?S3pTb1FWUVJ5QmZ3MjFwTSs5N2ZoQzF0VytUci8zallTLzluY0VSYXpvaklD?=
 =?utf-8?B?aXJqV21uZndidy8zT29PWEtMajR3QjBKREgzVTVnQzYzenM4K3ByREZHZjc5?=
 =?utf-8?B?M29PUVphemVydFA5SFFyTnkxeTFwVFpiamZBSGpXYjRqaHhMWW8vaEdvbHRK?=
 =?utf-8?B?ZVJtZXNXcm9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3dkTGlrMmV6bVhsTkQ2UFF6bTFNc3hqUzV4S0lYY2xNWDBrUDFrVWhNMnFr?=
 =?utf-8?B?UXhZSmJ5UzZ6L2ZzK2VEcHEzRTczMVdxN21oWS9PZTh1UWJlN3Q3VXVCSVM1?=
 =?utf-8?B?TDNNenBzdkVpZUd4cjljTGRWVWVCRHN2NjFDS3JiYTZhMEczMWNOL0JTRFl3?=
 =?utf-8?B?NkZwTnlTcGhMZjJwRnhUNzFOd1FTaVBQbzdPbUpxaTEzSk8zcDBRL0dCY2dr?=
 =?utf-8?B?d3NzbDhCTEM2ampuTmRSM3lZOE9PVGlIMFNUcjQ0NmZ3L0JhcGVNSmRTSDV0?=
 =?utf-8?B?ZjdNaVlTQzJxakQ4UklCTW4zTTBibzRIWWJseWRUZ2VheWphNGlqRUdiUTZn?=
 =?utf-8?B?a3RpWTFKVzZVcnNZYklpak16V3I4Mm1mRE1BK3hPYXNPS3hXOWRLYkMvVkJz?=
 =?utf-8?B?OWprbW9tYVNKdXppYUxiKzh5KzNXL1hGbGFhT0Q2UUFqTjJoa0tDMSt4S0lW?=
 =?utf-8?B?WkdyVjdXbU8zR2NxZDlyN3gxUnVlTU5CT0FTMGJ6cUZRbjZvSXpLOStwdmZO?=
 =?utf-8?B?SlpzOHJadTgrbzVRVEpsMlpVVExKam5xQk5LOEFtT1d5R2Y0WDc1YjlhcERz?=
 =?utf-8?B?M3ZwWnd1dERyZ1NsV2RML0VFWndLZUlFcXdqU29zYkRtNGR6ZHM4ZmpaM0ND?=
 =?utf-8?B?ZzdmQVE1RUlRRFBGMnRtWmR5V09tNGxDSHVrVUJhSlNjSHNmYmxTL0JHWUls?=
 =?utf-8?B?L2hxQzN1UnJEMDhsZVUwb1p1dWRzOXM0Q3RZRVhrL0lGbEhxOE9rdEgxM1dP?=
 =?utf-8?B?SWZTVC90RWtBMEs0cG1ISWVPVkJNUnRYQkJlNWd1eS9zWEJoNjBPeXJpc3hM?=
 =?utf-8?B?TWdyYmRXMlNGU3Z1QTZ5RUVOU25EYTdLKzMxYWxTVmFrOU9nR2QyOGk0MXVu?=
 =?utf-8?B?MFdiNGtPR0Qya2tiV0dQV0poWWdoYnZ1bWJnaUxwaWZsS1R4SWcxUGNZNW9H?=
 =?utf-8?B?QWVSQnFNVVRobEF6Qm0zZWg5ZTZIMlJOMVB0Mk5ZUU5RK1pKcTN5NnAwRFlQ?=
 =?utf-8?B?engxMXp5WVJsUjBrVkZIQ1V6cjdubjZDak1sL0RKVzE4NXI5K01JUGRoRmky?=
 =?utf-8?B?UDhZY2U0Wk1YT0ZGa3FvcHE3ZUdKcENib2VJQWVrNjErcWIyVk1ET3o4Rktu?=
 =?utf-8?B?SzBQbVZUeHdrTmRtWjJPa2hmZFRDMUJaRnRpOWFxL0RPTHhvOFdDVXJsNWlI?=
 =?utf-8?B?TDFhZzA5cWl5UlUwRVcyQXZJWXVLOTZBaytoNkZ2OTNqajRRS1lOUlhwdUFU?=
 =?utf-8?B?bnkyaitTTmFZMGhNVm5lZzd2YU01dVhLNzBqcldxbDNYMExJanNaMEZzVVNw?=
 =?utf-8?B?RlJTaU94d1BJQXF2anYwSHNraHdheTk3dTE4OFJqR0xOYzd5dXZ0UUl0VHB5?=
 =?utf-8?B?VVFWaVp1eGlOTDg3c05vSHIvbi85SWZEY3Q0cm1hVmI0OEhQZEpCRWxGYmJN?=
 =?utf-8?B?M3NKZ2ZrbVFGdEhVUnhrWmg5TDJSdS9wblB2Y2h1dVhVVUdzU3BCbjNIYU9W?=
 =?utf-8?B?aWxycGJEUjJxNzZ3Q1Zmd0QvQnpGZXhwQnpvZXZ4dlVJbitYNTNzM3BJdEJS?=
 =?utf-8?B?UXBYSk1kZG55SFpFRDBrazFGak52WXNOWXVrUklxTTR3Zm9HSDEwT1h0UGc0?=
 =?utf-8?B?Y2h3dThIa2lEdHovT01PUmRzdzcyR1UrbGJIb0QxOFl2K1JhSXNYK3ZKK3RK?=
 =?utf-8?B?ZmJzZ0VQd0hKNlZOQk05RDZMNlJhS25UMWZML0cyZXIxZmkxRUdQZG5raVR5?=
 =?utf-8?B?azFXNEtPbExZMC9LenZ1enU1RkY0a0ZiTmxWdVlpRWVuVnBMQi9UMjZaV1NL?=
 =?utf-8?B?dWtYV1Ntc09ZaDNnRlJwM2FlVUpkdFdWdWwxT0dheStOZkp3QTc0QUluUXlB?=
 =?utf-8?B?OGJPRlNUcE5FVHFxV3hvYmdmcVFYRkIveG5pNHV0dTJkLzMyN3Q4a21TNi9W?=
 =?utf-8?B?akt2OTBJNklUd1VLaXVUVTNzbWJJRzR2UkNVTVkwKzVLa2xGWUcyamdGckxs?=
 =?utf-8?B?T2tCNWgrMjVZdnVmZ1VIZWYrZGphc0dtZDRIK29nRWxSK0JjaEdSTTFYMlcy?=
 =?utf-8?B?ZU5uY1h5V1lXWlorUHk0enl5c1NWTW9nZC92MWhBaE1ObEt2WXlHdm5SQjNk?=
 =?utf-8?Q?iwvzpSPn8wpKtrDEfHhjJCbGd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a11a03d9-72af-4595-58a6-08ddb908c2ee
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 01:35:44.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uI0geCL5lFctz2hsE2IgUI8Sezf4xokPUqbKpYMwmhqpsMP1JB4YUuWPG3bIt2T74AcPzTVh5iqpCDwo+WSRoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7833
X-OriginatorOrg: intel.com

On 7/1/2025 2:58 AM, Kirill A. Shutemov wrote:
> LASS throws a #GP for any violations except for stack register accesses,
> in which case it throws a #SS instead. Handle this similarly to how other
> LASS violations are handled.
> 

Maybe I've misunderstood something:

Is the underlying assumption here that #SS were previously only
generated by userspace, but now they can also be generated by the
kernel? And we want the kernel generated #SS to behave the same as the #GP?

> In case of FRED, before handling #SS as LASS violation, kernel has to
> check if there's a fixup for the exception. It can address #SS due to
> invalid user context on ERETU. See 5105e7687ad3 ("x86/fred: Fixup
> fault on ERETU by jumping to fred_entrypoint_user") for more details.
> 
> Co-developed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/traps.c | 39 +++++++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index ceb091f17a5b..f9ca5b911141 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -418,12 +418,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_present)
>  		      SIGBUS, 0, NULL);
>  }
>  
> -DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
> -{
> -	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
> -		      0, NULL);
> -}
> -
>  DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
>  {
>  	char *str = "alignment check";
> @@ -866,6 +860,39 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	cond_local_irq_disable(regs);
>  }
>  
> +#define SSFSTR "stack segment fault"
> +
> +DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
> +{
> +	if (user_mode(regs))
> +		goto error_trap;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> +	    fixup_exception(regs, X86_TRAP_SS, error_code, 0))
> +		return;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> +		enum kernel_exc_hint hint;
> +		unsigned long exc_addr;
> +
> +		hint = get_kernel_exc_address(regs, &exc_addr);
> +		if (hint != EXC_NO_HINT) {

The brackets are not needed for singular statements. Also the max line
length is longer now. You can fit this all in a single line.

> +			printk(SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint],
> +			       exc_addr);
> +		}
> +

> +		if (hint != EXC_NON_CANONICAL)
> +			exc_addr = 0;
> +
> +		die_addr(SSFSTR, regs, error_code, exc_addr);

The variable names in die_addr() should be generalized as well. They
seem to assume the caller to be a #GP handler.

> +		return;
> +	}
> +
> +error_trap:
> +	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
> +		      0, NULL);
> +}
> +
>  static bool do_int3(struct pt_regs *regs)
>  {
>  	int res;


