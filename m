Return-Path: <linux-efi+bounces-5404-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D19C4881A
	for <lists+linux-efi@lfdr.de>; Mon, 10 Nov 2025 19:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34379188EB67
	for <lists+linux-efi@lfdr.de>; Mon, 10 Nov 2025 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4E329398;
	Mon, 10 Nov 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRRlIGC/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A616327204;
	Mon, 10 Nov 2025 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798533; cv=fail; b=TeTjn2B2/FaOtuxq3eBHrw/CCBb4cAZpS+D4wTJ78CTm7Xj4VBHT82Jo/IPf9WML+HMeYKSGG2wENFLKmiX+zP5bKtApFJ2lp2ZsNhqOdrTYyMRGaetalOxvUbmeJxPrLYpgytIDaR625BKWgEkcIxuJ7a8rxLSpE6zZyLDoC34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798533; c=relaxed/simple;
	bh=EvIjFNHIgoXsm4gMVxP1SnE8uyiTULoWV9fcQhxxwdI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t1vQXQva9Hq/3iVh85VHFUHd5IlheQwtcHKXTxBhCkwsGtjBa2PlQubFyJCTyqOmt+ze2bOHPVMUdA/NqtkUcxkCecIVErh86WUmNTh+y3m3fpyl6bZvdpUP3MDWqcG59lHRzv1v+jNhUtq3xQOt3eBPXepwa4HUIrRaAoSkz38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRRlIGC/; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762798532; x=1794334532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EvIjFNHIgoXsm4gMVxP1SnE8uyiTULoWV9fcQhxxwdI=;
  b=BRRlIGC/sBrs3YXYp6lgGbccVI6hDfkIN+isrvd3Qg6aOULHjoTd6tgg
   x1KY1ZAizuvB+CfUVixZ0A/znwmSc01yeBgchENobRXXARVxQxNs+97Cz
   BKAZ+ZSRbAHd4XccEKKEqUfbYSBfCzqPjHkPsPrdJ3G8r5mhgWZ+cjc5n
   9Utw50oy3MN1ocfcJx2jAlZnk2jZb1to4p8q4aUwYtEa7WViqS4jnNB2r
   XjRrFmlT7aenJpqJ1/3NY1wP8LDyW8jV9NjsGZOfaK1uQbgrxyet+8NQB
   Xqgj5SuCZsIkh4G/rYXZY1HkU5/5wiullJh3ghSEuNreg+pEpZY0ihOrt
   Q==;
X-CSE-ConnectionGUID: yLOC/W0uTsOvJKIqXitBwA==
X-CSE-MsgGUID: FTdvAiYqQxyv47dKlPHd6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64736739"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="64736739"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 10:15:31 -0800
X-CSE-ConnectionGUID: NZSt7Qg0QOKiGB712DQt6Q==
X-CSE-MsgGUID: 7vvDm16VSte27aj4gItEDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188488117"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 10:15:31 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 10:15:29 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 10:15:29 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 10:15:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgsvKYvSMc/2D6Q2I9+HuX4k/sPtHNu6So69/bQbdzReC9hqFzlAUy3HayAp5/JuBOMI77i7T0aheCbuMTAp/jSnT106fdRB8AON+0WjjLm75QvzkfIbr0rXr8hjVr2iJwqYnWBc7CnA13NYFn3ioudKNalMvi5GZzLGxVlH9V0w3yTKNRmzzRnWwX+No+Dy9BrUbGvkVQ7C6K36lRCjwSgzIrH9/rF2ejVOCBeofsi0GH9vOTYz058AVZH22pMovm/fp9rryN5shhiiCOVI5GabxB7fwK9/o3t/aAV2Xtm/1e5Dqe532xKoD+LSmICkDmqCtUDxzpjys3fdDD65FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFdDCflQ8VGmQd2P3k6yNBTBUr/VRuKGrwv4saEZ4k4=;
 b=huVv/sJC9NNR3EQ/9Wf60Bl9P71fbKSD2mA+d5BpKjxoi4DMmAwd3qYt8IjhmDCvIjye7BisJ67bh/4gkhx16JBbBjk91MoBcWYMoew4E6y7OhoC7fnXiseqyKIcmEf0U+QGKAlYM8cxc6QHKlnmkCh2BMPhBq2Yz61IksNKOftG54w93GDpczcX/NhekulLZe3FOr4wjtmiA/+njkHjIFlsRYSRRVVQMkL1MNcU2CLoHGQTJ7UEhvgYMZuhAtpnpFplviiZyUWKbEJzDtiQ++AwFQ62YspXWe7Z4NmmfzsK8zsknivbsrZ9rLHf+1KWSgibFrTq06J51IJNOoBlfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 18:15:27 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 18:15:26 +0000
