Return-Path: <linux-efi+bounces-4198-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7661AFDCE4
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 03:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780961BC808C
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 01:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBCB18CC1D;
	Wed,  9 Jul 2025 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sm0iUs5I"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22417156F4A;
	Wed,  9 Jul 2025 01:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024460; cv=fail; b=sVUD2yobf8eUxbP/7Q4RRCCScqIIFwNVvC7jnspVAsIAsTSqMEj5YPxoDfEWOr0uQuIY7mNDPGnM08N/Yxmp6fqAMjbjsDtGj3MYEMmMk5gvRmNsBbtXdZyDvGcg4hqcVpPFkUfuEmW/YovSOa8D5D4XQGR77LQ/x3hlMflmmTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024460; c=relaxed/simple;
	bh=7URCJtsv+9w8Oc+sYmWFVX4hFDwmkXq4CYS5NRlEwUI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QwY4xRcyyCT8AfN2/ylEqnkPNLE2rl5TcLwdC7QEnxKoXgERmeUPZz50Ad6J0qQrB4nrtI7BgV2uh94GDtlHRKuychwxpZOiSiKn+klaCqQqBx/0xko17n3AD1X/UPQIir7V+ParXNyIVlgVg83c1E2k0wRvQn+WJr5GNv2Vr0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sm0iUs5I; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752024459; x=1783560459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7URCJtsv+9w8Oc+sYmWFVX4hFDwmkXq4CYS5NRlEwUI=;
  b=Sm0iUs5IEI62gCJMpDJzhwVjnu1D7YyCmJydIRqT46/QM5A25hlEQELY
   6uYmOPeOHRLvBzorVLCS7h9gfgQGxeZQkRc/LyuwxVklQ9nLdlVBvF1Xv
   GjjQvFR3vpZWo5EjUiuC71hrDysEKP+xu9It8yDhsRxgCMC65S8xGWFkI
   F21AgOgm6BaY8pswUZ+CjMtqs1gBAj7MvQJGtVz2E01ksODD8VX56SkX7
   nnsUDhpaYs/aKiR/FqEEAZqhBHpuUDkD0FwjFfUGRCg51aZSQiYcWkfv9
   UrVozSY6aszobrDw2zURChIDv2E6jz/xuewLgyXPsrrIp9/zY+TWz9TiA
   w==;
