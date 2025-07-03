Return-Path: <linux-efi+bounces-4109-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8ADAF81C6
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 22:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68135545058
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 20:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F02D29B782;
	Thu,  3 Jul 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKF8GFvR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA511E5B7A;
	Thu,  3 Jul 2025 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751573581; cv=fail; b=gMKA5JS+Y9L8srlK/8D4N268uqyXaocgRz4OJOoK5hPtzN1sCxcUwlaPLUMtuXAKpkei3HayjuKpitr6+ZeG5b2QZgyINPnhy/VSrpApQF/HtI9SKFkl36ghCPIrh4uTRMqfTWolil4b87ig7o7ASN5N4D7KeFj0wQ5B2aqD+Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751573581; c=relaxed/simple;
	bh=Px1mI6b0aTDGe8CVxpz7VbM4ZS0QjQmzhZOqejSpr6g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DfSUh6pbkiySQFSGmc7nfhosVGxPV2Tw7RuKPshjGFHKvpid/GGB9NH8PeRIqvIk5gc0SQLCqjetTY5lEjhKCV2cC76G3iNcsMM5ccpCxP/CAbXfwax+gBWJ0/iCr+nYCuaTU8RTH5oRvG6avCOx/jff9o3otxnmhpd8wTZ11/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKF8GFvR; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751573579; x=1783109579;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Px1mI6b0aTDGe8CVxpz7VbM4ZS0QjQmzhZOqejSpr6g=;
  b=BKF8GFvRJe6jgxdDBJOEuUW6g9KjmjYr0Z/qRKENVfDPHXhDBuFC3BWO
   zkg8N6LemSkqeC/r8XCCzH1Z+k9l7vdtGj7A/UhOtSPazosSonwKP3YRG
   JX78r9gPBfRgN34BtW72WmWbRGAMb8oz3d7LUBM41Js9onxYzoQJOVKHY
   eA9jIbD3nLFSVKnXwkKRjKAmgCgSKAC7WtE2cvClqLwlXyLRGYUWY97rr
   8LPVVJVxzOk7NyOgHHEq1hBkp1LP1mDRfnsTqr45OfaG5TGROyNqBP5jg
   d7jr8vgA2h3kf/cvY6lv/machQv6OEq6fDhnFthV443aOxozf4IzSQbeM
   A==;
X-CSE-ConnectionGUID: lAWA0BfFRJO3RAcsoQbzGw==
X-CSE-MsgGUID: 2NspFA2DSXKmys7g7FYpAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65259870"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="65259870"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 13:12:58 -0700
X-CSE-ConnectionGUID: cRT3tQu5RMWJxrInCYT/Zg==
X-CSE-MsgGUID: d5O6g/zVT+iev2yNyQ2eZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154597003"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 13:12:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 13:12:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 13:12:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 13:12:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDp61XjgQEVNTMVqgbEIfvMXdxnh9NESO9X3uTi6uF+b/abnR6VGLPw5oPItjl0SLRX3F/eFyDPGAWbh/oIySAWsPLNc1iUjLV+8zK5T0wwSSxlvGQLsUARMDjYfnoXdehnyCl2A1jRZSH96QR+pDulPbGLx280NAl87Syw9G9+dFT4lNNp6ggLVJNLpYteUBPsAoLrc5K50wXYTL0uC6rOZD62/y6V3cUiluq1ZGSfGJG5hd2O9PjYzp3kblZvOUzo3IzI5H1s/aJOdEi5PmADvHYEnTZ/t4pd0i3gmhvuxXysGQ5iR2KBG7Yg1kIevMme+9eGT7pDbZptXyGP2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uh6GakP1C3mCfHMroD/O/NG51D4NAfCDamDaIUmimlE=;
 b=UwOilKz0Yz2XEQTb1x9vCXNhEm3/eCyuW8rOVFSMf/LUQjchd8CP+f53Uco9KAwkYgZh8cMwzk+OxD852447yqnDZfVYyx1qIV+lT4c9RJ1UIVbQlQguCSBDs2Q/si3pF83JvW2iyfHqR6YhkPSqFwlwJ1mc5HWblN9sItQw1NI5Sm72aYzoOyktHj+t9MJ72AiTcnyrIMqcn/uICPQJj6CjWFGwrZMCQZEInw0+gFTRs5Pawd9GXfqYdb8+8lTnS3w6j2gRE5e7AJIp0gzKChbr2ctWrEFnzS96VjJ99yy9Ly1rKSNVEVp//WwIOu/JVS2o06iSE8aQRV2xVMduwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ5PPF524F3F9FA.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::829) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 3 Jul
 2025 20:12:14 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 20:12:14 +0000
