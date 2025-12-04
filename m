Return-Path: <linux-efi+bounces-5798-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D01CA50DA
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 20:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93DA930B0414
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F09347BBE;
	Thu,  4 Dec 2025 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbH272+C"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22540347BB8;
	Thu,  4 Dec 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869678; cv=fail; b=g2XquUPR3F2/c9eBsV10HCt+w/G2W5XWHHpo6lmb/35rs+OK3ZQwmP/TB4/iwicgCZAGhvP6XFu1AVPUWZrHjZtLKR6KPwpRh6aysFawOhlJhEXraY6ELGAlCYcDbV0zcTlE6r/0Y+bSJcPM8AKtUGMd+tI5LpAng+lAwjTuhF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869678; c=relaxed/simple;
	bh=5DIyC4voXed0tjujjB+YmkmCoNzPNnLbUpDBBqWk96g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WqgmUHyxiwHdlWg2Hg4j88YC4c3KTKw9iXbwxFlglClNnnoIKmON9DAxC2XfIlgi1UVW6AbuSouL7yiOrvDcTUy7iV6bxmZDvTBvq/ZPIaM/U0oNRaBWiKk2MKHhApTCISWq9V4veG4LcG2m4bLpy5fgjVry0SLmD8/qQMwJuyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbH272+C; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764869676; x=1796405676;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5DIyC4voXed0tjujjB+YmkmCoNzPNnLbUpDBBqWk96g=;
  b=QbH272+C4iPxdpm3s4xWiKIrIRclXASuQ0AnDMLmnPeFdSilPGMOq8Bo
   gO9twXngWyrMoqLkk62z+fci8k46xmxHmvwN2ldQFLcaEHGLD3NYJITUu
   chHfiqR/FQ9VQk3CylmKlzBzZi5b8VYK2Cw/9hTKKEVVg5hW4nIDz/aen
   egorFVFoZOakoPQHtiM69dBo0EkkLt0ZfqONnlZbdqzfMOBJEXfXV8OD1
   YiWUXHtbluiXg5C9NTTVLgJb+d6r/wdGo+tvRE95F0yuKK+FpDrorOkg8
   +kfqAc64R/gg7FNKASqqpYWMWw1pB7e/j3JNfekuXNzEb0NyJ5fA/dU9+
   Q==;
