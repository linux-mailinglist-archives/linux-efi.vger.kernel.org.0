Return-Path: <linux-efi+bounces-4078-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B81AF0784
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 02:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C2C423543
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 00:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C31CD0C;
	Wed,  2 Jul 2025 00:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQ06mcER"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921694A28;
	Wed,  2 Jul 2025 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751417725; cv=fail; b=t2hurSkGJlXkT3f+6g/T1OAR3rSJHF9caB2OFgdolYknDF9A3cWfgGNnsb0rMY6wiC339ZhIOj/9D0ctGKVpwkFH0AHzxpkR0Xc9Qs7sEAgmDN7Mm3RkX2T/MkZC4oADYfyn0H9cxF/qV3RwYl754plyHtBIdNJf3l6IOj+cKpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751417725; c=relaxed/simple;
	bh=qqaV59dLgaO3xaEgX0wMVXaDkwXxR5hwcCBTLqXtoEU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F4T8kfK2BXbJdFMeF1q7WBag2OM7BFeaEwgrjYoGfYWKn3EwxfVHNAkGvFACL+fMd/Hzicu7TAf0L0v4M1kXVmWAdIpwsgyCn7d8yVc0PpapnfDL+IwF15sX/nZ2k7co6SDTVWhbju+TEJ0JjgF+6QOBDdQuzhBlwBsPHBSD56Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQ06mcER; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751417723; x=1782953723;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qqaV59dLgaO3xaEgX0wMVXaDkwXxR5hwcCBTLqXtoEU=;
  b=KQ06mcERIivt9I3ccOZbnrL3XAZcHkE9NKBJCVJ8d+phqs91PpjhTEEO
   c2UTNYNs+wX0kenVES0Lox/7lVOFsOZyTRfczIC6sY8bDx+wuzRjgQKsp
   mxKIbfcfwg9r4bwn13ZseIdqmN/yOEGGs9LhO95bHKwRHmWSbvWkSz1RZ
   qkazCXCiF/OusQDpgrv9532h+FiIi+2/mtlXfD2z4XBFp4+ts3sI5E2xR
   KFDTsG9jXG22lMDwV+8hTABeVGhR/RNDaoVeoD0cPqEay+j3AXoxPFesP
   pdwqqs5YIsarBQL7HBhO9wdOklmdhgNbr97LgpRMV7vqiaBXCtTyHpGyX
   A==;