Message-ID: <e0c0a8f8-7ec6-4f54-801d-86f7ca1cbf7c@intel.com>
Date: Thu, 3 Jul 2025 13:12:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
	<xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, "Ingo
 Molnar" <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang
	<kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>, Breno Leitao
	<leitao@debian.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross
	<jgross@suse.com>, Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook
	<kees@kernel.org>, Eric Biggers <ebiggers@google.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
	Changbin Du <changbin.du@huawei.com>, Huang Shijie
	<shijie@os.amperecomputing.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Namhyung Kim <namhyung@kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
 <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
 <mgo3qfjekobe6qflwkpey3p7tzsp3b2mrirama4w2rxyckce7g@3gce3fn5emvu>
 <bbe9dfb6-88c7-4724-bafd-0524599c9369@intel.com>
 <h7pjqco4nngern4ucj2krt4uuau5v522ni6w5vjup3qlkvn2yb@oskfps5mlzbc>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <h7pjqco4nngern4ucj2krt4uuau5v522ni6w5vjup3qlkvn2yb@oskfps5mlzbc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:303:dc::6) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ5PPF524F3F9FA:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a6f377-0491-46fe-3e96-08ddba6de6b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmY4dXViWlcyNnpzRStLbnphSU1BNGVtNU41b09XQ0ZVbExQaUpSQ2w1aUhI?=
 =?utf-8?B?Z29Ja2ZydnRkbzJZWHcyQ1RSRFNGaFI2N1RwMEd1ODQraVFielpKU1VpV2pQ?=
 =?utf-8?B?YmFvSU5DL21DQTVkenFQK1pUY1FSVXFEWjVCRklyWHExR2prQmxhZHRFMk1Q?=
 =?utf-8?B?Y1RnditUMjZXL1VjclBOcTJRV0FkL0htM1c1anhjdVlRS1U1Z1dIb0R0TUFW?=
 =?utf-8?B?aHgvai81TW9EUVBieE84SjcyM003UXVwVGhtY1lXcTNWN3U2N1d3eEFpRzZW?=
 =?utf-8?B?Qm12T3FDaGc3UE9JYUpIMVdtTy9HbFUzUzV5dXJ1eXlIS2dnTWFmZStsbjFr?=
 =?utf-8?B?dFNuSlZvSmJpaFdMaWN5ajlQZlVTQTR0ODFQU0Q1dkZFaXpMK2dwblpWYTNk?=
 =?utf-8?B?RHBxVTJLLzZyWVBhdVFocE1ZTlRFbU9ZRTJ3ZENyWmtUL3FwTzBkVmRiT0pP?=
 =?utf-8?B?YklOSDRRK1NIWHk3Y0V3S3IyTVZMVUF2a2JMeGtZcElIZUVleDk5YzhuSGNS?=
 =?utf-8?B?VjErWHhLNzZ3RWl4bzIvM05HVUZBemtWWEdETkFUQUpQQjhTem93WjQ4OU1W?=
 =?utf-8?B?eDZFQk9LRmxxT05BZ0FSckFSU3pWVmVVeEsxVlpzL1hJekF2VGRoNGxXeHRY?=
 =?utf-8?B?Wk01cmNIaExDUTl5eDBXWC9UK1laWHJTQTArNkprckJFUVpybHA4Y0tNa1BD?=
 =?utf-8?B?dWVPT1ZXQ1NxOEV4YXZPTjhQVXQxdXR6NG9ySis5alV5SmVocldhZ1lVQU9H?=
 =?utf-8?B?QXdDTUZFR3hjREtoUE5TS0V5NkRXNGcra25JL3lDSExUc1orcHc2THpGek5C?=
 =?utf-8?B?d1FLMXB4SGxvZVl1anlYZSs1WHVhVzJaMXd3b3JHOTRRRFFqYW1oQXFFWHNv?=
 =?utf-8?B?TFNDdkZWc1FrVW1kNUlxQ2xtT1RGeXB4SVJydTg5N3FCaVFvUjArS2pMamRD?=
 =?utf-8?B?VWZKaW1nMkprdkhMTEo3M0Z4R2FyL3ZCaTFjNlMxSXZvS1NGSUxkQXJVd2Rp?=
 =?utf-8?B?YXhtWjM2eERtOVVaRnR3RVZPMzdhOFAwK2NUS1J0YWhWS0txclowMDlPazVs?=
 =?utf-8?B?U0hZdFdQR0FoMGdZQnJTSjB2ZTRvTk9HcmZQMkorUHFNRUplaWJ3VTRKUjU4?=
 =?utf-8?B?RVJqdi9obWczVWN5ZWlpUThqMXZYSWVTYVllT3VPT1ZtZ2pCVmdsQzZ4NFJv?=
 =?utf-8?B?bEtLd0VuMzVrQkJ3K29yS0Q0cFBxKzY0TGpsbUwxVld3cTNCQzk2YnlDSzIy?=
 =?utf-8?B?a0ZPTmUraUY4YmxMdXpDRkFyeVZleTJ1MHFKTXgxWDdydmdRQjdUVmNHMGwx?=
 =?utf-8?B?VjJWdjc2ZWhkMlZtRER1K0RWVVRWdGpuY20xRE5xRnFoaWJvSVl1R2l1MzNl?=
 =?utf-8?B?Uy95NUZaZDVYSVdqblEyNGI3T2VtWENYYjcwTjVmTHJKVGdPQTV5UlJxZXE4?=
 =?utf-8?B?VHdoT0FSbjRXMzd1Yk9Wb3VYemJISHRtaGZFSGRiR2s4eHVKK1FodnpjY2NY?=
 =?utf-8?B?TDBsM0d1Rk82RStzWmNDMFhJR1U1UFFjUGs4SjEwUzB3eVRFaXJuVmlWT0dy?=
 =?utf-8?B?VUN2VXFtS3o3VFFjcjJYNDduaUFFSGtxRXIxWVlPWmtnUDRTUWNoOVFDeFhq?=
 =?utf-8?B?a3VXc2pTY2UrQk5xQ1V0WDVUOWhHMkkrc3Q3RTlJUTgvcUhRREhRb0FmNjJx?=
 =?utf-8?B?d0FVZnRzV0NYd2tNc2pBYWRYakVNU1F3SmxyUVdselZFVit1a3BrNjY3OWlt?=
 =?utf-8?B?NGUrUEpBYUZ6TDdVemZXR3NsNjRKU2N3WmkydFV1QVYwS0FxeWhOeUNOSzZD?=
 =?utf-8?B?S3FXOHVrbmg3SVVGbXhLUy9mTUlWR0o0TUhTR1BTMXBTRVNJR0hUK2ZQQmlk?=
 =?utf-8?B?RGlCdW9ZWk9JRGlMdmRnOXNJT2N3SldoNENzaEc3VDhuUGgxMjFBYlpWdDla?=
 =?utf-8?Q?Gb7HWkCqDDw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlEvOHJwYVZpVm9TVm12K3hCeHZRMS9haGNneGthK2UweWZNMmRhVHB5SFE2?=
 =?utf-8?B?S3FTdm54Wi9ZbCs5cHlURTFjVDdWRUprODNyUW5Ld2Z2a1BDSFQwRmNzS21O?=
 =?utf-8?B?SUpMNk1zZDFaWXR0SkM2UjFkSk1qZ1BvdTVMWXRucC8zc1N2Yll2SjhFMlhz?=
 =?utf-8?B?ZGhlbkVaVnJIcXAwV1dnS1JWcnlrOGZCam5IM0VERGN3MXdvOEt2QisxZEs3?=
 =?utf-8?B?cXF0Q3hIcTBuc2xpdU5BR1kyNEtCOE8vclM3WEVnMzErWFFZcHp2aGE5bWZV?=
 =?utf-8?B?T0hTNXloV1EzNWNReWNSNEhmUU96U1JieEFaSXo2MFg2emhOYUpjZ2ZXYUI2?=
 =?utf-8?B?YVg5c3orcDBkaTg4VU9YSGFWQ1RXRnZjbktaNFZJcGprRVlISjhTekdpOUVr?=
 =?utf-8?B?bkUrVnREZ0lIblRwbk1tRm13amVaTFNFL3ZhenN3OUdUUE15dVFQQS9GUTBs?=
 =?utf-8?B?MlFkMFVtaUh3bk5xNU9mSmdyUWg3SlZHYUZ6V04yRUlUdWNUaDIwKzhQeWE3?=
 =?utf-8?B?STFKZ3lldUNCTmtuTWliYjQ4Qk85cUFybThKZVh2Y2dGMklHZ2RCdHE3V2R3?=
 =?utf-8?B?bmhhSnVvNm02VmZWWVM5UmUxSVRLak84SldLZFFiSWRpVFd3TXNRMUkwU051?=
 =?utf-8?B?dkdFaVF1Q2E2ZlRPQVdtZVNEZlUwTGZCTkRGcW9WU1Q2ZU01WXRYdGdUcStY?=
 =?utf-8?B?OUN6ckxpZHp0cnJPOWF1OFdvTDN3bERhNlVIWXd5RW5KUU8ycGxzWjFBR3cw?=
 =?utf-8?B?aldTTjJGTzdWRzNncGRjUmJDSnRTOUx2Y1EvRG5DVXJnOVRybEJ6dmtzalZG?=
 =?utf-8?B?S0xWMlE0R1M0cUErUnh2UnVnby8rVGZzVE9RWFJBRmdFeTFnbnJnTENtNWZT?=
 =?utf-8?B?c3A4c1lhc29jbVZ0RlBNODYrTmNDM0ZJUUFPdTZwU0JqV00xUXNoZEV5VDlB?=
 =?utf-8?B?TG9ZTkN1Q25tUkZQZnN1T1lobzJpUVM0cXZaeFpLS09rSDBRRVk2LzRWdE5t?=
 =?utf-8?B?T2ZKSFMwWU5XYWt3eXRvSXo2eVpubi9wL3BRa2lwSnArWlZrU2s2R3prS05T?=
 =?utf-8?B?eWQwVnM1VXFOb0dNSVJ3cFFNNEdvSiszcGVoTjMxOUFmeGhncjFuNGRjdmR5?=
 =?utf-8?B?ejdwV0ZKOFczUnB0QkZ0NTZHVGNNVjkyTjRlWlZKQmZSRmtwbkxBNTd0b21l?=
 =?utf-8?B?K1ZOcXl6N1huQ2Q2ZmordFdGUnpVMGp3Q2NlcFJnSHRwTndNaENCOENqS2RY?=
 =?utf-8?B?Zm5TMVhndHJoNGN6YUhFOGVZNXJiREdhUU1jeFFUOXZmM1pRdHhQcHpvV0Iy?=
 =?utf-8?B?bkNQNW4ya24zYWhoSCsrTW4xQkQ5NU41ZkZIMGdWd0I4WkdlakxsQ0daV0dy?=
 =?utf-8?B?bnU2S2o2bldLVEIvK0R5a0hYTld5OUg4SDZ6ZG9wdEF6V1lJeFhJbVIwS1ZG?=
 =?utf-8?B?RCtuaTRxcnU1eGVqdWRrYmRoMi93UkJYRkZmOEJYRHZvSC9OaW5mN0pYRjZa?=
 =?utf-8?B?OHo4ODlWQU5GU0VVRjMvbVJSSjR2NVZJaHhQclYybWlnbXZ0dGptOVh0b0lo?=
 =?utf-8?B?QTlRL1dicGJNZ1BMNjJyVXI3WjNMbGhVL2Rjc0J6NklWYnU4OE8vVW5hYkl5?=
 =?utf-8?B?WG1MajZUL01ncXQ2dkpEeXN6T2Z3c3hZQXh3d2hjdmZUaUFZcGVrQytsZllC?=
 =?utf-8?B?T2RKcXFQNW9hd0pialVEeWNRMmR6RktmdHNjUXU1ZXFyYnRUQlFVMnM4b1E3?=
 =?utf-8?B?YlF3a0JsUHQ5S3VlVlNWN0F0d0JLYVJDVzFneHM5eFViUFgrdVBZTDhHYmVV?=
 =?utf-8?B?am53cm1LOUlEYkJHcGtKSk5EbTNTdC9BMWZReFNNWTdJcUl4RUNScnVhVlBq?=
 =?utf-8?B?OFIvVDY3ZDRnQmlNZGhQUFBpZ0tkTWlqUHBnMG5MbDVscER4MDJhUzFYWnBs?=
 =?utf-8?B?amJPUFZmTngzL092VVlySUZpSXBDTWRtVVZXQW1GbExIVFdyK2dXelJXRTNH?=
 =?utf-8?B?ZVBIeDJ3b2ZJMHMxaHBxMFJURFhsS1ZHS3FaQmgwd1lvMUtnMkNCQmM5Wmtv?=
 =?utf-8?B?aThRWHMyKzRsSC9CUXJiTVBudHpjSElhK3dQSW9vRjdHaTB1SkQwTXNQM0hp?=
 =?utf-8?Q?4shzD3yqm75uq6U0m3LIz36l9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a6f377-0491-46fe-3e96-08ddba6de6b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 20:12:14.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPUCmtZxMQWazzVrNtTFmFs7QqRTzbWrnM2qo1U2VP1+iFvfMyInrd6mr+JkDt6P3UK8bQQSXyjKg34vOhXoCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF524F3F9FA
X-OriginatorOrg: intel.com

On 7/3/2025 4:31 AM, Kirill A. Shutemov wrote:

> 
> cond_local_irq_enable() need to happen if we want to do something
> sleepable during exception handling. It is not the case here.
> 

Makes sense.

> notify_die() will be called die_addr()->__die_body()->notify_die().

The notify_die() within __die_body() is slightly different from the one
called from the exception handlers.

__die_body():
notify_die(DIE_OOPS, str, regs, err, current->thread.trap_nr, SIGSEGV)

exc_alignment_check():
notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_AC, SIGBUS)

I believe we should include a #SS specific notify before calling
die_addr(). Similar to exc_alignment_check() which dies on kernel
exceptions.


if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_SS, SIGBUS) ==
NOTIFY_STOP)
	return;


This way the behavior remains consistent with other exception handlers
as well as with/without LASS.



