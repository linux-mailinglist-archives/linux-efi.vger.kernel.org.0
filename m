Return-Path: <linux-efi+bounces-5077-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B19BBBF801B
	for <lists+linux-efi@lfdr.de>; Tue, 21 Oct 2025 20:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 361CF4E97C4
	for <lists+linux-efi@lfdr.de>; Tue, 21 Oct 2025 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06797346E60;
	Tue, 21 Oct 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBNeQSnj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B108246798;
	Tue, 21 Oct 2025 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069825; cv=fail; b=Mx3uWz0FeK9Hpg2bmnJUiIb2bGTwDdL9KZ5sXji86IwALIkrv311zp4N0N0gaf1IO0t4+BRsD2pJZVtFk8MLJOkILNdGmuG8bKy42wtfcvjM6gvmXxJcsfWymJZPvVNJtScPGZHw6FLkRf4L7xdbWGLiXtXQCn/mIxpSgt6Ua1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069825; c=relaxed/simple;
	bh=Kn1SYrpgpyfrbr5gyhiyGh6VSCyibGtJZSlmV8xif0w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XXT5fMazMZmg7jjfXFQtLm5IIn30+MqZ62HhWtnemInBfoNiWvTkc5okAMHnU+1IevfIUFtDzFv+vhRoBXP1W8F4fB9Sgc42CrYpE+6uWhu/rmgKlu0Sa9bEbnhRb9ptrzRWgBr9p+efnoy439MmvaFD4imQkBMA9dr6A3DJEQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBNeQSnj; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761069824; x=1792605824;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kn1SYrpgpyfrbr5gyhiyGh6VSCyibGtJZSlmV8xif0w=;
  b=kBNeQSnjDZ60Eo9PJuTCAucxwL6lcJWI9sqHtpM4aDXQZ1oO84LnmNPe
   SAAbRXCxt3Kt/tQpTZpOHmxcX/GiZVJGVI8WIZ2ME5EwM7KLhoQId/ssv
   yU3CHZ3NtIVgK/uo9WqE3A+YNTJY0kbMpOHxif32FQsXvFTSHB5Bvbq8o
   LZX9BsDAj6vvMTiRNB6GFqfYRJos4Rkw5Y6FHtlD5rdlXiPWcM4jGflTK
   WHCtaP9aitbTWPHFHNKIjdyb0BTkd4hycptPCSmF635/tRGNOuutf1TFJ
   LiEmwHJP0mcRPcGvtEjvb5rzQLe+wpi5Gxo9fu8cDWyNm9ctaooE+2HPT
   Q==;
X-CSE-ConnectionGUID: 533/L+fTRl+ZByoLuG0b5g==
X-CSE-MsgGUID: 5+T/YxlQQZ2do2g+HwH5Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73876690"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="73876690"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 11:03:43 -0700
X-CSE-ConnectionGUID: Yb55QRf3SM6NH9DiXJZrOw==
X-CSE-MsgGUID: nPUu5eSnRE6U7EbCpIVHww==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 11:03:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 11:03:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 11:03:43 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 11:03:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoWGvJn/AR9i+v6b+NzCbvcY2Sc99vNtOxUE4TDquABSAjGTQ4yP6RNKqmwSfAcczWUF5mS8AS0y2gokoQtAeN1elONPoq0dZeZIaEpXLwJLNZAf4533HnKLtW1O0EUA8aqjfyYBV9bm/POsM/PZs0UBPnsatwP0XwDorImcSFb/WuUcjndwHrtDumZ8e4EEjZIqsYUAjkcyJS3gpHEeW8rt38gesmHV9N1BFOQNuOOCojaAXGkKH1xDfKy2TsUzumcoat+X99hba8f4LhOCJrFDiIjSIOFJwdC9aFME24QGdM1qMMZwJw4tQ3CINqXLHxzAfp2L59bL5be4PEJCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXeV9C7hDdiVJ/iil0xVa4JhkjgOexRp9z9uzlHvS+8=;
 b=JhS9f8HKVlyOnTacSXnyYy+6c3XXuhPMBNFwE3PPoaVAhqpNFlswzcNCgeRKX2ieUlIcwN76nyxpXpcxlIunT9V7/GyEiFn6+V77LMZsS3Lle5xxs/TfZsUo86u3zQpYW7FDuO10WcWNyCDGmcWQimeJqEu2NxpQOE+gJNA6tM+H3WzFnaVeag2KuZF5JFxT6UlQV6K7BCvThxv7Y5ZMjzlBXyMtWTLnhro99ZsD90GxDcAnKALv271kQUHI/bqrg5widbNW3BYZ2PCGXRDgNtFWdXoItU2C2sVlMNI+vKaClgR/x5i3sDJ6RjxAUgfMhVOTqQMlC03tyUWzQ/bRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 18:03:40 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 18:03:40 +0000
