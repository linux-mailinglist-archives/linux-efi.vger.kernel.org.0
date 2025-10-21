Return-Path: <linux-efi+bounces-5080-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D0CBF8D67
	for <lists+linux-efi@lfdr.de>; Tue, 21 Oct 2025 22:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B71A1898C60
	for <lists+linux-efi@lfdr.de>; Tue, 21 Oct 2025 20:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3146326AAAB;
	Tue, 21 Oct 2025 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQQoA/w0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BB9284883;
	Tue, 21 Oct 2025 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080162; cv=fail; b=ZwWWSnvxrYfuKGVNTL8CbQq8xf8Mo8aSyUdzc7AuhOgwSj/9/mh+/Fni0BfF/+758g42HOn2kzyd5PoiuO2E27iWlY11qcs4ODEL8Gn6CWJ+HGADX+a1o2Y7Za6yoqjrPsszg7Wt1LX1S0w/Xm4MwXVRusl68SMymC1AvTJZrIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080162; c=relaxed/simple;
	bh=NGay9EAiGXcX0+Le1G2e/9KH3wv6pnPN+DF+7VKAv44=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XXR/4OFscpfKe8m3D46wLDsGcCw/FlRBtf84+8lu2rQ1CMQ04a70HUrHdangG4+z2ra6qu1Nn8BXdRfHKL385beMh1Vd1PnX4suMCGZ6P/h3QTZ27nCMYVzcaCsfrJribsaf/jCDpAhLvecK5ZdIcsrVzhS+tAxM7WCQmB4kH8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQQoA/w0; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761080160; x=1792616160;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NGay9EAiGXcX0+Le1G2e/9KH3wv6pnPN+DF+7VKAv44=;
  b=iQQoA/w086QN8/AuWLQyXfF9R+L13ahKk9IH+xKYkVkEjcViiuETEocl
   xe0zOmT/NIWjTAiYDGzFomMmgxyap2jCIZxPpOGhFRYNrqxCfqpsahA17
   ph+eX/jF3RVAfDbfMy8fgdjh/5c4SymwXOG4rwD0Kd03AC1a+iuxebVLO
   C+f3mPvRPZVIWhaTJoz8m2sNt6S/w4vce1WhXyzUrLCksFpPL+eyohdWd
   V4fAsjjfY0B6CS2HrLmq+Sao/ps6LcgW7NES0TQVOOcaktZJJFBIaUSyq
   BTbTTdGZPOIe/nmRcm314SQ0ypeaIFjUgguzrz7Wd0Gskj9fiwrRM3FD/
   w==;
