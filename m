Return-Path: <linux-efi+bounces-5839-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD03CBA1BB
	for <lists+linux-efi@lfdr.de>; Sat, 13 Dec 2025 01:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF327300F64A
	for <lists+linux-efi@lfdr.de>; Sat, 13 Dec 2025 00:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B74195811;
	Sat, 13 Dec 2025 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkJl8K5C"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2111624DF;
	Sat, 13 Dec 2025 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765585274; cv=fail; b=TayUBKYjnXn4CnObnfD5FVKQbThWPcn7rTR+13eX3ZFLSFong5U3NvfVCNgXpvs+VxOb5azMoJJpbMtPMm+hvLDWReOiZwYpKwFrfixUYiaGaisLLqZJFhXQ5ml41l4Q1gLm04/jepQfrCVsHZkjYZ4ItAW6GmA+BRQ5nwjNISI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765585274; c=relaxed/simple;
	bh=afI/BN7xb7YXDW5/LSK/4wSqALeed3pWS5bFDSc7aUY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CfqGxCyvqqPLZ9vhprtCJ5fl79Zs6wxfZR4/48hI5DiTD8m3x+HwN1IZPssgdRWZHNevzjR8XFJXDkJK2nnXHFl0m5tOw5Z55i12+jqOTzOK5HhNlMwDeX3wtxr8rgOvX+bat3LalWZPtVL01vRdy9Q5d5MhDUIYrLQm4TTMiwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CkJl8K5C; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765585274; x=1797121274;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=afI/BN7xb7YXDW5/LSK/4wSqALeed3pWS5bFDSc7aUY=;
  b=CkJl8K5Ciom7QYjAHoQlB3uF5VcTIVClIlVU0QqWShvhKbDWWHWeg1z4
   tm9XkoPa840Cc6VITHJJH/hWmlnWcxNNB9Y0sJLwoMZQdv6K9jSsxFxP1
   UL2vwjb98zDSQLja0Wwut8Hvvlckc48fYGVg3JrYyDqnn3fGfcPBX6PAb
   9l5hKHmiC5svV6P/RkMDO+uekmiXUqitrNLCXZI+hlxHU5hTIvk32wjMK
   KZnXcRNKbXRyswy2FHMUrsrZDu1q437VNiwkDCA3OCfZoNGmPcmR5TV/U
   s03mwF9kfnUkh66+qd+A6nwonLW/Ja/sLWkQgdbQ/JIRnkYhZ8CsBSABH
   A==;
X-CSE-ConnectionGUID: IQxACsVARO+2axsgjR9NyA==
X-CSE-MsgGUID: E6JNqILITQSZvSx5bgI9gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67533094"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67533094"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 16:21:13 -0800
X-CSE-ConnectionGUID: iALW3YgCTZi90GB5tmIxbw==
X-CSE-MsgGUID: 6AD8rBEvT4aahWuoIYw8ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,145,1763452800"; 
   d="scan'208";a="234614593"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 16:21:12 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 16:21:11 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 16:21:11 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.29)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 16:21:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWHVaLeUfdqq97QlSJ6fKNyEdXQhUEXvfeFuDgrOBieIJBFHpMJLE2W1vm+ANWNMVI2aU7Ifpv9Y0M2UEGuUg1n2emWcabCJUed0ZHDLRyWzAdGc0figjLWlqTMLQdU+PCsUVTxCLMMuxmo9jrUNURB7LoKPVtvSKGzRVVnbQMU+ZhGVVzNx3O/ld62frMQuMoBW2pu8SgqLFthzz5zsQcaFOClR6UgDhMygUEG10c2VKnt++OR4on+tSDimqUKrdrlggZ2GKGWoTh7ft5MRIsFy9KoSsDSoyYl2VGXn9juuTRA4GumnFkd1vyw7B6GH1v9Kf2uLC2jYha10rKXnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUbjT8ivMrc9XTppfgov8Rtrl4WD5z9yknJSb439qHI=;
 b=rCwRaWBv1vZlajreI1m65NGemto2RXLBdflUUO3OTJV1R+oQGgsUBs7eHrtiX2+RJ69YZK/sBbfwMvqzmBawNz1gKnuvJWh1syH728U9kCRGRAZak4B9bR6kn4ytynsp5hjVesBOvAOsom8YlmccHjdBJrD+/eIJNbATtVilk6f8CZR9gm4eKmGZNrgtq6bU0NNI7rKO1KqzhHSwaNhy4nC0U+zB/JIt63f9Mgz4hAq2/WcM1kcwIVblxon8j96qHcmxYDPZreONDW2YS5WbqZ+NS/dKtcRGzvMsQo0e7Gi3WuhQQQD2ThyzHQ8hraZBJqi7WYoMtPIcL0NQ/gkG3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DS7PR11MB9473.namprd11.prod.outlook.com (2603:10b6:8:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Sat, 13 Dec
 2025 00:21:09 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9412.005; Sat, 13 Dec 2025
 00:21:09 +0000
Message-ID: <98ca1e1a-4bc7-4a6c-b587-b6c2a60db7bc@intel.com>
Date: Fri, 12 Dec 2025 16:21:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] x86: Extend LASS support to EFI configurations
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
CC: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
	"Tony Luck" <tony.luck@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>