X-CSE-ConnectionGUID: ouxat6feRRaK5SWnJzqYjw==
X-CSE-MsgGUID: osm+l6yyQ0Kqb9Bc2adsAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53791053"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="53791053"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 17:55:22 -0700
X-CSE-ConnectionGUID: rTH68FldRzOnNywyXx6KeA==
X-CSE-MsgGUID: ZBZxilsYQi+Dt7+UrEDH9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="154469058"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 17:55:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 17:55:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 17:55:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.89) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 17:55:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdK42rei0IruZ9aRyS4DKqxYki3o7fwpkIN4Kqvqj/At3FehxBimCOmxvf66F3OVXwDqjOVBe3AfEjjuqiycFE4waFQezz8p6X0eu+LRw/8yArsp4oVM5o9GzeuizZgHuGObNdtMvCxXeui8uQoSBzJetc0fQ0q8ss5ObhoYcRwdKuqOJ2MBYzsqThS3Qk0ONnD4r88lUnjg1mm1noM1mKaixv88rqNCu9RfbQ9Z39QhDxXl1S/pboOw/IhDgi9JMuSfz7JmUhhQ46FQvCLKkIlS87CJV+z1XiRDyZGjHh93etxqj7kTboEc8V9YIxaLLOW7SDJU1eyBeFKaSEhsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94TSLge/MpE6gu4B+0gYGXDwynEJaYmghttopy+0u8w=;
 b=jrJVdbYBRIN12GknKckDVYB7JtbMpFBAC6vVreG4eD3ADpWkcoZtXxnPYnKS7lT8KdD+m/Zg13zmBiaVL4wQTG9FZzAWarpSDt/KXXEMSMrsKf1u9F42+FvrZKN2QY8rgIQeZPGofKBM6s6n4T66kwJ9MtW6ZH5wSwoilzZltymcrHRCZHeybfTCbfoM26nyCJeMdreE1/AQJ9tXy5YNIO5a2ennCdP1Ad+elLDQA4t0m2aFnl2fglHX7KPUyEkglbMBt7jkAX/j/YUFMy5rZflyCpuPHfuYovvpQSqYzE7SdtRsqdflIxYPzlsyQaRckb4B+Nu2hQ6zhTjcnOl4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS7PR11MB7949.namprd11.prod.outlook.com (2603:10b6:8:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Wed, 2 Jul
 2025 00:54:47 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 00:54:47 +0000
Message-ID: <d777b118-68d1-4212-a33e-d129d777515f@intel.com>
Date: Tue, 1 Jul 2025 17:54:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 13/17] x86/traps: Generalize #GP address decode and hint
 code
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
 <20250701095849.2360685-14-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250701095849.2360685-14-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::19) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS7PR11MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa2efc1-619e-42d3-1f6a-08ddb9030ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWtPdDV6R0NCbG1Pc09OSXNxdEVYQXFzNEdQL1ZSeTQreDhhRHpUYWtVc1da?=
 =?utf-8?B?LytKM1d4dWNvajVoUWZyYzQ0V3dER0xGc3loRFJPelBydndKS1JkQTdMSjBo?=
 =?utf-8?B?YVhLVWw5UVlMNzA0a1J2VU1zZVllOXluWkRjbnJvZWw4V3JkSmNWdXJTdXJn?=
 =?utf-8?B?L2FZcGt3VE9LSFd4dlpwMHZzYUhrN2FVL1pxR3l4Q0J2WVFCUVBNa2s4bTh2?=
 =?utf-8?B?WHlhNHJOdzVTejNET2ZhbjA1dHhpcnptMlpXa29KWC9oYW5PcnpVNzZnMmIy?=
 =?utf-8?B?dzk5TlJQQ0lvRzFxQ1F2d1c2cnB2MjVPRlNMRjUvQUNnZHFvdWNFcWNGRzRu?=
 =?utf-8?B?dEhZNGdQWjRoS2crM29ZUXk3a1JYS1JkZlB0eVN0UE5kbCtCQ3I0SG5TRUJL?=
 =?utf-8?B?MnhPODI5ZzhGV3J0aUZ2UmVkNDJLdFAzZHM5MFB1M3RNTDZraXJwc0djQjRy?=
 =?utf-8?B?dlBLaFA2SktOY2RTTkZrS0s3dVNiTFlWQ3pNaHNQQ3ozdEgycTdOMldMU1Ax?=
 =?utf-8?B?MWlNUHczQjVlK1ZXMWZjS2dHNFhxYi9yRHp4Y3M3dFVFUHh3SU5JTjQvSVZI?=
 =?utf-8?B?YkZTT2dhc1QyQ1ZVMVBZT0dBOGltUWJpREZpREFMTVRzUkRDK01XZlpXWStt?=
 =?utf-8?B?Nk94NVdLcEtDYXBwYW9SMlVvYjNHTmZ2UExmRnY1RjN2dlZ6WTRNTW5hY2tw?=
 =?utf-8?B?VVZMeDU4THVMdUtPZlZIMVFwMW5ZUXowQTNSUEdsUzZyRVIvcWJZNS8vdXY3?=
 =?utf-8?B?ZkxMT04ySjNCUXRqMzFIMFVhdXlrOVRmNGRBdEoxSlZzbmRLQTJaYVNkdWFv?=
 =?utf-8?B?NU9XdWhvLytRbFN4RDdZMGlDOTB1YTNSQjROSFluOEtVR1d0ZVhXa0VHekg3?=
 =?utf-8?B?OEQvaktDR05nM2lLbkRmUkRobWdxRmNoNWhLOXQyOG9pa3Yvc2QrL3BMR0Zk?=
 =?utf-8?B?OVRwT0FIbXJFSXhZZXdGOVcwaXJET2RFMjI1Wk9IUE9QZ1VYdWc5RjdwUFBI?=
 =?utf-8?B?RXRKSTZFTGVzaEgrLzlReXNZSFRRSUE3S2lBQzVsRTRkUFRJbDlmdXFqUE92?=
 =?utf-8?B?YXN0WVhUeTRTalRMTHNYU0lqOUwrZk93aU9wUlplWU9HNTFVUFBtVHdSNU1j?=
 =?utf-8?B?MForNHB6Si9IdFpEMStvTFRuSUcrUVdIWURHd0FUMnM3clRyTEtva2d4VGtV?=
 =?utf-8?B?bDFnVFdyL3JLTXNyeStFc3pqV3VhNVoxVGNPVnVuQ3NzTWZ5SjlEV1BZVHhx?=
 =?utf-8?B?VjZDekNLV3JKL0Z5NzRreE9rc3IrbEIybnIxbWtkNnpIUTJGc29SVTFvb21j?=
 =?utf-8?B?UzNqTmpPSFhYQUV5Umw3MnR4UGhiYlVHMXdIZzZRU1p1cUpoQ21rcURSSjh5?=
 =?utf-8?B?UXJRcDBvSmJiN0pJS2dyTmtWZ2ZEZjJCWi85T3czTmhhS0tUK2NQZW5DMlFa?=
 =?utf-8?B?N0sydW9VaGVYUUk2Y2FxNld5U3lyM2J0cVI3NUVMT1Q1QmFPZjVmMU1CaVNw?=
 =?utf-8?B?amh4OGIxN21TLzhBWHdBdHo0TVVhYUM5djhiU3BGZkVCMG43TXZFK09VdWZE?=
 =?utf-8?B?b3k2RnhRRzUzVnJhdzhrUDRBWHRUQzJhNDVLdlVYdjFVYmRFNG8ybHJLeU05?=
 =?utf-8?B?d1ZDTEd4MEtrbUZwM2JISi9GK0hWOXIvdE45ZEZQNVl4KzhETnVwUjBGcDBn?=
 =?utf-8?B?Q2RQeVpHVFJmeEVaTHlOZDZSRVBza2lPdUhvQTNRYWJDdWVabnRBOVFQWTdx?=
 =?utf-8?B?WmczaTc0OXBqbGsrYWw4VUdlMzRhUkVlU2N3eHVRMmI5b2o5bVczVE9NbUlx?=
 =?utf-8?B?cmw2V0FVNUE4SmJMdXZCNjJzSGlsNEVFYnZ1eUhFVjVQUVc1K051UFN2YjlQ?=
 =?utf-8?B?N2FkcFNFWlRadStYbjhZcmNISkZHaVd2UzVNb3F1U2tGUG5ZdkdYMGlKdGxz?=
 =?utf-8?B?MmZjbmxKSi9QOUN2RDFkRFNDWkdHWTRHczlMRmVUa08xOCtBSjB4alV6ajNZ?=
 =?utf-8?B?T3hXYU0vTlRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SklodjA3YnpENFp6cmpXL0JvQVhMQlc1OHlwTGg3cnpvWlUyV3RjZGNIK0RS?=
 =?utf-8?B?dU5BazIxUmt3ZTdlWi90WEpRZmNFS1ZTTm94aDArNXcyL3hqcjhUUE9XdGlY?=
 =?utf-8?B?T2tMQzVjVlhXV2ZsdVVmYytUWnRsM2lYY1JBZUdFZXBhTmJleWZseTVCYXNM?=
 =?utf-8?B?MVFNSWloNTZWOWJ6TlExMy9YcHZQUjFvcjJWU2VQNmZDdTJnN3RZRlN0bURu?=
 =?utf-8?B?VlVJaDdlMmtkTWkvNGViWTAxcDVqMHFWNzVOalVteFN4TjFUWHdHV0pWdkIx?=
 =?utf-8?B?akhSZDBTanU2amNmT0RycG9NOG9mK3VVcmFWQWJhaGFGTkFCbDNpc0ZickFi?=
 =?utf-8?B?WmZNQmFjaUVQSURvSU9SR2oySzFoTjRBckxPWDhVWW1Ba2F4K1VaMlBERFF0?=
 =?utf-8?B?OUs2b045ZzQ4NGV2QWtoTnlma2MvV3Ayb211U0VsckVza0JBNU00UU95aXhO?=
 =?utf-8?B?TnJPTFFXRjhVTjB3Z3Boa0hPZ1ROaUgySFR1MUNjOGg5eDFNQXA4bmljTnkx?=
 =?utf-8?B?S3lQMzlTZXNqL1JUSXJ0K3ovelJMLzYvWjVsN0E3Z1pIOHJaQWg0MEtUNW54?=
 =?utf-8?B?SmNiSWcvSXRUc1gzblllL3ozQmFaTVloVTc4REc1akpVSG16d25DVWJZRXhs?=
 =?utf-8?B?TkFOQVd5azA3cmxiclg2eVBSMlhjNHNINW1OdkhBN3RqWFVwdUYyMS8xZTYz?=
 =?utf-8?B?cWptYkV3aHpiY3FKdktmUXBpS1l4TER4Q0haS0tUeFhReE9UNnZqaWNIaTlO?=
 =?utf-8?B?UVM5Q2RLWmEvcW5CcUt5Uk1yZjRvUW55THVZQkUvbEQyaS83YW9XanBLV1VI?=
 =?utf-8?B?OFFYWXZ1RFRQbUxVMHVKQ0ZsL05MODdMdWY4L1NyTUhKSFlTaFB2NVRQREs5?=
 =?utf-8?B?b0x4N2FhckVWdHROSTVjMzVhbXVrMzFSaXNqNU5Vb0k4cjRGdk5FN2VaTVBy?=
 =?utf-8?B?bmk5SXk3Q2VyVVYwaHE0eVM4K09LSG5YOTI1VFpYTDFkTlJ5b3dvWVc0bCtl?=
 =?utf-8?B?T3U0aGowZ3JESEE4bVRQK0xxNW1KeXZkdnlSeTEvR1YzSFFuay9RWkpqdnB5?=
 =?utf-8?B?dVRlaEVONzhTRTNCelVyWmR3c0pBaWFOdTZqZ2dqUThJNHV6QVhQSHJXSStB?=
 =?utf-8?B?cGhvYitvZHUrdFBXY0dYVWVmbit3QXJqSkowRDhteXhoRFdjYUsrcVhES0wy?=
 =?utf-8?B?bS9EUTJ1Z1FRbjRGM21kWTg3Ym5JOEI4TFJCSFQ1MHFGNUZHOFRNN0hCWUg5?=
 =?utf-8?B?b1poUVpwa3Q4eFRlWnU5NzJQRmRhVEJmVjQvb080WWtlR3lhbnlteTlFTVcx?=
 =?utf-8?B?RlJiN3E1SmJzeW12U0oxeCsvUUZ1eVFTSnFva2xSeGVhOFdxbm1FckR3cTM3?=
 =?utf-8?B?TXNsR1ZuMkJmcjZsaGk3TDJLcjM4ZGJ0NUpvNXVqdmFWMUJlbG8rREpWL0da?=
 =?utf-8?B?RDZqR05NeWREdytyZjRoOXVnMGVTaFBOTWNnMzhlY1FqQ0RpOGowWUlXM2o0?=
 =?utf-8?B?NVRJZExqUEx6UmJYT2RNV1YzaXhLa05jMXdvTjV3clo4UUVSWVpCTFkvV3lh?=
 =?utf-8?B?ekNBSXV3Vy8xN0tGMVZKVktLQk5QSlRCclZJM09QdzM4Q0Q1L1ZYU05GU0ZN?=
 =?utf-8?B?Vlp5TklXUUhNWXpzVlAreGpxekttT1pZT1RXMmxkU3VzN0xRaUs2dHhIMmRV?=
 =?utf-8?B?VSttMitmTnBINHhnOE54TWo4bytSSlhtMFE1cUtkTktsNWc2UnlDOVEzZWc5?=
 =?utf-8?B?VGY0UGtjNFhJbWtoVm9SYVV2aTJPc0NqQStOUElEM1g5aDUxdmFRQnB5UTRS?=
 =?utf-8?B?Ni9lZElYRlN3c2NxeGdqdTJMdlRFaTV3eWhWUXlBTWlpemxrTVdPOS9lQzRC?=
 =?utf-8?B?VHY0NVZGUnNMZktMd29ZUXljTGRnOVQ4SUpPNTMvRTdXb1BZby9uVFJXMldL?=
 =?utf-8?B?VE9iQTJ3VDdNWHdyMGppY0tjcXFXWWdaRWQvT05CYUFScW93OFJlR1JlMXBt?=
 =?utf-8?B?c1UwV3dDM1dwd1FtQXI0Wk41OGdiOXRGa2lnazM5SnJ5dlRKUXVadjBxVlE1?=
 =?utf-8?B?aXNlbGFvbFZDWmVyZ2g2ZlNON1J3Nm5yM3hpWkJBczZhVmR1ZWtTZG5SS1Bk?=
 =?utf-8?Q?9qMHA2TUBu+AzNTEw3baTX5j7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa2efc1-619e-42d3-1f6a-08ddb9030ad1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 00:54:47.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7gTw6uO2V3Bvhpt1lBjy1bEfEe1mHyhcj9Hl7000zbJ2DloIwEvHPp5XSlYjXJ04bLW6TJO9atuIPwfiPXQvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7949
