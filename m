Return-Path: <linux-efi+bounces-4090-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D30AF6092
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 19:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8BF1C46293
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AB6309DD2;
	Wed,  2 Jul 2025 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVLD4RRy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403E309DD8;
	Wed,  2 Jul 2025 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479012; cv=fail; b=UOH92hacrmN0BSi1rNJmgqO4FIZGQ/RZ5VnGC5daQ5rUQVoA8KnXmhZ80c/ygO3C1+vDDRLvAk/HN1HEpwSwVcF0867h2HQxeGyPfFvjvfo0o9GDR3hG7vD7Nvv3uQybMgNMtGcg0ZKeodweM+qLKnLnl+hiFWvkTT0O6rta3Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479012; c=relaxed/simple;
	bh=FioAZcaCf8NOieoMqlL/P4ejWQVe+XZMZ9b4K+/+MtE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LSVPx0aVRw/VH+uf1DLBoHrRVHKaI9fLpyaGnCZndyaOB2+kPFuN2U2y/EjvzOAkze70QgQka1MRABfw8g4S9UHfD7B8vcgA1UIdHhuQ/CkmCEOrmUnygAqPzMlmLIyNfic3v6Sa7q9mI8WfMcWKR6A4hNzh0/071rUozzrKXE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVLD4RRy; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751479011; x=1783015011;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FioAZcaCf8NOieoMqlL/P4ejWQVe+XZMZ9b4K+/+MtE=;
  b=JVLD4RRyPCewGaD8Og9lf64LNRglnLu+CvPy+EVPmcE0MS78Km4A939X
   aCwUxEf6B4TqOgAsEg2c1QAnQ8BLRghqAvCOzceF2lsVcF3nqhbHhDwMl
   xbZ2krrMlfpYuJfbcHsLlc9Pd4FYxrXplQECI3s8oE3hTA5u3yz8C18Nq
   4d/QU3FbpfsBF2RXCar2Bis5eurFebrNl5IceLiNFh3yMUFqxu0by3b1/
   gNdk1gc3hudyHdpGZgo8tMKumKspL/TwM/3eBDcJuyTMf6cccTRujca+B
   u52t+ggpmut72Ahc0XFtFqumUNJsqVN8f2uKu8ErDyELLW9rEYOux01VR
   Q==;
