Return-Path: <linux-efi+bounces-2048-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF5C9B553D
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 22:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6E51F23D5B
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986E220823D;
	Tue, 29 Oct 2024 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LARC2gId"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B019258A;
	Tue, 29 Oct 2024 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730238424; cv=fail; b=ck7OJLcLeRo+YiC65OfSzStvC0MlGki7BgaFd4ZIqEI7kINAN20LMkMdqui5CEbGccgupAVpTWWCAfEfG1Fug6mB5T3897f3xoL4mDNvXP8aqH7PIUCNUpJpZbUF7BlRGLGVDbb0poVbyIAdm49krbx6G10cVQPAT/D/oIcvydI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730238424; c=relaxed/simple;
	bh=XDmU+BtpLk2F6/B3Myeh6Mcj6bIatDv5tSOedvVHRlo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j6L3Yvoig4nusJikMRU7UiXMT+sYxCLX3OUkM4KajrVssak/ohhB1EKpDU/lHdKcLTfDcyabj1oHNrzRwq5Rgti4l4gS0Lb3eHs6Xhm8/RUuLHRXUorZWu8TK+prggepYEQv6hYYBfZo7m/8V7evtzUgeE6J3adHYD3vBZ6wFBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LARC2gId; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730238422; x=1761774422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XDmU+BtpLk2F6/B3Myeh6Mcj6bIatDv5tSOedvVHRlo=;
  b=LARC2gIddZm9Y7SyVa/9UcjFjy9egDot8wlzWdMxeztHmXOGfL8V7gYY
   +ifs+8sLEBKi6BhoHFrjD48RANMc/oVPMINDXHWOqpQDtlDb2qf3SJ3T0
   HfXbGgM8/ZfAYsG5j5BxbN02el0oPmX/klgPaJPvK7bjK9xH7MxPwtWZA
   SJPiOOCQjc0i0pkjQwzNvPicEVwOAdhqm0ts26kioNEVlAEdWUFTNICF6
   6ibB9zQknqDLpthTNAkKR77GX/6OVvTMmtanP8SnBnWI15rRRtbQNrv/h
   D9Xzxv5mzi1jcgImCO2gsZrLCY0UJSAISMGD8SOvbNfb4e5tN4sUY4LI3
   A==;