References: <20251204072143.3636863-1-sohil.mehta@intel.com>
 <CAMj1kXFicnmVUeoRsMNbBgDN20fCN+R01H9shcgOJMD2Nzn8Cg@mail.gmail.com>
 <5fb937b4-5459-4894-a107-945bfb50a701@intel.com>
 <CAMj1kXECOBQczcNeqmhfgttz_0545B3m7OgLAk4WE_hOkUbohg@mail.gmail.com>
 <B0E164E9-9037-4DD3-BFF6-E628B23349FF@zytor.com>
 <CAMj1kXHYKX4nU_xULC9vBDQxdyq9n_gcDqUTL2QZXvZhkHZRAg@mail.gmail.com>
 <F707CA45-DA37-460A-AEFF-C11AC6AB6A05@zytor.com>
 <CAMj1kXEQFhdZ4kcObsxNoj2cK+TGS=xBU83ARVrifxjw8yPcJQ@mail.gmail.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <CAMj1kXEQFhdZ4kcObsxNoj2cK+TGS=xBU83ARVrifxjw8yPcJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::29) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DS7PR11MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: baa0139b-1639-435a-a075-08de39dd83aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0swZ0g3c1FROXhUbW9RRHRtTFVTeUplWEpPVUZiN1E3R3J2cnBlUzNJMU9G?=
 =?utf-8?B?eHBaL2VTdWZObEtNYkR1Yzl6bWxFSVNDeU9UUjNWSVFwSytudXZ5RDFRWE92?=
 =?utf-8?B?WlVVd3NidGtXRzMzdXA4SSs5N1Y1eHJLbEhhRXd3ZWdkcU1HYjhNZm53aWZl?=
 =?utf-8?B?NjZ6Q3dxVHM2N1RXTjJvUDVsa056dU11cnB0UWdKa3AzZEVTUXY1bUhtVFpN?=
 =?utf-8?B?L29LNXVlZmF0TGVWNG5XMTJaQ3BuWC9hM1F3dlJkQjFRK256MGNxT0pWdmd2?=
 =?utf-8?B?bjh1MEQ3eW5ZTVBYcjFzTTBtbDArdkR0ZTNkOFltaTYxUEZSdEg0YkF5THlp?=
 =?utf-8?B?YmNsbEsrM3FCSXpNZ3BBcDg1Sk9WSVQ1M1Jkd3VzaDFDY1pxZDdNc0FYQmlE?=
 =?utf-8?B?bkFjNEpsenFhU3g2UTFiOEVhN3pDVlRsZFU5Y2U3TjY1NTU2a3ovZzdpZ1hT?=
 =?utf-8?B?TkRib202emNTU0tXbWY2Ri9aYm02SkZDNG1WcDRrRlNPb29DSll0MEM5RkRF?=
 =?utf-8?B?dGRXYzZpTjVRVjhTZEdFcXBqcjdwUU5VZVJxcmgzbU9Ed1RtdnRtekVKNENq?=
 =?utf-8?B?UEpCZlN2SUdFQzVXOE8wVnM1bXd1ZUZIWmRubXZZVVRLWnN4OWZ6c2szUFdh?=
 =?utf-8?B?aDBTbTJQMzlJaFJzV1pWZUFycGE4RndHV1Z0bXVSSTZtTzlqU3djdmI3NUxP?=
 =?utf-8?B?R1UyVithOFZUcDkzMXcvWkE1OFB1R1o3MkVrSTU1Q3V1R0p1dnhaZnpxY1Vh?=
 =?utf-8?B?ZTZDaG9oSU1SQ2tWSm5oRzZ6c2lXenhMSUozaGFJT2kvaEJLQW05T3d2Qk1M?=
 =?utf-8?B?M3RKNUsrSFdmZnU1RHBhRElWSFVuV2VRZ3JiSVNodEQydS81dTJwYlBMVVRY?=
 =?utf-8?B?MGtuVVllSTRBVmtSeW9qY1hPT1J4S2RsdVdrQit3L2VxdnZscG1QdWVUb3hm?=
 =?utf-8?B?WU5MNjRkc0dBby80am03b1dtNmc2SVFYRmJrWUo4RWMxblEvTmM1NU15dVF4?=
 =?utf-8?B?WUd0WW9ISm5TY1FybUtUTVVZSU83VVZtbDFkK3ZjVy93WjJmeXU5L091T2Z6?=
 =?utf-8?B?OXRIZ3lzQ3RUMis1MzlQaFF3Y003LzYwMFAyVlVhUlVJZEhocTJ2am5weVNp?=
 =?utf-8?B?VEZwV2kzWVM1Y2l6eDJoUnB5dTkxRjdqZUdUTi83a0J5emMrK0RZNXpsWGRn?=
 =?utf-8?B?T0JkWkJ1K081dVdFcFYvT1c4U3orQi9idm9PT3A4NDBjVStrVjdnaHhSWTcr?=
 =?utf-8?B?VzJ0YW1yZWVWODFKWkZlR2piTmFDT2hIREZMaDVKWFdTVUNYY1ZMR0FJOCt5?=
 =?utf-8?B?em9yRTdNQm42dkNRd0F6dXNHSjJpK1g3UXhuRTgrNU5QNit1VVBGQktaMjdu?=
 =?utf-8?B?YkZXTEc4UWV5cGlaUHY2dzVaWk5KcGwvYTB3bkEwMG05cGIvRkZZQU1pYmRB?=
 =?utf-8?B?akZqQjYyT2lWQm50dFVlbk96aW04TEQ3dlUzNjFXNkV0OWhPM0liUDBWV2xk?=
 =?utf-8?B?MHRrSisyRmxhdjhzREtWOUw3bGZsdk84cHZBekJua0V0STd5RFUrcUI3NnB3?=
 =?utf-8?B?NjZzdVpkZit4S3hWYUNPNHR1ZE4zYW95SUlVNWdBZHFPaVE3K2FSczVhemhx?=
 =?utf-8?B?emdBZ09ta0w0TjkrVHVVTHFreG1lWCtqd0pqMXdxVTZ1YlpISzZXbk4rVkdR?=
 =?utf-8?B?U2UydmUxbWJxZnYxaGJVc2RkOVBQbVhCYzIyS2hnbnZQd016Rmh6QVI3bEs5?=
 =?utf-8?B?d0FpYjdqdnlNcWI2QWZtaHhRN2wvYkEvZDh1SWxEWFhPQkx2REgxZjM1V0p3?=
 =?utf-8?B?cEtwRWtrK1JwYTZrWVhvOThBOEo3NGsyYlpYV0c2TG9SSnpyMFIrakFVR3Nr?=
 =?utf-8?B?QVRJNk4vbWdnTFNnZmNYT0d1MlQ3Tjd6YlFxVXp2UXdweFljTHdvbXA5TVd0?=
 =?utf-8?Q?DSzEkohm/auC9wGpTDlOARdOpPdAaS3n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXhQMkhUQkFRNEZ6OUsrVHJlenkwWG1mWnRhb2UzOGxuaHVHeWd5SVFZL0VT?=
 =?utf-8?B?NUwyRDM5OVE1SG9KUnE4Zk9QR2N4WGlrOXkzNy9ZdkJHenN0bWg1dkM3V0hQ?=
 =?utf-8?B?aGpKMVN3RjJiWFVJa2VBbEN3cG9lV0ZJa1JUV0g3TTZ4VUhhWmcyUkI4TUM4?=
 =?utf-8?B?Vk1MQy9nTzEwRXhlT3dyanB0djE0V3VvbVJpQWhQbzlvQU9yZmt1VkZxcUww?=
 =?utf-8?B?KzUvNTBsYlFJcE0rYk0rZEY0ZWhhSTR5WVVoTm0wV29FVzNsWW8xVFc5OWJy?=
 =?utf-8?B?ZnZ5NWhOQVNnb0huZkFVeXhrZDlvVDY2ckVpWGJwNEdpK2UzYW5XVWxFWklo?=
 =?utf-8?B?RmZVQXJqUnRYaDJlbDZUWHNUMHJUb0xCeVAwTnVFSkpGTHN4WHlkQ0JGTXpS?=
 =?utf-8?B?RFgyMkIwVG1WOFMvUE80T3RzWE5kU2hDMDUxT1ozS1dxekJZRUNTandHdURI?=
 =?utf-8?B?KzBwYzAvY1lRNExTSkozcUgzOHgzbUpaTzRzTWl1S3BGd0lrSXdsemtYZTRC?=
 =?utf-8?B?cUdqdjI0K0FqOHNacEcycGRvUVRSZ0kwTVFkdGc3KzlYaXYvSkVFVEcxWXFo?=
 =?utf-8?B?SXlvS0dwT1dFZm93VDl3aEZMSXdJa052OEZiTkZUMWdXR1lEUmFsaDRTL05l?=
 =?utf-8?B?N3lFR1Q5M2cyTHZyWGRrSmRwOUx4N0k5eDBXdDVlcHNrUndHMWxwMmtsek1l?=
 =?utf-8?B?MFliQzFTZ0NYcWNnMjZXK0xyZ2t5b1dZUkI3cmdRSXQzSXlPa0wvdENPZ0tk?=
 =?utf-8?B?SHJycTFoQU5OK0R0UVUweFpkOUZvNWNQVGI4NndJY3pJc3NXc3BIUWdVMkxG?=
 =?utf-8?B?OXBzYnV5d1ROSklBQndBY1M4Qzk0ZGVlS2dzbGp0R01JUERYVks3TFRnZ3lt?=
 =?utf-8?B?ZDZacEwvVS9RTkp4UzByd2NqLzhuTUJ1WHFPa1RDRGhucWtRWDE5bExLZisv?=
 =?utf-8?B?RWZzbUVjRFE4UzR5SjJ5RktkcjBmTC84cGFwZVRCWEk2dHNzLy9la1FXSy9x?=
 =?utf-8?B?ajJXMnRscHdLZEN1cnJodVhhZUlzZjVzVlVIUjF1MThiZkRNRmpGdDJnbHFK?=
 =?utf-8?B?OFJqWENET2JNYjJKKzJUQnJtd2lrbjc2NngrU3c2VXF6MHpXaHBUNWVUdVNB?=
 =?utf-8?B?TUIyOW40Uys0SHhmM1lzSi92QVpTRituOE82Q0w2RE5yY1RKY3NqMjVnbjVB?=
 =?utf-8?B?YVpqVEdKcE9Sblg0WUJWR2hVY0tVYXJxZWwvRUNUcmRrbEZNMVMrVHNDcjRS?=
 =?utf-8?B?b0M1cE1MZjFBWWJxV1JKMnJITHZScXA3Qm9wSGJ0WStIS2RMQ2JWZlFwUTF6?=
 =?utf-8?B?TCtrNGRicTh6Zk1ScEVWUXZ0OGJCcHFNaGpkbVZYOWpmVlI1WEFsY3Y5NU9O?=
 =?utf-8?B?eEIyS0YyUm1pTDROS1VFQUN1NkEycWNJVTJVaklPQXB3VFZQcGgraHBDOWN0?=
 =?utf-8?B?bTlFMGlBNi9aYXNoK0RYM05NQmwwdUE2ODVUdjhMTFZxNjVTZkZjSlhtcHBo?=
 =?utf-8?B?QUpWZm80aTcvK0NCY2F3Q3NVZ2xLZFFUWHJDYXRncm5UWW94VlArV08yamdv?=
 =?utf-8?B?Z3cyR1RCc1dGd0ZDa0lOL0NESnFUVWFrc01SMERzSVA3elJ4MGdXOXh0Mm45?=
 =?utf-8?B?eUp3Mmhybm5UblBmNU9SL0JDS01rOEJ1cW9xOXZIYkFyWTJ5dGxMa2FOVEZo?=
 =?utf-8?B?TjBTNE9SdGxEUUU4T04wUCtTUlpnSXBNUXc4SEEvQkxMT0VtaFZFekRaMlRw?=
 =?utf-8?B?bXlUVlo5ZFFaUFZPRGRRVlNUSUlXMkJMOTNmNVNmcVRXcHJPbXlFZFU1OEtN?=
 =?utf-8?B?VXVoVC84RGVheVY5N0lZZkJpbzRYODlRZEJrRnZtQjJiejVSSWE2UG1lL3J1?=
 =?utf-8?B?REZySEUyOWJBVHFVUE1zWTJuUFMwUzFWNjFmQXp3Zm5rVFBaclZRNGtYajNU?=
 =?utf-8?B?UHVOUFo5RUVGV2pwZHUwUzFpMGM4Sm1JbDhwOHJNQ3Y5V21yUVlUSmVyeVZm?=
 =?utf-8?B?cjduOFRqeHJCZTY4Q2xEV2MwUE9aYWNJeXVKVXBUSHlOdm8ybmIvTldMRkEv?=
 =?utf-8?B?dW9tdjZaN3BoK09sSnZETEZxL1ZXMTJZSDUzbk82WVNyc1BiZnRjeHdWRTYv?=
 =?utf-8?Q?HB/bf1HCWiCBo8OkgGxqySc8j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: baa0139b-1639-435a-a075-08de39dd83aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 00:21:09.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRSD3LmAl7MqdOD4AfC6oHsVJUcZWk6gMsTi3Nwg+FgJEwlXfVAqhppx2Jw026PbJTXo8fmww6GnqYVqJBK51w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9473
X-OriginatorOrg: intel.com

On 12/4/2025 11:58 AM, Ard Biesheuvel wrote:
> On Thu, 4 Dec 2025 at 20:51, H. Peter Anvin <hpa@zytor.com> wrote:
>> 
>> But your underlying assumption is that disabling LASS around EFI
>> calls is a problem. It isn't, because the efi_mm has explicitly
>> unmapped any memory EFI isn't allowed to touch. In other words, we
>> are already doing the equivalent of LASS "manually."
>> 
> 
> I must have misunderstood then - there was some pushback on this
> IIRC but if en/disabling LASS is fine then sure.
Thanks for the feedback! I'll leave the patches as-is then and wait for
additional comments.

