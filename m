Return-Path: <linux-efi+bounces-4280-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1065AB010C2
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 03:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA095481939
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 01:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FF53A1CD;
	Fri, 11 Jul 2025 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHJ2OEI1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE49173;
	Fri, 11 Jul 2025 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752197077; cv=fail; b=mpxr0UhHeIggnfwnzRqrVz9APhG7XJ2Ll8rUI5NnVZcmjl037kquD5NI7MMEeYSAxfiIYP2abTj5HOAFFgLa73JN4Iqd9GgtpK1euNt6hbgnK++e4X3QrlGqP1qvT2SsWXak0kvdd8IGe7ZAMuGQ9Fz//Jz4pQldM0122RyxQms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752197077; c=relaxed/simple;
	bh=bbYJAbgemh+PAU91ZB+voLmdlRPsCU/dv95vFk20hGA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E8UArovebVFVA5YQtZCv77oNnpI6+6uVKGVVXHSn3aklvTqMMZx+hY11uMWPX6jWUscEGJZd/PrwyZNVy0fZPEjMkljofLWpWyBVyP68mrC+i1gmteOC5/qmC17zmTC1JMiPqIfOgXamcJ2v1DgX79xforpCokPPe3DgGJcMIXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHJ2OEI1; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752197077; x=1783733077;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bbYJAbgemh+PAU91ZB+voLmdlRPsCU/dv95vFk20hGA=;
  b=CHJ2OEI13Bqk/RTn/W5ZT1NiN3Kxp7zZEdEcQCORZ6my/Ns0w+6umzfB
   uaeLlmJ6ZxMCmEszklr5HHdkNZUUs/xchY5KDSIF9TpwMXPGGPDyQ8kAu
   eV8K5DASP0t+Gw24rpHKgObSufgYL/M3Hk8JeE0vDQNi64+RXxEFBDBGk
   MH41JEQAmx/hZfJlrCSM95uo382oIZh7oaDaFVeLgAEXYPRUqn2+OJlSa
   ffeHttHoTuzdXbK4bbKu5tJcxKZ0va5FwcITWLiDIpD6kfRk7Dyg/TckW
   chW984pmxH4HP6BIOIAgjErIxESqOi2cf5uvN+2eOhVtuDFO0ijTPOGnq
   w==;
