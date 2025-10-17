Return-Path: <linux-efi+bounces-5071-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EB2BEC621
	for <lists+linux-efi@lfdr.de>; Sat, 18 Oct 2025 04:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 453B3352902
	for <lists+linux-efi@lfdr.de>; Sat, 18 Oct 2025 02:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39726E71E;
	Sat, 18 Oct 2025 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBJWggKY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC87242D84;
	Sat, 18 Oct 2025 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760756041; cv=fail; b=Q3RbRH2fMZUs1VO6B4b/aF4G+edR5yEw5ShHPaZbVS25TeS/diMzMZlIZBCALp22vidNaUgf9yQruRbW2rmKg5VDwVzr5grEeYLAl499t7DtiWymsWsGGqDiByL1aMugYItxukcSo11ilW8fgxqmJfgBe6TTehaaBIwcmJfN+g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760756041; c=relaxed/simple;
	bh=s5IYrQXp1atJgbaCbSgWdI2/dRuhn9v6uaF7UWtmbEo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XkGZMkRpe6k2HuoonyI8Ev/dwryNlLnmSKXEZA0QcTllldvMrxWAseppO5kvxRYZ9opf8nXcjazEQtpyHdOdR3tzdhfP0NCtxUtrTNlqADGDEKDnsmDobiLX5c1Q10gzql7bhP6EaefFNkbH01jw6fnGDYpr2adHbYKRDvpV0lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBJWggKY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760756040; x=1792292040;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s5IYrQXp1atJgbaCbSgWdI2/dRuhn9v6uaF7UWtmbEo=;
  b=KBJWggKYWGFA8kDRtdNlDe1L2YvH5YDjI6ZSmi+qpOOfSC7pUNN54H5F
   /g5A1KHeJbaVTXiBtjnWRshNtauV3aiaihezSO0dv8cUiKT6M7Vpnx8Do
   OhDEq8QUD/YuTWWGxFgeP3YwwpVFrRuRzAJl9gYcrLEQBClRqvsFnP9ta
   GwE8FTRIVQf9lcSvf+wMAK5RTSu5VVqf0MEklPOsx5v94cwUG233FDXaz
   8Ij/Bch96aQewv6ZBIV2D9+fvfFexU3U5AAYyPUzN3OwsBWnPpE45k9Zq
   JjvDKKfEqVIoWuv2gc16vNevC5Zu9dJThzN9FHOTOocXfhDPmgKqmsMmm
   A==;
X-CSE-ConnectionGUID: e7+YLlM0R+qcVl9jrskcBw==
X-CSE-MsgGUID: TdBPi7qWTCm402aEvOge/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="73572954"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="73572954"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:53:59 -0700
X-CSE-ConnectionGUID: 8SwYbQmcT3GCqjIITPZh0g==
X-CSE-MsgGUID: rnCKD1rHQEShFR6pmzUhWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="188179925"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:51:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 12:28:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 12:28:23 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 12:28:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bB+cStzQkccpgmXLchqP1yvcoBtSzni7qfPS38IeWFWWvnH3vXLv6Y9zGLKXxDY4XcG+KSx813CjlEZEsXk03B+2WDBSV33+lS2LhBBPb6EjaDfz5UWoP5zKHWCXufza3P/l5XAkfqStaHIPORkkJ9yD1ICBF4k7w2UJ99uocYvP+nbnnZ9EoKUGFK4K9MLCfwKd3NMXKQHUn1iuYVQWHMjGhj5B8JZ9D+MynpnLH4FmBuVVQWpKCbnKHqM5/PlL84rwnIENH/TC3uh1i669fSVyjuzhO30Sb1Jpz+6uYQGHQCXEBsEe9Z8Stw1O0i9Z3acrfaOkwqgJViXOQFZcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIZw0tCVTG06wj39SfBIFcx3CX1CKMLo1RyPU9DshYk=;
 b=s9gUMsS377KvH1xngwz9tg6xksJ4AoiA5kU6kVYiXhSekIDBJiNdGyChTEESvcFZXQmwiE07HAXbkjBn16BnWjuJEPg5aPhC4+qbVdDBXbt78810mGz4/sHhxn9X+1yPBKR6HQ6iTUqemF+DT7veld3hEPgHLHYExTlKTXlrQcS6BXHyg+OgvKiklGSAnhgaOmA8xQ6oV8IPDW4bKh7yQ1HH35BgbM1vSs9dDt++7LVETeiBNHwK9C2vvpD6viii1VHV51MKdKT/Igb2fhfbOizfKzDZ0NmIXKwqFC4EOCVm+1VjQQvUFSm8Y1EK8zC6dugt+bXqWPoTn6OZvBdb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 19:28:18 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 19:28:18 +0000
