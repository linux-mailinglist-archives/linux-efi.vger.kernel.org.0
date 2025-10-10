Return-Path: <linux-efi+bounces-5019-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 829A6BCE0C1
	for <lists+linux-efi@lfdr.de>; Fri, 10 Oct 2025 19:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A4F44F0A00
	for <lists+linux-efi@lfdr.de>; Fri, 10 Oct 2025 17:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC80C1FFC7B;
	Fri, 10 Oct 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGa3xMuc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F7205ABA;
	Fri, 10 Oct 2025 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116260; cv=fail; b=swCw6DGY+VR26vBkF9LGPylKSC3GiQt9aoqwKPc8n1IxZT8GkkLTsFb0gSC7Lq2QwyDgGsHiykWnICW2W0xqqeerJ65Sd/T5r1j4EYMH5SaqvapJZd70rRgXMTMjhciCBDaF1mUn89uoI1tIHx70rttmk8PiIzq87SdEw6KF6QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116260; c=relaxed/simple;
	bh=L+qbAvsxEQ91J26+TqYgTLtYGXa/2A3pWCVlD3krYOw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lXOD6ffO+STSLzqM8/sqgiY01TkqZjjT7yjJ/zVO+TtFOiZT6tHjBk4mz8bUDf5xoWDwR2hY0F8taba8B451hdt9AaXfgk20Di6dtWgtXTA0MB3mEbmwTH2g6MwO6nHu/kdVwcquqxWbQmWPEP5R2n9BvlsHPqcjjycBTcLos6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGa3xMuc; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760116259; x=1791652259;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L+qbAvsxEQ91J26+TqYgTLtYGXa/2A3pWCVlD3krYOw=;
  b=hGa3xMucplGTH/TyYtOMu/+O5qab0P0/C5Ez5nAUIzR8jLSwJvZl1H07
   ip+xoThqpVfG2r4Xf4Ipy5TwzFfLgYGIOCfaEDwuCEeyRfLd1I7Pyl2A8
   9ow1/RdrxYUNt1Y/FSX27IzduPl43vx11BJbUwBodBysYXNFRyJF9OpWH
   ZsDvgKRmK00hZmQxgSB0L+LM5Jc+Ny2YyLf30XfTGY2ZteF6xzX2UDFeg
   0g2f2YpgvQuV4z25BRiSt1278s396xvGYeh0kZJhNsOGkjguR3uhfzy7q
   38cGTpEtQ7YB3QF2GbYSB55Wcpk18Q9s+do9quUdsrLIGStFk6IsftwDU
   w==;
