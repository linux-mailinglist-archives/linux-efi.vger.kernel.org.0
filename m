Return-Path: <linux-efi+bounces-4992-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 680C3BC29FD
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 22:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C16A19A1495
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 20:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14401B87F0;
	Tue,  7 Oct 2025 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gd75tzE5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46B41AAC;
	Tue,  7 Oct 2025 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868445; cv=fail; b=kIXZQ2d+bYiMNTMiI/omvzAtllrhp+LA9f8sACmsq5Lfuxzw6hCZHfDD8J4KnbDCUglz/8MKdzY2CCe1BAThKk4d8FY3ea8KLFuN0LrFDaaGsZr67NI44tI/CK5a8c46TriWDwNMtKIOmDQAJ6TZ1n/YsbHcdjNIdIOyxvCDMfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868445; c=relaxed/simple;
	bh=fI1OznA5oVsd2kycEQP3vqADlAuHreiFbXSJO7PH+QM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vrra5rSGvbiIyIWj1fGEmYxQbnH2PG1RDSgfKXk9LjDQ/v0iJ6t0AGjU2xJxZA/Er1uobmYHweVp5XtJN18lR5J1L7jQjT/VQmfh63LXWsY9N9oMYWuByE2FPNLy2PpOWVPChqF1WbWshkf8okfxpXIJCbIe/J+YoGRth5NpCNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gd75tzE5; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759868444; x=1791404444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fI1OznA5oVsd2kycEQP3vqADlAuHreiFbXSJO7PH+QM=;
  b=Gd75tzE57yJh0/YiGhyeudvjtQ6N0CtaqQoJZCT6CDnLS86wv+D724Of
   bBs5mhl7JCt73UDfFKp/A6e49uIykwz/jXpRmxP7SsxIbSSXgxS0EOXKl
   /G5Jx6dXZJa9SMy/DXpb6c9Rhm8VioS7NDb9zXnqRQ6oeiHhaEY5Hwooe
   xbpxPJ4kq9g+4zofaZ4tYYIIB8xlyKdSM4Z4aVwv0GAEotNmFs4pRaiAq
   FCTdE5m6dWnjLhBgi/pKMXMJy94ZBWsW4v0dcJbSH+i4eSe6hAaCyyiZ8
   JenZJ9Qcs9ZYT36jTTHQAexLlkTCahRt8MFFZgXIWjBO9Xlx+atbpX4SK
   w==;