Message-ID: <72e629c9-31b7-4ade-84a1-4c06b955d746@intel.com>
Date: Tue, 21 Oct 2025 11:03:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
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
 <20251007065119.148605-2-sohil.mehta@intel.com>
 <20251016153514.GDaPEQsj9eNwWfmtLf@fat_crate.local>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20251016153514.GDaPEQsj9eNwWfmtLf@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|MN0PR11MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: b86eb6cc-9e51-4ab2-5aee-08de10cc2a19
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG52VlVxNTNKdkZYQ3B0bFZ3Y21Mc2xjSUZ6YTViTTJlblpJamRjTGRNRHVR?=
 =?utf-8?B?TWk3UEZVQklnem9qNWpwZElrdzRheFUyREJqTFNCWkx3VEFLYWZQL1pKR3hP?=
 =?utf-8?B?Z0NFaFpHUEpsbUlrbksyY1FvSnB4c3lRQ2VEVFZGL0tYbWF1VG40bHAyenFn?=
 =?utf-8?B?SkUwWnFhbGJLQlZjdng4bytxVlRScmhrNk1wbzJQdmF5byt6bHB2WVFYc2ZY?=
 =?utf-8?B?TnF6alJBTzFUSUdSVG9PYkdSU1JTNHNNK1ZPRjBvK1BxS2M1bzd6bGIrU0Nu?=
 =?utf-8?B?MVVNOVpVY2tYaG9yM0JKUmVRVE1PU05nMUs2YW1vMlZwOEV5ejR3Rmd1K29M?=
 =?utf-8?B?eUV0YmxOSmtkdjVCeTNlczVjT3NxbWtTWnprUk1HeHZDU2JZKzZMblR6OVpR?=
 =?utf-8?B?Sk5vZ0k2aStXYWd6dE81RUEvZDdWQ1pvMWZ0TkdGYWlZNFY0STIzbzhQN1c0?=
 =?utf-8?B?K0ZuUXR1azh1TmNHN1R5cEgxN3VkbmpvMG14TTlVNGdRQkZnQThheXVTVzJn?=
 =?utf-8?B?c1dyVDBvZG4yV3hXdW9UM3ZlYXhmK2xKenlWSDAwNzU3MFFneFdERVYxNk5X?=
 =?utf-8?B?VUFLL21VV2xBZ1ljekpQSldPMTh1bzNibE5FRnZrK1lQcGhQaW43QWxqakRQ?=
 =?utf-8?B?R0RqdDFVc3M5N1RzK1RPSkFJZUxsWHRPQW9aZ0x6YnZma1h2Z2tyR2VUeU44?=
 =?utf-8?B?SzE0L3BPNUJ4N3cvellhZkpiU0VzbkNFc2J2VExCdFVWR000SjZPeEVvOUMz?=
 =?utf-8?B?elBUVTVjNlZ6M25BZTQ1Mm9xcVNPTE5NV0NPY1h4QzlmOG9laS9vejRsNFR4?=
 =?utf-8?B?UFM3a1U5czJ1VXAzU0FqUjM2VUNybTRESFA5UzFFMTNUcGRuTDBiV0hNUlJa?=
 =?utf-8?B?VHBybnZJcHo2dEVCSEZYNmgxU2R0aTk3VGE5R3kzS3B4S3lGQlRzdVhmaEJM?=
 =?utf-8?B?Sk5qMmp1SVpkUGFPY1pJTEUwMDRoYTlrS2cydDBRT2dJNmd1NkpRUTJaSzd6?=
 =?utf-8?B?b0lVU1V4ZW9pWXlLQlIrUnRLTkpBNTlsUTM1NmczbU1JWXJFR0FjT3JjYnQ1?=
 =?utf-8?B?eE4yaDQzTnBwS24yOFh0STh0UkVsdnVLVXE2TFZIc1BscC8wR1BadnBBZ1N4?=
 =?utf-8?B?L3dLa1lWV3l0V0NUeUxLNmorc1AyN2JzZ21lUUozeWlRMGszdC9zTWpzWWJD?=
 =?utf-8?B?NTJUaFRYTGllenFoZkl4VTlyTkNENWl2Y1lqNWIxdWp5Y2hXRVBzbFA5UzJG?=
 =?utf-8?B?QndTWHUzUjhYaE4xK2x6ZHFENTh4RDErZlFER05OdUV6QUh0UUFzYlhnbjcy?=
 =?utf-8?B?Z0hHc2MzdC93Q29uU0kxSmxtWjZyakdsL3FGM0hNaFp2WE1Nck8yMWdEMGhX?=
 =?utf-8?B?Vjh5V1c4V1dLZEZiYkcwd2JJb3R6ZHZhaVJNTFVzMHhwa1hYRm4wTFErcFNz?=
 =?utf-8?B?d2kwSUtSbVNzUmVUOGNKTlJ6M3dwb1hWck9nTE5peTNuZTFXL2tjWnMxMy96?=
 =?utf-8?B?dFExaXZMdzJ0Smp0ZzNJckhwMjNnNGlaa2tIenlaMytvSllzWHFMOWhHLzl6?=
 =?utf-8?B?SU0zWWRoUWVTb2UvU2RoNTdnMVVMYkdxMldIYk9uWlNUd2REeGpOUE5mOUNp?=
 =?utf-8?B?VFFOVWt2VkcwM1ptbTcvSGE4a1U1U25nZ2l5cFd0UHBRR0k5cjhkM3RZV2pi?=
 =?utf-8?B?NXFuU0ErMFV5UDE4cUxtVjNQbnZxY2EveUhkNWJMek15dU90bS9yOWxiNzJS?=
 =?utf-8?B?amUrVzVDdHE1eXNaMldxTWcyM05MWDVZSjBrRk05RU5pS1I1bmZETFQwUFFB?=
 =?utf-8?B?MThXamtIdmx3aTNFVEFSRFZmaTN6WXp0bjJ3OVVpTkd2NmNBYzVOcEFQT09Z?=
 =?utf-8?B?T0Q1RTNLM1RqWWpwTW5vcFBXM1FkaWJ6UXlVM1JUUytZQ1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VElNRk84NU9ZL283RTdRc0VIVXRzQU95NXdEZDV1VTZrYW9ZYjZkUXF1QlFw?=
 =?utf-8?B?SkxvcVVIT1cvc0ZHVDF4RTk5NStNK1N2dXh5Z0czN25hUmM4RWNGa255OG5D?=
 =?utf-8?B?RWJVaU95SDhLeGp1UGxFTldENVlrM0o1UUo2S3o1U2xJN0hUYUZYbHBsVUJx?=
 =?utf-8?B?dUMzRHJuN3NJdXNyQ0FNZGhCT04rZzEzUS8ybmJYRGFHbzByWEFhOFhoZXJ5?=
 =?utf-8?B?Z1E2ZllrUVpxL0J2TlNOMHRxQW9yNXFYbVdtU1VGU211aGxyN1FUZUFCWUpE?=
 =?utf-8?B?R2pNeVplT0ZsRkU5OFZYOWxCNWMxUFhmSXpadFkrcXZ2S0JLcTBCajhFa3Zq?=
 =?utf-8?B?T0xKd0VKbURnSEN1U2RYcVhHWjRNS05GUjcxSFl1L2pEL1VhNkwwVGdqVmtS?=
 =?utf-8?B?U1AyTW5KK2FtdWVsSEVQSVhHV0JEbHFEeFgwK2FxbGRiSjNuaVM3R2JsTXV3?=
 =?utf-8?B?b0pHcWFZT0FLVldiUFdZWEhNQzZRZ3ppNEtwUTgxYVRLYXQ4UktycCs2eVlh?=
 =?utf-8?B?V3NqOStCWE5IcXVRWDg2aDBhd0hNVzdDeHpQeHFncnRzVEJJamV5TFdFREhi?=
 =?utf-8?B?WkhvQWdZZVVZenIxZWM0aXBNdndaelVQdXNlencrWTluOVhDVTd4SWp5OVo1?=
 =?utf-8?B?bzRtOVNCSkdnYXJmUVFPd1ZSUk5KamdVZlpGcWdhWEtFSElselZLQWdEWnBm?=
 =?utf-8?B?Z29sOFNFblA0WXFxQXdWenN2ejR0WW1vd0dMT1B5M3Y0LzhLMXZmZm5TWng5?=
 =?utf-8?B?U1Jkb0RaR2dtWFFNSEJaZXBwNUprQk1DZTRDcnJtMzZSclVCbW96M3N2NHdI?=
 =?utf-8?B?Q3lqaTNSYlJRNS9XUW53U0l0L1Jsay83TllQWTlsOXh0eUp5bERNZWtuYmhO?=
 =?utf-8?B?ak9mYUhJRlpuMXYwdWEzdFdFNUlNTGlNWnkvZ0Jxd0YxODhLaUJzRlRVRVhq?=
 =?utf-8?B?cmFpOUdYczN0cWNWdnVjUGl4UldlQW5NVktrZlNIWFdjUlBFNWZKem9KR2w0?=
 =?utf-8?B?U1hsMmx6SmdpcnExQitPVk1ZWTd3dVEzQVhHQ0JNdDg2RE1QQ3ppWEV5RnZa?=
 =?utf-8?B?WFQ0bHc3ME0xWlBnUlE4MVpFSEVYNVptc0lsRjh3NnU0WnI0SWd5c1pHaXZF?=
 =?utf-8?B?SWtRbDV3cjBnVmx6anVxRVRzdG1xczRGRnBweTd4dWZJVUhHN2plZXJROUFm?=
 =?utf-8?B?WUhzOFdDWGlUTFE0YWc2aHdMMm1hTmxQT3VXSy90QktwclRSakdnWHpnVlpM?=
 =?utf-8?B?eHRObmd2bEIrY2pwVEVIbXZGNE80d0VjZCtKTmliSFVxTXA2VUpyaTd6d1pk?=
 =?utf-8?B?c2xMTnpaRTJtOHZHTUp1bTlKdTRpRlhzVUp1NmpwK01vTW9MMFRqeHcxVHFr?=
 =?utf-8?B?NXM5anRRSUN2Tkc5WklVRnA1S3BqaVgyNUZLWHczbTBQMmdmU1VSMkhxcUph?=
 =?utf-8?B?elMwWkc2Mm5lTENjMTQrWHZsdjVsTS9adzZ6ZjlkckhxR3BZZkpLbGNPY2xu?=
 =?utf-8?B?ekRVNVF5aS83d1Z3ZGhTNGppb0x5RThEMjNESkNZUnd1dFA3aDZPNkwyZ00v?=
 =?utf-8?B?NUJTdUw1b1FGL1FKNmdJbHA5VityWWJ3TE5xTFlpNzUzVWJtRlBFVnQ3UUZ3?=
 =?utf-8?B?UlB4RGRqQnFGOXZCODN2Z2xxWitwbVJ3Z0xwVUlGemNweFVGNjFySDJIRml6?=
 =?utf-8?B?cUpGQnJoVWpRMm1acjJucTFpWTVabDBicGZ2M3BnQ2FSUitaYzllWUs0MWFh?=
 =?utf-8?B?UStJc1hZSGZzME9CNmpyY0ZBd1FjditTVE5nemtqMUFLQlpsRlU5amFvTEFR?=
 =?utf-8?B?T3dhV3Bzb0hGMXdZR0ZKM3BXeTJ0N01TanBiSUdUWEhWNHVqVlUyMFgwSm9w?=
 =?utf-8?B?STZjeitKZ2x3RHh1S25wNlFmUVl4UzBCQ1pPUmRPZitZcWFyaVhVVEE3WWtR?=
 =?utf-8?B?NEd4b1VoaENhNW5WMitDeUN3eEpCVDRKZHA2NGJzcy92QWQvamRLMjNUdlVs?=
 =?utf-8?B?UnZhMUo3R2U3OGxnSUU5TWE1SFpmS3ZsbEZRSTNXc1F4eTF2RGo1M0FnVEs5?=
 =?utf-8?B?WVB4cDFwS1d3eEFnN0Q0SmpmZzJmeTVHTVFpdTZQdklneXZZQS9zZTNkNFRZ?=
 =?utf-8?Q?tEomCgSFLvP6Xf0WC2Q5t4q8k?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b86eb6cc-9e51-4ab2-5aee-08de10cc2a19
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 18:03:40.1291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdBPbbRvwGIAnOQPkp6FFLb5AM5zpGXmVNRZTpKz7hIw5nILcfnYFaejrZc8slpnpfgIIAz1ypESUqQ9VA5myg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
X-OriginatorOrg: intel.com

On 10/16/2025 8:35 AM, Borislav Petkov wrote:
> On Mon, Oct 06, 2025 at 11:51:05PM -0700, Sohil Mehta wrote:
>> Link: https://download.vusec.net/papers/slam_sp24.pdf [1]
> 
> Just give the full paper name and people can search for it. Links tend to get
> stale over time.
> 

Sure, will do.