X-CSE-ConnectionGUID: TOQTZUeRS56YGk9TBhx6ig==
X-CSE-MsgGUID: HYOjzhSHTo6nik3JI8y7HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="79782546"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="79782546"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 10:10:58 -0700
X-CSE-ConnectionGUID: w3NBpcMsRJCAHFNUxW+N3A==
X-CSE-MsgGUID: aKPv7xYtQ420Yq+dKu8ZXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="180606592"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 10:10:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 10:10:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 10:10:56 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 10:10:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ1Ym4MkKmlSAjq4l+QzmZxlVDvmZYZ0sr60ydzYyBYs4sxD+JJFtwyMx+bzrZyqfBuVCcDem1ipFq5+MzgCnsGUti9/Cf2KDKQm0u2OKOxcHh/lbPOpIAY3CJUD3Wqb11enwH63XkT4i3igv+picmCsliTizysL3n8wVzZ7/MwBN2xVjj+4lU/49/2I8wDTsoV/vNctaWieDDdApDJbB9L9zLcqvMXigCO3PRqlKNjGzNRffBKitAMG6Ey2BYG0vywIHFO0UCWeRCby+Y+xQyP1wf5Y92u84Q6fsyhNgsiTC1ifn693u34mt0mp9KNdD8NY+rdGYrqXztMZoHxbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxy1aWvAKrNHT7hqcIEBM+Mp4+Bev9VcUjx+d71KjNU=;
 b=y4JGUtNcbAOvJAJwoLZvgQFr53W5I27/EiVDkszfYlvUshkPn12rgki26W20EbpI4cntVegQYxK32WHDdtWyUw/QPURWeTHmrmvC9cHyjPrwG5w08Nkhx5MvRvPcASQVo0WgwQ3b3EP9njFvBSkleQkKuh5guIbBM46bHL1cxdNmsSTWZZNi2jpuxlmklEkxuWQTsoNhSSQT7GYuCGRjYdIQ5hbtXcIvMKaEFU1sLZQd247Zbji0ueIVHzRb/Jl/1/JYV5jv/5pvo4qW2fIYq9oN5oErkyes2Dg3MiJz9swtIIH68Bxr2etW464m4XUSb6E1Cj6JSCTlJJB6+bvUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CH3PR11MB8341.namprd11.prod.outlook.com (2603:10b6:610:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 17:10:53 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 17:10:52 +0000
Message-ID: <7c60a20f-6107-43d4-b742-20f0dbfe6d50@intel.com>
Date: Fri, 10 Oct 2025 10:10:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"vegard.nossum@oracle.com" <vegard.nossum@oracle.com>, "xin@zytor.com"
	<xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-4-sohil.mehta@intel.com>
 <9240edbe689108f920d4b0c5c786278aea47d1d2.camel@intel.com>
 <07cce6e1-db01-46ad-9848-80cc96f3b468@intel.com>
 <2ac89a5fc103f895a185010f11c81014dcb58d9b.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <2ac89a5fc103f895a185010f11c81014dcb58d9b.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CH3PR11MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: e496db48-28e5-48e2-fa66-08de081ff797
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjQ2TmVWMEJvMGp4dnlINEQrSm1iRFl4czZLaDZTcW1aTS8wd2s1RktJclN2?=
 =?utf-8?B?VXA2YVVweVJmTGpoaXRZVmZTbXN5dWJnMnBSb0lrb3gvbDZadTJOREo4VzE2?=
 =?utf-8?B?OWZtT0RWVERsYzZIY3VsNXVzTFdkdFdtSFdLUDdRZVNaTTZ6UDkvYlA3TXJW?=
 =?utf-8?B?VGRYSmFnY0k3S3lOcTNUU2RzS2p5bmN2VUJUcGRta3hmUllCUnNnRVVwY2p0?=
 =?utf-8?B?UW9xaTBWUmxkVWI0b0VmZmk1VEhtYU5WOHgxc2VVY25ucUxtZVNLc2gwMGM1?=
 =?utf-8?B?T2VoNndwYTJ1aWcwZG5JdUhvd1B5MjYvcDBic2g1WU9iZ2dEZWhweTYyWjJ4?=
 =?utf-8?B?aEFjS0k4WUVnNWRUZDJ4TnBSdnhrdEMrTFZkcFgweEUyanhDODBQV3BwZmpX?=
 =?utf-8?B?bE9DUC9NSGViTmR5L2tJUXQvaXA3U29NL3VUeS9hTmczaHVPQ2txZm1XNU1W?=
 =?utf-8?B?M2I2dVhJZFNTc1BPZERHQmh4V1BHOXlhdS9nbGlCaXNKT0RydmlId1hIbk1J?=
 =?utf-8?B?SC8wZCs3a21Vb05hMjBEbG9vT2tiRGd6Uk5WREd6Vmg4TEtxR0IydlJFajQ4?=
 =?utf-8?B?RkIybGpVWE4rRk1XWGFHNGZsUTR5RFhoOEYwUkp3ZTA3c1A3K1hQcTVqRDhq?=
 =?utf-8?B?akwwL2c5RjE4UnFadlI4d09XVERVcjFJRnZBbElSUzBwMU5ldVl4dVlObldL?=
 =?utf-8?B?S0EzQW0vQ2ZmMUNsQXc3MHFWL1NORzkveG52VEhreWx5dDgwWjdtUlZLRmYy?=
 =?utf-8?B?MXNsT2lhTVo4UWtKOCszUTh0WUpKZ3Z1WC9yeXloM3F0VDZicnVQd0NheTIx?=
 =?utf-8?B?MDhwVjNFR21CdU1yeDRIclI3UVh6YmNvVUVEUkpEOVh4dmdMRHN3YnNZSnY4?=
 =?utf-8?B?QThwRnI3MkJvREc3dkV2M1pwMCtqK2pibWMyRXNvd09VZ3RFZ2lzajZzK09m?=
 =?utf-8?B?Qks1am5LWEZMbkhEb0l1K2FRNy8ySy9KZ3NjV0VOajRyVzBleXE0RVpwTFFZ?=
 =?utf-8?B?bVpSVWNQOExYUmJvcXM5RkN4MnJNZ20waktQNFl3WUZiUmtlRzdkRVRHSGxK?=
 =?utf-8?B?WFFGMnhBTGsySER5QVNpcFFKdS9NdXBBNTEvVDZRSWtRempDY2VYWGhkck1y?=
 =?utf-8?B?UXFZbHZHczBlOC9odDFuWmQrTFVyQ29sL0Jyd2Y1OVg5SVl4NFZZbzBlZkl6?=
 =?utf-8?B?VGR6UDlOcjlGVXhFZ1dRV2l4UWNlNnZ1QldxMXBUOWwzOXpKNWNuWjN5c05H?=
 =?utf-8?B?azlWYThhYi9xNkpMNDhSMnF5TFErYXJURnlVcjQvSHl2NUgrRXZ4UVhxWDc2?=
 =?utf-8?B?ZDg5NXI0VG9mK1RhdHBIQm9kQThYTGZpK0ZGK2RsbmZYdlVYcmdUOURkamNq?=
 =?utf-8?B?aWJ2cWtFR2ZlamE1aG1sZkVJOVR1NUFKZWZMSUZRNnRRdGVNZVBQMUtyczdS?=
 =?utf-8?B?aVNRTXIvTmlVWUM5L0U4NVQ3SVhYVjRmQmt4UGpNVW1CNjFVdTBORjNpNENJ?=
 =?utf-8?B?d1lPcHpQME5ESVBFNmpQVHpFeitQbGNJK0k2cVB3cUt0bit6Z1k3QnA4endt?=
 =?utf-8?B?b3ZkZS80ZEt0Q3BQYkZaTjFlUW51Q1dSYTBORldiMVJmaXAvaW1iekphTmRT?=
 =?utf-8?B?d2loOFdHMkMxd2pUNm85TU5ybk9LSG52eUwybnIxQno2czNzTHkyT0YybTVE?=
 =?utf-8?B?Q1Y5RmsrbkFheUpQbHM4NWNBU1VCWEY0M0RrYWxUREtpcWN0b1lWelVIZnE1?=
 =?utf-8?B?d3Z6SkJpTjNadGNSMzZxSUZzRkRiU2M3bWdoWEhlcU12aEhGNjU5OGgzWHBx?=
 =?utf-8?B?RHVDUVpoSmtIVmpXdHV1VU5FYWlzcmZqa1pIOXBkUk5qMFFPLzZSU2ZDVjJu?=
 =?utf-8?B?cWxpcHk4TktxYUh0elNlR0FYWG9CZHJDRGx5TDRPOUptRGVMb29nS1d6Zkhk?=
 =?utf-8?B?QkVlWnFyc2FhZEFhZmVhdkdhbGptYW5ZZVFxcnN4YVhpbVlqUmRKbEJQLzdC?=
 =?utf-8?B?dVdORHpEdVVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEdjS05DN3FQK2JVcEpKQ2ZmODhCeG9xRGIvc0V5ampjYStLcjVkemNaVEtp?=
 =?utf-8?B?bGJLYkR3S25Vb3JOQ1JPTGorV0E1TmZLSzZ6MzQ5SlJRdGdSWmZuZHZVdjU0?=
 =?utf-8?B?TU03U3FJOGsxVVREZ0p4bzgyb29ONG5DejRiK2ZmR2JDYkV1K0sxTnNkY3NM?=
 =?utf-8?B?WTFOekJ0ekcrZWxGNDFIQnhUWE43Q3pPejhQdS9WMGhGSktvc2hXU2FYVHhF?=
 =?utf-8?B?TkFEOE5wZDV2ZHYwUWtyZFM1Z0JoZk03bFZBckg1aldRVWZ6MXpzYjBuNlNR?=
 =?utf-8?B?c1F3elFoMElDeGNvMnpNdHFSN3VSdk9zenlpbzJhY1gvdk4zRFpZN1pabWpW?=
 =?utf-8?B?QWFFenBTaFpncjAwZmFLK21zcUc4SEhSN2c0U1VITDgyMnNrNE4xSkxDNlBk?=
 =?utf-8?B?RVZPVVFuNW12Mks0dnVCeGpPc1ErNkpvK3lmaTJMZHVDdzY5SmRhcHg5Ujh0?=
 =?utf-8?B?SW1Fb0o1THMwN3F1Y0NMVENRbUo3dENqbEdSL2NGUzYyUDB4OC8zK3hMUnpo?=
 =?utf-8?B?VTdHL2RGUnRwMFRBYjIwM21VSnp6RGpZbW1RUFI5YjQ1YTBudTdDOGZrQkhZ?=
 =?utf-8?B?UVhMeGhhdUlpRGUrdHNYaThKTWxacGowQUJLRE9zSUxuYWhJd0ZCMVpycDIx?=
 =?utf-8?B?NWhPVG5CeFByZkVJK3JCUm1CM25pT002MXoxNXRzWEkvbWRPRks5YTRjNkhF?=
 =?utf-8?B?REJhU2N5SUVjVit0KzJBSEpJbGMwOWtyb0pkSHdpM3dJa2FiNGpCZ25lLzJZ?=
 =?utf-8?B?SkhvMDZpclVPQW41UU9pVHJaNG1RdXZ1azEzd3N0NSt6T1hGTzcwQ2FlNVZt?=
 =?utf-8?B?czRHUm80M3h3bHVCamFScjgvM2RQVnVwYnh4SmhSVmNPd1pmREtPckN4RW93?=
 =?utf-8?B?S2IwUmh4SFArbUQyZE5ZWXg1QXVrWWI4TXMrNUhFbEFKTkJwUUowTjFlWG1W?=
 =?utf-8?B?THBRVE5lVFJRTkhBcmpTRXJzbEhmWDh3NVlPN1hwR0ZvOFF6QmpLdmFGbVEx?=
 =?utf-8?B?cVpBbGdlOUZNdkcrbjRJMXNkRVdqZFJmMGxGQlo5dmV5WndCOEtaVGdpVzNu?=
 =?utf-8?B?L0JZclpDc2lKUEpIYzBnYlRuYlJIencwYzhOZFpSN29nNTJmVEZoNmhPMXls?=
 =?utf-8?B?cHM3emFsNHFUUE81UGVKOWM5S2R2OWZpTjZ0ZW1McUhKb1RXU01RaDZCK0Z4?=
 =?utf-8?B?YmZlT2lWTDRQMmEreko2RlpTbVlnZnZpYW0wcVFxQnJPT0RjcjIvZGdoRWpG?=
 =?utf-8?B?MUdpV01kQy9UYVpCa2dmRDhNdFBIWThmMVZhMmxzcmJuQ2FqRXJzMkRubjBY?=
 =?utf-8?B?NUZJYmJNazlTdjZJQTVCRDhSWEhjdS90UDMyM0lDNHhwWUxPZ1J0K1JzaDNh?=
 =?utf-8?B?ZlNiYXYzT3dGWW1UN2FaNXZvYlJ2RFZoTlE3SHdQdjR5YXRGTGVoczJHOUVG?=
 =?utf-8?B?enZzL1Z5T2Y3Nm12eVpTbXVxRWVjay9DS3d2b01oTE1CSHByUHUyaThPRWFl?=
 =?utf-8?B?TFI4NkxoWURhTm8wNC9xY2tVT1NTVTlQWUxGeWppdHVSRkJ4ajJkczVhcU00?=
 =?utf-8?B?WEt5b2U5L2dQUzV0QndtK2ZGT2NDdlhxQ2FUd3JEa0s1Z1RKSzRsM1RKUncv?=
 =?utf-8?B?dkNIR1pRQ3ljRjhCR0VJc05YQi9lZXB2R3JLL0dObWZmZ2Nhak5ub0w1cEdP?=
 =?utf-8?B?bGlhUE9QL1lsNkNvTmlteXdaUTN1SGw5UmdqK0NsZVBSc0ZBbmdsZ1N6Z28v?=
 =?utf-8?B?YUZlVDNGNFc0Y3BmbXhsanMzbStNNXdaL210TE50NE5UMVJnNXJoUVc5MjI3?=
 =?utf-8?B?ckZSQlBQNk1PcERQZ1h3czFYdk96L1E3WlBWcWhobXlvK2NNNzBQRlFXVVdM?=
 =?utf-8?B?cXhYVm9FYld6KzZPdjRUVU5VNEhDV0NFUmJhTEJhMjBoSmF6Z3QrYVY0c0V1?=
 =?utf-8?B?eTdzbEo5bVFUVlZJdDgrdm9rY21pSXdtaGRpb0k3VHJLTVMwVUw2YlZyS09I?=
 =?utf-8?B?WEVxWWRPMXdlMjZCYmRGbFBvM3dYZFRyQ05NZytLYnErUnRLNWdwL1RrVSta?=
 =?utf-8?B?Y01hMHhER1RBYTV6NVg1VUhna3ZPYXppNWFDL1RibjdBZ1p0cktYdjJRUUsz?=
 =?utf-8?Q?fschlsZ0n/0uQg1MsIHHjYZRb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e496db48-28e5-48e2-fa66-08de081ff797
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 17:10:52.8775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGC0a3S2p6wTtl/P9QgzDsqjsOcuatuKTqRGuT9XtT4ovmrLgBG/slIr1ee5YLPXrLM4lFKr5ugZCEAU8UOmDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8341
X-OriginatorOrg: intel.com

On 10/8/2025 9:22 AM, Edgecombe, Rick P wrote:
> Honestly, just unconditionally doing stac/clac doesn't sound that bad to me. We
> already unconditionally enable SMAP, right? If there was some big slowdown for a
> single copy, people would want an option to disable it. And with text patching
> it's part a heavier operation already.
> 
> Was there previous feedback on that option?
> 

Yes. Boris had expressed some concern about the extra toggles.

Dave and PeterZ mainly wanted to keep it separate for code isolation and
better understanding.

https://lore.kernel.org/lkml/7bbf9cae-6392-47a4-906c-7c27b1b1223d@intel.com/

I'll leave them as separate.
>> The issues are interdependent. We need the STAC/CLAC because text poking
>> accesses special memory. We require the inline memcpy/memset because we
>> have now added the STAC/CLAC usage and objtool guards against the
>> potential misuse of STAC/CLAC.
>>
>> Were you looking for any specific change to the wording?
> 
> Ah ok, but the compiler could have always uninlined the existing memcpy calls
> right? So there is an existing theoretical problem, I would think.
> 

What theoretical problem?

The existing text_poke_memcpy() is a wrapper over the kernel standard
memcpy(). That is an exported function call which shouldn't be inlined
(or uninlined), right?