Message-ID: <cb92cd41-b5bc-4aa1-9cef-f2e73bc05d03@intel.com>
Date: Fri, 17 Oct 2025 12:28:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/15] x86/cpu: Defer CR pinning enforcement until
 late_initcall()
Content-Language: en-US
To: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <kees@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, "H . Peter Anvin" <hpa@zytor.com>, "Andy
 Lutomirski" <luto@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Kirill A
 . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>, Vegard Nossum
	<vegard.nossum@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, "David
 Laight" <david.laight.linux@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-6-sohil.mehta@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-6-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:254::13) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DS0PR11MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: ce86b25a-355f-470f-e515-08de0db35365
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVVXdUJDMDFXLzU0aGYyUzFXTnRaT2RSaXFEbjhSaW1pcFFvWU5FcHNWQW9o?=
 =?utf-8?B?UEdkb0I5ZGREY0ttNWtnRExQZDQ4UHRWeXVKN3VUaWtmREh2WjVyd1c3SERa?=
 =?utf-8?B?bGRtRGd3YktEVHRsZThWMEhiMHdtQVVFRHlYZGtLVDh1bTB3Mnc1UGUwU21D?=
 =?utf-8?B?RUV5NDEwUUNxdW55NjhqRjFXYm1zTGhyNVF3aU1Wc2d2dUFkNUNwWnZQcDlM?=
 =?utf-8?B?Uy9SVDY3Q01xSS8xTVRyVTNaS1FDamxZMkdOMEJiaW0zTnVxRGVSRjRHc0VT?=
 =?utf-8?B?MlZaZUNIMEEydkhLb2tLdHhkQyt4U05BbDBoNndrdHJpZ3BLZmdBQmd3YktF?=
 =?utf-8?B?ZXRHRFd1SzhFTzhmOXEvOU5ZZ0RoL2t1RGozVCtlY2FpTnpFOENKUkdVem1r?=
 =?utf-8?B?S2wwNVR5RXRsN2tBMnRweFJoSmZuQ0E2OWNVOFMzWndoTnZIaFg4Wno5Q3BC?=
 =?utf-8?B?QUFOcjROL2o0ODJSYStmSDNlNEY2S2xRVGlWZFo3OU5ZVjFkditYT3lRcmlp?=
 =?utf-8?B?K0dQQUJYRC9TUlltbTJBUE9xeDExYUpYSnRHM21sbUtydjFyMjJXZEdMTnZW?=
 =?utf-8?B?RkJBUTNlbXgyTzVINURpNkUzUSsxMWxGU0MzY3BzMlZLWWtlVitwVDJCcENF?=
 =?utf-8?B?MWtuWUUxT1BZL2piZkxiMG45Znc5eWVDL3FsKzRPOVFTZ0Q2Mk1valNuMm1h?=
 =?utf-8?B?RTR2RVI0VnZPQmZNbFBSTHFNazRyZHZOVzVhK01VSTFFcTlGK2tqcnBIYzMz?=
 =?utf-8?B?WmY1ZStjQ2NRTUlDd3lSZUpCRHJrelJzaUNkWU5selkrY1ZuMG04Qkwvc0Zx?=
 =?utf-8?B?Sk5hQUg3Y1MvaWRpQ3E2b0dibnAvZTFTWmhxYTFMUU5DMFZBdHhONkVZQTNm?=
 =?utf-8?B?Q2RraE9ZemJjb21wRyt1dkpoQTFMT2lLOWZxZVBRNklMdjN6S25UYUs0MGZ6?=
 =?utf-8?B?QnJDQnpibnYzTWY4eDBhb0pOMXVvazR6UXdJVFQxcUJVdDdJQWsxSWIvdEZy?=
 =?utf-8?B?QnhWNTNwdXR5aEVodU92ejg0d1JlUkI2b3hKRms3MlQxZkVMaUNZY3JGcEZ0?=
 =?utf-8?B?UUxpN1FqQUNDQUt6WVBielJyNXBKaHQ1Y05PLythOENRMVVDQW9yK0ZqNHNh?=
 =?utf-8?B?VUhyaDU3dnYvaENoTVJOemZ2SDJQRFVzVXdxL0pvcXV5ZDdZS0hOejJOcUhY?=
 =?utf-8?B?VVlodWNCa2pqVGZ1NTYvczBzeFRWOEEwek4xU2tHU01JRlR2VGlXWVVleFdw?=
 =?utf-8?B?bkRGNTRZRy9kYk1YTkpDRWNWYmM3T24xbE9Dbko1KzIxL3RnZzU0aWV1Yko0?=
 =?utf-8?B?UWwzY1BaMlJ1Y0R2T3MxUXRpbXdJZ3NOeU5nRXVZbFpFclErU1JDUXZvL3Vn?=
 =?utf-8?B?UVRYTm5Ld0dIdHpveWkrb0RSVFZBTWl2RER3MXlQWWtxUk9SK2M2ZVMreFVp?=
 =?utf-8?B?ZGtWNDloTnR6ckZ4THhLK0E0WTU5YTQ0bEVDTWhkRFgxMUlZOGdxaXFSTmho?=
 =?utf-8?B?U1NEZDZrQ1h5VUY3b3BMclp0NWNrWVBrbmJvMTFIS1pSMHkwSjlRdmNiMDRH?=
 =?utf-8?B?cVV1K0E2SHVLZjA5Y3JwM3J2dWhrZWFYdTNnTUMvUWNTaXNqS0NmUElldWIr?=
 =?utf-8?B?VzVDMTJ2cVMxMVFkdVA5TmlLMWpEMUxFSWluVHhuUXF1NExHT1FEb1pUL0Mv?=
 =?utf-8?B?ZkJOWXVFRFBlUzc4Y21PQ0orbVYxOXRJc0Jsd1NZeGt6Z1YyejlMazBKMkcy?=
 =?utf-8?B?ZHRJZnJUaUdIUXdGUmhzeDBhQ0owYTZqblFVZ1VNVlBvOTlaYURNbnNWUy90?=
 =?utf-8?B?MzEweTREVXRMblRKRHNld1pidDdRVW9Ob3U0K28vbGhwU0JrZmV4NExVV2ZY?=
 =?utf-8?B?aXpMTExvOEpKVTBZVXF4RHlLZm5seWM1SjJGWXNHZXBEcnhUQ1VkSk5zWTE2?=
 =?utf-8?Q?SEUIu2znG7DjEkQTraT5cAcVe+xshfEX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1pzbzNEcHJNckR2dXRybHVxL0hWQUVodTArWnpwL0xjK1lEUDltOUhUTXM1?=
 =?utf-8?B?dG1FOUYyOXRJdlBaaDViajNMSlFNYWNqZUdxOS9BQ2E0TVdienNXbytMcTBE?=
 =?utf-8?B?UVlvYm5ndUxNdUNmSUtDTnl0R05RNmhtTWZRQmhWbXBNSmJmaE9VeUo0NDJq?=
 =?utf-8?B?VEs2WFdZZGlaTUZVRXFJRU4xQUFUVDdkNVJ6cEYzK3prU28yeU1mR3lmQlJT?=
 =?utf-8?B?VjQ2emsxUGNhY2xpNE1haXo0eDZ4Vlc1UlNQb004d2FTNmtQeWUzb0pxd0xr?=
 =?utf-8?B?dkxXRDNmMDVKZldwZ01qZ0JzQjNMd3FyRXhFOVBBSmNRR0NkTmtaa05TODJa?=
 =?utf-8?B?bDBzL0l0eWdWWXJzZzUvbk1tRkpVT2ZYUER0SXVwSm0vSVY3M09HNmI4S3Vy?=
 =?utf-8?B?WkkycXZraFU1NnNkRHpJdnI3R3Z5OTFOMGE3b3hkbXFFTzlHSWlKVDZPQmc0?=
 =?utf-8?B?a1FncnU2OU8vS2JYVWlZbUUvaEJNMUhVUUc5OElKUHpTVHVsS1ZZUkNXSm5h?=
 =?utf-8?B?K21rU3ZLWmhuV1ZKVDFOZFRDVnV2NVNSU0xHZEY4T0dGZGRyRCtCc1c4ZURN?=
 =?utf-8?B?aEQ2VkFHV0lZSFA0c2lPQ2xEV0NzY0Zma1Y3RDNYNWIwSHE3cng1K0p0bjFq?=
 =?utf-8?B?eWg1czRqdXUveTM1QUJvS2p3aVQvMmEyRWlBc3lCeTcyQ25uYkRTQXV2Nkg3?=
 =?utf-8?B?RGYwZElBSXI4RjVGVkN5M25ZeldsblpsWEdEL0M0M0Q1Y2VGbVNuNDJ5UTZu?=
 =?utf-8?B?akZrNUFUT2N0SlhKTFRMVmNpSnJnZzc3UmhicmNqSUFBdG5jTis3RnJ1U0JF?=
 =?utf-8?B?cFlmeVRGNURQaE42QnBjaUZxMENIS2lLYk1lamczeUh6a1J6ODZHWmRaMGVU?=
 =?utf-8?B?TUNYWHBYbzZlSmt3Uy9OZjREK1pYbzN6T1BOTm5vQXk0N1JkaDNuR0pjT3Fs?=
 =?utf-8?B?NW4xL2lDNDR1eXhRN0lzbVhhcmtQSHRITDQ1enlianJPVjB0UmlTNTFzOUhk?=
 =?utf-8?B?VWxlNjdvWWJidTJQUk1mL3lrajlyU1FnV2xPV0MreVBFTG1FZWpCbWdZOFd0?=
 =?utf-8?B?SlFKSUxQLzNVOXFFYlROS1lSd0hXZHFZd1RlNE8vZSswLzVXYlNUQ2svQnpm?=
 =?utf-8?B?SlIveGlLRzdwb0tiNm5KYzc4T1VVa2lOUkVvOVQzTkFOZWZnNmhMa3lOZ0xK?=
 =?utf-8?B?WVVvZTN6RG4zckU4bUlrb0JpQmhRalY0ZDJNeC9jSlh1WDdXWXBnVnZZOERt?=
 =?utf-8?B?WXRvY2Y0bFpROFcvT1oxUmVxYlNRSHpxalZaQS9UOVVNYTJqM1NaclF4OG5S?=
 =?utf-8?B?a3hvWDJicE1MSC9YS04xTCtvSEVjYzIrMWFwanV2VEFsY3RJY0FRZVNDeXpB?=
 =?utf-8?B?bXRESjk5S0pRUGpMMGtMMEtHYXV6bEFPeTNuRUJVcFB2ZjFVUWRJN1BhNHBD?=
 =?utf-8?B?d2NNUDAxZmZDZ0MvTC9kV21wRnY4aDExT1dEVmpFRVZwcVdHeVhSQnNhSzRr?=
 =?utf-8?B?MXZEZjZjdm5nYThKdnE3bWhjUzBYdk9rSTlueWFJUnBHQjc3UmxteWhSbFY2?=
 =?utf-8?B?UEc4djRmVkFXcVhxck11cTFmVUthQVlxMnJzZDJRZzlUdzZJdWpLY0wyczFD?=
 =?utf-8?B?bDdRZUdXNENpSFM2bGNzUVI1dXVZTTA2Yk5sY2ZtKzhmVEVHM3lzZjNxZ1J6?=
 =?utf-8?B?WXFQdEQyNnY4ZTlkYkR3UTN5eG1LVDA3UStOam5kRE56dVlZQXh5SktYN1dY?=
 =?utf-8?B?WE1yM1pYMUdOSFNCYmNFM1Z3QlhXdHBWQVFxZy9lRGo1NWRBdnl0bERTWVpW?=
 =?utf-8?B?cUNxK2M4QU01eTVMQW9NUzFNYTFsSXJ3SVgxU2NHSyt3b21ycXZLV1R2bXZJ?=
 =?utf-8?B?Y1JwV21xRUljeEFUaURVTm9aaXJ6SlBYYkY4QzI1MmhyVU5nWTlvWUZaS2pV?=
 =?utf-8?B?WElGbGpMeHNDS0haZk5xV1ZuOEZEb3hmdWEwdUUzV1pPZ1Rody9mdHQvTnZn?=
 =?utf-8?B?dzRjc2U1cVVHdmtlMnFYZEtOUkdVb0RqSlRYWHV1cG9jWG9yMGYwTjFDYWlI?=
 =?utf-8?B?Qmt6ejJQRWlFVDhXRWl6N3VxZmRYSGxRTVhlYjNRc0RUVUdpaUlKNys1aHRZ?=
 =?utf-8?Q?wbhqmEtm+f4W10/I01Rrlxm7f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce86b25a-355f-470f-e515-08de0db35365
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 19:28:18.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZh3gKSXrTeCEZET+xmB7txQz5HPBrxDoHOIOaohD36sGq77P4LxcuQHfue3h40etgc7zalwHoHSvXfNLHyXCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
X-OriginatorOrg: intel.com

