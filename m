Return-Path: <linux-efi+bounces-4997-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58790BC2E0D
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 00:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27330188C143
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 22:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5627F246BB8;
	Tue,  7 Oct 2025 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVo7N2ZN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A53A1D2;
	Tue,  7 Oct 2025 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876409; cv=fail; b=Z7/cUHx8Pjv4lv+Xp3jJ31ClQhtt753QuW69kYZND1cLUfGyKaLx7omZNRb4WzkIMUlK/PzdJ90tKxsnSB6TECVcgmO61ANoBYSFS2FsS5uldFu/mRkIw3rNgUDV8uNnXB5L75e3a3jo6OX0gYa3s1JJY1gkuEjM/YxwxCGbaxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876409; c=relaxed/simple;
	bh=r0wik5GRHZhfRF+yTDDUXkAQkN+Rur8nr8FI6OgaW58=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X9DGEwgUBWo1FQnvGqlMSHgfuzBMUczlbklzQY9wuXqgI5EH9tvuQSXMjcD2hcGfN59RgqfOQ24qD3Lvg0m91cKTG96Ln2EnYLHCnR6PhUmuLJQS44vaNUl00MMkL7R93CAhVo+js9MopFe4PKpH6NaCFHBdkDyK9YElHIz7eoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVo7N2ZN; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759876407; x=1791412407;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r0wik5GRHZhfRF+yTDDUXkAQkN+Rur8nr8FI6OgaW58=;
  b=mVo7N2ZNN1R9C/7JvH3tMfJqFZ9sYqNCPVtrKQkR7w7BhF1aanla0PuK
   iKrxW5MWX4Ujp+aoaQIAB6f4PJHRd552xYPtfCTAS60RqJ312K0hkKT2H
   HXIDdfkZhSHgxDux8iEdg+eiTX/ifr85Rq3PTJTDaYLR7iCFRmcbVwGHU
   g0QFzTLIOoQ5yAR5EtYcFKRiSQqR/Ry9c10s1icjNscMnfr41nJSVw1G0
   B09NTSGkfKqEyY6dsV+acoWiWFVsmrp9gCF8Hsj170XF5uRAxTpCQ2B++
   9+yv9Ie0tOWv4h1ocNt07rc74NWg1qva65rS/AN7suSGoJimloKJCtKKb
   Q==;
