Return-Path: <linux-efi+bounces-4197-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6155AFDCDA
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 03:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5E94E4EB7
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 01:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0393153BD9;
	Wed,  9 Jul 2025 01:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/JmAT3t"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C3502BE;
	Wed,  9 Jul 2025 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752023953; cv=fail; b=gKshAZ/QK2uF2lcshU62PdAuGNZ5kBjVkjbNNoxoujggbjWIVTMW87z3UGZdVChBnxuwGrzDzcFhnN6qKdu9v4pHiBCZMB1xBLzVSRv710En2X0NoA35K10KUYpMzIkCB6S/aQLtkakFZlHoHNK5XJpVzd+PWf+UPImk07P5+5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752023953; c=relaxed/simple;
	bh=bKnPu0JfLS/MZaa7Umm39p/tE3wy38wNEbK8Tg2v4CM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PW45+ib1uigcurIQ0GEENxIdj0TZUTeYHBW13HD1eiBQlyYAOYs1aGjsWp0r08lYCGHIcgACAPdE6/C2N5GAzREQuKatu2qFbePR3NxNIc/gSWNiNlWiSBDW2m49Iksz1vyZYXrlEhJI3ZKG9Dub0OITZzFwF4ID4ODP1/Zaa2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/JmAT3t; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752023952; x=1783559952;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bKnPu0JfLS/MZaa7Umm39p/tE3wy38wNEbK8Tg2v4CM=;
  b=k/JmAT3tIa0VTe8Gy+x33bK7N13vTx3OqGxs974XwDtRjjKOl67DqtdN
   rSKLapF91MVbLHUcOF3jDrFPf4RmKBlSkS84G3gc9WVo67XVkgaOrvBZr
   Ixu+b3wv4yPJS5D3DD0WzIqFRW/YBF1vv16aPPGvCRkEra0gpcl7Qg55H
   oVETWZGH5DJqvA/KtkjurFQITofvp7jalF/6IGnPHIawRKvcbvXQeWaBQ
   5I3YtWv59f1z4KfwDKEACVdt+yuqCDBWmjDyFJuMiDmRRK0mRjH6GI3KX
   PsDIZ0u8gu3GdRDe5caCi+XJ6fDSeZZ4n9m1jXBEmKfbX+mmxPVF1FLmR
   A==;