X-CSE-ConnectionGUID: fwT/t+hPTrWaKS4ByZvMMg==
X-CSE-MsgGUID: FtbtdKAITvOZTFaAe+Elxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53653477"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="53653477"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 10:56:50 -0700
X-CSE-ConnectionGUID: steufwDLTrWQW0Mvcqb4Eg==
X-CSE-MsgGUID: 23cJzDXNTbuWgnNUpD+r2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="154224078"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 10:56:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 10:56:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 10:56:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.76) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 10:56:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7HVL5YDSpc1yoj2K7wa5OPF/fweKpjD3RuNbin6pzssF4dquq6Sq4lYG9FFE1X6qsopGMh3uXNDfXIy611GRlwJSf+VnJk5Az2pqArGU26QMgb9wp1i/bjciBWU0mJjNko3iyoTPKboUSeEtbBBjvr+VtwegWxtaTYSHtHHMiGJw7EuMB9XyKaHO020RxW0Pr3lcmU8qS11/G32JhpBcF6xr4vJcNytC8yi1HADII8z3/yX9TG66rNJ/W3BAr2WNhW5ieVM7MqE43DOlTEMm4xp+TQR/fVFOnnzWcLJ2leQld60V7mcfomHlazIrDlkZeY2I5jyS2oSKpIFtkHlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVu4qViwjgdk04sm+FBKjg4H2KqT7XiQ8AGT3+vxfTQ=;
 b=tH4b7bn9I9uYtlwrQMD70dPxUTWvWk1UG9NcK/3FuCcRgT65wHfm2Ry4g0Nn7gqqdGVRWNu40kPU4gpso6ffym6BizBzLPcfL9MS/JCR/Rps2b4IRjCmF1ewRU8/QddPpHfpvoJxFLuNtcsWnHcK+G8Ylz0wxFY1GBdoTZbQIOEmyxcL0xPIEIaltGCLgVSWuUcsyHbcYuL8XDM4HTojx91mdS9x7ZOWbGj2nvgbQEWRKfHULUC17fds4pr2OsbhFdX1HmtAAHzPoT8y/N0G0wxYiiFG5bVoQnEBJepJk/AV/wZc0hOYsliYJjb9D90fyVeVUkXSWh/4OSvs89ijjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3315.namprd11.prod.outlook.com (2603:10b6:208:6c::33)
 by BL4PR11MB8845.namprd11.prod.outlook.com (2603:10b6:208:5aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 17:56:30 +0000
Received: from BL0PR11MB3315.namprd11.prod.outlook.com
 ([fe80::9c18:1e19:b200:3848]) by BL0PR11MB3315.namprd11.prod.outlook.com
 ([fe80::9c18:1e19:b200:3848%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 17:56:30 +0000
Message-ID: <19868e42-5f00-4127-a48c-ed48c0297a87@intel.com>
Date: Wed, 2 Jul 2025 10:56:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
	<xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, "Ingo
 Molnar" <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang
	<kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>, Breno Leitao
	<leitao@debian.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross
	<jgross@suse.com>, Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook
	<kees@kernel.org>, Eric Biggers <ebiggers@google.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
	Changbin Du <changbin.du@huawei.com>, Huang Shijie
	<shijie@os.amperecomputing.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Namhyung Kim <namhyung@kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
 <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
 <mgo3qfjekobe6qflwkpey3p7tzsp3b2mrirama4w2rxyckce7g@3gce3fn5emvu>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <mgo3qfjekobe6qflwkpey3p7tzsp3b2mrirama4w2rxyckce7g@3gce3fn5emvu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To BL0PR11MB3315.namprd11.prod.outlook.com
 (2603:10b6:208:6c::33)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3315:EE_|BL4PR11MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: f834f5c0-d1c9-4ec7-e0af-08ddb991c5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVE0czJidEVOVDRtd2dnUzQvcEJhOG1XMldHOC9HdnJXeURWYVA2cG9kbXRV?=
 =?utf-8?B?c0dTeUtkbWFldmNpSllENnlTU09vT1VTZ1VVb3N0L1RKSnFidVZvMjhkdkpV?=
 =?utf-8?B?YTE5U2hLU01mZUFZSy9xOTl1TDU3NDgrOGs3UmhMdThWTVBQTGFDZ291VHdN?=
 =?utf-8?B?VVNpMGZhMnNObTlNME5NVHVwOGVMUWxreW1JN2o2VHppRnVDQjNhZ2RJNnVk?=
 =?utf-8?B?Yks4Q3p1b1RSM1d4VDU1c2sza0twRTZFSkN5aUFyaC9wUGpZZTBldVFUUU5a?=
 =?utf-8?B?aW9jb2puMVJIUjZFSm16ZUxMa2Y5aWFvUkU5OWdNUW0xTEYybnltcWIvaSt3?=
 =?utf-8?B?cGN2b2xjOUMvSEhOcUFTUFYrWWlPc0szOWZXNHAxNmVUV0xSVkVFY1NFSExG?=
 =?utf-8?B?SHRPOUp6dHJlTXdiVjczNTNyWUhpSExrM2xVanlaRTk5d294aHo2dUcwcHpI?=
 =?utf-8?B?UEoxT0IzRVpZNk53akY4Nm0wd1c5QzJrejJiWXVsbjZpeTluZjhzaFl6K1JG?=
 =?utf-8?B?enpkbFl0dDlOeWtmTXR2TDZWZDg2MXEzWkF3OU1xUWxpajF4VzNSRHFZS1BX?=
 =?utf-8?B?TjY5dk1wQ3MvZUpTcGNXOTRHN1FjcElYMzU5TjFDTFljendtS0I3NWNIUUxp?=
 =?utf-8?B?OWJvY3ZNbFIrVzZ5eWxvZ3d0NXF1L1N2RU5zWURBQzJPajdIemROS1FnbUsx?=
 =?utf-8?B?UDBjRm5uMVZHSmxzMUNIdFhQUG91ZlYyOWFrRkpuSnh6NWtBVjgxOFFMdjU3?=
 =?utf-8?B?dHVjSUlneU1QbnBjUlFxMy9jRVhuUUd0ME9RL21GcGtiYlBDSDIrdFpJdm9l?=
 =?utf-8?B?N2lINDdacDkwcWwxMzV6Q2d4RFF4SVJmeGZxc2o5WEJMVmorekg0VEVJYVo5?=
 =?utf-8?B?WUlkbG1YRnJBemNhQU5lS2N4S1RDSkhzZEtpeDErei9scEJsMXkyUHM1amFy?=
 =?utf-8?B?cnd5bnBmSmI5MGIxRnBFUkUrQUdEa0JXNUFtNmwzZ1hPRVN3bkxVaG1NQjI2?=
 =?utf-8?B?L0dkcExZV013bmFFYkhaTG41STIxRHpNUnI0My9EaTVvL2JSQ3BzQlJaMWUw?=
 =?utf-8?B?Qk91WFhJd1dsODJmcVJwQXFUSEpndFY5NzNFdERWbWlYZnowNUZSZUpJZ0Fl?=
 =?utf-8?B?ejNsNHkwWmxyZzBvTm5uMHBxY2o1dk5VWlRmck5SZmdPa1Bzb2ZrMFFYV1Z2?=
 =?utf-8?B?c1Bkd1hJNVFTVnV1S3JwUGwxNUoyWUU0YTVSOXlpcVVyMFJHUUM0UkZDYVcv?=
 =?utf-8?B?eWdEcThDNnMveXdDclNxcmNJczZzYWM0U3VlUlQ0a2JsWG4xYzJQc09oaUdu?=
 =?utf-8?B?U2NxZExJTk1zRkZaN3hFTW1MSkZFTE9VbHcrRkFEZzJWdjQ0SWJWT0Rud2Qy?=
 =?utf-8?B?QU0zWG1FTzNEdGNuRVN3NmZiRkEvVTBTcE5xSTZaWmU5OFNTb1VCdzhNTStJ?=
 =?utf-8?B?SnJVVExWVkVjdGxnZGpXQVNiYTlCTjkrVExYRjUwQldyVmJiOHhpeVA3YVNs?=
 =?utf-8?B?Vmt0UDJXc2o3R3BycG9YUW5lM2pNdk0wYWpFMVVEQm9qUHdhR1o4NWdpeVJo?=
 =?utf-8?B?bmI4alArRk5icTZUZi9WdGJIWllUamhXLzlva2hhTE9oSkUxWjg4eXVra2d4?=
 =?utf-8?B?UE9qL2VUSzZYQmJYenZNRmkydFZOd3VLeXBITVlZNVd4YnNtMFdGSkFCc0lv?=
 =?utf-8?B?aVIyL1Y4NTVBZFR2SUxCVmtSd1lFS3Q0Uzh1bUxmczlmc3RwWk91citDMlA3?=
 =?utf-8?B?NDhIQUltM1JZNzhYWVdOTHcxaFJleDJUb1pDc3A4TVJCMGFGbzVmZ2ovUFFl?=
 =?utf-8?B?d0QxbC9JSWg1NGY0eEFoT2xheHN0LzdxU3NtdGpXWUpRRFBMcTh3UUtlaldr?=
 =?utf-8?B?YmZIV1RIM042MC9JQzZpaDZyQlBialo3Q0NtUCtpaHViTWs4ckdlOWZpSUYw?=
 =?utf-8?Q?3Pn7F8JrvR0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3315.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNwUnRiUTlVZDNUU3RYTkhJNXd3OVVFeWJQeUhkU2U3a3luekVuR2EwWm9K?=
 =?utf-8?B?MElXMGtNcHJhTFEvaENPOFVaRjc2L2xOblFPeXFZSUgyVUpldllLbmw1enp5?=
 =?utf-8?B?RXY2dmR5MnQ2NWV5amhUNDNSbWV5UDhxTzYvUVRXRUl1RmRseFQveGFqQlpD?=
 =?utf-8?B?Z0x6M0s5VStPcDM1TU5WK3dFaFd5VDVBZXRIUDVubTYrUjBFNS9leStDNGtm?=
 =?utf-8?B?QkJWR2ZYUlZzdytlZGxMaVVZYlRsNUV6MTFCTXZvSVNiRFlrWU05S2NPOHQz?=
 =?utf-8?B?cGp5eDY1bzBHMXJCU3M0VG04UGVDUWU4UWN0VGt2YmRwZGlpYjAxVE82UDR1?=
 =?utf-8?B?OVN6NkZXdzVaN0RrRU5yNWdFSDVOOGg4NnFob09sNHZzTXVaZHBjdWVla0Fm?=
 =?utf-8?B?dXZGWG9JVlVocmtFQVNvQU5taUU2TWJxbEZTc0RuRGE4RHVFdStDbE50VU9n?=
 =?utf-8?B?a0tIMHhhdHE2b0syQjgzVDdiSlA4c0M2OFRMMmdOM2dCR05GT3h5RXd0RURX?=
 =?utf-8?B?NXdyVEF3cGdPaFJtbGppOEJyaWRFR2FlZk1KanFqc2RMeXFaQjJhd1V2Y3lI?=
 =?utf-8?B?b05ZRjR0QkxwYnZZOEQ2SnRiMUszUElmODJ4MEZOUHFqNHNEQkZwNEo0K2dB?=
 =?utf-8?B?WHlJQUZmSGp6bFFDcnVzUDlGNXVkaFQwVFZ1L1NCWUZ0dFo4bjZ1UkJkVkNY?=
 =?utf-8?B?QTFwTWdINWk1YmdqWU1SQXJvbWQyc2J0aFN5aE1ZcU5sMnUzSkw2THYxN29I?=
 =?utf-8?B?bkRNbk9uZ1VDRG1OUzNuTXNmVVNXSjMrbUdZSWY3dzkxYXhYNUFqaStHTjZ5?=
 =?utf-8?B?MzZXUnpDWjJhQlludGZWcGtQTGxVTGdIVng2bWc3L3RiQ2t6NTk3b21vdzF6?=
 =?utf-8?B?c2p4bWtXU0hGbW9NL1oxMDJsR2pWZU5nU0g1d1BHbTJrbVc1MjE4cmlXcUhV?=
 =?utf-8?B?NkpxRnVOYTUwQURvZ3RJT0czcFY5Y1RlQlovV0ptNHBQRFlKT0VvQzUxMXRB?=
 =?utf-8?B?dlF6Z1dJdXpiSFovRVV2ODZQV05ibWR2cVhBdnFaa0hRa2plVUNadklYSmN0?=
 =?utf-8?B?Y1IzalRCbDA1QTJSREllU01mWEltSW5GVUZibU9mZkVRcUlkbFdwVTRkK01K?=
 =?utf-8?B?SWtuNk12L0dtbFRCeUJ6RHByVFNhcnUrYlRxSkxiYkt4TWVCdGF5Q25mWmEv?=
 =?utf-8?B?ajhxdXNYaEFzQlIzLysyVThJK3orb0QxdDZ1N0ZJN1lFdkFndkI0aTN1SGpT?=
 =?utf-8?B?RzZqVlUybEhpUXBlZ29BQ3RnTDczN0hMTE5oV0J1MkozbmVUSDc0UjVZQ1lz?=
 =?utf-8?B?a3YvZW5uUWZENm8vYllFOWJWaTc5a2tOZWd3ZHZ5M094R25veEdiTTU1ckQw?=
 =?utf-8?B?TWNSMFhXckdhLzZKNms5SDJvTDVteUVzOTVQV1RRMjJWTGZGVFVKT3h6Qi9n?=
 =?utf-8?B?RkJ3YnczWFBZdDYzK3BXc2RaQ0FPQUZxcTFmWGhHYWlSbVBINGVubHZJT1Zi?=
 =?utf-8?B?VEhqS0lReFk3ZXVNVDFvZCtOOTU4Zi9yNDl0TmRDUXhhUnFrREdxTStBOWEr?=
 =?utf-8?B?bW00NHdaaEU0Y3lMRyswTjIrMWlkMW9nUkVFc284VSt0Z2EvWmR6UnRnTytO?=
 =?utf-8?B?L0s5aVpOYVVmbkxGVnhJZ1RWbk8wZDdld043Rk91Uk00elJBYWZkYnFMNVhz?=
 =?utf-8?B?Z3FFQTFvRlV2QnV5WHdZbHdBTEVGNTdzTkhXQU9XZlF6TmdsdFQ3cTZtQTdX?=
 =?utf-8?B?MzJNZHQyYVo1dDRuUG9TemtGU3Y1TVBmd1FpWFBNTnlXeTdQaUtUNzQxQUsy?=
 =?utf-8?B?ZUFYcWJPWkVOS0ozbW5hUG12ejRUcEtxZHcwMGt1ZmxxMW13VldZR1dabzg5?=
 =?utf-8?B?TXJZcVB5NjRwa2l5dlYwdnRuTEVjMWdua3NuQ3JVTTZYRDcvUGswMkVjMC83?=
 =?utf-8?B?MlUwdGYvVlp5WHdkWS9FcFRvb3pYeUxCTHg5Qnl4R1VGdWZyMGNIdDY1ZjVj?=
 =?utf-8?B?VlQvQ0RQelhsbUNKREE0YnVhYk9kQTRGdVpiN3NLM3JtbGlMZy91ZDNKZE5p?=
 =?utf-8?B?aGN3c2k0eCtvOHdjWDJzdnQrR0E1am40OGlzUStXamMybnhoaFVvTXNBRDZa?=
 =?utf-8?Q?ToYCCPi4qUyM1PhnNa3n/t+zN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f834f5c0-d1c9-4ec7-e0af-08ddb991c5f7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3315.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:56:30.1090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2SrYp3dkmD5ZIFXC/iouGRkv4y6lCs7WRpYTFhwIQ2qQjo/H4/OzZboJA7vFVRnZdp+wcGPBvBD2ERdDCvjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8845
X-OriginatorOrg: intel.com

On 7/2/2025 6:27 AM, Kirill A. Shutemov wrote:
>>> +
>>> +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
>>> +		enum kernel_exc_hint hint;
>>> +		unsigned long exc_addr;
>>> +
>>> +		hint = get_kernel_exc_address(regs, &exc_addr);
>>> +		if (hint != EXC_NO_HINT) {
>>
>> The brackets are not needed for singular statements. Also the max line
>> length is longer now. You can fit this all in a single line.
> 
> I think line split if justified. It is 120 characters long otherwise.
> And with multi-line statement, brackets help readability.
> 

Are you sure? Below ends at 90 characters for me, including the three
8-char tabs:

printk(SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint], exc_addr);

> I don't see a reason to change it.

To reduce indentation, you could also do:

	if (!cpu_feature_enabled(X86_FEATURE_LASS))
		goto error_trap;

> 
>>> +			printk(SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint],
>>> +			       exc_addr);
>>> +		}
>>> +
>>