Message-ID: <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com>
Date: Mon, 10 Nov 2025 10:15:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/9] x86/alternatives: Disable LASS when patching
 kernel code
To: <x86@kernel.org>, Borislav Petkov <bp@alien8.de>
CC: Jonathan Corbet <corbet@lwn.net>, "H . Peter Anvin" <hpa@zytor.com>, "Andy
 Lutomirski" <luto@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Kirill A
 . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, Randy Dunlap
	<rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook
	<kees@kernel.org>, Tony Luck <tony.luck@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-5-sohil.mehta@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20251029210310.1155449-5-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::24) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DM6PR11MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c3ab2f-aac4-49a6-e235-08de20851fb0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2trck5saENtV2oxNjBUd1FvZ1VRV1BUNktnK0Vua3lUZHcyM2VyMW1BaTdH?=
 =?utf-8?B?R010NWN0WWg0ci9veDI0MnQyYnFrYzNTMmJHRVBGNzA1NnNyenZuK3Vzb280?=
 =?utf-8?B?Z3lWN0hwOTl2ZHJMU01vd2h3MkJMenRBd0VSdDZEcElWSG9mVjJiMWlwR21i?=
 =?utf-8?B?UFZHWnJSbkZrNEZWUWFIUk5waDgrTVMzZnBpT2xlVGNyRnNZQkxheHlWYnV5?=
 =?utf-8?B?VGFzUi8rdERHOTVmcC80SE9PVlNDU3pwNDZWRUZKb2Vja2YxZnkrTW9mOURl?=
 =?utf-8?B?a2JzK2E4U0lmcHVsb0hjd0dLVy9iMlEyNVZwK0VQR3J6SVIwT1VEK0cxMWdU?=
 =?utf-8?B?Wi8vWVlGN1lrbGJFamdjMWl5VWJvcllsdVpidzlIWGh2dFBzZkZCNEY2emZw?=
 =?utf-8?B?VTlaeHdVbGhPVDI4YmhPbU9pUjdxRGRkYi9zZTNoU3JCdmtSaU51WDZiVG4z?=
 =?utf-8?B?R3ppSE1Qd0VmcGljL2Q4ekpjY0s1c3dGOXZwaGI3b1FFLzRObE9OWDBia3lL?=
 =?utf-8?B?bGk2NG1NYnlvZ1gva0V2Szh0M1R3OEhKcFB1ZlpOWG1qcWpaS28wWkM3d20z?=
 =?utf-8?B?WVMzTkZFZDRJeXB4c2hHQkNQbndaRXR0Y1dzaGk1VXlJVUJIRGY5YUloekpu?=
 =?utf-8?B?bkYvZzNRcTRkQVI3WUdBUnhUdjFqbzZJWm0vWlk5Zm5wd2FQNVBEVG5oMjBL?=
 =?utf-8?B?VW9KNUZSYWN2Q3FKVFFPREk4eVo4RDROcExWL09OUU91TUNXNWxHMEZ0R1pO?=
 =?utf-8?B?djBqMW9rWm1ZbjlpVlladE1rZ0h6d1JZc0dUS0NpNXdlR3VUeVBDOXlDSmlS?=
 =?utf-8?B?bGhkTGduYkVHeHU2YWxCQ3o5MHgxK2ZaZWt2VnRZaVFTN3ZBbnpLaENYMkdF?=
 =?utf-8?B?WGxRNEhONUhjazJrT2xzUHl2cDF4eFk2RkIrNmgwbkUvSGlTdVhkd1pvWjQx?=
 =?utf-8?B?TjgySFpkYUp5RklSZ2EweWF2TlpBdXYrbTVNWUk1YkRLSi9xRG5wWEV0djJ0?=
 =?utf-8?B?MjVMYmptMUZKWmowTVIxaWJqSDdkbWVpM1pqZUJyM282ME5JQ1RJRmFyWFhG?=
 =?utf-8?B?Rjc4ajd4b0VnNmhXRkdoN3pzSUtqQzZ6K1gwZDlXemhsZkJpKzVpZXFmSnhN?=
 =?utf-8?B?Vm1BM0pVNmV4c0dzTHNTaGZQZnVFZFlRMkJ1Z2lGR2gzRy9wQWRITGNNVFZ3?=
 =?utf-8?B?STNkSEJYU1hlOXhzU3RrSlE3WXBEcmpGT25vM3Q5clk3WEtSM0ZLeU1sczlJ?=
 =?utf-8?B?eE5VOVJTWFhJUG1wSTBMMGxraW9leW94dW1HNjJOb0hKRTdIOGNMUndSOEZT?=
 =?utf-8?B?amJSSXFHWWVDV0FsYWY0eDFtaVFvWllYUGlGbmNCOFQ1QzcxbmxiMkZIRjha?=
 =?utf-8?B?TkY3dnFacHVhL29VbFJuaWZFSTRiaTh2aW9FazE0bmtvK3djeVRVaU42UHBR?=
 =?utf-8?B?TEl4cjJndkdoRmlkbVFRU1piOGk4N2l2VGtSMHh2WHc4RnNTTGJMTXVEUlNZ?=
 =?utf-8?B?WFdtUitZV1dCbHFCWkY2blNSYVljWkY1bXp4UG1VeGNDRzlPMzFvR0oxZ2I5?=
 =?utf-8?B?WnB6UnIwbXlLTE9EaUtuYlRnL0pTN3RpVU85WHFWUUluTDhCWEEyaDl3OGhS?=
 =?utf-8?B?ZG40LzNpWEJpdHlTdkp6QnMwSUdVcGExeXI4TWRpaEhBMTBxaGRZWGt5cmtz?=
 =?utf-8?B?L2t5ZXlQN1VNOGdQNmhSeE9GVWxKTXJiZGtBVFFObkJ5UzNKYmZ0bFl0Vnk0?=
 =?utf-8?B?ZDRFaFQ5QXc2RTZmb2hKSVFqTktIUG5QRnNIQjhIL2ZPMEE0cVVPbDROdXE0?=
 =?utf-8?B?WTZaelpnSFBkalEwMEdpL1RBeDlvZjBySCtEQkdud0Q3YUpCY0pOUG10Mit4?=
 =?utf-8?B?eFpyMGYwa2I2dnkzK215TEJMWVpRaWs4K0V0L25VMHhxdSt2cmJ1akh5TTYx?=
 =?utf-8?Q?75Aly66E1gX/NOAZMckN5rBcSSVHxsG2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2FRU1ZIK3V4NFZVcHZWenpYWnBiN1VDelA1T3FxQmhHMGNrdkVYNUN0c3hu?=
 =?utf-8?B?ZUdVQ0VTc1ZBeDVUeXVUTWtxMEcxNktPZzlFN21DZFBVWlJVb1VzUmQ3QWNJ?=
 =?utf-8?B?RGhaWTFaR3VmS3BEOUs1MHFLTktwTzFsZ1B1cGtPSlhETXVtSlYwMWpGVEpT?=
 =?utf-8?B?NmNGaUw0ZWZmMU9PaEpUK1hVVEoySHhNNU9XSFg2cVVrTDdwSHNBTHVsN0F3?=
 =?utf-8?B?SEJ0OXhTVVVLNEFCaitPOTZyRU9reWU0N0RGT3ZyREZvZEZTTEpvZVd0c2NG?=
 =?utf-8?B?S1UyaEVDajhZVFYvdERmcW5udENJeFJUSjliOEduUStFbTBxUGoxdGFEMmJl?=
 =?utf-8?B?Wk5SQnJGZUhjZzdxOHFRMGp4cGpOaVkvWCtiT1FFWEpTaWxWWDJRbUMzS255?=
 =?utf-8?B?Q3ZtYUJ3aUJ2dDJLaUF3RDhtdUFxVkY4UWY4SklaSUhWd1hvYnBqb0VaaGwx?=
 =?utf-8?B?OGtmZmdxRXR3RHNTMUJqS1RhajZtaE5YY25HTW9ucS9uUkltaDFOU3FnMzlt?=
 =?utf-8?B?MnZxOEhUZU5aUnIvakV0U0hEeVA3ZjdPUkE1TVZiRzlHYzNlYzdDdTkrNmpH?=
 =?utf-8?B?SWZNSE9UOVdvTW5Na2drWk1YUzdGOUJUNklJNjdpZy84Z2hocWNoL2NvWGVo?=
 =?utf-8?B?WlYyNVNoWkRZNC96QXIvdzlQeGcxWEkzMm13Nnl4ZTg1M0JmOVJVTzNjSUJQ?=
 =?utf-8?B?eDdVdnJwNlNKL1R4STRrbE1wYXRXczM0OGE5MkRwS3R5QWlaSW5nSHFWZldp?=
 =?utf-8?B?SWpXVTlRZ0lzdW5RSzJiN2xLcXhjQU4xR21lTkZOc0lCSnpOc1VGZnI2RzJo?=
 =?utf-8?B?bWZtQ3JzTWFzZ0hlcnMwalpwZjd5ZGRyZ1BkSUxKMlNRQVR4R0pJYjd6Skts?=
 =?utf-8?B?cGl2bHlWbURjZnVwWHQ4aE9pTW5iNWtHdW9Na2czaUhtQ2FUWmVzOWxlY0dj?=
 =?utf-8?B?SkFNTngrYlVTeWV4VVUrTFJMcEh4K0V3cUFHbmdSeDBIZXBGeUN4K1pPajZj?=
 =?utf-8?B?SkJodU8wdnJlRXdaVVFwZlplcmU2dGhaa0twdDRzY0pnbVpjNzhwTGxKY1Qw?=
 =?utf-8?B?RmFxYjZLZDZHc21sZ2k2MFNLMDJRS0hQbFAwVzVzUmhLODNhRjVZblpjcWgv?=
 =?utf-8?B?Znd6amZhVUpON3VzcjJBUSs2My9ndk9YbUIrUkxOMTg5VUQ1YTdVVFFYMy9E?=
 =?utf-8?B?Znl0QmQrZ3I4dktqUHRDdEhxZGF5U0szd3BXQ2s4eVBJSjZCMlc1cnV2TFFP?=
 =?utf-8?B?cDlFbCtCSHhtdGk4ZEczVkJNOUZXM2o0azh5MUhPYWhpa0plKzY4TC82U29v?=
 =?utf-8?B?eXhoeWhmNWVGQU0xdEVUYWVQTkIxdEVCRUpmVVRmZ2ZrL3ZhUlJwaGo3d01y?=
 =?utf-8?B?THE1a0VZMzBCcVlkVGZvNU9WbFlnaVJxaVlCMkFlM1NHbzVyOWIyTVdpL0dp?=
 =?utf-8?B?Nkw1QVBKWjlQblFzcXdtbGhJamV3Qi9FQld1bkJxQWc1OVhkdDZaZVlkYnFp?=
 =?utf-8?B?aUFrZCsxc1FMOFc5L1lESkozUnBtR2EzYlluSUtzTWdETWZiT3orMWpib0tk?=
 =?utf-8?B?SjBRTjEyeHFFQnVVdEQ1TEREVDVueVUyaWRJZWR2YzVXVFh5YlZnK21JT0F4?=
 =?utf-8?B?enlFcWZvNGJYYnh5NTNkUWhhVlhwdWQ0dFdiaGRvaWJJMG1DNHRiQTRQYUY4?=
 =?utf-8?B?bExHOVVaUWNrQVRKdktmYXMxakJGVVp3cllRYUVaRVpteFhySW1FVFY4bVVa?=
 =?utf-8?B?encvRGNhOS9xRDdwYmxnTzBVRG9wZSt5b2lTZFpiVGZYcTUzeDcwWVIzYTFm?=
 =?utf-8?B?RGloKys0WTQrZlJjaGwxcGswL0dpdE9pZW4rS3pReU9Rc2V5N0ZaNWlVTklU?=
 =?utf-8?B?UXJ4dmlqZjhWWlFId1Jqd2ZjRFkyajFGNWpQVVEzbW5SWjNxQjMwUVBQRldV?=
 =?utf-8?B?dSthYmZlN3pmTWxYUWVsMmE5b3NvUTU5dzJEZmM2TExYcXo3emVDeVFMbW8y?=
 =?utf-8?B?S2NadkRsMHZpcWZuRHJLZ09ERjljK0xVbUx3QUtNMDM1ZVlzUE5rSjdjWjVM?=
 =?utf-8?B?RmxlZVBhK1YvaGp4TkltTGJ6RU5ubkhvbTZ5bDdNVkRXbzA0cXc0cGdBTjhV?=
 =?utf-8?Q?H6ZTDo/Wi8NkG1OtXM6jC/HzU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c3ab2f-aac4-49a6-e235-08de20851fb0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 18:15:26.8775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYh15nSsDX8vi274nNnpOUFTTPc/qri07bFg4P8UCIEWr+2BF8SlDbFfpumWDz7LCsl4EY0tAPNS4+G4P26FDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com