X-CSE-ConnectionGUID: 9a/DKfiWSI26IpYtscIwfw==
X-CSE-MsgGUID: m6OUobVwTL6BGfx00AWyYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76823035"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="76823035"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:19:10 -0700
X-CSE-ConnectionGUID: goCNWKoPTIGXCIiXjjvuVw==
X-CSE-MsgGUID: AR62oPrvSrWUWUhY3aw2bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156370570"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:19:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:19:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 18:19:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.60)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QANvp3q4EJbi4PxfBrS20iPp2ZhHTWDNZ8f+H/4TpOafKLc8H/X8c+G55Aj8RQA/DDmD2ziHmCGsRhNBIe33ODFjA6G5ipoYXVvGSytWYQB/8pP0WGMYtfGhB8gHvJtnMysgpPG+wM5bnmycyRuF3hRLXvj9FtryjrJ5bEsLmAJ6Db7L+iRNoYrdXn4BdvzwExiq+9k0zxfjIvrzB3klrflWR/jdnfGbeZB4nFpVAic50+biRnSK1054iPIlJnVWAA7YrvoIV3cBVp4srjdL2bFXDHD21garpfcFapvSVMlKThz89kV53RQOX+wwb6zmtUV7WGG8f2oWbHDPDRxbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqU7CE/rU070R+3I7Fm1G48ckA+n7Or83bfwF1YLSl4=;
 b=kkQunKYcR0u/kPgA3JDwvR7TY8dPNE+BGajkIF5tIzH1OmTCyVNJrWzY19rD0HdbFVOwLfae+jL1GyZ9XflZsPCMTDY5g3cHXztZ9zLDw1CGf2h2P9S4eJsCn15bOFuyCd8jRB3WJ6y1moxBVTAzQp4zdgr5I4bd0fnl29ISzOha93st8CFts+P+ToxLuS6AM7EXm/qGxpcJs6F5JlFmOBXQ9zFoqHobMB2kWFMAZx65dEA4WRvRScgd0qV4xEGmxBXKXuJo+wtDFiL03WNTjO089LcsV4Mv0/mjUKl7YwovVKoGvQ4YDn/+/OMKKuzEGsZZDcbixcSTtU7yNBk0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW6PR11MB8439.namprd11.prod.outlook.com (2603:10b6:303:23e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 01:19:05 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 01:19:05 +0000
Message-ID: <9340dc9e-bd4d-450e-aa9b-b6b6829eab32@intel.com>
Date: Tue, 8 Jul 2025 18:19:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 04/16] x86/cpu: Defer CR pinning setup until core
 initcall
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
 <20250707080317.3791624-5-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250707080317.3791624-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:334::6) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW6PR11MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f3b195-3bb2-47e3-084d-08ddbe8698be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anA2dGtQNmcwVndSb2RNR3dkdmd2S3k4RGdEUFprTzJIOWllV21PNm84NSth?=
 =?utf-8?B?OTF2bWZzcHJYcC9jSDF3ZkVUMk1qTnJFcjFYdXJrT2I3U0hOS2tNVENuMHJr?=
 =?utf-8?B?Sloya2djNXE4S3MzR0VTTTREUExGVHdEZmlrQW92eFlYWCtCRHB6T1RkZ1FH?=
 =?utf-8?B?TW9INjRKTG50emU5SVVsMjhFYjlCK1NvV3JUZmp5dkF2YlFhUGpqL0RVTENY?=
 =?utf-8?B?K0lLdFMrWjJTZnpIbzU3U0wxOWVoVEp6MW80U1ZkdTdvTUFTRFZINzQxYndj?=
 =?utf-8?B?NTZZS1B1aWUvcnFuZWNwT1BHeUdFbjlMbjB2blpmMjZHaHVaUjdLZ2VlenNN?=
 =?utf-8?B?Rlk0dnQ2OHlKcUJ0RFprTDJKMEVGUUlOZjIvOVhkS0JPZER0VmRHdElmOWFj?=
 =?utf-8?B?bGZza056RFQ0S2FCMzFwdFNnTm5GOXdIV3dDV0VMTDlRMUQ2dXJJNjNYWnRB?=
 =?utf-8?B?cTl3MGkxU1F1TjNOZzBQL1FuTkJUUGpRaFZrRDRkVjQ5SzBVcHRBcUd4OGVU?=
 =?utf-8?B?alZDTU9ZSWowalVWVmp4em5xUFQ0K3ZDeWQweGFnUXc3NDVqelVuVVB2VFBO?=
 =?utf-8?B?b05ZMmNUdjV1S0NKK1pDTmxZS2lRdzhReUYrT3Z0b01ibUtqend1MDlsNDJW?=
 =?utf-8?B?OE5adjRHK0s0YVJ6bE9rSEFSajJ4dTVxVmN6QlE5WWZyMWRucWlabDV4QnBu?=
 =?utf-8?B?MjhRalM3czJXeHNUS3hhcFd1OHN5Z2VlNGtwVmlpQkd4alBRSjJ0dWdsd25D?=
 =?utf-8?B?cG5ja2RtSEtSYlRjNXYyWWNUejYxK0hxOFExTXNNWUdEMFVYcDJ0TnBaWXZ3?=
 =?utf-8?B?UmdQZmVoMXVWTTVRNTk4OUh6Wk1pK3lwYUdwMm1RRlVnK2srclZKTVFPRVJN?=
 =?utf-8?B?eDFxN0RWTzV2RTdEU2pHL3VCTFJiZnd0Y1hyWml6c2pQNW9ybUdBZklWWW8z?=
 =?utf-8?B?ekFucmYxNEVkeDAzKzRhWnpSTHExSWphWmhHQjJ2R2JyamI5R2t3aGYzQ1ZX?=
 =?utf-8?B?c3NuZDRlUWYrcVNhOHdRT3h2c2lKUElSc292ZnUrdnZ1aW9vRENjQ0JOQjdS?=
 =?utf-8?B?T0JVbG9Cc3ArOHlid2JmYkhPS20rVXVpWGQwWjExcUdISFVaSW5FZHFqOTVr?=
 =?utf-8?B?SjdVUWpvUlBaV3VIV2ZYb1FiT0FDVG4walhwMXMwR2NzY05lRlYxYmI1QWVi?=
 =?utf-8?B?NVltaWorc0JoVHYyUC9MMmFRMjJ1TElsbU9Ec1NibCszL2NabHE1UVdSR2pl?=
 =?utf-8?B?MDJuLyt2SGdUS05sRzJrTFRGVloxSlAxcVJ3aUJKYWxqZU5KZXRtNllFTzZC?=
 =?utf-8?B?Ny96ZkhEemJTQ0t6ZVRoQUJMb1F1NmdkL0swdFg4ak9VSHZrS2U0cTBsZ0Z1?=
 =?utf-8?B?RTFCUm9iUnJIdmdxOUtKVlR5eGJxd3NISExpWEl5VXd5ZkpCRU5VSlNVSmV0?=
 =?utf-8?B?YjVqUE1sZWdsRzc5dVFGeG1JMHIwM1h6WHpXUm1FelZXbUNseGVMVWkxUXpF?=
 =?utf-8?B?YmxFd1BoZzN4NlJ0dFVSeExaRDBESHU2b0NON3grU0wxUEtEcmcvVklsRTZr?=
 =?utf-8?B?Sld3Y0U1S1lLVTNpa0V5aEVLZWpkSDZ5UVpSZXN0elN4dlVhRVJwcS9NNDEw?=
 =?utf-8?B?VW4zSy9zVktLNmdmSVk2TEdWZnNjbXBiODhyQS9JUENiTzJTK0FjY0t0QXgw?=
 =?utf-8?B?Q2VUT0h4WVdudXJCTDhkTlZvdW1URURiQUI3WjFDTlZJY0JReExkZmRZNGQ1?=
 =?utf-8?B?cCs3NURnYnhQNks5NGVJQkVuQmgwS1ZsWEpsSks5MkxvZlpudVB4MEdsbDUw?=
 =?utf-8?B?cFhucnhOYS9tbWlBakhDcHZoYS9kLzFybTQxRVNlNm14dExLMU4xYUxLbThh?=
 =?utf-8?B?bnFOMDNaTCs3UzI5V25NSzlhNlRoMm9uNTdmUVR4TFpaYjZZYW42Vm11QnU5?=
 =?utf-8?B?Z1RMR1F3WVhhT3gweWZiY2daSS9WaElkT2JNcVlRM1dIQjhMTmxLWUR6cTB5?=
 =?utf-8?B?SWF2YnlWVzBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFRnVWVoSmFsd1Irei8rbW1jcFlmTlBYYmFYSksyc1ZnM2xMUk05WStCVkNV?=
 =?utf-8?B?cExjMnFRNVpQRmw4OVNjQmpKWmdzU0VxYkxsS2dQbzRFc2s0UnM3bTBQMXpJ?=
 =?utf-8?B?aW5XV3lyaTdydWgrSDVjWHp3R0hyTkJlWEdVTnpFRHBRd01UQlNJa2EwcVFV?=
 =?utf-8?B?RjBVVnZ4TVhoWG9pQnZ1VzJnYUNqV2NEMVpta2pkbjlXUXhraUYwdGFTMFFn?=
 =?utf-8?B?NTdhOW9TdmVXaDZyR3lZMUVFcEdvUU80RVQ3Zkg4ek9Gcitvelhsam5Wa2ZU?=
 =?utf-8?B?OWpvU2NhbFJmRVdNVUpoVVk1M1ZoL3ZDN0FFSXV1RGwwMi8yOHZVbVpabjd5?=
 =?utf-8?B?dG00emtoUkVYTXZUaU10cGVUUVRRNkk5elpEUnRyVHhqU3NMQVM4OTVVMEZI?=
 =?utf-8?B?aE5McEdTWXRieEJuQ3hRUldNbjQwK0hzZUxFOHorNkJONkp0a29DSVJEcWQy?=
 =?utf-8?B?SWpqYXg2Rjhta2tJOTFqRmpHaFI4STdGVVljZGVRMzAycFRjYk1BandwNzV1?=
 =?utf-8?B?VWZTUjZEWWpaRkNEQU9SREZodDJqR0MyVUdXUUNpY1MzdUNGaWQ2L0lXdjFC?=
 =?utf-8?B?SHFqQlNEeDMydFhiRkZScENEQW0yNXZiU2RMWjBBUXdPSGpvMm9lOXUrMTdt?=
 =?utf-8?B?OWxwU2RwWStLUnpkdW9kMSt6WEZ3NHlOYjhrM0E3K2ZPN2xsd3VET2xQYXdo?=
 =?utf-8?B?OFRSQjM0QVR4ZVhSTEhwL1A2alhiYlpKYmhGOWNNYUE1eG0ySHNUREZRTmM4?=
 =?utf-8?B?d1pHRWJvZlBkdmdoWWpEdWFhZVZIeisvN0lPVkVBbHFHcFMrWkVVcDVreHlo?=
 =?utf-8?B?enZHdmk5WTRTM3lnU2U1Tmh2SzdRQXlQS0pyK0QzYzROZFhvaDg3OFJ6S24v?=
 =?utf-8?B?QzNiR1Y3eHYxNDVJNzZJYWhOOU90aW5BZkw3VG0zYWhjOVNmL0dTUjE1bVhT?=
 =?utf-8?B?QnloV24xL1AxU296NUlCbk1pWncrL094U29aei9PZzVndFBiK1lPK2YvKzRp?=
 =?utf-8?B?TnoybFMvd1pHeDZlOVFFSkFHTWRpc1docktuWHNmMStnTXNtWXpjS0NQb3VW?=
 =?utf-8?B?d1AycEdHVk5NVDlNNmdjY3ArWXNhZ1J6THlQMEh0NEVocVkrL3BUQjJYdnZi?=
 =?utf-8?B?a3duU0RXcS9NVkxYamsvelJCUk8ya245eXJzdnZmZzVKYzdUU2xjZWFJSldD?=
 =?utf-8?B?WmhZS0pudUpWd1hXYVU5MVQyL1VuamZCYkFOZUhwd1ZTNWs1d1NXMS9OcVBC?=
 =?utf-8?B?aTZtdkxrcGJPNlhuOGV2Mjltd3dnVE9BSGV1SFdDaU9GREZZMVBVb2x3NkhY?=
 =?utf-8?B?YmFtZUVQNTFMeklzQklOMm5ianBUN3VYV3gxcnZuT2NrY3ZCQnB6OGQzSzhL?=
 =?utf-8?B?ZVJBK2drQ3NYcFdXcUJNS0VDVHp2Um9hdHJDR0FkRzdDUnpVN3lySUVwQ1Jq?=
 =?utf-8?B?SURBVmhuYkxXcWZpVzE1a2pKbGZBczl0KzR1QjZ1d0pMZ3cvNlg0SUg0UHJh?=
 =?utf-8?B?M1hvZUpWZGROMCtmUndDTjFFWGo3SHJNdTY1R29uZ2ZZQkRXMExaUW9MRWFp?=
 =?utf-8?B?UmxQUmRFNkMwRTVJc2MzUHhSLzVZVWZYdm1LWnZSZWtUL0xiN0hEMFlnaklG?=
 =?utf-8?B?dHZBVXBEejNEUkN0Q1YyK2IxaU5PVkV2QkJFL0N5b2FYVU82OXd6c0RrLzQ4?=
 =?utf-8?B?b0F2VmVHdXdXM1VxSHRPa3hMYVRJNFpxUXhjb3NUWElPb1I4c1NNcCs4Y1Vp?=
 =?utf-8?B?YVVvbFBtV1orcUxzTVY5VXkrZUJYUzd1VmF3NmlhY2w5Tml5RThnUllvNHB3?=
 =?utf-8?B?L1dlQ3V1QnkwYjhPcXhTaGF1cklIYjFOaVg2MnkzUGhnMU9PdVNML01nOGhB?=
 =?utf-8?B?WWRTMU9Lako0Q0dDbllpSU0vdDl5NHJ6SEVBZTJTbmNQcTNqSDROMXdFME43?=
 =?utf-8?B?VTlFWVpyYnFuY1F6Y0I0ZXp5VWtoU0RTVXVyT3RreHpUNXJqWWlrS1NqVlh0?=
 =?utf-8?B?a1psalRjQi8waGR1RlFqeVFRZ0I5eFA0WElmZ3Q4ektWRkFXaXBRNGVQMjFy?=
 =?utf-8?B?OEpIbUhFZTlzZ25GeTdWR28vcUxvbThkRU16QkFXOFBJcWRsS1lIUHR6UU1n?=
 =?utf-8?Q?qYg855cLYCssBeBjrbYCz8Q2Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f3b195-3bb2-47e3-084d-08ddbe8698be
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:19:05.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhb7bhcpAYkZIwqVUcTy9wXonQ4vsYb3Xe6A+/MC+9KI6bQctcpqZRFqdGjyQY5iN8Lf6LT5m7lQXEGbudmTTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8439
X-OriginatorOrg: intel.com