X-CSE-ConnectionGUID: a2mEIs1sRZWdI9Qo2K1G1w==
X-CSE-MsgGUID: Ic91S6eAR3Wz/YvISRp1RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="49614427"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="49614427"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:20:43 -0700
X-CSE-ConnectionGUID: qyEpkIWoR5ePSTQ4+LVEAA==
X-CSE-MsgGUID: 1/oL6CTITka6j34pkxjK5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184626625"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:20:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 13:20:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 13:20:42 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 13:20:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYaFMi3YUHxWeWTcZHSTH9808fnSWGAreRWUgr073Mls7DNHEmH9fy2bEbs9epqYUCIMVyq0zJPt7NrlI27voQyDNq8acVO4sMuGBauadiTlKodKkvK/NpiKw/Bt0wC+AMcj2Maqub/c0Ud5fmtinj0GfSVEtp3cPEYqMoNFGXBCfY7UiMzd29qn5M+VbB7ZIHNubAcupPFs1VVL1A1Ddo10D1VZ6xB5IorpZ/PPEsfomPvny+8bJFVPSVTmRDZY0Yc5/mZfLZnnSCjeZE8qG1dmIF36Ox6fQ7rYb5XNqj8IClEp4UbibYfcBriqg6Dh0S5RcD9q8XRyUZsifoK0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyaaS2UITeA099+bgrJ25+36SDFgtfOLLC/94j2279Q=;
 b=NHxzujwo0J4Xb+5Z67Jn0VlFPnGpiRc0snuA1IOmXbPKfgTyAMrx+fwNBSI1CWCo8g++vmFZosX9lM7u79wt22wLwMtqnT7jENt1UwPGCKsikN+xU0MQH5XJ74iJfCyfR6rm1KkHceVopw8GJzebPwdD1fC4QZNAe0+w2Cq7DGYzBGBgQU3vEEY1aEkwga009YDewQpSIFvjvw88v8KCrcLa2PzeBGpLFJt55eREplyiQrMWm2c/M/3c8UKp0iMAROOfEJlxaPUmkrqac9NawdI8f3u1OcHwABcI7bF8h1O5CiIRmRBIVX7g5URJbHJQLakZfDkNKoZPWRO8PxwThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by IA3PR11MB9062.namprd11.prod.outlook.com (2603:10b6:208:577::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 7 Oct
 2025 20:20:40 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 20:20:40 +0000
Message-ID: <ea578640-c02e-4ba9-b0b1-e9a5c9c313a9@intel.com>
Date: Tue, 7 Oct 2025 13:20:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
To: Dave Hansen <dave.hansen@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
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
	<linux-efi@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-2-sohil.mehta@intel.com>
 <47fb7efd89698f46a305ca446d0e4471d1f24fbb.camel@intel.com>
 <5d95d421-1413-46de-a578-c2a0e44e3aa1@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <5d95d421-1413-46de-a578-c2a0e44e3aa1@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::7) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|IA3PR11MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 540c838d-3fac-44de-de0d-08de05defbd5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzBycUp5YlpyaWtPaWIzbWFaZzdKMWRxQjFEdHNyYmJua09aZ0tqS2VZVUlo?=
 =?utf-8?B?Mk5wVWY4M0lKb1RoY3dwRmRCc0ZGNEY3QXNyVDF0YW1lSDhzSWkyWkJjWnk2?=
 =?utf-8?B?RE5zWm9OU1IzbnI2bzJNZ3g1QTNlVmtuUzZXaW9DTGJTOUFZd1J3NmxQZFZY?=
 =?utf-8?B?L3lOT0hDZkNSQ3lzMERzeDhlTlNpc1JmbGpHbGY2WmxhdVRGbWhvVndtMVNh?=
 =?utf-8?B?WmgrWkJXYWNLc25JaXNqVDZiWXlXQ1QxZ0RrMVh3QzlyVjJodUh2UmkyZjlq?=
 =?utf-8?B?TXRpL1FxKzhyaElOYThmM3dGUXhNS1ZKbXBtenYxWGZjdklGNEl2Y3RaVWJk?=
 =?utf-8?B?QTU1aWVGRG9TVVlrRW1Hc0JMSmJUVjhJL2hKK284OWRaMnp0amppYnBtdklU?=
 =?utf-8?B?c0tYN1Z6RzRPUVNnQUFBdDBhUUVHZ283Y1NTeC9uVWQ3YVpWdDkwTlJNUXZT?=
 =?utf-8?B?MnpQQXdOcndHdWxBbndmZUlYVWY0enJXRkJCTi9rbjEyTWhDcUhFdXJRLzZG?=
 =?utf-8?B?dyt3RFh3aW1iUjZkRWdyRmo5VFdBbFcrWVFkM3VXaVA4WmFWQUpZWnVEOFRM?=
 =?utf-8?B?T0xKNWk4Uk5EU2h4VnYxUjgxQjlzTVo0UUJCa3ArOTcyWFU0ZUlzTGZxUnI3?=
 =?utf-8?B?WmV1V1dHdXFtd3Jrck1UN2U2eUhtL3pyYW1XZDh4dDJSWlA3eDlQTVRQOUJu?=
 =?utf-8?B?ckdmci9zczRiWTd3Nm4zS29RakFzZ3J6RnZXK0FpMXJteldBcXByMnBIcnp2?=
 =?utf-8?B?N1dWS2tPemVwcFRFSi9CaG0xK2liaUxrb2U3SFFnLzFnYmNycjNEN1lnb0Jz?=
 =?utf-8?B?Mk5lNFF3bU1NK0YzTmlWUG4wSlZPQUk2TmhabENGNUM2OEM5dmQrbUExREZk?=
 =?utf-8?B?bnNmUVFOMkFhUVl6S2QxT1JkU0xNKzVkVktZblgrdm1JVFdLK0IzcnNmK1hN?=
 =?utf-8?B?bWFlTjJQeENoM1RWMHVPSVlwdkYyQVdxaWk5STZ2SGRGUVZZTXdVUGxGM0pt?=
 =?utf-8?B?dkhvZDV0ZWJQK2piWGlBTzkrOUhmSTRzdURGYlNqdURPTExuNHdwZHlGeS8x?=
 =?utf-8?B?NWFLUHNJRllXUmhOKzZPbk1ubkwwclprS1dGWko5amllWmFsanF3SCtVRm8w?=
 =?utf-8?B?eE1rc2xVT1J3cVpPR2hSWElsM0dzRERSNE1CQTFkL2RRWW1Vd3d1MDFaWjlu?=
 =?utf-8?B?blVKcUFsb1psMC9vd0tPZ1ZjNG5iSEZwNmw1T0lCTFBGbDF6U2pJd1hIV2lx?=
 =?utf-8?B?NFMrbUM4M2pjQUFYZnRrUGZoamVzaExaekNINlpzNlpmQTNmcUZ2NnFycG9p?=
 =?utf-8?B?RDVnOWRjSUIvaVhESzcrc1FCOWg0U1RpbEpWSWZYWitsUS81Z0JQeWlLZ1o4?=
 =?utf-8?B?cVBNRlBjL2tJcGN0cnpoZ1pNWDlUaDBjeExETlpROWdsamlLd2hPVDdHelJq?=
 =?utf-8?B?Tjg3bHhmVnpNQUhiazZhdUpFd2s5MitDM2hDZmI1T25tNnpoa1BpaGdRanh6?=
 =?utf-8?B?WUlhV003YWEyK1JrNVEwL05lNmZKYm1TZStPQlpEU1pnNzNPTUF6Y3R3RWtV?=
 =?utf-8?B?SUlPZkJqRHlaYVlKM3h6azBSQXJlWm1YNnJ1SE9QTWpJNis5Qzdsa1JPWXU0?=
 =?utf-8?B?bnpuZnVlVmdldDVzY09IUjFQUVlMelduTHlGaFdKL1FjVXJyYTBWekEyRDF0?=
 =?utf-8?B?MGx1WVkzTXN6WVNDbjFnajk3eWw1dGZpSkpDdVB3dElhQU9rNWU4VldkYVFa?=
 =?utf-8?B?S2dGcllRN2dZL0djSFVMWk5uY0hzTmZUZ2JhKzdnclphcDRBUHRPbUFXY0JO?=
 =?utf-8?B?N1I1dFRjNGFDMm55RGhOUnNQdmNqV2JubUkwb1pQdjhpemJreDEwMGxHUUov?=
 =?utf-8?B?WVd1WUtEKzNsRVUvbXJ6QW90WUVRcTZaZkJVNnh5NmlHYjlJUHFLeEV6aDdX?=
 =?utf-8?Q?LeN2OllBJYnzegRtI75UiAOsbJbyYYe7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0VvbmY2MVZRV2pwYTNQMHdmN3hFNG9HMGtzTmxITldjZmhWdGdGdUdKWTRB?=
 =?utf-8?B?WUpCN2hPcGwrVnQ0ZGdVeUZDVWhNVk1MQlU1QXltbDhtYlg2ZTV0cDE0SGZD?=
 =?utf-8?B?S3ZnRGF2M1lpVW0zYkFybW1BWnBOVDhjZHZyOWhtaDNXKzlwcnVPZ1dmWjhl?=
 =?utf-8?B?d1BvVXF3Wkc2WUpvN2x0elNzcm1wTlI2bldWakxXRDNQQ0thZGY4WElYVzN0?=
 =?utf-8?B?UzZTbFlicWFHVlVLTDY2cmZXeXEzNWFqUS9rMDlVNU1Nb3R4MlFaRTRxWDlW?=
 =?utf-8?B?U1lTTHh5OVViZUw4VlFDdE9RU1RjOWIzK090dERwTHZ6OXk4OFdKYnA4Q2FL?=
 =?utf-8?B?b1NBeVBSZDZ3NXpGZGE4N3NLa0pPc1lldEdYMnhqR0pJSGZac1FRdjJmR3pL?=
 =?utf-8?B?S0xrZDV5NFZPWmEwdmRKaGorQ25ZZ1VrMkdMUkg2NUtyMnkxdmp2RWpBY0pF?=
 =?utf-8?B?WE5vTGFvN2pxVENWRnhjTVBxVW9uYklqbUpUVHBudk10QThxOTArUFRHVFBo?=
 =?utf-8?B?bnByczJYNlNvdkxJMFlNdmlDRVliK3BqWEFSOEVySVJsWmFUc0dhRk1ZN2lN?=
 =?utf-8?B?dkJ3bzFFMnRVTmJVd29xRWtreDVhUjF3Mk1RclA0UGhMa25PTkVqc2pBZGtu?=
 =?utf-8?B?blpuckozMGR4Zzd4Vy9lakh5dWJBbDlHSC9xNklvWk1BUG1EMkpzVzdsZjVl?=
 =?utf-8?B?czQyMllMYU9TbmErbkc1aDFIUHF3QW1xbWFaUncyYzhMZHR6V0tOL0x3RFk5?=
 =?utf-8?B?T1diQWhpdC9aZ1IraEd4NS9xZENwK3VDWjI3SmMwUVlZYm9CeHAyZ01VRDA4?=
 =?utf-8?B?WFBqTVMyMFd2eFc4ZktrVHpnaU1LQTlJR0F4Vmc1dS9EaE0yZ0l3eDdFaksx?=
 =?utf-8?B?bENOZUN4VlRlMi8zdllFaDhHUTdYNGZvWGgyemtXdXliU2prV2djVmc2Tnln?=
 =?utf-8?B?YStxOXBNRTJJaEdoOXdrVXNOcUhhM3grRnNIMWUvdTZaNE9Xa1pnQXczLzVC?=
 =?utf-8?B?YnEyQXZsTWdFejM2YWtBY29kbnk0eDRCaHQ3U1FRWENldHFvK2hlSG0rTTV1?=
 =?utf-8?B?SmYzT2NBMTNsb1MyUkFuZWQrVU02TGJMSXJNaDRWQnR0YjBpajFCTXJ3TE9z?=
 =?utf-8?B?VGtyUXh1V1N0SDZsZ1EwSjhNOEcvZlJpYUliYjFqUTJ5RFIwQjM2Um5zVlFP?=
 =?utf-8?B?RFJVS1ZsZ25HWjNWaVNscnlFWHFNekZPUXU5QURtS1pHWXhneUdoTjNyNkxU?=
 =?utf-8?B?VVNuRVkyU1FMeXBVR05qZGxDOEpLNVZ3OEpTenUyVU1JVU5XdElIVGs4SVhC?=
 =?utf-8?B?cVF1c1A2QjRFSHNjT2RucEE3YmxqL3lEaGRpWXBkWnZvbklQQ2ppNXVPNDM2?=
 =?utf-8?B?aUxnYWFqTEZIQXQrMzJhYW5FdVc2SGs4QWZlQVJIaEVHVDhsM2dqbEp4UDRz?=
 =?utf-8?B?TmhQU0lkRkhEK1pUaS9xSDh6ckN6OTZocjdPMDlXNEZzbXh3NE1LM0FnNE1I?=
 =?utf-8?B?eVEzZ090eTJlanE3a2Q1bE00N01IcEZzdEtLM2Q2UDFzYkZvZ2FLOVFTblBE?=
 =?utf-8?B?ODlsQzAzaStCUXJkQ0dEdHoyaUt4UVU4WE9sUnBpdHY2dkQrTGpGYzU0VHBG?=
 =?utf-8?B?Z2ZlQkFSQ0ZhaFVDa3B4dzBUNmhtdmpqeDE1TU9DNFoxbDR3a1hzUVFKUlYv?=
 =?utf-8?B?WUtNcU5wOHhNa01rUDZWWHllVXpwYjZTeW5rcHR2UkF3U01ZMzcyRjZpZkI3?=
 =?utf-8?B?eEZIcVJVMWZrbnhWOVdtc1lVRlE3YjVtSjdIdStHY3lBd1E3U25jb0lKL0xx?=
 =?utf-8?B?VXdUcDB4Z1RVS1doWEpHRFhvZkthYVJyMitTVlNiSmJOZ0Z3WTduQ1F6d25u?=
 =?utf-8?B?RHhMVUY1NFpYTXFBQ1FJTFI3OU9STHVGejNjN3ZGU21xT0wyaTVxMWlVTHBp?=
 =?utf-8?B?NW14TEpZRWcxbWNMM01BVmlOcjE0WU8yc3dPUmJtNEliSDJtT2pHRHJ1b2tU?=
 =?utf-8?B?Mk1jc2RkeGpDSEFDdmd1UEtPMjB2UnQxbytDaWQ4QVhpVnQ3aDAvaFpTeFlo?=
 =?utf-8?B?bjBINTJuUDFqR2FPV2FXS1NSbWEycEFmajVRVnAwSmcvWkJ0aUNuUVNtVSt4?=
 =?utf-8?Q?CutZrdXV67YZliOgbqWqAIv49?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 540c838d-3fac-44de-de0d-08de05defbd5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:20:40.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Mk4xk0PluVSxojCrykP8usGQP0j2VFycS8zB+giJsWWq6T4GZ9if3QdwuYRE/kdB+VTMZDXmbpipjI6Lg0Urg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9062
