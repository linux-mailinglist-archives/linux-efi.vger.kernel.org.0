Return-Path: <linux-efi+bounces-4201-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F374AFDF09
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 07:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BB8486026
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 05:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B188269AF3;
	Wed,  9 Jul 2025 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZI0KHFVz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A377AD21;
	Wed,  9 Jul 2025 05:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037960; cv=fail; b=AHMKU60eMFmM26ifXWjON9bznwAhHwq977EgmlpDraW2Yx66GTpDmfeKVrPyK9tcw9yt4B2FhAGEWr4IPLHN2n9dQ2y+nuz/OHhchbNt037VZAMq86K/dY6nlURaJqPJg4Q5X7z/VsW4FQWshY7ydMV0wmu4RzV0q2WBOBp8OgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037960; c=relaxed/simple;
	bh=H3XWUO4m7Og9GCpAtYZbXg8c8UmjpslQFk6w34n4RNk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MqNM/b039tJOGI9WZIvvPAnjfolTVVYPHcbHJJkgMn3fQytyhYQJ+0mmu80MRS8cV6+x6kaFVdRW+6HVojICAnl4MPXlLunL1gi9WsMw/QMwuYL4Zs07VLORhTm9UMDhQ8yQ9ILnbbaOLMNOvTy3NXIwvZg8rBrcUg9xhlY2/+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZI0KHFVz; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037959; x=1783573959;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H3XWUO4m7Og9GCpAtYZbXg8c8UmjpslQFk6w34n4RNk=;
  b=ZI0KHFVzo3pO8SUPwCdj7QdgEGb67bcvppWdIjeFhn30R4yIoDyASDZm
   SXz1tU+ou2EvDXaPpS7eCuXd8itW/4/JukwJX5LfTOEVc1+LXE6Y5Cz9r
   Oo1LqiIKKy0yhW6sZf+v3KVJ1dp/H8rqqqL+cnCL6eWJAPApBODKDNDVM
   vc57RLo1G68o17/2sdnuYI3E3lZltp39R+BvBPOAaKyYWySuvb65vAqLK
   2KhcKjR5Z5JaUIKtTOAVyiHVWSIJ9LVgIcqBWbEEA33YG4ch6SXGki2YU
   oQshu+fQrCFCmdqWy2bm9fjQfQYPTXP2J67TiFteokulrVwGZLTeZem8j
   Q==;
X-CSE-ConnectionGUID: ngJFCH3NQQW+z8og+gw8Iw==
X-CSE-MsgGUID: WU11c3RrTcuU2JIYM93q5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71868540"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71868540"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:12:35 -0700
X-CSE-ConnectionGUID: xrdRL2MJRViTqgJnIBWtyA==
X-CSE-MsgGUID: JsQ3Xt5zTQ+6Y2PxizjbJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156005463"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:12:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 22:12:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 22:12:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.50)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 22:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJx8yPR/ZtkdB5P05h63xuS4MAXAaYuANwAQEmsHh7pZ3dwfnr9q6TR0nfdhBq9NKffDbvjE8QipBS1Nnb1T6XdIUBa8R1zKJW2yk9x9Qu6abFFfiA+4qlIreiHSci4VQ8zLU5de6KMHFTzCU/RTpvrQbmT1tGI1ZUWzy00OCvkF6olZ9ZDF0VvGbTR7/2+YS1nF7eVvsAqiS1qPloVKf2M8NRkUwbb1GV9RYb7nHMsaw7EFCZ3bMVU2JbMweYQSnCsbSIY/1s7JCmM0oCjte09TDAm16TnnE07lAGTOnVrwR+YShLC8YD2TIKCt6m2HsYq81/TdfBmSpBxvLq+4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpX/PVSafcEN0c+N5sXumiV47jE6JDzDCGxHhTVa8Tk=;
 b=XUJ0oR+iQ5L8AAyzBirf+0GYl60nsE+BASaBkVqo0IjmkMus/sdDEjF4IJoo6t7sQzVUoMoTWoJZzgalrMN7UmRCIHDoOQioYEwRln0nVGZzVnvusw+oaDQ+avno2Ob5n3WZ9qRz4StqORfIzTgL38UxIU2VVCDcntrTjcfqn7wAkVpYfWbsUnbaiUqlXhmBea+xUM/dl6ZHT7N/ksBGFEg69Tr5HsBjQl3aImH+v5P5n0p6AeWgZBh9bhrx5ao7dav1AOLfRXzL5QTX2MMP4tH3WY++LP6EHakd4YkBmsTaf/Twk4lC4zctnPW0OEerrfOE5DWP4LTftqyX/NljIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 05:12:31 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 05:12:31 +0000