X-CSE-ConnectionGUID: A0S5mfpkRfyqjgUiRYs1hA==
X-CSE-MsgGUID: MYkr4ruyRoKZ8hwQbTwqbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64524569"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="64524569"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:27:37 -0700
X-CSE-ConnectionGUID: iMDvYKSwR3W9qgmkwqa8PQ==
X-CSE-MsgGUID: yl9Ti4t5Qa2dXT4SAfww8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160167729"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:27:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:27:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 18:27:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.86)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:27:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0lwmQlgSQDokrSXHypiwKEWBd/wfQwGDuM8ZthkMupFvLM/pzFgUQGHXrs+4QHTQcYECp4DgtWo1L63oEPhWCGPaGRCLN8xniL1BytLH3YFwxFa+9ceEV/0iUiR1xTZY3Hd9pNboNUZlVm7wBvC15y5aa/uwbX+JU5J2BwL7Y9Ax2JUx8/YZ8Ay/h4eW4BRDiILz/vYSotLklAWsvxaYMEXaz+mWgLT0/A5Q+vWGvxw+YgOazfr+Ah0W4CLjnyW5RX1GCEaQBLwAlKYXhn0z0nNvC9SFLrpx7DdlrQRfts2FOsgRpjc0inzGRj23I1aeZAoROH1DmxLpF7SkrUOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWDnK3P1UyutbR7qdf+toPWxiFpjnLbrVQ+MbnVZDrs=;
 b=ecrGzLA1dpT7TLYxD017IJBeQMZ5WLQTgYwVx5AhR69bc/YuF6obavu0W57RhMNa1Ljm4F/0ZifxEbp2kGw8dYYQYZijndSTIJOoxHKoAQujKMqmvufR4pLYP+QBB4sHwZBq2J/eVXsOGHRqBXFsYgT/OcYbzF+UhaumP8+ADwn17TjntRaK5D+hkY5uG17yD2U+PDJOmggcd6bEUnw4PpPg9zcNM4K1vvs0qqbzgires0vuyvQR1rrR1/M6DbDHg7iLGP7HCuCUZDm3sU0/cjXJY12/c2N/gj3yaCTJF6wp8sairRlsmSmul++almcTo1pH/X+bsNHLGAFSJjrP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CY8PR11MB7873.namprd11.prod.outlook.com (2603:10b6:930:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 01:27:24 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 01:27:23 +0000
Message-ID: <c68a7034-e769-4862-ac6b-c38eff7ce92e@intel.com>
Date: Tue, 8 Jul 2025 18:27:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 05/16] efi: Disable LASS around
 set_virtual_address_map() EFI call
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
 <20250707080317.3791624-6-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250707080317.3791624-6-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:74::26) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CY8PR11MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e94711-d6ab-4489-09ba-08ddbe87c184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmtRZk00SzQramhMd1BDU05IZ1hmaGhkcHFYaTh2NUwzT0o4ekdqUEpjTkZC?=
 =?utf-8?B?eHB5aGdBL1RGQVFiMmpPWWdHRzRiUk5JRnpqWmhQL0RvbUZhOXR1enJKOHl6?=
 =?utf-8?B?RjRUTzRlZy9hdXRLMFZ5eHNwM1A2c2N5QU9FVU1EZXdtYjRlTGhuVWFxblBH?=
 =?utf-8?B?UUlWamYxMW1IMTVNU2F4b2RhYTNrNUp2aFNIcUd0MmVkMzlzSXJiUkNRWU5o?=
 =?utf-8?B?NFZaelhlVlo1bzZFd1lFN0RldjhkWEM1TmlaMXBJM2Rqc0VBcGwrK0U3Mk9F?=
 =?utf-8?B?aG8yUnJFdUZWTnExMlBQazVBQmwrVno1em40TjBlVytqWEpmdGszcXZsRTV1?=
 =?utf-8?B?S3ZDL21MeXpsbkhUTEtyUnRJVERIZ3dmZWFxNEh0R0thWkNtM1hlSmNUZDE3?=
 =?utf-8?B?bmErVDAyUjFjeEpqc2FPL1pqaGVXOFZYTXRET0VCM0Y3S2pYR3dsaFM1VS9O?=
 =?utf-8?B?c1R1SzFRRmt5dnZrcEVRTXdzU25XcDlUVkZVWnNhb2dDR3JpZTNXY1VHNzg2?=
 =?utf-8?B?WkJRdUU3TWZHWWtvOGpUWllVSjdCY3doK2x2Q1pxcVlMMmY2OXlPMEh5UUVX?=
 =?utf-8?B?SjZrbkZBYjFUYll0YXMrL1liRy94c1ovMTRIaDNqRGhXclFXaUFnRVdsZ3Fl?=
 =?utf-8?B?WlF6RE9oelF5ajZkV1RaNi9SQ3RTL1NiL3pzZVlxaW85OHRaVGE2SmZLVkRE?=
 =?utf-8?B?aGFWMXNiT3JqV0Z3M1FqR2RNM1BwWm5IaEhyTVpZVHdLOEFScVJkWjhUVSsv?=
 =?utf-8?B?TmV0aHZ6VCtpTGV0Q2tLa1AwYjVpRkJlcWFydTd6Rm5Sb3k2NkZId2pQb1VQ?=
 =?utf-8?B?eDc1MDY2bXB4akJlaUVxZlg0WU0xa2c1Rk9Ma0JheHdQZExSOFg1NVNJb1pN?=
 =?utf-8?B?Q29MU2Joak5adEUxbTZOWW5PSUphVlFoZFZ3L0pwbFJHbkpkK1J3UVBsNzRo?=
 =?utf-8?B?UFBsWlNlQ0h4dW5VZURtNlZlUkx2VnpjcGhlNXV3eFhvUFc4WjdDV2NwVWtC?=
 =?utf-8?B?ZjFWQWF2Nlc0d3lxN1laZmhUKzZPN3dJU1lMbzNsdFVNVHdNaWErZW1qeUFW?=
 =?utf-8?B?THRxeURWcStTV3RyWEYxdzlIQlBYZWNJWTVOV2NXaWlmcVN3NzFMNk1lSitv?=
 =?utf-8?B?YUN1REdjRVpWZDBxak90TGJ2YlNvd1FMT1pDc0J6eHlYdWxzODBMWW9BUTVU?=
 =?utf-8?B?Q3JpU1o1WW9tWWU2L2FtZUFzSUZYSkpGRVIwUER0bGpGTm1mTGhLb1Y0OSs3?=
 =?utf-8?B?VGlYT0lLK2NIelR6dmhZOHVKTzR2a1UvTkFKUm5UWmNtZ2Vsd3J0WTVKWWVS?=
 =?utf-8?B?TUtFY1NNeTUxbG1FT0ZicXpYWTBYRUVneGw3YmtTRXM1SHBjdU5wNDJoNnh4?=
 =?utf-8?B?WjJUUTYwd0NXcXdwdDFmcWlxUjZVQUpRWXl5MURHU2VrTWpyNS9Rdm9QRlJM?=
 =?utf-8?B?THF2T3U3aUVFZ3k1SzRScmM5NTYvNDdIQmhES1ljeXRjZUFtNEhhNzYwRitw?=
 =?utf-8?B?S0VtM0FnZ0R4NEpUV2ZrZUwxdC8yaGt6Wkw2bkg5cFVwbUlKQmFSYWk4dGYz?=
 =?utf-8?B?Mm9sdWJpVGtmZmNWSnE4ZGVqeE0zcDRBSTRjNmdzc3FKNEFRS0pzMUJhSGV2?=
 =?utf-8?B?QWlPNXNXODNPSXdXTVM4M0ZLTnF0Y3Q5UzhnTjJwdzQ1YXlyVmFJazQzZ1A5?=
 =?utf-8?B?SVJSbWllME82RlBLNlJRTEg4eHcyZkdPTDQ1NDJzYXZib3Z2WUYwRDN3a01E?=
 =?utf-8?B?bVZONXZKaktMZ1B2dmlkci9ndzJLNEp3anRiWkZmWU03Umt3b1M0ZDFPN3JK?=
 =?utf-8?B?a1l0TVhKZUxhUGFETCtsQ2pjUlI5TTdWOHI3TzdnUytJT2puN1k2OUF5RldN?=
 =?utf-8?B?V0VsamUvWUZ3bUEvL2ZPbXZJTzBhSGpZVDl2SnZWdUJEbG4wYkpORlpHNHBJ?=
 =?utf-8?B?d0p0REVQVXdxSUVmVUlNVGlvbnV5dmtsTjJvYUpiRW9HaGR1TUpBM01TTEg1?=
 =?utf-8?B?Wk4yQk94TXJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJ1TXBaVFNybXREbVhCQWYyNXZMNXhDQmNJNytFdFhaSGxPZWxVY2pheXZZ?=
 =?utf-8?B?dWNzLzA5ZHBRcnhLT1FTTE9neUZwY1pMdnM0NnF1dUlqTCtxVWhHWnRYV1lk?=
 =?utf-8?B?WXJQTG1GeWxMSUpPYXlORHAyc3JIS0p3djN6ZEVEVGx2bmNLdXZlOUZ4Szhw?=
 =?utf-8?B?WU1wWU1mZUUvVDVkZHpNQWRvUGk4aEZHOVVPU0tZUUlaWTNvNy9qbkJMR1k4?=
 =?utf-8?B?bVp4S1JmZFpvZWcycitSTE9wWXIrOWFidmV5NThvU0l6TnQxYjJpd3F1ZU9N?=
 =?utf-8?B?UEpKSDU5RHRMYWo4eEVnYllEeVhST1dxZGFNd25xdmRYRVJWajNJOUpOSGlh?=
 =?utf-8?B?SU00VXJiQU1iWEc1NW9sQTE2cmN2WVZFeURMd1FocVYxaFphUzhUOTNtVGx0?=
 =?utf-8?B?SmtKK1JjeTQyV1JVZEY0K1krcWJNRFlRSFNnd2xRdzMrdXdab0hqOXpEbS9x?=
 =?utf-8?B?UW0zVWJ2ZzdkOE50UWJFclk5MVF5eXlRQUgvczlxb1FVdkc1MUpTZmNWd201?=
 =?utf-8?B?K05INlBXd0c4aFl5Z3UraVA5anFxdjBDa3FPdUswUE8vOVdBcDk3bHV3UVNV?=
 =?utf-8?B?NVJVUm5IOExwS2RUTkVZdXhIazIrTUpiVEEvTWo2MDAwV1dyODFsTWVzSjd1?=
 =?utf-8?B?L2xObm93T1VHaW5pUGxNM2RrTFVtM1lzbFg5VXNsazV4d3V3SjYyMjRXYmJy?=
 =?utf-8?B?Q2RmWjZ3YnJMa2lUd1dJSDA0Yi90OHovcmRTQVV4dFpDZ1VIV0NFOTBSMk1i?=
 =?utf-8?B?cGh4RVJUR3dra1orcDBaMnV5Znd3bEp3OG9RODJLUFRyUVZkVDBJLzlmS1ha?=
 =?utf-8?B?b3FsRW9ETzZGcTQ0a2FHLzNtZU1HMXB3SmN5TFk4ejAvNTNqTzlqTXhoYUJr?=
 =?utf-8?B?Zld2cW9LQ2k3a2ptREpkWXlqaWZQMmRBdVhkNUNLMnJCam4yOC9yMDVqYmlz?=
 =?utf-8?B?QnVuQTNCSWhVZWcrZFhoQ2Zpb2VhYlpDR3BKZVlla0MzZ1RHaHIvczZDMjg2?=
 =?utf-8?B?YXlNN0Z0Wm5qRmMxZ01BMThwVG5rNjljT1diQUpYNno2K3lWTU5zb0h0T2dp?=
 =?utf-8?B?ZnIxdDM3M0dOdTBBTjFaUXFxMjB5c2Y5c2RGSlBYcjJTZDVKRUxncDh5YnFs?=
 =?utf-8?B?dUI1RHhnWldkanM2UG92RVp3ekY3RXZSNVVRLzZab21xZ3ZZYXJiNy8zVWx2?=
 =?utf-8?B?R010a1BORHA1RDVJZXNZYzNGdGI2Z3E3MklpOU1keElrM2pZWHlxM2UvalNX?=
 =?utf-8?B?RERmZVdvME5memNJeUdxSGR4UGQxQkxJVW1yaG5EQUNtQzROQURJWSs3bnV3?=
 =?utf-8?B?WnhpVitBVlo5c1NlMlRZWEFxdE9KZndMTXBYeWdaUS85Y2dIK0x0ZWxMaDBp?=
 =?utf-8?B?RERXYklKOHVuNDgzYk52NlBEVjNNSVA1d2lVZXhXbHJXN0RKTjZQNUhCUUxT?=
 =?utf-8?B?bVdGRm9zTzlUSGlBYjJBc2dmandKd0xPdUlTVkRpUzFld2RXVFNudzBSN09W?=
 =?utf-8?B?cElMS0lrTFcvdmIzRVNKQk5OSnJZN08xYTkvWU5hN1cvOVB1MnBPcnJzS3dh?=
 =?utf-8?B?M2NzcUVlTk11SWt1WTZoaVBMRGlrYkFDOGJDSEV5cWZzckdDUFN3Nkd1T1dX?=
 =?utf-8?B?dTk3RExUYlRBZEd0dzRqOHM1cDZoMFAzTXBSdVEwQUNqbVlwWm0yaVNaWW1S?=
 =?utf-8?B?MlFCZnlVTWVyS1pJMSswYWl6YkREcSt4RGdqTDN5dTU2L3V6bEl5RU1OQ3hZ?=
 =?utf-8?B?L0dtcFIvVU5WZUdwd29SQjREbjNiTC9LVmhNc3dMcU45WXFtNGpyOTdUMDl4?=
 =?utf-8?B?TUFEeHIwZGx1SUd3VWcrYy9aYkZzVTBjNXJsRWtvVWdSZHgzQUJDTVFWbWpT?=
 =?utf-8?B?Y3NYQ2N2NndlV2RjL084Y01IeWx6dks4OUh5MXF0MU82MC9LcWlBeUZ0SXht?=
 =?utf-8?B?Mko1cVE1QmFBM0R3WC9hN1doUzZZODZDZTZzbUJZUXp4UEw1WXExS2JVRFBX?=
 =?utf-8?B?WWxaeHpRS3lVV0lqc2FUelJ0MjdPQjE0WisrZXVWT3o0aWVqdWVIV2JCemkx?=
 =?utf-8?B?QmNQSjVNeHB6YzF4YlVHdEo1UDk5NkVTYjE1bjRsWDI1Zkx5eUQ2RDJBN25a?=
 =?utf-8?Q?I08H4h/++V3UqtZFsbf+vDNYk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e94711-d6ab-4489-09ba-08ddbe87c184
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:27:23.4724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyfPX3Uhg81vPNbDzSqevycmZ/uSFjzuB+Pe3YV64MGO8Caw/RlA6amYPe4yahDq1vJHdaAb1SuKqY8QkryJFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7873
X-OriginatorOrg: intel.com

On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> 
> Of all the EFI runtime services, set_virtual_address_map() is the only
> one that is called at its lower mapping, which LASS prohibits regardless
> of EFLAGS.AC setting. The only way to allow this to happen is to disable
> LASS in the CR4 register.
> 
> Disable LASS around this low address EFI call.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/platform/efi/efi.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

A minor nit below.

> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 463b784499a8..5b23c0daedef 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -787,6 +787,7 @@ static void __init __efi_enter_virtual_mode(void)
>  	int count = 0, pg_shift = 0;
>  	void *new_memmap = NULL;
>  	efi_status_t status;
> +	unsigned long lass;
>  	unsigned long pa;
>  

The two unsigned longs can be on the same line.

>  	if (efi_alloc_page_tables()) {

