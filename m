Return-Path: <linux-efi+bounces-4071-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3370AF02F5
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 20:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D7D7A8831
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 18:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C7D2797B2;
	Tue,  1 Jul 2025 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFp0nTa2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE53225403;
	Tue,  1 Jul 2025 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751395454; cv=fail; b=Rd+1+C9VVX3BG2t9xrEKHtMg8WslddJprzmjil8KCCRETc2Ro4zNX4pfsxZtIZKh8oWOsEFZW+D52G96m6TFcdKgGmWB/Kmxiyn/BoQoBOw4jSXUNJKrdS00GIS1f0mAQ1hsPsogE52J6UvKSFSzNFFeHAdgmscwnH0DkfHPl28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751395454; c=relaxed/simple;
	bh=4vZhtMR2w/Q4DvPkZtjaWTlvY/ikUSOWqk/P0w1zkqY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F4SqSKjiVPyizg4FepnRoKUCZZaY7HyF5rSHCkje38ewM9qnSWwdlILIYymFh5Rw5RfRe/3FLvrulXcj4cR55aOGk87Za4C0slW8FJC3C2ZkuPCXi5WKgFasOG06O4i44DzCmMUohyWB+LOq9gXL/PltWvhxt9I9PttcbUQGCl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFp0nTa2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751395453; x=1782931453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4vZhtMR2w/Q4DvPkZtjaWTlvY/ikUSOWqk/P0w1zkqY=;
  b=SFp0nTa26HQ1XlAHVgLQ4HvXSZYJJgiuAZoz8qZRHJB9haD+ip0CjtWx
   YXo158C8MgldRHHLiNBoWA87SuYNvZLemeLu74fBsajkAJxNPvJi96CVD
   3GcGp0sNXp7IsENV9zrzccDUhbi6wWxmtB/IUSkFN3meXr9sLXyuAUbi9
   5Mm2faWwEIIAkj1YkSSLczSzp1kHox2DMF43/aKw/5iAb+4ZT7vDosfWS
   mz8062PX6BqO7UOwjgUuxwgQBtXsIw6D7hn7MJvDLu9tz5sbl3ucmGfZb
   f6jzHBGTFdDForL35FyaKpdbkMamusap+ic6ptj63kyRzO1icb6rfPXVM
   Q==;