Message-ID: <1a2f6b4a-114b-4c27-83f9-1aac46f2e7c0@intel.com>
Date: Tue, 8 Jul 2025 22:12:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 13/16] x86/traps: Handle LASS thrown #SS
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
 <20250707080317.3791624-14-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250707080317.3791624-14-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0050.namprd17.prod.outlook.com
 (2603:10b6:a03:167::27) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CO1PR11MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: 828a4c9c-49fd-48af-976f-08ddbea7349b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWMxNS9ybjFwKy9WVmFvK2FYLzZna1dqaEZUOVg4VVhMQUh6ZGxwOE1Temgv?=
 =?utf-8?B?MVFSQVltUmNUeldUZjYyWDloVmRLdEp6dXpRYitoM0F3OVJzNGlXUXlFTElD?=
 =?utf-8?B?Q3p2bDVWRTNoNnFIZEU2UUdsTGVIcC8vYUUyYnJUNGxLVHVER1d5QnVScE9W?=
 =?utf-8?B?NndLOUhzbGxxZ0t5SzJwaEZkLzZpV0M5NEtUY1lzcHd1S0FZTHhRc0ZuK1dH?=
 =?utf-8?B?T2lhWWhxVXcrUFZnbXo1WCt3VDA5OUlEZmFDdTVxZEcwTDVza0p0MzYyVzJa?=
 =?utf-8?B?d1FGRnFQM1I2QzZPUlFrYXNwQ2pjbnRKR1I3eEhiQktWbmwzYVJITytmK2I3?=
 =?utf-8?B?VW5jbjk4SzZtUUR2MGc1c1MvbUo2VjNFdHloSTVCQzdNOGh5Nm1yQUk0dVVR?=
 =?utf-8?B?b2ZuWlZZSGR5ZUdrV3VsNGtIS1dtZTdMOXp3eVViOWhVVkVPclAxazV5Ym1p?=
 =?utf-8?B?Uit5d2FIby8yUHZqSUE5MEl4SFUvQ28xU3JtR0xCZE5WbmlNdFBIYmJYdHA2?=
 =?utf-8?B?UEtZNW5rQVZxSmV0bzZITzBPd1JvM00xSS92Ni85dFNYczlWTHNES2hhaVpF?=
 =?utf-8?B?MkpLK3J6cVQ1OXNIZ0RybFVlYlhHVEcwRTQzV0N0OXNpZG9wa0hERU9KdnpP?=
 =?utf-8?B?bGp1K3BmblZkWktRdG1sZnZxbjhKNWJ6ZXF6SWJSOEgrb21rZnM0YXk2SGx5?=
 =?utf-8?B?VVEwc3R5S0VUNk4xWjZwdENrNjYvNm1DTHN1aUJ4SXBPNGVRd0VoYTMwbk9D?=
 =?utf-8?B?dWZSRXJLSWxaQkdtZllrZk5jb3BWc0NiWmVvQjREN0xLVG5DZVg4NFBvak5W?=
 =?utf-8?B?c0o1OVFOdU5Ua2xRUHpwV3Y3RUxxNmt0cXVhQjVYMHptQStrYnRhS2hFMXp6?=
 =?utf-8?B?clhIdkk3QnFHMGRzTGpDa2U2cGlQSjg2YUZ3SzZHK0NZRFNRbUxtaThtQnZi?=
 =?utf-8?B?VlUvL2dCbm1YMHFyemcyaTlUK3grTitZdnhtK1hqMVNvZ3RoUkJ5L3NhckE5?=
 =?utf-8?B?NVNRNE5uaysxRkJDVUNQV0F6ajdMZWh6THVNYWxxVGdIaG8zQkJlUGwzMDlG?=
 =?utf-8?B?aS85cCtvRkF6SEd1Mm4zZG5QUlNQYXUvNm14YUpFT2xLRHphbTZrKzFjV3Y5?=
 =?utf-8?B?ZXFPRm1OSGxBdjgycFdzdUIrQlY0bnpqTHl3Znd6dFNQUTRiVkJKSG9vVC9L?=
 =?utf-8?B?NlU1VEEwbHJ0ZTh5cVNOM2VjN0hjWnE5R1FrMG96NG1HUUVUMEJiRE5HZGRM?=
 =?utf-8?B?azdxQXl0WENrRXM1Q3FQZDBJYXI4Q1hORXhVcUZRK1RvM2cwcnM3Yngvb29W?=
 =?utf-8?B?NU0raTBKWTZWc00vcEJMRFFvd0dQUXBoWFhkVWVqTkpISVVJaURJdGNKUWVx?=
 =?utf-8?B?NmJXbTlhVG85T3p0L2tWQlRPclFpSGhmRjNkeExGblBFSGFDWGlsOEVtT1dR?=
 =?utf-8?B?UXdiUFRjTEM2aFRjOHZDSlBacEpuLzE3bFZLSkYrWTB6dmNuc0gyNUxKUGdV?=
 =?utf-8?B?ZUQ4ejVHMFIzek0ySzhPV3hESzhjalBTZk5KY3lUeDVydjk5b0hDQUVXRXY2?=
 =?utf-8?B?ZEJ1QllmY0FSODE4dEtESERtd09YblBwb2E2b2d1RENNcWh1NDJyTjZ3bUpj?=
 =?utf-8?B?K1YxckRDTjZKcFVseWIzVTRtMnU2bEFMaUJEeHlTUnQ5MU9zbzlUL0VPTHFs?=
 =?utf-8?B?TlZsLzFRb1pRQTR5SzY3WDkzaFJmKy9NdEZyWXQ0MTNHaWYreWpvczdUVGVH?=
 =?utf-8?B?NXBJRjFHcmdrZGhtSiswYnVZcEtTZXhud2JWaXN3RElyVVQzbk55eFMvUFBk?=
 =?utf-8?B?R0l6dW5NRUdya25pRERqNkRYUmRVOVA4QmRPYVZrcEU3K3RHQVpEakFmeXZY?=
 =?utf-8?B?Z1JUMVhBVXBxSlZ4ODBSVVlmZlp0K3djVVh6WFphVDNXMUJSMG1USWJyOExF?=
 =?utf-8?B?TVBtdkVIMlJ6NTlCVG1qWUJSRktMemF2cXlNQ0N6SFVmSExmZUlYVTB6Uy9o?=
 =?utf-8?B?VlpPOWJDMFNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1VrQldINzNVYStYUDFUdVNYeFU1Qzg0QmpTNnh3OGhoMkNLd3lyc1V0ZWdX?=
 =?utf-8?B?ZkcyZHFaejJ0MHJSZ0k3LzZHZ0tJNkRGTkxkSS9WQk16ZFY4S0lBbzk1amJt?=
 =?utf-8?B?N2JlVC90K0k2dDdBSEhFM2JxdEJlakFudTVKbzBOL1E5Q1prNVpjSmtBTlMr?=
 =?utf-8?B?TVBKYWZmeGRqRXh0SDBVM3R4dlVjNTZWZW05ZWRrY1RRQmFoVzRLRWlwT004?=
 =?utf-8?B?c0k0VXkrMU8wakE1R0hXTWJrZW9CeWRvSk5aNDVKRGhSOTdqVmI3WEVhVWlr?=
 =?utf-8?B?TDY5aGhzQVovZ2VQOEpJaUhRT2dXWHNkSjVpRCtJUW5Oanp2dk9XY0t0Z0JK?=
 =?utf-8?B?UENKeWREMFZUVjBrQVp3ekNsMWFBK0NSQ3RNT0FVNmpNMmsxbUQyVjg4aThz?=
 =?utf-8?B?dG13VEtLS0JLd0k3VUVPUFFWcGhHUEZmZHlIcmp2cEcyd3BUeTEyeHRvQ3Fk?=
 =?utf-8?B?OGxROWRUME43TEszR1RLbzNFcDFlL3NCL2ZFbVZjSW5WdzdyRFBFUkprU1Br?=
 =?utf-8?B?QU50alBpMng0VDhQSnNFTk80cUhielpCUTBJS3ZHQUhaSGZveW1WZHh2NG5p?=
 =?utf-8?B?cHhtTUJhUWZ2ZjM1Um0xRnkxSUxBaTRVUjdCRXJNbTZHNHAweFBaczhSNkpR?=
 =?utf-8?B?R0hKdTA4bFNmUTVyeFVqMFk4RHIrMXY4bzlNL1BlbTRmanNDSFpFRkxjek8v?=
 =?utf-8?B?a2FDK0xvelp2dHc0a1Z6S2t2b0lmNVY4T3U3S2p1bXFuaFZCay92cTRsek9U?=
 =?utf-8?B?dGdyUU1zNkI5RWtGcDlzTmZvRTFpak1VZkpSM29ucVVWQTRaTVhtdUhncG9E?=
 =?utf-8?B?ZVpIdU1CWEsrNm1OUHk4MnB6YjQwUGFqaVNmeVIwSUQzK1k1RkNMODAwV2ZJ?=
 =?utf-8?B?VVJKektvekE4eERXdEowRU56eVk3eXBJUDdKSkZKWkgvaHRUSXZuZEVxL3Nm?=
 =?utf-8?B?UG4rN1JiK1hoRGh6T2NBNVl5MUF5cXlmcDhTWHQ0TlVGWlVtUDhqc2o5dExN?=
 =?utf-8?B?c2diamxxaElLSW5hSjNOT21SMk5HOGlmTE5aRXArelNnWmx0RzNITjFQVTdK?=
 =?utf-8?B?UXVDWmVuZjk2ay81d3RoY01QQkpyeTU5dkt3QnRFRVgyeXZFVU5FMldaMHk4?=
 =?utf-8?B?dmFRdDY4ZUNRWDNmdW1LSzlsZTd5ZysveEc4ZXNEUUhSNTl3QjVMcUhDN3Qx?=
 =?utf-8?B?enJOanhvTU9TZGdpbU9MZmtRMVBMeVZqTjVMbmN4cjBNWUY5ZzN5eDM2RGM0?=
 =?utf-8?B?OWhKcnU1bStZT3N0TXM3MDNSSTB3bkJaYW02QjA1SktDN1hackdKamxYWGo5?=
 =?utf-8?B?L1NpdGVKTHpXYWhSd2Q3V2QzUWYrQlhnOFNGcnNwaE9lQVJ2eUtxYkpPak1P?=
 =?utf-8?B?VVFCMkVrN0NkeEw5dEhQWW10bFAvNkdpK1l4bFNPcDBYbkNnd0pwWUgvK01C?=
 =?utf-8?B?VVlaMU5qTDNGS1hYYXhWemV1cWs2a04rTVVxRUkxMEd6TzhEamh1N2F3T3Ni?=
 =?utf-8?B?NE5lY01LbE5FeXA5TVRQajZXNTNCNnRuNk1VdHhReVFKN3lOOS9hYWt3QUpZ?=
 =?utf-8?B?WjBQMngwMU82bkNCVUQxOXF6em9COGZuQ0RNc1haYTdRNUVPNHE5R051d2o1?=
 =?utf-8?B?T3JqQVpLWlpuUDB2LzhtRnA1TlFxU2JrZXA3WExEZnJqcHVSV2I5aDU0aTBt?=
 =?utf-8?B?QWVDajkyQXVULy9Idklpd1N2UTdlMDNRWUJaTVdCQ0RrbUE1OEl2UDgwU0Fa?=
 =?utf-8?B?SjY1SDNkYUlUalArSnVQVkZ0YjNxMTlNMWxHLzlabVVzeXJpR3BzL203bFY0?=
 =?utf-8?B?dFZ0bGlPc2t5aFVGOEVsaC9WOVJSbkFQdStSaGxOWmE5TERuT1JnelUrcG1J?=
 =?utf-8?B?b2Y1SExKTWZoemZ1bXNTajFHb2FzS1kvZEEwWVhNQkZkZTFYb2VLSzJOR3dr?=
 =?utf-8?B?cTlLS0Y5a0JKdmd2RllTdUlxOTlpQVRtNnd4RTA5Nk9WZHFGL3RnQksxak5E?=
 =?utf-8?B?S0ZuNExMNzNKWENXakd2NGhVVjQ4d3BuWEQrWEdXaHlhQWd4M1UwWTRCZjRC?=
 =?utf-8?B?RHNveXl5M2l5NmpZYTJKcHFoSUkwU2JrRU52T1h3Y1J2alE4Ry9ObWNlVUpx?=
 =?utf-8?Q?5cx9DhaDVsFdcv1Z/BYqELLNm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 828a4c9c-49fd-48af-976f-08ddbea7349b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 05:12:30.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXRp4tdhd9bjyOeVEeFMCYukeKU7V2kNmw4Fi+Y5k1jcFRvftWmWv+49LkPd8fK3ew2r8hNSHHMQnxPer/LXzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
X-OriginatorOrg: intel.com

On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:

> +	hint = get_kernel_exc_address(regs, &exc_addr);
> +	if (hint != EXC_NO_HINT)
> +		printk(SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint], exc_addr);
> +
> +	if (hint != EXC_NON_CANONICAL)
> +		exc_addr = 0;
> +
> +	die_addr(SSFSTR, regs, error_code, exc_addr);

I see a slight difference between the #GP handling and the #SS handling
here. For the #GP case, we seem to pass the hint string to die_addr().

However, for the #SS, the hint is printed above and only SSFSTR gets
passed onto die_addr(). I am curious about the reasoning.

> +	return;
> +
> +error_trap:
> +	do_error_trap(regs, error_code, SSFSTR, X86_TRAP_SS, SIGBUS, 0, NULL);
> +}
> +