X-CSE-ConnectionGUID: 8kbUsDNVRFCV4Ade7Kcjsw==
X-CSE-MsgGUID: AxNIp9yUSUeni3J9JEF/Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62426518"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="62426518"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 13:55:59 -0700
X-CSE-ConnectionGUID: q2bSCCaJSm2M8cbB4ULUyw==
X-CSE-MsgGUID: soA+xJrrQyiy3DaYLCo/tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="187728597"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 13:55:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 13:55:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 13:55:58 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 13:55:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4M2P5QgFyNv7KLP9+xgqHIPJMrxFp0H8j2N4h5XkKTef2ZCcZPoxv0fJMRKDhUQ5G7nLlGhg7db4NI4oLjgvWn2fZ/pEoMvt4y6WvpKQ1dZF1H+V/qOicIvYWuqLH7SNOuRJ3cz03Uvur/K9OaSkewyU1lvbAiT6DxRepl7hN0TnH5RHB3+5/NC8gYi8D711CgGyfdM6GqVnbzZ/dHp9f4PkCd9twY3AxTwavce7OuB5QpGqSeK+GF+8nFD99d1YaAJ39kD5sKVjkRanOslFkdOlKetBWwy0KooHhbwzewH5mEGkakoiC6a6+1WBnp04u1CImioW+nbFpZPHn3w4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UE8Mj7vJX2KgHpr/NrE5TT0eR7OKP+tRNWI57+7Dqso=;
 b=xGUKJRewjH5iqgq2OO4IG4QChAPyxz37CjlcbXoknE06JB4APYc+TrgxQm6WwbpjeFVcN5J1btxDfHehGAEShUVpTx9zYWZzf5TU0Po1RLGTopzeiGfju7388j2FQXPg8OjfzDeY/0lBXW1069tkMY9hk1E4K++nerUziaTwqSFg7JVjXhEG/Hc8uTccazcLvGmUugDE8kLKQ113I2NT0yl0TlNNljOOAM2TA0ZKdA3COB7MBdKxqNe2aCWWHUauAvH0CpCdTrkt1gkqotLoVh4XoUlPEWFYHUib4VuBDvw/N3GP1Kw5yzAMRwc+fZAZ5agZRRIEHHOa35EYZJ/YTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DM6PR11MB4676.namprd11.prod.outlook.com (2603:10b6:5:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 20:55:55 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 20:55:55 +0000
Message-ID: <144029e3-30ea-4e94-9afd-4da53ce4a657@intel.com>
Date: Tue, 21 Oct 2025 13:55:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Kirill A .
 Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, David Laight
	<david.laight.linux@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-4-sohil.mehta@intel.com>
 <20251021200328.GMaPfnEDibnBrhNTmQ@fat_crate.local>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20251021200328.GMaPfnEDibnBrhNTmQ@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:74::25) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DM6PR11MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: 0284cb21-9297-4cb7-2ebd-08de10e43a64
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0NKS0tLMzBkTDhObmJPLy9GTmxzT1ZaQlJWRVJVOEZRVXN0TlV0dXpGMHB3?=
 =?utf-8?B?elkwbzl2VFdlYmhLK2ZLUzRPTkc4Qm8xekkwSU5SaHVUenlZd1FHWlQ3Qm8x?=
 =?utf-8?B?NTV2d1NLaVBwcEpjeXJCa2VsT3JRQ1BOVGdvVENZZWc2Rzd0ZTJIdVUweUxu?=
 =?utf-8?B?amd1U1dGWmNyN3R5YlhJVXoyUDdWOURhaXVDY1k1d1BMM1ZuQ2x2R0JMSUVU?=
 =?utf-8?B?Mk9Xek9MY0RtdzkxRzdoN2lRZDBpanVlY3JEb0tVOXhaRDYwY0NuUkkwYkJU?=
 =?utf-8?B?MXFWL2hwUTFSdTVjblRNRmsxZlhZY1VHVTNkcGd5U21QcnNjb3BuSnVocXRS?=
 =?utf-8?B?dncvQ2tpaURyWisySWQyN1FpQ1oxYVFoUnpPVjlaQTJSMVhzWi9aU0RhSXlH?=
 =?utf-8?B?aVllOTNrRXBjenJsKzVKa1Q1dTc1RFNrUGtHNWMybHZuRDVnbm4xQlhFRGFX?=
 =?utf-8?B?NE9UUTRVdWFDandRQ0xKZDh5ZE1SM1VPajdZeXJyOFBoVU1ObWVzWURzbWRZ?=
 =?utf-8?B?MzhKTWxsOVllWWdHR2lrOTlYa0EzYzZvU2FEa2lmdWxjS2JZenlZcjVHbm9P?=
 =?utf-8?B?NWRVcEV3RmUxck1qLzVjcUo5dHBTS3JzK0tPR0E5VzZpUzJHVmk4WHNiMEVB?=
 =?utf-8?B?N0txUkwzTmtseHh0UjJEUzVxSlI3eGRxZUJtOU9TbHp5aGJHSkcvL0hLTkky?=
 =?utf-8?B?YjNvbDVlV1Bob1ZvZEoxQ2NKSC80M2lUcVhyVjRMdzZONzY1SUxUN3dpSnhS?=
 =?utf-8?B?cDFRT09SdzZDYjdEL1B0amhqQSthSlAxa29QNGhPL3N5aVhzNmxTd1QzRjI5?=
 =?utf-8?B?N0ZzMSt2QSs0UjUxRzFFM2FmM0tPUFBVRkRKZU4rMW5odVZORzB1NzFJR3Iv?=
 =?utf-8?B?MStrYldJTXI1NHRxWWNCMzRnVU1ITFZFTWRGeDQ3K1pBVWhJR2pibzJheVYx?=
 =?utf-8?B?QW9qWFEydSs2ckxWNGh0NUxEYUFvQzArUHZsWi9QTFVGdWMrdVVUVTk5b1lq?=
 =?utf-8?B?SGdQWE5SYWt0eFI2SENHT1lYUm10SXpZWGZOcFk2Z1puNnFuWk5zZEcrK0FJ?=
 =?utf-8?B?dldDWkpZeE8vU3Q2SWxJVWJVOGFDOC80eWZjSWw5aFVoK0E3RHZBaVVjQi8z?=
 =?utf-8?B?aGlrZzhLVEFPa3JvK2pzbHdCdktKSnJVSGYxMEk4WUhrSHVpTWE2cC9YeFVW?=
 =?utf-8?B?ajlVNGdtaUVFYk9ZMzM2WFlSRDZ3NWdzc1MrK2JubjFhMW4yV3dlY21rOGxU?=
 =?utf-8?B?amJsT1czS2pVUEZZdVd5ZTM4ZysrcloxMVlIdFZuRG5DSTY5RFkwMll6T1pp?=
 =?utf-8?B?UFczMDMyNTg2L3Y3Z2U3L2cvdVFqbDNHc3hCTzRmMDQyT1pnaXJOY2xHckRl?=
 =?utf-8?B?dnlwOXRLdUs5ejY3S25hUzhtZFhCNnpYRFd3cDFjbWUrNDI4Q0dab0F4eWl2?=
 =?utf-8?B?N3poZFBjQjk0akVFRk1wV3VFUlRMUHJETzlXNVhkWTcxR3ZSVVk0bndtN0lz?=
 =?utf-8?B?Sk4va1Z6b1J4Z3V4WVZnQzFxVndlSENybFB0d0FDRksxM256RVYrZ2NWZndx?=
 =?utf-8?B?ZnJEd3cveUJWdCtFVmUvZDRzanltMks5bkVUdDdTcFZ2UUtZMFdkQmk2OGxh?=
 =?utf-8?B?Q2hrUUFJSCtKMTFCVHZLeHNOUnUzTTlLRGZwTmpPNy82R3VoMUZsZWl1MmNI?=
 =?utf-8?B?V0J0YlpUY0RsVDMzanBHV0VSdGcyWnoxclg3NGdaT0RTVkxpSHBmRStZUUlO?=
 =?utf-8?B?akN6UVJRbVlQNTFwd1hLcGc2Wk9ENVE5bzd1SFgvSmw1TjVzWGFGUmE2dmo3?=
 =?utf-8?B?S1d5dmJ3YmdqUWJuVk5JV0NYTjB1c0RYcW4wVlBtMTM3cFFyZUJxZldrQjNy?=
 =?utf-8?B?VXI2YmhFMkFWR2hPdU1JMTI4dU1YUDFxRzNlSXJlMU94SkNVZ1JheTJmQXhZ?=
 =?utf-8?B?aTE4VHllTDhkdDh4OUZBb0RWYm1WVDhwc0MzU05yM2N3RCthZnBKYU80bURk?=
 =?utf-8?B?ZytUbU43aXlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1p3cjlzVFh1aHpKUkFzV0crYm90K3JLMTVXTWpYKzhzRzRCQlBsS3F3STdU?=
 =?utf-8?B?MjJWeTk1U0Z2Nm5hSHUwRGx3emwrMFNUWjF0VjlER2VPZnJzK0lVMERXM2g1?=
 =?utf-8?B?TUZuelhQRUsvZkhJd3A0cDRUYkFseVdnRjlZRVpFWkptamJNVjFjYUhjQ2tO?=
 =?utf-8?B?azBGbVB2K0JFSWowSjFTanczZE9ScGtxVWxHclMxWi9jRDlVREJpUVV0VEp4?=
 =?utf-8?B?cks2dUJKVTNwZGpYdDJDREZaeXlZWmpZT3E3azg0TFpQdUd2b2t1SmdpOUhL?=
 =?utf-8?B?MTBUbzN5eDFxSjFLd2ZQUUxjUUJjZHNSWnNnZVVjeDQvTXpHbEl1bStFcDhl?=
 =?utf-8?B?UGVHbTVXTDU1T3JBbUtqNHRxbmFYa3FkYmExelpPM3lBUUJ6eVFxc29nVEN6?=
 =?utf-8?B?dUNLOSthZC90a3B1dEQ0N1ZVYThEOXVudEJWNDBKa1NkNnYrY3ZVaVY5amVZ?=
 =?utf-8?B?QlVzbUpJTzh1aHFYNjIxSTc5SGpZNmFicUhDekdWZFBSK2hIWDRJWDJKNkk0?=
 =?utf-8?B?Ui9ORlJ4NmpSQVVFTXBCek9iKytIQTR4L3FxRjBzSGo0M3hpUklsSVQ5Q0VZ?=
 =?utf-8?B?SWdCcTVoRFZNb0NDRDdFUER1ODJ0UlVHUHhoU2VjdDBRRHJiZUJlUHc0eGM5?=
 =?utf-8?B?ZHFReG5OdjhKdjRueklTK09sbFVncGFldjB4dHVWZEpSVmJIZTVMU1c1WGRw?=
 =?utf-8?B?UEx0RGRYcUprdGI4dVVUYTdJRGZOTXpTWnJqU3F3N1RjR1FMYkFMblFZK0NE?=
 =?utf-8?B?eWFPbkYwNEsyaXJaVmJ5ZTJTV2xQQkVtZEtPZXhoalhEeGpUbWFWRDA1cXpx?=
 =?utf-8?B?YzRXRjY4b2x6aUtia0RwV0ljaEUrUTRHVWdHUUp5QVd3MTlTeDVYOTlBTFpn?=
 =?utf-8?B?WEU2RnN3cjFqR3p2RmRYMDBIYmMvMWIyQkI0QWFaZHZwdHJPKzhqeUU1bk5C?=
 =?utf-8?B?QTM2c2hFVUU1djlkcVN2Zi8vaUo4bDFBSUhsV0ZsMnFUSHJINXRtR05TMjU4?=
 =?utf-8?B?K2NtU2FSQktPalNaNVN0eG5RN3Nob3dtZTQ4UU9VVmc1NlJBWDlFWDNES09t?=
 =?utf-8?B?WWROTnowTWxRUXcrWkZxbWIwYnhPY1BWaVJ2ZEZMVHVlQlR6YkFoajhPZGht?=
 =?utf-8?B?bDE1S0lLYU8ycW05OStqdnhDc21RcUdob3RjL1FvTlZCRFlqeENhK1U0Wk5y?=
 =?utf-8?B?Z0o0OS9PUWM2Y091MmZVTlRCRkRVTXdRWlA2MFk0UDBDaUV4TTJCTUdualFr?=
 =?utf-8?B?UnNEaGdQWWYvbVhqaHNIeFk2dUdCMFpJWVRzWHlDYmJLbElJV2RkR0JjSXl4?=
 =?utf-8?B?alR4T3EvRWppbGE0bWdMM1lUTVRxOVF3TmhPaWw1anB6NkJkR1Y5bW5sd2li?=
 =?utf-8?B?S0JQQ2ZXSDZoeVBQYldPcndPNlVKY0VmMEtjN3NFbmFSOVVUTjI3UVhKMnV1?=
 =?utf-8?B?V1ZZdHNOWmUrRDRxalY1c3BaRVZseGJwcnJncGRNbWZWNDVXQXl5NkdSUWtn?=
 =?utf-8?B?R1hydFcvK2h6UG54RVN5STBEdTVoRC9zbEpZQjFtVmQzaWtrL2xiWnN1RTVD?=
 =?utf-8?B?K0NpOWU1bHRvclN5MjEwYklZeVV1bWhJa1V1SzhmaVF2dVU1K09mNVplU2RL?=
 =?utf-8?B?dHRiVnJlNUkyRVQyYlFqVk9LbC9rc3Q0eDJKVy9hNDlDQ2tJakZ0WVNaU3dk?=
 =?utf-8?B?UXE2VkxOKzdqeFZxa3hlU1ZJWnRJQTZGbDM5Q0w4ekNTQnBmWDk4a0RNaCtz?=
 =?utf-8?B?SVYwOFdKR2JsSTZNRURWVHN6c2xIY2Jocm9sWVhKbzVYZysyR0JQbjVETHFt?=
 =?utf-8?B?dEpsdHg3TnJ3Nko2aU9JRDdSeDZCaktFZGtZcld3TlRIQ3ZMV3FxYy9OTFRu?=
 =?utf-8?B?OVJJLzlwTUlJdTlzck56R3BNMzNPTEVkbE9JbWlhTS9rN0VleUx5Y0VuOTJv?=
 =?utf-8?B?YnFQamMrdGtFVFpRV2NQTWVpcHd3cFU4SWF6eEYxbktqTjZCQkUwQjZ5RElS?=
 =?utf-8?B?TWp1RVM5RGVGK0JENElKUk9BSWUyUXpDdzEvQzkybmdjK29pU25BcnRyMFoy?=
 =?utf-8?B?RXZkU2FLT0QveEM4UHhsd0ptdHVza1Z2dW1KTFBHRUx0ZG1xc1Mzdi9JT3N2?=
 =?utf-8?Q?Tf2mhWCkJB80k8aWJXaLGm8JM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0284cb21-9297-4cb7-2ebd-08de10e43a64
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 20:55:55.3167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUL05ik+mlo7a3ewhB1zE2tRYbBYx8XiMDddYxqFCIQoiMjVmxcvP/qnY+KwiV4TCNIETWvFdTxvcRmLbvP82g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
X-OriginatorOrg: intel.com