X-OriginatorOrg: intel.com

On 10/7/2025 11:28 AM, Dave Hansen wrote:

> STAC/CLAC are also architected to:
> 
> 	#UD - If CPUID.(EAX=07H, ECX=0H):EBX.SMAP[bit 20] = 0.
> 
> So, even though LASS _technically_ doesn't require SMAP, it would be a
> real pain without SMAP and STAC/CLAC. Thus, this series relies on SMAP
> being present.
> 

The spec says,
"A supervisor-mode data access causes a LASS violation if it would
access a linear address of which bit 63 is 0, supervisor-mode access
protection is enabled (by setting CR4.SMAP), and either RFLAGS.AC = 0 or
the access is an implicit supervisor-mode access."

One could argue that the LASS hardware enforcement of the kernel data
accesses *depends* on SMAP being enabled.

> Actually, it might be worth breaking this dependency hunk out into its
> own patch, just so there's a nice clean place to discuss this.

Sure, we can talk about the above wording in the spec, as well as the
STAC/CLAC dependency in a separate patch.

I included some information in the cover letter to explain that:

When there are valid reasons for the kernel to access memory in the user
half, it can temporarily suspend LASS enforcement by toggling the
RFLAGS.AC bit. Most of these cases are already covered today through the
stac()/clac() pairs, which avoid SMAP violations. However, there are
kernel usages, such as text poking, that access mappings (!_PAGE_USER)
in the lower half of the address space. LASS-specific AC bit toggling is
added for these cases.