X-CSE-ConnectionGUID: +8sDzbiiTKSpTsyzATrHUw==
X-CSE-MsgGUID: PH4+KaL8SCKzuw18AP1p0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66622674"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="66622674"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:34:36 -0800
X-CSE-ConnectionGUID: eIldPBUVQlajYhxFD6XFHw==
X-CSE-MsgGUID: F/j3qhTgTb6Z5H8N/qJ0IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="232383314"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:34:35 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 09:34:34 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 09:34:34 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.69)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 09:34:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmio+qujjCrNhmURmcEVVRbeVkvu8G/cgkQiXP+zOXRCTOBaFUBcNwGl3+XrK5yBEAKVjpdK8h99V0zDh6mkXPpqh5W5Ij/edTXWYTKD932GoyL64LIoOA4NTgmneIlDVf4NgLGRTY6eJB+4XwPzCgZNLkeCImqLKz13GEjxZ/AZ4OGsfBFCRCrgYNEjDOWC/r0ryzMn8cD9djHcH/ddush2KpRInCIsdEiRDx839fjVIyl1ybwkSUECLmJYShhXRyTcJo3SHs7O7ICXCpEFqn60TlpPvsNnhCn39pa5FhWX8lRR6TiniTmJQFhxFwZWibB5sGkAg7XNOW42Ax3JPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D9zQi/+gYQtbY3qDKKGdzoWqIIHN1Kvdt9P5Tf0jjg=;
 b=H8gzrte6VmCJA7QbAT8wmd6LDvr1vjr1vFzi4n1MDnboF+ZuYu9Cm1IpdazWUg4DP9MiPaQ4satZE1hsc48R5nU6qiYc+Kus1dp4+nORmU76Hiz5Oj3fo4+yvE92dv2ilE/wvYeqMKXPDFBrtQa24PSLjlir0j8X75kuO70BB5ZzJt6x1uYaHJ6EimLWYIDJrJe35US8MjVUOsIieKdv9nowNQeKuRa4hH3VUW7QP+tG0vzYSjTYewNqSnE+VTHXHRfIT7sw7k+gGXSNBNMOC9ONLGKzx1phltHU9FH0w22VoB4JmUdginG7egYdquZkkXrcSk/JNskqY9ZbNLYJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by PH8PR11MB7071.namprd11.prod.outlook.com (2603:10b6:510:215::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 17:34:31 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 17:34:31 +0000
Message-ID: <5fb937b4-5459-4894-a107-945bfb50a701@intel.com>
Date: Thu, 4 Dec 2025 09:34:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] x86: Extend LASS support to EFI configurations
To: Ard Biesheuvel <ardb@kernel.org>
CC: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tony Luck <tony.luck@intel.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
References: <20251204072143.3636863-1-sohil.mehta@intel.com>
 <CAMj1kXFicnmVUeoRsMNbBgDN20fCN+R01H9shcgOJMD2Nzn8Cg@mail.gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <CAMj1kXFicnmVUeoRsMNbBgDN20fCN+R01H9shcgOJMD2Nzn8Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::45) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|PH8PR11MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fca2a9-4ccc-43d7-8cb5-08de335b6235
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1RJZFdKK2Vrckg1OVVXUXk5bWpRNkhFVEpqZnNsOGdrMEpobi9WdnhsTHlh?=
 =?utf-8?B?RS9RVG5ZeTZhQTNpNk0vK25NVWtKc2s0WG9DUHNZR2RVam12NFFiaHd2cGhn?=
 =?utf-8?B?UGYxUGo4ZnYzRldhQ1hZVXpZWnFXb1VIWFZYV1YyMTFlc2w0bkdXMDFYUmdx?=
 =?utf-8?B?S2thRGpiQnkzQ09SRlF1dXZ1NzFTNzNRL2JUVkJsZkJQd0RhU1VwVFgvMHph?=
 =?utf-8?B?VmhFRnlFZG4rejFUZnZMTkd2akY0VSs4TzlwQ3JzbXAzNTVGMk9WaU44ekdq?=
 =?utf-8?B?MnFiR2FwMm4xa2RIcGV2KzAwUFBHVnhPc0NjcUczTElTa3BYNEVmeVFzRFFQ?=
 =?utf-8?B?dFI3ejhIcUt3TnkyclI1YWU3MEcrSnhxd3FLUGFnc0o4a2JaaHcrdktpQ29V?=
 =?utf-8?B?aGYvTS9TcEg2eFRGbXNCOFMwUUtYU2NGcjloR04zK0plclJubmVQMkJBWmd0?=
 =?utf-8?B?SzBOdDU0N1FtNEI2Qk1GWkpMSVRjRnpZMUV4ZGhtTXRCdkp3UFk4ZUw5Ym8v?=
 =?utf-8?B?YkRUZTR6cEVzb0EwSW9zb3kvRjBFdktIbTRVK0FtSzNYa0JKTzBzWVE3Z1FQ?=
 =?utf-8?B?TjlySkdGNzVnQ0NvbFlzS1VhUkZ6WVdIc1JRbjhMekpFMkMyYWRSL1U4QXlS?=
 =?utf-8?B?VHFTeVNIa24rU1I3cXg5empLM1BTaVlOVi9VMzRxU1d5Rnl5dHpRcTh4U1NQ?=
 =?utf-8?B?SXgrNVRLWloxZjF1eGRDUEc0YzZjL3phUW5HQnN5Q3FWNk5va0E4Sm8zN1Jj?=
 =?utf-8?B?Mi83ZXYya3QyVlBHMDU4WFNTak5GUTZpRm9RbS9Td0o2WmJ2VngzeTVEaG1G?=
 =?utf-8?B?V3hrM2hiRXVSYVFqdzVUUXFDZHEydGFER0JjWkNnMTg2TEhYK013Y0FtOTMy?=
 =?utf-8?B?KytqQXlXaTBaelhxVWNyRkY3WnNUd2lKSmtxbmUrak9XZUJhOHZjTXNHUzdH?=
 =?utf-8?B?aTFKM1pDbUdZWDBkc0N3dkw3cWJFdzIzU0VVeWwzWlhHazViWnZWdVBNRmtV?=
 =?utf-8?B?djE0Uys0MjRwOW5vVzU0c3BsR05TR3JocW1IZzdlaWZmeG5pV1Y2WUplMUdr?=
 =?utf-8?B?elp0WFlFMlBrS25kUXpMNTE5THJjRzJTKzZvQVNvYzZMNjBUTXJaakk3NEVE?=
 =?utf-8?B?enJkUVYrbmZ2UnlFWXcyVkpGRkhFazZtZU0xNVFnNkpxODRLZG1DeGdPdzFE?=
 =?utf-8?B?NklSRGxrT21uVEtBanpuZVVUSlZvMEdsa2l1NHowemZQdGw2b2NuVnU1bWRD?=
 =?utf-8?B?ZHduWmIzMEVIYTBkTmd5bE54eGI5dEpVcXRtMmsvazIrMDEzR0xzWWg0Yncz?=
 =?utf-8?B?YmZvemc2Q2hXeUcwYk1uZXB3WEZBNEZjdXFhYTRyNVMzK0NKZm9TbFpnUCts?=
 =?utf-8?B?QksrMmQ3TW5YMkMwZzhvSXRaQmR0elZ6ZUF3UXJCVVg3MnlxZnJvVFdQSE9u?=
 =?utf-8?B?ZXNQYjkxZ01RVmJjcW1XWnRUTEJZT2dLNGU3VXRTZnUvTW9Ia1ljcnM4NlZi?=
 =?utf-8?B?cVdMejYySjczUnMxTUFSaTZobm1uRTN1WE81c3BFSVg1TlF5d1ZUQlBrYmkx?=
 =?utf-8?B?b2xjaGtJVkx4cUdUOW10bkpXYWNCQU13UTRZSUxIU0MvLzkyWXZpSm1qUWlX?=
 =?utf-8?B?YnlJeU42S2loUDBwTnB6VUljTWRoNWEwV0R4MVNjZmUxa0s0Z1lXSlYwQlR2?=
 =?utf-8?B?T05BY1NacE1razJuY083dlRPcFRORFh3ejJjVDNYR09CRUUyNWZqdW56S0ps?=
 =?utf-8?B?UDBra2wyckEvaUxqczFjVndYV3RvNkE4MXpYbzdyc1pYMWFCUEdnTEZ4c1p6?=
 =?utf-8?B?UklvUHdIRUl0YjVGejBobzJHOGFSc2R5VUlkSUpMdk1JOVVLMkNVdkdwMFBB?=
 =?utf-8?B?Zjd6TVBmTm5sL0x2em9scnVnakNwQlRoTnZFbnE1Nnh5K3RiMnpqZkJPN2Er?=
 =?utf-8?Q?t7cie5cu5JMjL3HyOw9nJjaHfbIjKxq0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi9OVGFFRmxteEZsd3plV2NEYXc5ekorRkJuSlZSV1ovR3NJZXBLYUNpSFQ3?=
 =?utf-8?B?eWJMVkE1TmlTbUVUVGw3Nk9VWEE1c0hyTzRhUXUrVkQ4WW9LdG94cGh4UWo3?=
 =?utf-8?B?UldqRFpBS29RbDU5Zi95aG5OSFVvSjc2RjJuZ2VmRllweC9rY21QblhaVHA1?=
 =?utf-8?B?dUphNjdpYXVKL2pQU2RxQzVQbm15d3Z1UDkrU1c1RVE5T2dOSitBSXhSNmU3?=
 =?utf-8?B?clJ5bVdlSjRsaGJWcElPRERvWmpqZGlKRk5TaGFUUzh2Nms2cDZaTk9RYisz?=
 =?utf-8?B?VFhFbDFXckRtaFBpQ2xRLytpQnhtem5odjQrTHVnNXNkMVd3QVVWMEx1MVlB?=
 =?utf-8?B?bGRRaTFKMWU0WTFNcjdWMXFKRDN6ZlgxWFpNd2VKQ295TmNKWktnU0ZRQVFs?=
 =?utf-8?B?Ync4VXZQdDNlVG9BNHpGeUJxTCt1WmlVNHYwdTVXSVppZTVXV25tc1hvZXFQ?=
 =?utf-8?B?Tk1OWi9ZUzExVzhqWjl5Zk1wWUdwQkxRcFI2VjBXMmtvKzgzOEZEdmdhS3hF?=
 =?utf-8?B?WGJSemh1dDBKVnd0eElxWlpaamdwVTJDd2REcURKL1N2Y3VnQjJKVmltMEZP?=
 =?utf-8?B?NTJORWtDWFlFSjdxS2hvcjZ5RW56V2xocXVsL0tPVm10by9rUWJMaVVlbTFu?=
 =?utf-8?B?dGhYSS9JYVpPM2hURG94MUM5ZWQvQU50c3hhbXhTd0VQdDRQTk9vbGtWY2tm?=
 =?utf-8?B?Q0plMm1YdWxUSVVnRUZoeDMyM0YzZ1dkN0ExcElzUnFzUlRRaVhkSEU3a3RI?=
 =?utf-8?B?a1hEc21aaEZUZlJab3ZNdDFaTkxqWkxlTGh5Vy9nY0dvQTNyU2lXalpNbC9I?=
 =?utf-8?B?VW9DNVp1SnczeERZTEVjelpXcjBmVThSWElwaUowRFNiTGZtaGRsNGFRV1NN?=
 =?utf-8?B?Sk02ZldXKzBKRlF5L2loM2pFaHFqQkd5ZWRsbWpnS0hBaEU4QzE5WXpMVzVO?=
 =?utf-8?B?TmE2ck9COS9zK1BrUGw5RzdCNHN6NitWWEhBK0RGRmdHbDZBTHEyeXRZdHRQ?=
 =?utf-8?B?dzRLbXJUb0h1TndMOEUwQ2RveGJnSjFUK3h2bEZaSm15MjJGVnZPSmNOOERH?=
 =?utf-8?B?RnJYM1ZueTBNM2pyS1JGVnhZckk0N3UyRWxXdHBuRFZUbjdOSFpGWHpWMU93?=
 =?utf-8?B?TGx6SCtDckxrR2k2cHhQU3RpT09QQXYraWJ4VjdwM0hrcXFrWVMvUDM0TGtu?=
 =?utf-8?B?NGhBRVduaENBakM2YW1hTXhIWWd0QmMyZXMyNW45aE4raHFTWHdwT1pQRDIx?=
 =?utf-8?B?cXVMVmY2UHNTRG5OeTBtZVZoUWVWOFhhTFdaUVZMZURoK3FHQ0JMNGFzcURn?=
 =?utf-8?B?YjVJS2MrQzRzZEFDUkxYSk1oR3VyZUczTlFBYmR4Y1JrVkUxVVFjU05nTDZr?=
 =?utf-8?B?dTUvdWRMOEdDSUxtK2FBVFlNdVpCZnRqODJ1WmtaKzd0VjE0R1BSTXZ3NUhW?=
 =?utf-8?B?MERxeDE2bkZ0Rll0S0hHS0FlZWFyR1ZzNlZod0x4VHBHR2M0QkNiTHp1N1Qv?=
 =?utf-8?B?eEg0SjZBdVFRWlcrRVQ2d2VXZmkvVk5WSTMzbFJyNjV6NEZQd1k3WXB2ZDQ2?=
 =?utf-8?B?Q2tQZ21EMHdWUTEvU2g4SWpnMW5FZi9EclBBL2xuL0tUby80clJiR0txK0w5?=
 =?utf-8?B?cjdwdmtqT25VVHR5VkQwY3Z2NWlQZTgrbGZ4WkpaVzRXaEt2R05vNHl1UTIx?=
 =?utf-8?B?NlJKeDRYTDFpZE0yRUNyY0tiRUdjWHVSazNXUFNZaHNQemRIaVFoNGkvWWJY?=
 =?utf-8?B?TzZvQ0orQzEzU0dmaWhoSlhoMmlkZlhqa1YyTTJUcm5PbVVsMWl2WlNsOGdn?=
 =?utf-8?B?T0p0dkFsYXdkRDRWeXNKd1gzbkxPMHBnQVBGQ2RXTTJxbSs5QjAzWDU0OXJT?=
 =?utf-8?B?aE5rdXVkemVQQzdBU1hZRUhPeXlNNExnWWpxekx1WUpEdVdON2FOeExiYzVK?=
 =?utf-8?B?UDJyZzlxd1Izc0ZaZkpaWFR0L2RwK0JmVjJ1R1gvWHdDU0U5aDl2Q2JGTGh3?=
 =?utf-8?B?RGI3YnQ2bkM5bFhGNzA5bXZlMWdBN2ZvbjlIUVJvdXlhTzB0eWswOXBFSTZL?=
 =?utf-8?B?bVdNRkhwN0xjK0J4SC9PWjFJTGcraDNGUDkxdHZ1UEwvc242ZVFVQTc5QmNE?=
 =?utf-8?Q?765WaW2MrGmqEFg3CwGUpsND5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fca2a9-4ccc-43d7-8cb5-08de335b6235
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:34:31.7452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXoyP7XUKQZTKguGOKUOmxkkpGoY3k+5Zy5HuTrYYvZixEq+h5PXZsG5bvn9RwLVRMHpJkqm1mp+RiR8q8CN8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7071
X-OriginatorOrg: intel.com