X-CSE-ConnectionGUID: zCuwCRSTQYmeU9MktJT3Wg==
X-CSE-MsgGUID: wQRpI5SiSPGlY2+XvymtDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53538687"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53538687"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 11:44:12 -0700
X-CSE-ConnectionGUID: pcOulHiwTu2TOmlsNPZydA==
X-CSE-MsgGUID: 3T3yc3avQLSYM52hEbWsRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="154577128"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 11:44:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 11:44:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 11:44:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.68)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 11:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhvU8a7lQVLV18+VFkuNbCqM8rbcO7HmAPFr81C2f72zkpw35bph1YlyjEV8z93ACmPBs+uQr7rBx3SbjGtgIpO7qbVtWjG2KGdrj2YSFMrodCxi6e1ShQgw2qm06BcunKWCgVX/hk2E2H/F2hOhyfMEk1DXw/tVaoDsdOcofksseN8gtrvK0zZHB733bIdj0e4N+k39MJrv7CgCN9CLQYu4F+pYXQDP5uMrrsNA74M6svDJVm4xhKKoohvx630mDUUYpdvU/Zok1yc53TpBsxmAMWi4xdlpkv+72EXi6h5oVLNU1SHKzL+abnwBYQv0sULxEM410uJ4vnwYYM8DTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fz8xUlbBsOpxMuIpQTuoPDblSKbXa4md9/NpFwvuy3I=;
 b=PkRbwHdol9UouBHjESnQHIkXpGZeY03hLibsJgU/1SsT0+NDaNAaofZO5Y9YHPv74bfmAhecT0V7iVWKOqCifM7sd6HuVT7TLfuQHqVP329gr7SwoaLO1YRcCXfyz9CEmqGzWhZPEZbGBVciKDXZ/0kEId5g+aJI1jx0XcW+N5q8Cb6A7wMOU8RN+DBG9JC3EbDMD3sLn9+rQkpJAqCwq5DRdh5WrY2xW15X7RzpSfcY4BYOskO6RIgS0XQvSg3Cx/jaGx36VJE9qFbRdxiAKwnB6pN/LJH5a5iskemV9dZbf1f5ymXFxQpTQvdwbQlwaKxb8gVlJX7KwAdZKR3ffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BL1PR11MB5302.namprd11.prod.outlook.com (2603:10b6:208:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Tue, 1 Jul
 2025 18:44:07 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 18:44:07 +0000
Message-ID: <fd8c912c-89d4-4933-a3f8-f0a38a3c3482@intel.com>
Date: Tue, 1 Jul 2025 11:44:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 03/17] x86/alternatives: Disable LASS when patching
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
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-4-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250701095849.2360685-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40)
 To BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|BL1PR11MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: f33b8971-ca54-4a6f-04d0-08ddb8cf4283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWVBblFTZmp6Q2RhRXIzVWxwT2dxLzd0MDVjUEJ0V2k2VFBUejVSemlkNGp1?=
 =?utf-8?B?SFkwcjRDSUxGL1NEM2ZhMUFzQ2hTbkhFa1hnRldLcHd6dlBodEhkcUYwNHlU?=
 =?utf-8?B?ajFpMFAwSVZ4V2dZWEVycGRrR00rcTJiaGtQdDRLSmdkQmRHMTlLSytJUWRO?=
 =?utf-8?B?eWpRWWlXWXlray9rSlU1anNwMzZybi9Ec2JKZ0thYzRvK3hDVzYzMWpOd2Qz?=
 =?utf-8?B?cTIxenlKaUdlcFhKNzVzMTJXMTV5S3c5MEk2UjFIbEtJeitxdE9iUEdXazVU?=
 =?utf-8?B?UVZoZjlUYkhFWXZDQUhuVUpXUXNNcTBqZTliTEZrMk1vZmJOeEdBYnp4eTNP?=
 =?utf-8?B?dHYyVHJnOTRjdk5VMXhkNng3aEtlZUNrS0dicnZYckV6Y2VRdlg4QmNwMCtl?=
 =?utf-8?B?TWRwTkpnU1VlTEtKYjhGKzhjaDJPZzNNTVFKN2hhRU1wLzBPcVlMWWFuUGt5?=
 =?utf-8?B?ZDBGN1MzQS8wZ3NkVWRBYVBVZmVVTlpTbUFaWENwTCsrU0NVOEh3Vzd1QWxO?=
 =?utf-8?B?NzhDOEFLWXNrdnlvRTBHMjR2bDFPTHp3Z1ZDd3k5M3BpZDdLTTlHcVdiYWpL?=
 =?utf-8?B?OTZwRllPQmdreFQ5ZXViaCtVemJXZ1pIclAwaUlZa0JKbXFQLzFEL3grRmdh?=
 =?utf-8?B?TVN1c3I1WVViRVJNRVl1eTZOek1KVFgrVEdIL3JBSm1UalRKVVZleFN1eU9i?=
 =?utf-8?B?eUx5amh0RVp0TzVlTjBFSUdjVTVLaDNFZjd4TmxvME1HTWNkcThmWktZNk1v?=
 =?utf-8?B?S0hvWDhLd1EyZ1dTMXhQYktCWnBXM1Q4REtBcC9jbld1Q2l4U09ETGRTcHM0?=
 =?utf-8?B?M0NHNmVBZUU5bmZheTdTMHdRclBmWDlzTlltY1R3RGV0N2MvbFYzQmVVZlly?=
 =?utf-8?B?U2lWRHZaMS9NRHprY0JiNmVnbE5YbE1KNGd3eHJLY1pQLy9aVlhPNjBrcGJa?=
 =?utf-8?B?NU5qSVlHSmxnQnhJV3ZQRUp1SnB5d285VXNVOGtEaytqeC95YTFzQlhHZnBS?=
 =?utf-8?B?ZUI0TngybTVZUExtZ0FEYmd1MWk3cFNWTzVmeWk3bFpRdVVhOTRlaGs0cjFn?=
 =?utf-8?B?WUFsbVR5WTdyWmxYbzdoalZ2NkZSSWl4amp6Q0VzeXhVeFAyRGJBbkxaV3hw?=
 =?utf-8?B?TTBwNnNGMlZiYzlUNi94d0NJZmxwSVNQVWdUKy8wUEdvTlJkWnlQQ1BFOTBy?=
 =?utf-8?B?bzVzZjZEcVhtNE90eFczQUdET0xaWWZVQW1ac0psUHBCSk5JcU9lTE0wUkw0?=
 =?utf-8?B?anZiT3lPbkRWbHFjUEhxSlVkazRDeFRhYzFzRUpkb2wxNFZaWlIzQlZSQ3FD?=
 =?utf-8?B?ZU9IUTMvYmJOTzFZVk05d1kxYjZpTVRYVGRWMDFRL2VVNjcxNE55RHhOdkdm?=
 =?utf-8?B?YjYvcHJpY2hwZXlOTktSVDNHRG9vSTZ3Vk5hZmJLVUk4WWxQZmpDdmpCUU9T?=
 =?utf-8?B?Q084aS9aRkFXOSsra3FnS0xJRnJWZVMyWlh2VzUzWkpzUklKcm1DVHFmZnVF?=
 =?utf-8?B?MzFRU0RicDNIZ08rWGFwUXdWOGlNN0lQNTkrUkVjNVdBV3BZQi9raW4zVzNK?=
 =?utf-8?B?SzIzN3J3RTV6NUtxeis4TTdwOGFkQnV4L2labVp2UFpKL0YwWEdidWZiZ1Y5?=
 =?utf-8?B?QXJlMzFaQ2E1OFBva09qTi85WmNPNVVMLzRYbE1rM2xxWWxjQlcrTXF4cnE4?=
 =?utf-8?B?SEdxSTlUYU55KzU5eWZLTnZQVkUvUjJUT1ZMVHk1M2JKaHRHcHRRbDlQcnpN?=
 =?utf-8?B?SEpXOGtlM3VEekhEK3FjTS9FN2EwWEtlOTdLelYzV0E1Z2NNWjNiZnZWWTFD?=
 =?utf-8?B?SGdRc1k4M3VsdHp3dmhET2FZdDA2bGUydFJUTmVWVk0ra0pkbHJoSjhPcG1P?=
 =?utf-8?B?M0tyN3l4YW1ZZzV6VUZpR2RDZ2hlVFMrMldLbUR0dEg2M3FQVHFWNUh0NHR4?=
 =?utf-8?B?c2xxSGRab0RaNDhaeHlXOXpRVVIvMWxHa0VLeU9ITWlaR2V3ZmhZWms0NUVv?=
 =?utf-8?B?K1lBelBKdmZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXNMeGpySXFSTlg5dkRMVDF5TjRHaEE5MGhuaHNSZW9pR0s1U1Bqa1RxUUp3?=
 =?utf-8?B?dzBCSlIycThDMUZsOFJkVUgzRU1jZEpSRGozRkJDaGhoNlhWTGFuQVgzUm0w?=
 =?utf-8?B?ZWZCV0tsSGlOcDJoaFVRQ2tqakRreFdsVUdvcEsrdTZmK2UwL3pLOHJpVEhD?=
 =?utf-8?B?MjNMNVkwcEhEbnFiRmlPRjBpMkRGY3ZTeGZIYnlKanZMRG8wUGJHL2JOVDY1?=
 =?utf-8?B?SE5EK1B3L21QQU55U3l1YzFyOUduVmNEellnTmVnbGRYY28yYTZuSXBLaVFt?=
 =?utf-8?B?c29KK1dzSmFtZXJtUVh0K3Y5TGl0RzM2QjJITUlvaTYveUdIWHp3bGFwNUti?=
 =?utf-8?B?eHJkVkk1UFdqQ21FcnpheGg2djU5RkVPVXFYZnZYb0IxZTJaSUc3RjRQamJN?=
 =?utf-8?B?eFBhYnZSd0tLbWZmTVdtdTQwQTFxdzhkalpFMDlFcEs3MnJsUFF4aHZPNlY5?=
 =?utf-8?B?cHBYVUJxdHArUDBFeTNaUVNrWGhDR2JNZzlVUHBINkhJbjBHUnp0M1AveU9q?=
 =?utf-8?B?SllRU0J2MlJuakJoYWlmRG1aTjZEMXlYNnNFcHNvZFFqelRnV2FjTTVia0dF?=
 =?utf-8?B?c3BwTUR0R3FpWmIydnhaMCtCZTQwb3FMK1ZkbHlUbWNmcVgvWS9idGpXY1Mw?=
 =?utf-8?B?ZmhpRkY1QytlRTBwY2xmcW5jOG5XR1lTL0k3bVNsTnRZdjRlUmZpZlBPcmNi?=
 =?utf-8?B?eDFFU1NWT2RXWWRvcFZjcnFnL1BzZS9iUGtqR3ZZUE9FVVhzVkRnMU4za3JT?=
 =?utf-8?B?T1AxUEQ5TmF2ZjVSTldBSkJzUldxNFFZZGxwMTdLd0FqbzI3OEtXSGxOM21o?=
 =?utf-8?B?QThsS3IvVWQ0aWcvY2F6WXhKV25qWmdTNTB3VkdvdmllNmM4bWxVTVYyOUts?=
 =?utf-8?B?bDVpM2lSWjZYVGZES1pJK3NCeU5FVmlsc3V6TkphWjFvQW1wWFVlU2dxeW8y?=
 =?utf-8?B?L3dFWEZRM0ptOXdoT25kMEt1UmhtLzY4dGdBVHYxT1JxRXZPMlFjaEhUaStZ?=
 =?utf-8?B?Vk94VTJKdUVMK2VjNkhmYnlwUXNoTDFWM1FmSEFWWUtFMmNzMFJEejBzYzM5?=
 =?utf-8?B?NjZESHVrd0RJenZSSGpCR0tDZk43ejJVamdpeUNWY0dtVytTZm1nU1FvTHQ4?=
 =?utf-8?B?cllNSHB4RlNoYUlvc2Y1R01HSkp4WDVxVmZRZndtYk9YeDV0QkdzekFGZmVM?=
 =?utf-8?B?MTZ1eHg1YWZ5b0JBRWxDelFhb3JSZjZqK1cyNllRVkN3N2JmajJ3TjdvQXN2?=
 =?utf-8?B?aUxGWUVJQzY5ZTRNUDNBeWlHVnR3Ti9Lek9yV3JqVzR5ckxZRUJzNUVjWkhG?=
 =?utf-8?B?TkpWeW1sSUMxOG9vdm4xNXRkVmU3TURjbGdWdzRJNWtqelZRQ1prL0FWWGo4?=
 =?utf-8?B?MVpQUEFSS1hrVHBzYXJwN1BPSTBNRHdDVmRKUkNETEN3WEFWVXVsdWV2Vm5C?=
 =?utf-8?B?OU9oM2ZwWCtubmJUSllIMUhEbm5QeG1nSzllMlU4OUlTcU1tb1NwOVRuSkl6?=
 =?utf-8?B?STE3NFN4cm1WSW1IZGQ5QkUvekNjSGVXTE95MjBIa29uS0lPakdoc1crUUo1?=
 =?utf-8?B?a2hMTTJiV3ZPMWRhbzdyZEFyRTBnZmNORWR4Q0JINGpqZUpMWU4veE5wdnIv?=
 =?utf-8?B?MHJRc1gzQXJTNzBSNC9KdlMrMzZJbVJFUW9NQWZvR3pONFVzNy9DMjFwVkdk?=
 =?utf-8?B?aTRlams3VWlkTkdVaWxRZ0Q4RlRiWFBrWE1mUHZVWllDcDlVbG9ZbjJibUlR?=
 =?utf-8?B?Vmkxc2pJQTdSSDQ0Z2Q2Y0pDNUwyakM1N2Z3bXV1NFdUeXVVTVFub2ZlWHRv?=
 =?utf-8?B?Q0liTHBURmM3TzhlQ0FNVzV2ZXRwdnl4bldKU28rUVZVQ1NsMTlTcEJOalgw?=
 =?utf-8?B?VnRMK3dCSE5qcFNBcGN3Q2pQSnZ1SFZNUVZJRW15bTFhRXVhZmEzZXVIMGQr?=
 =?utf-8?B?NlFaVm1hSCtIRGUzRkxYU0x6NGhraUJYRlJLWWVPTUc2MXl1SThJSTB6ZE51?=
 =?utf-8?B?bk1say8yK2NKR1c4VHdaZk1FV0QzK1MxMnhTdWVFcG4wRzd4ZTNWc2swSi9X?=
 =?utf-8?B?U28vaVZSM2JGcllzS1ozV1I4Z1ZGOFA2ZHlqQTQrSlJ4RXg3S1dweHhFYXBq?=
 =?utf-8?Q?AZGHfdrrw6Ub3hqFnZOs7t+KB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f33b8971-ca54-4a6f-04d0-08ddb8cf4283
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:44:07.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eso7DAdBRCdJhudcSLt5CSLnLb8KAebutpaMAB/i3weEOQjwbr068nMfeHIBGCa6/xoK9E3hLvsBFkBjSLb/HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5302
X-OriginatorOrg: intel.com

On 7/1/2025 2:58 AM, Kirill A. Shutemov wrote:
>  
> +/*
> + * The CLAC/STAC instructions toggle the enforcement of X86_FEATURE_SMAP and
> + * X86_FEATURE_LASS.
> + *
> + * SMAP enforcement is based on the _PAGE_BIT_USER bit in the page tables: the
> + * kernel is not allowed to touch pages with the bit set unless the AC bit is
> + * set.
> + *
> + * LASS enforcement is based on bit 63 of the virtual address. The kernel is
> + * not allowed to touch memory in the lower half of the virtual address space
> + * unless the AC bit is set.
> + *
> + * Use stac()/clac() when accessing userspace (_PAGE_USER) mappings,
> + * regardless of location.
> + *
> + * Use lass_stac()/lass_clac() when accessing kernel mappings (!_PAGE_USER)
> + * in the lower half of the address space.
> + *
> + * Note: a barrier is implicit in alternative().
> + */
> +
Thank you for incorporating my feedback. I like the updated wording.