X-CSE-ConnectionGUID: R5iUr+rmTImvJcbvbcBjrA==
X-CSE-MsgGUID: OOx3NJs4QsGnvSGacSEJYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47371632"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47371632"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 14:46:41 -0700
X-CSE-ConnectionGUID: 5gXwouM3TiOpzdn1i6U1Lg==
X-CSE-MsgGUID: ujC6HF24Tmeb2G+tl/c9Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82429978"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 14:46:39 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 14:46:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 14:46:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 14:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkFiBtMfQhfiUfRkUXoWz7OFVastYT9qx/DLLz06CYa/AXsKQl5dhs0Yg/ZhFqKiOrc4+zFZhayNhSn8evKb0UAbtHqH+7C2JDkDTkapTFhjdzVNecD3BbOvMSRncQHM+ECRBoET3uj1fMiPAaJCK8vZgAgkZFgxyTYTt9W67C96ug+LDFGGc7u+ztQQvpRBILc0WNre3hP5reDGyqEFa94zaK2RWgxQDQP9XuSOk39l5O9DWlWgAg2nrjghEzhcmbNrmj2dCdpWe1rdUWuBziHE/AjxVGlw998MNQUOcnC+S6QD589iudN+qMveVMgS4PsMKcdP79tjw+WErvT39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU2v29lUGWJwg44QHbQl6Z5gW7ff5WHMU2l+f466NcQ=;
 b=cfb4K8ysfPABrKiRkLmNumOwo963jAcAvMG46inWrTi/o9gLg4KYyy1U6dNuDlGCqfYIEd9KcPG6Ym+OZ1L2LR/Nr+e7+0U8bl65upaxuxcFxgaf9fKFnjkO7moJT5q7RKECz5dPjjJeu0G+ZO5CKXHVipJb0DACSClrhIGQK6dbCvUGLJUN1b05VXkHC4HZ3s/DcDDlRwZbJ+kI+Og7p2EpyM3VulDdqYRSHe8QlVMZ6JiTybo3XCgqukyS4RWdAx4bY5oj1OrbOyz414T0loc9mCEEwWu31FLdHphOodmh2cWiJIFVp7Lhwu4r9lZcfFXxBHRCmgo7tXP5ztwb+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA0PR11MB7741.namprd11.prod.outlook.com (2603:10b6:208:400::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 21:46:34 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 21:46:34 +0000
Message-ID: <d2c64298-31ea-49d1-8d43-bd8af55c162d@intel.com>
Date: Tue, 29 Oct 2024 14:46:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/16] x86/cpu: Enumerate the LASS feature bits
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
	<xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Jonathan Corbet
	<corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
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
	<linux-efi@vger.kernel.org>, Yian Chen <yian.chen@intel.com>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-2-alexander.shishkin@linux.intel.com>
 <r2lprcqo2c7cpbgvnioi7kul3fwvskwjviupsugkdmiays7qwc@bnqamuzz3rjq>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <r2lprcqo2c7cpbgvnioi7kul3fwvskwjviupsugkdmiays7qwc@bnqamuzz3rjq>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:a03:100::16) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA0PR11MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 4796a66b-94aa-4eb0-0897-08dcf863282b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmQwek1CRGNMbGFQcnlCT0dRaFk1eFJnZmRtdmRkZWluN1BFQzhvTWg0bUZS?=
 =?utf-8?B?SndJM2UrbzNwZmZ1dU9mUHV0WFFSR2k5SzhVZXUrVUVaaVZwY1BBSzZXbkNE?=
 =?utf-8?B?cDNBSHVYYjA5VzlsUXNXK0JmdEZGeGNOK2twNGkzRlYwc2QxUzJNZS91dzFK?=
 =?utf-8?B?d2Zpc0ZLMWxPYWtpbGVEQ1ZwZ1pCaHlyTk8yM25qQ0I5YmJNdXhJN3NaTXFG?=
 =?utf-8?B?U0FzNmh2TnFkM1NWZHpYL1A5cjFKSDI5Nk56UVZRK2g2YitzaUxoUXJyVnNr?=
 =?utf-8?B?dWZHdld2eklOVXNnWW93SXhtQjViVENHb2ErUDdjZmdCVUFCamYvSGI0UDFR?=
 =?utf-8?B?cXRvb2Vtd1p3WU1oc2NIbGpteC8vaWNUajd4U2JpYnAvc0doWDV0bXFoTEdm?=
 =?utf-8?B?SU1IOTNCNTFKR2dIM0dtUzFCaDVPMXQrYzNzNVZwWit3RTN0NTE0OUxGV3Rm?=
 =?utf-8?B?dk5lSWN5dWIzM3EvNXV5eVZLbzFQai9zQ2Y3aFNGY1QxQnh5YmtXMUt0ZVZM?=
 =?utf-8?B?aTlBQ2hTTG1TanoyamZpVzJUbnlyR0NMT0VBTzBYTFRTTS9NTzRUb1A5WkRm?=
 =?utf-8?B?ZGJmd25uWkxGbWc5Wnh4V0h3Vkw1K3ZjVElXNTBRaHNjWXlvT1c1TU43bWsv?=
 =?utf-8?B?YU5NcjdjNHdJZk8yWVkwNzA4R3RXeHBZS2RPMFlucTJZcGtVUTRYK3pncDc5?=
 =?utf-8?B?aTBYSlJMYThrd25vYndIc2JCZmVHbFFYL3NUdFRBV1R2amNPYTVMYlhUQ3hS?=
 =?utf-8?B?SFlCejFSS00yNkdTZUJWV2Q3RFpxcW5tZmNUUFY3c1RxTUFtQ1Z0SU5rd1c1?=
 =?utf-8?B?UmZKV1hMWmdJK0pORURzLzBNdjJuVnJOejczUkVobUJ0ZVM4K1hidHNqTHd2?=
 =?utf-8?B?RnZCMnRZcmZhZVlZK3BIdkcrNjE3akJUNUdLZlEvTExRSHpXZ2pYUmQ1UFB0?=
 =?utf-8?B?b29SUlF6aGNzMkI2TUZvd2lncEdoalZzUTJwODNPRnhFbkhIUXZhYXBFbUk4?=
 =?utf-8?B?aSszdldSRjlrcGpTb0NLdDFUUGZCdjhPVFVwMEV5T0F3cjFXQXlCNnN6UUlT?=
 =?utf-8?B?RFZzenFTNC9FMUxuYlVxYXQ3V0xtWkN0VDVmY2swYWxOZzFpVUp4UFZqM09U?=
 =?utf-8?B?VFkwZlh6NUdxR1BoWkt6bUg1RW8yYm5tWXhaWG1mWEx3dEdQRDIzRUF2d2JJ?=
 =?utf-8?B?YzBybVJCK04vYW9aYnFncmVNVWhJOTRxWkh0cUpoYklsdVo5aWtyRnBqYzJj?=
 =?utf-8?B?NHlsWmRLVmk0MEFGdXMzam1KY3VDSGUrcVpwZUpKWUhqaDZCdjh6end6STlZ?=
 =?utf-8?B?NDJENDl4R1Y2SFhlU2lGeWNIVDFsQTNFUVZicGxrVWdzK29lck1UYjlESUxN?=
 =?utf-8?B?N3ppVFIyQTRiaWRZaDZXUnkxN1VEanBSM1lCelVmMnpYWW14U1JqYVJKKzFY?=
 =?utf-8?B?TXZrcWgzbWdUc3AzZ1JBTDM3SVorMTBCNUtVK2E2OTFWT0Z0OFlnZklhL0JT?=
 =?utf-8?B?b05pQnlFN3dnbWtac3ZXTWVtVUFLMU9DblBKZ2gvY3pjRTB1cG1yNytpNWNV?=
 =?utf-8?B?YkxJWHVrVm5rY0dhNnkrdEtiVlptdURkYVV5Z3hQZEM2UmVtZFFudFJ3U1NJ?=
 =?utf-8?B?SlNMVk1uRU9SSW5sRGI4S1JHdlEveXZlbkF3Q0VsaitnMHlSU0RLYmdBaTRt?=
 =?utf-8?B?Ym9CS0JYbkh0UDhMV1ZTekN3cmN6YVBqR1lXcE96cHdET3k4ajhZdkZSVG5m?=
 =?utf-8?Q?B5dB7QazfpptFwsMbg5/kCYqPrPkiPfkcWg0kps?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFGei9CY1lRNlluNjdHem5xVURudzNoNyt3c1NlQTZ6VUxGbHZzWjVBbm1a?=
 =?utf-8?B?ejNjcURuNDBTRzZibzFPYnhBclFMVFRxeG9FVzJxdURtRC90L1NtS3kyV3Nu?=
 =?utf-8?B?eUpuNXh0T2NzMzhCZDNFR1dyZktZS3lUbStNaXV0M3ZpWG9Qc01QUWR6dmFX?=
 =?utf-8?B?aDF1VDJPZXJSUmV2U0IwRTNoZGIyVHZxNjBhT0J0N0d6SGpVSzZhWnRDTDNt?=
 =?utf-8?B?NHBiMnJjUm5OOE5NM211bU5hdXBnNGZVU0ZxZ3pxKzhGMGdqcU4zSmltQmNr?=
 =?utf-8?B?MVVaWEl6a21SUThqbi8rR1Fobi9BQjFXVlNPWXpLN0g3enZHUEpFclZscW1S?=
 =?utf-8?B?TmZEakI5d1AvdkRpc1NsUnNBM1ZUcnZJeFVqSFZ4RkF4S1YzenRHZDlzeVM3?=
 =?utf-8?B?RUp5dzJWU004TWx5aVRnZUZRWlBIY2pFc0IwTXpiNGtuRVY3VTlYNzV1NlBD?=
 =?utf-8?B?QXVXNExCY2UzOWludU5rTkpoaVUxNFhuTnlOazlYZDJsNkFETmFIa2dRWGpl?=
 =?utf-8?B?OEFYdnd0NUNLdjVQTFBQUitXRUZWZ1QwbzFZOEh4M0E4bmd2QWQ5Q2poWTZW?=
 =?utf-8?B?Z0dMWjlYZHFkaVFxQ0FqSm85R0FpU0ZpdkdDSURwZkhsMU8vNVZKWkVGRVhr?=
 =?utf-8?B?a1JRMVV0RDFDY09VKy9jNUk2RjdMa2tWTnpOMmpNd21mWUhpaEFORGJEMWhL?=
 =?utf-8?B?SVpQK3NPRmRVMEVQNEUxcHZUcnpZMHdBVnh6YVVITktmb0Vib1EzZXl3V0o4?=
 =?utf-8?B?SStQUVJULzh1dUtYZkhOUjFlOEREVUg0UUh4TGQ0WGloeUVFb0RSTU5NMXpm?=
 =?utf-8?B?Skp1SGhvaVJodVFwSU9kUElZNS80eEpMU1JrbVJlaVE5UkRXZ0pUQTkvNzhr?=
 =?utf-8?B?YUZWbkVhOFZNVTJ5Nm1FbTdyY3hmbDk4c2xOc2xKZ0Zhb2NybFV5VHp1Y1ht?=
 =?utf-8?B?QnUrVUJ5YTJDLzdlaHdqT0IxOWRYbnNnRjFzVFVrQ0FHWlpuZU1XVE94aFVQ?=
 =?utf-8?B?cVl2UHg1MDYwb2pYcWZ2TUw0MnhiaEJuTDYraUdiZ1V5K2FUcEdZaDJITTgy?=
 =?utf-8?B?a1ZLWkxja2RjbE5MTjNUcHFzT0JITnBkaExVakU0SVp0TXlCUlZXcjZDVTlZ?=
 =?utf-8?B?ak50U3FJUFZTSDJqTlZvUTFiY3BKMjhjVE8xRmQ5N3BtM2hENUhCcWRzNVkx?=
 =?utf-8?B?TS9jL0hyZi9iRGdNbkdweVd3ZDdUWGx5TER6cG1CeXdJWTZZOFlPNEZDMnJ1?=
 =?utf-8?B?L0xqWW5EeFQ0cjA3aUJvOHdTWDF2YnZGVG40TVZ1MWF0S08zZ3Q1OXVRNmdE?=
 =?utf-8?B?NVU2NHJCdlJtL2xpSCtFb3R4SFo5TkQwVXRteDhWTkRTZ2YwQjMwanlzQ05K?=
 =?utf-8?B?cTV3MExkT01KcldoK1V0WUNhNEJqMHZ4eXhvR0R3MXBuWWVMUGMwNnp3UUdn?=
 =?utf-8?B?cUt1TFdUSWVaRnV5VzdZd2FObXB5T1B2aGtjeHJMak1hWEo5L1ZkTEF4SlhG?=
 =?utf-8?B?ZVZ0a1V6OGZRbXRESmRjcWU3SWc0YXAyNnRjU2NRV0p1WnkvbndCMmwwQy8w?=
 =?utf-8?B?bS9uUFk2djh3RlpLZzJwdDdqLzJjMXgzSERUMzYxMkk2YmtZc1FaakJkL0kz?=
 =?utf-8?B?blBEaGNteU9JaDNnYjFGSjlHZzc2aXluNDNZNkdjTlJxaC9oOUNiZXVIaUJo?=
 =?utf-8?B?cGMrSGgxK3ZObmVKcVV4WTh6UytKMDQwVGdrN0x5c20xWHZEczQ1VDJoL01P?=
 =?utf-8?B?dDZHc1NjTFFmRFd5Q25sRVkyUmdvWnZkLzJzNzVKSHN5ME5lcThXdm9JUnFl?=
 =?utf-8?B?RWdNdS8wWThOY1QwNkNnM05Nck1hK3dBcFF4MFVENWVUN1ZCVHR0YnFlRlp3?=
 =?utf-8?B?OUJqK2dRTUlFQUdFSHozcWZBdVY1MFE3TWx1ektWQ3N0UmpOT3RLMEo5QlVJ?=
 =?utf-8?B?K3JxZDRUNEtOdEc5WGU3Vkl3U1JRV05URnovd2ZlVmhScTh1Tk1DMzF2b0Vw?=
 =?utf-8?B?eFY0d2hyNW9ReGg2WTROMFRRbVkxUkZqQ0ZranFZWjYzNjkwQUsxMjFhbmZo?=
 =?utf-8?B?WTdQbVNPdEtOUUY4ZHFpbnpOTkFCdW4zL2RQdGE3cnZ1WkZ6TFRzWFhxVkZi?=
 =?utf-8?Q?pDQjbcSUZkwR5HYtIlNWGQQHz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4796a66b-94aa-4eb0-0897-08dcf863282b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 21:46:34.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYS2EUga+uhgOkLWwitk+D5+P3FAIQ9jWk32Ld/5kLtVCsofxam3m+DxeA8N5nPUrsS7Kl4ggja4LioUfRVaGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7741