On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> 
> In order to map the EFI runtime services, set_virtual_address_map()
> needs to be called, which resides in the lower half of the address
> space. This means that LASS needs to be temporarily disabled around
> this call. This can only be done before the CR pinning is set up.
> 
> Instead of moving setup_cr_pinning() below efi_enter_virtual_mode() in
> arch_cpu_finalize_init(), defer it until core initcall.
> 
> Wrapping efi_enter_virtual_mode() into lass_stac()/clac() is not enough
> because AC flag gates data accesses, but not instruction fetch. Clearing
> the CR4 bit is required.
> 

I think the wording might need to be reordered. How about?

In order to map the EFI runtime services, set_virtual_address_map()
needs to be called, which resides in the lower half of the address
space. This means that LASS needs to be temporarily disabled around
this call.

Wrapping efi_enter_virtual_mode() into lass_stac()/clac() is not enough
because AC flag gates data accesses, but not instruction fetch. Clearing
the CR4 bit is required.

However, this must be done before the CR pinning is set up. Instead of
arbitrarily moving setup_cr_pinning() after efi_enter_virtual_mode() in
arch_cpu_finalize_init(), defer it until core initcall.

Other than that,
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index ec62e2f9ea16..f10f9f618805 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -490,11 +490,14 @@ void cr4_init(void)
>   * parsed), record any of the sensitive CR bits that are set, and
>   * enable CR pinning.
>   */
> -static void __init setup_cr_pinning(void)
> +static int __init setup_cr_pinning(void)
>  {
>  	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & cr4_pinned_mask;
>  	static_key_enable(&cr_pinning.key);
> +
> +	return 0;
>  }
> +core_initcall(setup_cr_pinning);
>  
>  static __init int x86_nofsgsbase_setup(char *arg)
>  {
> @@ -2082,7 +2085,6 @@ static __init void identify_boot_cpu(void)
>  	enable_sep_cpu();
>  #endif
>  	cpu_detect_tlb(&boot_cpu_data);
> -	setup_cr_pinning();
>  
>  	tsx_init();
>  	tdx_init();