On 10/21/2025 1:03 PM, Borislav Petkov wrote:
> On Mon, Oct 06, 2025 at 11:51:07PM -0700, Sohil Mehta wrote:
>> +static __always_inline void lass_clac(void)
>> +{
>> +	alternative("", "clac", X86_FEATURE_LASS);
>> +}
>> +
>> +static __always_inline void lass_stac(void)
>> +{
>> +	alternative("", "stac", X86_FEATURE_LASS);
>> +}
> 
> So I probably missed the whole discussion on how we arrived at
> lass_{stac,clac}() but just in case, those names sound silly.
> 

I am okay with lass_enable()/lass_disable() if we can all agree on it.

PeterZ didn't like lass_enable_enforcement()/lass_enable_enforcement()
when it was proposed. But your suggestion is much shorter, so maybe it
would work for him.
https://lore.kernel.org/lkml/20250626134921.GK1613200@noisy.programming.kicks-ass.net/

Though, there is a slight semantic difference we need to be careful
about. LASS manages 2 types of kernel accesses: Data and Instruction fetch.

1) The STAC/CLAC only control the kernel *data* accesses into the lower
half.

2) CR4.LASS is what truly controls the entire mechanism. If an
instruction fetch needs to happen from a lower address, CR4.LASS must be
cleared to disable LASS completely. (See patch 6 and 7).