On 10/6/2025 11:51 PM, Sohil Mehta wrote:
> Save the pinned bits while initializing the boot CPU because they are
> needed later to program the value on APs when they come up.
> 

Because we are deferring CR pinning, there is no need to program the APs
with the pinned bits. The pinned bits would get enabled during AP bring
up like the rest of CR4 features that are not pinned. This patch can be
simplified to:

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 61ab332eaf73..d041f04c1969 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -476,8 +476,6 @@ void cr4_init(void)

        if (boot_cpu_has(X86_FEATURE_PCID))
                cr4 |= X86_CR4_PCIDE;
-       if (static_branch_likely(&cr_pinning))
-               cr4 = (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;

        __write_cr4(cr4);

@@ -486,15 +484,17 @@ void cr4_init(void)
 }

 /*
- * Once CPU feature detection is finished (and boot params have been
- * parsed), record any of the sensitive CR bits that are set, and
- * enable CR pinning.
+ * Before userspace starts, record any of the sensitive CR bits that
+ * are set, and enable CR pinning.
  */
-static void __init setup_cr_pinning(void)
+static int __init setup_cr_pinning(void)
 {
        cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & cr4_pinned_mask;
        static_key_enable(&cr_pinning.key);
+
+       return 0;
 }
+late_initcall(setup_cr_pinning);

 static __init int x86_nofsgsbase_setup(char *arg)
 {
@@ -2119,7 +2119,6 @@ static __init void identify_boot_cpu(void)
        enable_sep_cpu();
 #endif
        cpu_detect_tlb(&boot_cpu_data);
-       setup_cr_pinning();

        tsx_init();
        tdx_init();