X-CSE-ConnectionGUID: fjDHDumKTkyNyt0OFwIWPA==
X-CSE-MsgGUID: zbrBdXLvSIaTcs6UXyfB5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57106018"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="57106018"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 18:24:35 -0700
X-CSE-ConnectionGUID: 1NsozOi0TL2dLGxx86Sa2g==
X-CSE-MsgGUID: zRwrmaX1RyaQBLJu7Wn6vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="160541248"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 18:24:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 18:24:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 18:24:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.78) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 18:24:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5GmApbVeNHzeB4y72zCnIvs24fqCdQeTt1lhN8C0ebDY8PBsLpFLPqvLbt2JPDqYeYEQFsQfkQC6WRKP88Kxmpdn/hICHj/nX8m+Bu5YquZwFPlf5yw83BjugQdvCZa4mUZjuaWWDdae7GhnRFyX3QK+4A9ZgLq+IzPDoGBQ7wHMkl+So/OvKk6545dOQ1zP3pgQTCCxUx1XkS1TJSY1NoPl5vzIGlUo+bH+Ee8lcWAuzugDBvj+kRc7lEB0H0WBEVU4nYEsr9BHAMmzxDiDCdfhDAgIYM2KNRNjdnPomHLI/fFCh5Om3WnDH/zxZ/toaumbiPruNNcn4u9FZnztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqYX8O0Yz2kR2NY7ZanyYh/JiXNSufJiiLimahL7ZcU=;
 b=plcNJ5jk8f0D2mqpBrBbZUqOdcnYtu4gfGPUd+D5qpvaMNvbLE5UUuCaARGEXzbGGB67bsEr3lkrgknB1dY4xkmGL6itIlCNv/DKM1PW17hIcs0CYE4vkBNPQG5aY3/MzVA28kjYw5FaNo0chPw751TxxjW1PVMQ0qkvRWuNjn4xt8plURQ3ay3BY32Y8E32mxsuQcm6dadhgykDc7+uCKujnFIOdFazM1qy1oCFdL0tOsOg7gJVc2EU0itV1oODRRZ5kxMITbVke0nIazPYqh2JGiEbo1vrEgYxr3USqBjNxEDZuPsWuNXTDvqRr+zCsCkGJ8TyyPIZWuwP95KBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA4PR11MB8992.namprd11.prod.outlook.com (2603:10b6:208:56e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 11 Jul
 2025 01:23:55 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 01:23:55 +0000
Message-ID: <f2d4b46d-9a8c-462b-be71-27bd02a0ab49@intel.com>
Date: Thu, 10 Jul 2025 18:23:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 13/16] x86/traps: Handle LASS thrown #SS
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
	<xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
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
	<linux-efi@vger.kernel.org>, <linux-mm@kvack.org>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-14-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250707080317.3791624-14-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::20) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA4PR11MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 399008aa-4dc7-4c47-799a-08ddc0199a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTBsaHNLRzdDSGp3QTQ2QlhGaUhkcjJYcllxcytpRDdRcFdDc3d4a3VER1c1?=
 =?utf-8?B?QktVRTJTbGxjUUVoVGY5d3pPZlNBc0I3clN1bG9taStMZWJCcFdPZ0NIb3h2?=
 =?utf-8?B?V1pnajliMWFuUVZteFBHc0hGZXBvNjNNcklvT1BlSEZ1dXk5LzE2SWc2ZWVM?=
 =?utf-8?B?YzNtRWFUemVuL2R1SW5xQ1hoYWRSNm1scFBLVG93cm80Nnh3QzZYcjJsMWNU?=
 =?utf-8?B?cWh2RjF2ZDhsSWxiaUFiVFFvaHd5RUJuTjBVblpKRzFoMVRtN0UzWE1idy9v?=
 =?utf-8?B?Nnp3RmQvbnA3aUZsMmw2Vi9pRmVLSVUvRkw4dUJjUk90MEh0SzRtVExTb0pj?=
 =?utf-8?B?SFYrUTRVNStTdUdQc011REZscTdibnFBaWg1OUx6eTYxU01Ra3p3a3pzWCtS?=
 =?utf-8?B?YVNyZGtqdjZZOVl1cUFxR0ZHend5akx4QzNnd2RxK3NIQlVsOHUyRHFYMzVM?=
 =?utf-8?B?ODdsWEU5N2I3VU5DRDNxR29lcGRudENzbXNSTjJobWk2aG9RZTQxZVg5Q3Nh?=
 =?utf-8?B?WEV4YTNWb0ZZNkZZalhzOVhvbE9tYTk1M2k2dDBiUldKL0N1ZWd0RFZ4aUFY?=
 =?utf-8?B?QnVZeGh2UDE3TDlKd1I1YXNVdGxBU2VWeWs5N3RrVFB3eHgrNFVrV2JvVVJs?=
 =?utf-8?B?a1dJWWVVcDZzUjhKeU5IakNvY05vaENxbGhTQnhPWWNTTnlSTE5BMDN4bEVH?=
 =?utf-8?B?LzJRbis0c2JUSVRnbGkyRXRnWUVPWk1BbDBzWlpTSFg4VEtsdS9xK0JFNzFN?=
 =?utf-8?B?WG9wdk1keEc4TTNBTmZvZHNDTkZsSWlUSWE2ajViellUaXhJMkc1ZkJhR092?=
 =?utf-8?B?WGZ1WDFWaENiNENUSE5ONCs0QjRnakplR1RsckxXbGtIeGxWaTlaYU16SE8z?=
 =?utf-8?B?VDFZbXFFWkh3d0I1L2dwTjQxOGJYc09HVWJCaXJ4SlRaSjVrek1nVEV6THhB?=
 =?utf-8?B?Mkt1dStmOUV2aThUVnJUUzlrZmowaEFKTngwR2dCdGg0R1BDY09sejBoUU4z?=
 =?utf-8?B?dmRrY1pzdTdhNzdpZmoySEQwbUxIeVVoUjNvYVV6Ni9EUklwNmJxQmFZa0sz?=
 =?utf-8?B?My8wblhJOFVzZXRVRDUxRlJnTGJOVmlwNFR3VjhybFNRd05VNXNvMGl3SWFw?=
 =?utf-8?B?b0JXdFB0Rk1ObXU2VW4wNEJUVS83TFJYcG1EMCtla2h3MjlmYnpKSE40dGNO?=
 =?utf-8?B?Q0tWZ3haTDZrTFZkQUhLQUlOS1dPQnVxVnFWL043bnI1bi9HSzZmVDY2SUdZ?=
 =?utf-8?B?bUxaWXh2NHYxdDFRMks1SlMrMk4ydkpua0YybjkyL2d5Nm5vbE9FU04yU3dj?=
 =?utf-8?B?MUNDejc4b0dqeVdscU5taklUVjZZNlczVDcyb2piazZnNWVlLzE1QmlTT2tp?=
 =?utf-8?B?RHBheVFVT0ZtdlhOVGYzMEh3d2Z3S1V4Y0QxSVMyNXNMc21LUHNmVmhVZGFK?=
 =?utf-8?B?ZjE5ckI1TGZ3bkhHMGp6NVVvd040SFJKVXNQOWZsdmQ5bUd1Z1NKRmE2TWpT?=
 =?utf-8?B?SE1SK2ZSR08vWlVIRk9DejRja080Zkw2VWJHWU85L2hLL05KV1Z4blM4M0k2?=
 =?utf-8?B?TlZ6bzhtdk9JQ3dKMDhCWEE0NTE1YjFmeGVUUFZrS0JteTliY0NoRzFES1Fl?=
 =?utf-8?B?RVlNVE9EUS83cTBqOHd5UzhaZ3Vhai8ycDRBSGxVVmdKdjlFQWNkQ3dUOFo0?=
 =?utf-8?B?ZjRZUXVTS2V1NzZIbTdBdXpNaUZIMW50VjR0MUdoRksyZXo5bUg4QlN4c3Fa?=
 =?utf-8?B?R2gxVzlGNEN4ZXJWVGF3b1ErM1k0TzZNME5JNzcxVit5KzhGL3RKM24wQjd2?=
 =?utf-8?B?SkF1ZDkzTGJuOXdOZ254MndLU3BxeVU4bllNdkl3S25FYWpqeG45YWRPNi93?=
 =?utf-8?B?RFN0OE5IZVl3TENWdUpZZEZGVkdsVnozS3pSdGp0VWk3Q2JBbzJrYloyWG1i?=
 =?utf-8?Q?DKEjD9EqV3QF3yvMikb0JubkcOHwlTF9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzN5YWl4cnUvNnJLMGJMdS80YVNjNFk4NXZlMFFzSGtCM2FGeTZYRUR6NFE2?=
 =?utf-8?B?SmY4WmVOMWZuV1NvSU9UZHJUL2duOEVmVHY1a21DU1BNc01XM1pIblF0UVNF?=
 =?utf-8?B?RkNlcVFxZy9rNkk2azAvNzhXaHM0azZzeWx2WEdyU1M0WktJNVQ5dVBmREYr?=
 =?utf-8?B?VUFoTDc3Qy96MmFIcTB6Y3FQWkwyd3pBSkYxSGIyazRiSmRSb200M0VWUDZV?=
 =?utf-8?B?aEpVNnFMNHF0T09XMGpQYksxSkp0WExITXRSemR5dG9kbHFYUXRHM1diOHVq?=
 =?utf-8?B?c2lHSC9iUzhMeGlOZXJ3WW0zYlJMbU8yL1ZmaDB6cW04QXdDMG1JYWVTTWV3?=
 =?utf-8?B?NmhCSFRqNVVleTZZZlo0dmsrZ05VNFFRNzZWL3JmUFRUZ2lEUmFtdFJLTjRq?=
 =?utf-8?B?bkZLUCtPdU5JelR2U08rOUswTjA1Vko1Y3cycTA4anJtbGFZQVJBa1hIa0FR?=
 =?utf-8?B?SklobE52ZWViWFgzSFJZbWJBR2UyUEMvYUdyVzdxR3hvQ0U4RFJueUxoRlFU?=
 =?utf-8?B?RFNZbVMveDVWbmVqbFdEaDBLQ0N6YjdINUl5eWRweHJYUFIzYkIzY2k2UmQ4?=
 =?utf-8?B?YU9WbUpIUFJONXkxWStpNk9UN0E0VDYxS0U1WU9sYlZKV2ZmZXlQSjFUY05n?=
 =?utf-8?B?ZDNiOUhlT0FzS1ZWYVlWV0JiWnpXaEZoNVBHOFNhMUJ3VU1IYTlyVTFtKzFF?=
 =?utf-8?B?S0s1SHRNTUNEWi9PcUI0ZVpHOGRhbXhpSkJMSElxd2JKOGhlTmJBbTFOR3dz?=
 =?utf-8?B?Z3lCSGE0N25RNnhDcmlUOThPbFJ5V0VYVzh3Zmh2M1lwdUkvamJKc0p3ZnJ6?=
 =?utf-8?B?NnY3elI2aGtMSkJDVVFESC93VmZnbHFzS3ZyU3laZ09PSHVKQjc3cHRkbThX?=
 =?utf-8?B?SlZhNGtrTlFlaEkrUGZGcWZRTzNkRGdXQ0t6L2U3ZWVSZlZLV0tiWXlyMEFs?=
 =?utf-8?B?L1gvKzY2b2pSdWxyRmpneEk0Tm5ONUdCREJjek11bFVMU2xxUURyK1RXZGx4?=
 =?utf-8?B?SmNha0o2NFlHdkRBTFpwZ0hYTWpTbDNnRktLb01VN2ZoSzRsbjFtcFR4bU5i?=
 =?utf-8?B?MzVTN0FzZm1BWGdmUlFLNHdVd1hJOWdqQTd0R09UblZZN2xQalZKR2ROaGt0?=
 =?utf-8?B?S25GYUxZQUduTDZmeENseWhuY1NCYld0d2RLd25paUVJOFk1bUpYdWRnV0E5?=
 =?utf-8?B?dmpqWjByUDEySkVSUW85K1REdkU2NFM5SWllc3AwZTByRSsrSVl6NXZGSEg4?=
 =?utf-8?B?NzVQTkhZYjEzaFRySGRzWmFIQVhpUDVmT1Q2bjRIZUhPc1R0VlRXbFB6NjBK?=
 =?utf-8?B?THEzdWV1WXArNDNsTkd4QTQyaU9Kam1KeitkaHJrVkFjSllLQitvekV0MUN3?=
 =?utf-8?B?RnFBZEZCWllMQStBY2xlQ0RHNjRKRFk0SFFXTkNTUVVzNi9pcGxQUk9LRXpr?=
 =?utf-8?B?bjVEeGJycFVZUlErNVhjVXcrOXdmQVBQNEJXVmlNY004NklSRnp1SmN2Qks4?=
 =?utf-8?B?bkF6NXI2eUtaK1VTTDlvOEV2UUxzM3h4a3dVbVpCYy9hRkRxQThYRkhVUXZh?=
 =?utf-8?B?MUEvOUgwRGpPY3pEMllibTdpVHBsMWxyTGVkbzVVZzhRM2g5TWdxS3o3Z0FL?=
 =?utf-8?B?V1BSdmJBa2tHL21BaGhDY0xkMjBEUkFxU1dyVlpqeVl2QVhlMG9WMGhzYmlK?=
 =?utf-8?B?RmE1NS9hdndHVHlGY0dqYldKRWRURjBneE1kRU5lVlNLN3dPYnlRMyt5L0dS?=
 =?utf-8?B?ZHlVSUIwdmV0aDJzR29IQ2dvYTBtMFVUWnhjRnY5MnZKTThZWTlMS3IyT3p4?=
 =?utf-8?B?UVJYZTRDN0tGUXgyQWN0bG1QYkRxYzF6WUhrRThVQXdUQWoxYVJsaFNiSnpY?=
 =?utf-8?B?eExBREthMndXd0t6MXU4YW9kTVVTVnhCd1dmU2xPbVg4Q042eldFTGdabEJh?=
 =?utf-8?B?cEgrRXNzRkJ3VVdrZkRYQUZxKzFyNTlNZ0J3aE13aStLblhTLzRFQWZEZkxi?=
 =?utf-8?B?WjZ0eE4zSjkrU1Y2bzRBbzFnQ2t3ZTNCaUUrL01pbHBuLzkxbytJazRIY3FQ?=
 =?utf-8?B?eFA0M2xFcDZ0b0hFczZva0RIREV1Mk1QWXN0eERwdUJ6Z0l5NmpJT3F2ZXV1?=
 =?utf-8?Q?DG0Qt2LA4RjZtuDHIfXH2OKNo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 399008aa-4dc7-4c47-799a-08ddc0199a74
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 01:23:55.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+rTf0DkQEsDI/pWo2BuTUCsMm6zI7X60xRQO1C2cRcaahI0lKPgT7RmLt5LeaEPYcsP9fe3kiCOtYspTKYRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8992
X-OriginatorOrg: intel.com

On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:
> LASS throws a #GP for any violations except for stack register accesses,
> in which case it throws a #SS instead. Handle this similarly to how other
> LASS violations are handled.
> 
> In case of FRED, before handling #SS as LASS violation, kernel has to
> check if there's a fixup for the exception. It can address #SS due to
> invalid user context on ERETU. See 5105e7687ad3 ("x86/fred: Fixup
> fault on ERETU by jumping to fred_entrypoint_user") for more details.
> 
> Co-developed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/traps.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