X-OriginatorOrg: intel.com


>> +/*
>> + * The CLAC/STAC instructions toggle enforcement of X86_FEATURE_SMAP.
>> + * Add dedicated lass_*() variants for cases that are necessitated by

It would be useful to know when such a situation is necessitated. For
example, text_poke_mem* doesn't get flagged by SMAP but only by LASS. I
guess the answer is related to paging but it would be useful to describe
it in a commit message or a comment.

I am imagining a scenario where someone needs to use one of these
stac()/clac() pairs but isn't sure which one to use. Both of them would
seem to work but one is better suited than other.

>> + * LASS (X86_FEATURE_LASS) enforcement, which helps readability and
>> + * avoids AC flag flipping on CPUs that don't support LASS.
>> + */
> 
> Maybe add a new line here? The comment is for the group of helpers, not
> for clac() specifically.
> 

Also, it might be better to move the common text "/* Note: a barrier is
implicit in alternative() */" to the above comment as well.

Repeating it 4 times makes it unnecessarily distracting to read the code.

>>  static __always_inline void clac(void)
>>  {
>>  	/* Note: a barrier is implicit in alternative() */
>> @@ -39,6 +45,18 @@ static __always_inline void stac(void)
>>  	alternative("", __ASM_STAC, X86_FEATURE_SMAP);
>>  }
>>  
>> +static __always_inline void lass_clac(void)
>> +{
>> +	/* Note: a barrier is implicit in alternative() */
>> +	alternative("", __ASM_CLAC, X86_FEATURE_LASS);
>> +}
>> +
>> +static __always_inline void lass_stac(void)
>> +{
>> +	/* Note: a barrier is implicit in alternative() */
>> +	alternative("", __ASM_STAC, X86_FEATURE_LASS);
>> +}
>> +