In the series, we directly write to the CR4 bits, so they don't have any
wrappers. But in the future, lass_enable()/lass_disable() could be
confusing if wrappers were added for the CR4 toggling.

> IOW, I'd do this ontop:
> 

> +#define lass_disable()		stac()
> +#define lass_enable()		clac()
>  

There is an issue here which you had originally objected to.
https://lore.kernel.org/lkml/20240710171836.GGZo7CbFJeZwLCZUAt@fat_crate.local/
https://lore.kernel.org/lkml/20240711012333.GAZo80FU30_x77otP4@fat_crate.local/

These new versions of lass_disable()/lass_enable() will toggle the AC
flag on older platforms without X86_FEATURE_LASS. It definitely makes
the code easier to read and maintain if we are okay with the minor
performance penalty.
>  static void text_poke_memcpy(void *dst, const void *src, size_t len)
>  {
> -	lass_stac();
> +	lass_disable();
>  	__inline_memcpy(dst, src, len);
> -	lass_clac();
> +	lass_enable();
>  }
>  
>  static void text_poke_memset(void *dst, const void *src, size_t len)
>  {
>  	int c = *(const int *)src;
>  
> -	lass_stac();
> +	lass_disable();
>  	__inline_memset(dst, c, len);
> -	lass_clac();
> +	lass_enable();
>  }