X-CSE-ConnectionGUID: 5ORA0qYrTrevjYN0hQE29Q==
X-CSE-MsgGUID: kZ1zRYZ2Ss2DsG92CSYedQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62014513"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62014513"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 15:33:27 -0700
X-CSE-ConnectionGUID: 6lIVtykRT9uiIaQMLpZcNw==
X-CSE-MsgGUID: ImTsQVuMT1SIvKGf71aYcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="181052760"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 15:33:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 15:33:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 15:33:24 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 15:33:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJacGLugeZhqJoM1EGmeggJNaQnLOpQiPvdFuxHYe2lZ1zR1nwNB0P6a7DH8fDzegsyCoqv3kCxWeppsxneszAzRG2mipsCGzZR4lcnsjGMR9nT9dDI7mlvWFnGotYmWbbc5EmpTc83bLELKubXXnp/VbcpkQkeOYKoTEb8tEX+gjA5uyjg0uz/Ni5wckExZyGewBouWLTb/JW6z2V6bibQZPrWn3RA7if4iNtv+SqR64tyxt2HZgWXHRyl9n2WHS8TPu84ZGNVdRurrxifioCAnF9LfBddLMi7887mYz7VLKnX/Sln5pW+EIUB0iWme6wHVb9k9vfqRCKxd/qAsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPP4//7MxyuBzhWMnVZdgTu2ZErsm3WdfxekTnQcicE=;
 b=OXvX5ZtJyfAiAFTfqUmSA7P5hpFanvmMSQEFyUMzOerpmeYxTAy2L1TbKmBfftxoy0vezbturIBhVobVM7fbNL+Stsl/k0JCmRikEbGbu1NcLtLI4MWgQIQwWFpswCNXSCbc/Y/QE6MJPrNl02cjy1m/QOYzER7++tDLnKZXQ/yyfCFInvu2/nQhxaX005l0c2clfv6ZoHJU0SOB820ei4JJsyjTi5sILAyUdjv+3W+3T5+kyj7Fiwneah3gT58mJrQKPXNyxTaUFToRVahkICJx/cazB8zf2rJtvxafRV+fAS+4tujqoFphOnPycA+xB8uWVEZCiUCB3+NKLy6UlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SJ2PR11MB8566.namprd11.prod.outlook.com (2603:10b6:a03:56e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 22:33:21 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 22:33:21 +0000
Message-ID: <b17c85f6-7c68-4fc4-8345-6ceb9c7848cd@intel.com>
Date: Tue, 7 Oct 2025 15:33:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/15] x86/kexec: Disable LASS during relocate kernel
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"luto@kernel.org" <luto@kernel.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "Luck, Tony" <tony.luck@intel.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "vegard.nossum@oracle.com" <vegard.nossum@oracle.com>,
	"xin@zytor.com" <xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-8-sohil.mehta@intel.com>
 <91d9ea3cc16bf76e682b43f6b0e3f9d53dce7724.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <91d9ea3cc16bf76e682b43f6b0e3f9d53dce7724.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::35) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SJ2PR11MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: aa579e09-c6c0-443f-d2f6-08de05f18545
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3pDRlM0T3lwdEhwTnFJVDFHdnV2QzVVR0ExaE5zcFpacUJQNWxhZGNjL0xH?=
 =?utf-8?B?WjdoS3oyTE5QQU5FSkVqRDVEQ0UrbEdLa3NrTkNwdU9yVzlRbHUzNld4UnVS?=
 =?utf-8?B?MGZITUpDeVBYSHdocDV5VXpONWxCOGk4akdIZVduLzNJYlhzNDRuSWNBbGY5?=
 =?utf-8?B?ZUQyM3hFUWxLbjFBQlJsb2h2OUI2Mmc0ZlNhdWdoS0ZpQnBRZk5BZGk2OWt3?=
 =?utf-8?B?QW1JeG9qdnBwYzNLenpvVmtPVFNvVzFKbkF5TEl4VGlXMnJiaUZ6SWZ6WkFK?=
 =?utf-8?B?ZGwzZ0FWRXh4N20yTElPVFhhTmFJY2FBSGdPN3JWNUZCWkh0RHh1VFpwV21E?=
 =?utf-8?B?Y01MNXlwMTlOMmxzcnE4RjRjcVRpUDRqWlNVcHNkZlFaM1I0VTQrNzlLSmhV?=
 =?utf-8?B?NVNNSWFWRkRGSUdPb1c4eWVrMDYzY1haMlk5VUNkc1NWK3hjbS9XK0FsRDJv?=
 =?utf-8?B?SVYzK1lSVG1QZnNlMEo1amFmbHl6SUl4VTBOdVMxMDQrTHMreFBobS9za003?=
 =?utf-8?B?SkdNckpFSFRwRXV6VGM3TnRBQkliYjgwK3FuWjdGbnJqQ1prUHVFdU5kR3RW?=
 =?utf-8?B?UkwwUGtOMTNBVXlDVWFsWWxmSzJHZGVHSG5zY2FnUlVvS0h4a1dIV1d3eDJu?=
 =?utf-8?B?Nnl4RmZmd1BTM3FBV0xncHlzZGNXS0VDbWppOUUwbDZZeVU2bUhSVXV1TjZy?=
 =?utf-8?B?Zm5jWFJTWWltTkZyd2VNYk8yWHplOG5PaUZ6Sk4vcldWZHBtR1BSUGJkNXRH?=
 =?utf-8?B?cktyNXJnd1ZWemRVZlkwbHQwNHd1NXBRVUF6dTJ2anovU2toVVF3eUZFVUVy?=
 =?utf-8?B?a0cyR3BqTElwR2haaHN5NWZaWHVoSGgrMEFJNi9wbUphY0ZGWnlIb2NFbUpj?=
 =?utf-8?B?cWk0WVFUUDduWk9nZE1nY3FaYWhWTmJCR20rcnJHYjB4VElEd3MwTzAySWhK?=
 =?utf-8?B?ZkRlVEx3WTZJQ0VDU1RoK1pRWFpMRlk4R0xCclZXdUF1TXFaRWxlZEhVZkVR?=
 =?utf-8?B?c3MxR3FUTUZaazl3dmc1RUpyME8zZ1M4Q1cxQkpxbDBCbjFVcldUQWRFdGRY?=
 =?utf-8?B?V0ZOQUxaSWxqQUVFRk5sVjdWem1nbithQlRsUFZXSStteGNSVGZQWVVPUjQ0?=
 =?utf-8?B?cUF5L2xtL05VSHFwMS9NT2tWU0tISThTUVpGc3JYejN4U0ZuZDlqSmo2Z0p2?=
 =?utf-8?B?RXlhdGgySzlGMXBEeE8wRUg3T2lvRkMveXhCYXR5ZGxUbEZXS09Ma1ZhYktX?=
 =?utf-8?B?NmRtcjBHb0ZOSktyenhuK20yeVp5UENKMzRDOHd2N1Q0YmJacmNFbzYyYm1W?=
 =?utf-8?B?NWI3UlEvbWhUVDZjaDZQV1ZQYjZCSWlDUFc1dVNSSTRzYUM3UjlKS0lITjVm?=
 =?utf-8?B?VFVEVDBLRVptcUpyeXVhSXF2MjNaNjNVY1E0L0lqa21rRFNkYnBKUU1xMFZT?=
 =?utf-8?B?b1I3V0ZrTG1nNUppdDVxbmhlOHRYaStKMThtUE1DU1RwVGo2OU9YNUNxR3hQ?=
 =?utf-8?B?NFRFZGV6eFViRG8rb3VDUit3THRBTkNGV1BmNDJsUWdwR0VpbW10Zmt1dCt1?=
 =?utf-8?B?bmJ4WXdoQXBleFZGemxLbkJoN3JNM1ZMZURiaXdIeFZNbk43VGttcklwOHU4?=
 =?utf-8?B?SE11VUVETkVrYTVyL0hSb1gycHFQREUrVzdkbGw5V0lhUllVLzU5Tm03R2Ni?=
 =?utf-8?B?RXFLd1E1YVBVSWpXVlBjNWdPV0JvVXVZTTVPazd2NnBxRDdHSVd2SnlZUWNu?=
 =?utf-8?B?YmZ4VmhZVzF5MEJucHhjR3JlbllFNkFhUDU0V0RaZ25MSzFrU3c4UHdFTFZm?=
 =?utf-8?B?MHVsTnJQelFwUFdHSVNXYVNoSUJ3dzBjc0NZL0FqTVkyNG1NWjFrUml5dDRP?=
 =?utf-8?B?OWZQdnB3RHBNaWhENVczTVpiWXZYK3pmOU5uS2ZLODkzYlZhSmZSWnpLS3M2?=
 =?utf-8?Q?gZTLO/2KmXT+WwVEaLsEYg9ay5gMo7Gx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2hLNE4ya1Z4VHJmTTA0c1NuWUoxUkdFdUF1bG1UMXhXN3JsalY3L1lqTExF?=
 =?utf-8?B?ckxXdTl3RURYTFhvMG1XcHc4cCtqZ1NGMHlWd0pPdkpadmtHWnRRdnVZcUpH?=
 =?utf-8?B?bEJmZGZuZGhyTlN4UnpnYzF1bVV1Q2VDNXdUKzhrRW9rZmxicnZlUEFiWjA3?=
 =?utf-8?B?RnBxYTVwUGgxT1JZT3MvdTBxeWg4Y2FQd1RuaVo3cTdqTGNFVkIwZHprZ2ti?=
 =?utf-8?B?REdvT0swZ2NSRTJqMzNFV0wrSUJ1SnJRMXdDVGRDZ3N6UTlyL1lhTVNKcExq?=
 =?utf-8?B?S09rQjVkZjFiVHkvZkpIN1k1aTcwK21rdWdEa0RZRkJpYzRudUJWWjAwZTBj?=
 =?utf-8?B?dXpsc3dhRXhSVldubEFaUkxKYXVKUWdxdUZpazNHQVN6MGRoaE5sVGRpOWVE?=
 =?utf-8?B?S0dmT0h3OHZJMGIveGpoWUdCcUpSSVRBZ3ZXaXNNejd2UFJpNC9PclBsRG9F?=
 =?utf-8?B?aUs4c0pvUDN3R1IvNW5GdWw1TFkrcExZMnRJVThXNE0ySzV1MndVeHJFQXJ1?=
 =?utf-8?B?NklFUFE3RmttQXpNaVF2L1U2NUs4VEhsZ1pLdnJYSkRMVEsyRWo3NERSREp6?=
 =?utf-8?B?dzltL202SU1Fa3NXMytwK1pmbVRyM1VTVVp2L1FHVm5NQXk0NlMrQlRRYXZV?=
 =?utf-8?B?dmlheXR2RlByc2IwZDFGNy8vLzlnRHdyNDlSQjdDazdMcUQ0bmUvNFIvNzl0?=
 =?utf-8?B?OE1tV2ZwbStoTVUzVVVRWUFwTkZJUkVkNy9PMnN6dVkxNWRUWEVDZDFiRVBC?=
 =?utf-8?B?d1lwYTd5cnhEZE5DVDFsQzFpWlZVY0ZScE10emZlMzR4V251UkhUS0FkWG54?=
 =?utf-8?B?d21jc1ZWb0RiZXMrNlJpcWpLLzRiOW1nT0llTEVEdStBbXpOSm51bmRDbjlJ?=
 =?utf-8?B?R0h4d2laNVhEREJsaWRpZnZLOHRtR2JUT3NOY3lhUzJYWVdESlB6ckxGZmxM?=
 =?utf-8?B?YWc2UDg4MTlhOWpKRnFhcTd4SVpTbE04cjY5Q080WjNjaTNsYkdqRi9ucTlF?=
 =?utf-8?B?bTR4cEdLSWQ0cWw3N3V1V0k3S2JDU3Z0aTZobWZPUldCV0VtajRwbk5HbGkr?=
 =?utf-8?B?RW1vMEhyNjl6RWhieU9WNytZSGptNkcrVmM1SDFPdDZoWHRPeXhVcEVRTnlX?=
 =?utf-8?B?YnRtcS9yOUJCSS9Dem9hVVNUeitPNzBQTit2bjJLc2hQcEIvbzZON1ZVRUEx?=
 =?utf-8?B?N1pEMkdUYVdhNjZYSEo2clRBc0ZPLzkzMSsrenRkYTJkZmhaNGlpbTdOQ0d4?=
 =?utf-8?B?bXdzT2VJenRZdHIvdnRyNjViV0pUQzAzdy9Fc1pEOGxyZjV1Q2JKQ1BDVm9M?=
 =?utf-8?B?QlhMU0pCUTlTL0hvV1BoOXZpcUV6RFlUM3AzUGxJM1FCSTUrVjBlYnNjRjRo?=
 =?utf-8?B?MGtBUjNHUDNjbHdvdjMrT0wyQVQ0c1ZGU1ZWMHpaUmlBN0NBcHM4WTMzRjk0?=
 =?utf-8?B?SzcybTJyWXRZTWk5b1R5SFBGTTFHZHdabFhXWVg1a3M4MUQ2RjRwRnlzNWE2?=
 =?utf-8?B?TVBvdk1tMEQwSXVUM3U3WGRhWno5YXBPUHI5cU9rTHlCM3EvNWU1Vm9iS1Rn?=
 =?utf-8?B?MGx1SE9ReDdVanNqWmR6WU5xU2EzSkN1eVh5aEhNa1JYVkVqREdqZkljY1Aw?=
 =?utf-8?B?U08wWENEaXpvQXN0L0pTZy9YZGNydGFHU1NKTFZweG1RaEhva2JyMGt2dWdB?=
 =?utf-8?B?NGgxRzZxRURjTm9sSzBjZmt5QUFuUzFwTWcvV1YrQjNPYmdZR2djOTFOMjV5?=
 =?utf-8?B?OHY3TW1KSW9CZ0UzL2Y3TlBtOWJUbjNEWXZnZzNqS2NhTHcyRHhwb0dHRktq?=
 =?utf-8?B?NEh1Y1M3ZnR2TWZBbWFpN3FzRTlDSnBLQlFOZHF1eGhEVmhaL1Q2eVExb2dU?=
 =?utf-8?B?L3VoTVYwbmloTXRqL2l1SFpSdE42M3pRUG9ML3IyL08wRmU1dnhFMm1jRlc4?=
 =?utf-8?B?OUFYK3NVMExneW5nVDNFWU84VW84SGUrNGRtSUR3bWFOdXYwT0xqQTl6VGJO?=
 =?utf-8?B?RzFsTGtkUUZ3SWM5bjF2L1plZXlKT2RhSlFZNVh2cFozb1k0WTBMd0N2UlNM?=
 =?utf-8?B?UzFxK0NqRS9ENVJvMTdPWndxRkdveWdhTjJ4TFFWSFg1WitETE9uQkNkZExp?=
 =?utf-8?Q?gItmCWqcBMxovjpJ6hp/nNjG+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa579e09-c6c0-443f-d2f6-08de05f18545
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 22:33:21.5814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjARFdxD4blWRRedNgeglWmpYgl7cGq2Fy1sV6vEyqD6C7Cn2Cev8arZNNvEuFQfTP/CNNjcOKJWXWvVdHL8YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8566
X-OriginatorOrg: intel.com

On 10/7/2025 10:43 AM, Edgecombe, Rick P wrote:
> On Mon, 2025-10-06 at 23:51 -0700, Sohil Mehta wrote:
>> Relocate kernel uses identity mapping to copy the new kernel which
>> leads to an LASS violation. To avoid issues, disable LASS after the
>> original CR4 value has been saved but before jumping to the identity
>> mapped page.
> 
> It could help to expand on this a bit. Something like... We need to disable LASS
> before we jump to the identity map because otherwise it will immediately die
> trying to execute a low address. But if the kexec flavor gets to virtual_mapped,
> we want LASS restored, so we need to disable LASS after CR4 is saved. We also
> can't disable it where CET get's disabled because that is too late. So disable
> it along with PGE.
> 

Sure, will add the detailed reasoning.