X-OriginatorOrg: intel.com

On 7/1/2025 2:58 AM, Kirill A. Shutemov wrote:
> Handlers for #GP and #SS will now share code to decode the exception
> address and retrieve the exception hint string.
> 

This is missing an essential "why"? Why do #GP and #SS handlers need to
share code? None of the patches prior to this have hinted this.

It can probably be deduced from a later patch, but it needs to be
clarified in this one. Maybe a simplified version of the text from the SDM:

"In most cases, an access causing a LASS violation results in a general
protection exception (#GP); for stack accesses (those due to
stack-oriented instructions, as well as accesses that implicitly or
explicitly use the SS segment register), a stack fault (#SS) is generated."

> The helper, enum, and array should be renamed as they are no longer
> specific to #GP.
> 
> No functional change intended.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/traps.c | 62 ++++++++++++++++++++---------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
> 

The code changes look okay to me except a minor nit below.

>  #define GPFSTR "general protection fault"
> @@ -808,8 +808,8 @@ static void gp_user_force_sig_segv(struct pt_regs *regs, int trapnr,
>  DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  {
>  	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
> -	enum kernel_gp_hint hint = GP_NO_HINT;
> -	unsigned long gp_addr;

gp_addr is a local variable to the #GP handler. It can probably stay the
same.

> +	enum kernel_exc_hint hint = EXC_NO_HINT;
> +	unsigned long exc_addr;
>  
>  	if (user_mode(regs) && try_fixup_enqcmd_gp())
>  		return;
> @@ -846,21 +846,21 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	if (error_code)
>  		snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
>  	else
> -		hint = get_kernel_gp_address(regs, &gp_addr);
> +		hint = get_kernel_exc_address(regs, &exc_addr);
>  
> -	if (hint != GP_NO_HINT) {
> +	if (hint != EXC_NO_HINT) {
>  		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
> -			 kernel_gp_hint_help[hint], gp_addr);
> +			 kernel_exc_hint_help[hint], exc_addr);
>  	}
>  
>  	/*
>  	 * KASAN is interested only in the non-canonical case, clear it
>  	 * otherwise.
>  	 */
> -	if (hint != GP_NON_CANONICAL)
> -		gp_addr = 0;
> +	if (hint != EXC_NON_CANONICAL)
> +		exc_addr = 0;
>  
> -	die_addr(desc, regs, error_code, gp_addr);
> +	die_addr(desc, regs, error_code, exc_addr);
>  
>  exit:
>  	cond_local_irq_disable(regs);