On 12/4/2025 4:47 AM, Ard Biesheuvel wrote:
> Hello Sohil,
> 

Hello Ard - Thank you for looking at the patches.


>>
>>   2) Boot services code and data are referenced long after
>>   ExitBootServices(). For example, efi_check_for_embedded_firmwares()
>>   accesses boot services memory even after SetVirtualAddressMap().
>>
> 
> These accesses use the kernel direct map, so I don't think they come
> into play here.
> 

I don't mean SVAM should have switched these addresses to virtual ones
but doesn't all of EFI_BOOT_SERVICES_{CODE|DATA} have address[63] = 0?

LASS wouldn't care whether there is an actual mapping behind the
address. It only relies on the MSB for enforcement. So, any code that
relied on accessing boot services memory before efi_free_boot_services()
could get affected by LASS.

Or, did I misunderstand your comment? I am trying to clarify because I
have similar wording in the commit messages, and it would be preferable
to keep that accurate.

>>   3) Some runtime services fail to switch to virtual mode properly and
>>   continue referencing physical addresses [3]. The kernel maintains a
>>   1:1 mapping of all runtime services code and data regions to avoid
>>   breaking such firmware.
>>
> 
> In [3], I mainly elaborated on why it is still necessary to call
> SetVirtualAddressMap(), and why it needs to be called with a mapping
> in the upper address range.
> 
> For this particular call, there is no choice but to disarm LASS, given
> that the lower mapping is still active at this point.
> 
> However, that does not imply that we have to assume that systems that
> support LASS (which are fairly recent AIUI) are buggy in the same way,
> i.e., that they access addresses in the 1:1 region after
> SetVirtualAddressMap() completes.

I assumed that it must be widespread because the kernel maintains the
1:1 mapping unconditionally without any Family-model checks. The code
isn't explicitly warning about such implementations, either.

> 
> In fact, we might attempt to use the availability of LASS as a
> preliminary cutoff point for disabling this hack entirely, and only
> backpedal if we get actual reports where this is still a problem. 

Sure, I am onboard with this approach, but some folks seemed skeptical
about it during the base LASS series review. My only concern is breaking
user systems when they update to a LASS-enabled kernel.

x86 maintainers, any preference?

Would it be useful to put this (patch 2) behind an "efi=disable_lass"
command line option? That way, if someone runs into it, there is at
least a fallback option they can rely on. By default, we would still
expect newer firmware to not need this hack.