Hi Boris,

On 10/29/2025 2:03 PM, Sohil Mehta wrote:
> +/*
> + * LASS enforcement is based on bit 63 of the virtual address. The
> + * kernel is not allowed to touch memory in the lower half of the
> + * virtual address space.
> + *
> + * Use lass_disable()/lass_enable() to toggle the AC bit for kernel data
> + * accesses (!_PAGE_USER) that are blocked by LASS, but not by SMAP.
> + *
> + * Even with the AC bit set, LASS will continue to block instruction
> + * fetches from the user half of the address space. To allow those,
> + * clear CR4.LASS to disable the LASS mechanism entirely.
> + *

Based on the EFI discussion, it looks like we would now need to toggle
CR4.LASS every time we switch to efi_mm. The lass_enable()/_disable()
naming would be more suitable for those wrappers.

I am thinking of reverting this back to lass_clac()/lass_stac().

lass_clac()/_stac():
	Disable enforcement for kernel data accesses similar to SMAP.

lass_enable()/_disable():
	Disable the entire LASS mechanism (Data and instruction fetch)
	by toggling CR4.LASS

Would that work? Any other suggestions?


> +
> +static __always_inline void lass_enable(void)
> +{
> +	alternative("", "clac", X86_FEATURE_LASS);
> +}
> +
> +static __always_inline void lass_disable(void)
> +{
> +	alternative("", "stac", X86_FEATURE_LASS);
> +}
> +

