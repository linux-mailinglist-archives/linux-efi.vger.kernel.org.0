Return-Path: <linux-efi+bounces-4478-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E51BB11683
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jul 2025 04:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501ED7BD0AF
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jul 2025 02:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DEB233148;
	Fri, 25 Jul 2025 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzZj0uJ1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231FD846F;
	Fri, 25 Jul 2025 02:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410973; cv=fail; b=K48JNiNQEbq1/lx5tIxk9R0RWLUgO5iPfS5zU1ZQ9ra9qB29Zz19Hr3CKLlQnrEgFv2bi/XHcQow6VgiA/DH4iruUHmk8rW1LixCXZsCaxneeASkDAuLjpL5uXujU+oNk3BoQT0k8BvmvGREv8d653bA4UYTnL1uaA0/7j2e0ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410973; c=relaxed/simple;
	bh=+W/hZJrU8kAN12wRFvGgtPEb/TxZeB893jwQ1ro9KrI=;
	h=Content-Type:Message-ID:Date:Subject:To:CC:References:From:
	 In-Reply-To:MIME-Version; b=Z1dNWotVXhPMn+86CH62966LRJuLSAcV+SDYPvUW5/L0OKowpog1+Xq1ipnj27rHbij6NOHO1LOOnYQ/L0MOSnbGKh15cO8OpOsTIl7QaqgQmIojAmZVBfQE+wXaUjyV0B7wZy4yb+BY1/McSZoWjHUN/dc2hWYtiTiDtxnMXog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzZj0uJ1; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753410972; x=1784946972;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=+W/hZJrU8kAN12wRFvGgtPEb/TxZeB893jwQ1ro9KrI=;
  b=gzZj0uJ1lttJTkgyYuCT0XhlYIlqRUOKjiZ1YPRKe1lWSdEfwF75gU71
   Ex7H1AEfnhkijqaIi4U5RSkvlX3nuer5pAc0ZVpy52uU5WpXxT1TSjIJQ
   VwKu4qqubXKOi9xft8EePmIrnUfSrIn3gVQfQUI3k56L/9TLx+mebDN9u
   5dNvMrEuHkI86MnxGl53wKnqCXMGuFSDX+q+nM9gIZnPeHbJqaKT2Y8XA
   Odp6jVKZRzejArtS/qs4uAxqV4E/YKgjgPPyResmSwiO3/ehglp69/Xxv
   LQRCEp30CsXk0kUH/NVeyLaP/J2wFXNw84OYPWB2pcQFABVfS9ZGsmGxB
   Q==;
X-CSE-ConnectionGUID: pnG26PbNQvKVY1y4b2fAZw==
X-CSE-MsgGUID: fHxUCv2rR4+2j8a2nhlmcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59556525"
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208,223";a="59556525"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 19:36:09 -0700
X-CSE-ConnectionGUID: 3bg5ieBNTMyoSi0afM3/Qg==
X-CSE-MsgGUID: 5k/UuAchRc2xLhAbwJpz4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208,223";a="161330484"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 19:36:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 19:36:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 19:36:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 19:36:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEV1CbuefZzv+pTBzAkULb4Q9AvXWAM0j6RJrFRNhew7ho1x9f9pBxezLuUUnxLnI+77J/Fm01w3bxvgIYVoAa10iNF6N7ECoh6cKhowktOIYQsvlphjmagm+7oNUkVpnS3NxnKCx3Y/L0AXqCYpqV517Zptj5cTf7kWR1QreYrhRf2cDVby0CkFdBv+41hOb2VOA+44E6Kcad71N57uX3U0EDr3a0pdC1PJLJlnQDerEvNA3mbkLk5Kcx/PCHAQj9sjJk1o3wjPvM1+J2hi87VEjuzCZ1zN5bRXTdWZIwWE8IbJAUPEE0pNVGa/aZEbKslavjLo/+l26PO9Kjv+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3hAQNFxKNYHrybuoJioi9AuMxKIZ+FP0FjTLh5F17Q=;
 b=BTAW+MIGQViyga8lYBh6RTmtS4rZOjDcedrU9Qps1ZLeMyXXaq9FpRoy0LUQZoT0eFG9VMj2dXKNUvYZMTi5p553yHLOLrqyd+PDjK5MzMiuJ+BAdxyyv0Dzr2cCf3d3CD7yRBitD0K9NjcIx9gKmAYaSlxp1IYGeoy40jRd8JcqXEpu4LS6rm5+n0k1FrrAvuQuuXKBMNur1ORC3ob3HfQy1KI1Nkp13zpWMy4gW0OMfTCjyv/y+8R9rl+pksCnFqA9nmyrhsiliGLPIUvXS0y3Kx+iAJ7m75zwRhb6d6WpDXTJq0sifNSVrjeZJuc17ns88O8ue2BJVKX17u4D5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB6954.namprd11.prod.outlook.com (2603:10b6:510:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 02:35:58 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 02:35:58 +0000
Content-Type: multipart/mixed;
	boundary="------------18s1F8WcBzGsUkBbG3AiQZxl"
Message-ID: <e2765d39-5f44-4c60-b37f-c252c8a98f3d@intel.com>
Date: Thu, 24 Jul 2025 19:35:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 02/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
	<peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Xiongwei Song
	<xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, Michael Roth
	<michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy
	<aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>
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
	<linux-efi@vger.kernel.org>, <linux-mm@kvack.org>, "Kirill A. Shutemov"
	<kas@kernel.org>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-3-kirill.shutemov@linux.intel.com>
 <7d93b343-b275-4edb-ae26-4578ae53652f@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <7d93b343-b275-4edb-ae26-4578ae53652f@intel.com>
X-ClientProxiedBy: BYAPR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::45) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bf2eb8-aabd-41f4-0515-08ddcb23fcbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmRpWjJSMERGTHlad082VkhFVytFSEQ5UCt0QlpSTGVTUDJubDhJaVlFbEM0?=
 =?utf-8?B?K2kyNkk1MUhob3FwQkFYM2k0a0hTZ2FGM1NaR1pKK1UyRGJibVZUM1lUeE9W?=
 =?utf-8?B?cWdsMzcvcUQ5UzF5TTErb0xZdXBzR1FEdGljZS9ua0VXcE9wTXRRVm9rMkRN?=
 =?utf-8?B?WmtaYTR3bkJWZHNTcW1Dd045YUhJa3BwUEVwT3ZHeEI5cTU5SmlubFcrZHVU?=
 =?utf-8?B?bElPQjIyOEhBbXgxa1BJcUdIR2NvVjBiTmdNZldheFlRZWgraW9wdk1lMGd0?=
 =?utf-8?B?dE1JSkRFRnUyVUdYUzVpYzljUktYTStqdUlGUEQrNlJQTmcrcUNCZ1ZSaVdt?=
 =?utf-8?B?RmRiZWRUNDdQaUFFcFB3Nk5qcUVUVGoyeks5UEVTdVJ6ZkdlM2RHWmIyME9W?=
 =?utf-8?B?UW5yK2F6a0toSXJ5emZaYzNPR3lQU29RWE9DNXhBeU9xQ05GM0gzY0dYY3Nk?=
 =?utf-8?B?NnREdkdJTFhuOGhwazRUOWxmaFJDRXFxZnRUa0UrQmNYdXBaUXEyc1J5QTQ2?=
 =?utf-8?B?NDZETzF0b05JRzJmekJPVU9xd0d2K2NzTmZmS2RzNHJobGpzOXRSRGMzcitE?=
 =?utf-8?B?TzJaL1pVbTlHOGt3aWNyWGR3WmlxTjI3R0dtUG8ySGhMWThGOG41WUt1enVa?=
 =?utf-8?B?L3BzaHhHZmdhYU1OZWxBQVYzaWZQU0ZuZHc2Z0xzakVxY2ZFTlN6OXI1TUFZ?=
 =?utf-8?B?NHRIN3g3YWprd2xZQitGMjRZME00NWJIVXliR2orS3hlTHFoSjJ0V1VOejNo?=
 =?utf-8?B?cDFoNXlyUzd3YnAxY2F0TTFJanoyOXdINDNHVzFTdDl1WnhWbmcwWDE2WlBy?=
 =?utf-8?B?VFQ0dmtBU3ZVRjI2RnFkNGNxNjJoRGlNZXc2TFduakFzdE54NTNySm0rWnNk?=
 =?utf-8?B?YU1nT09iNXEzc1E3QjU4QlFYZi9iNldhSTNadWlubUVML1pMOXJVT0wvVTAv?=
 =?utf-8?B?ckllNG5lMEF1UXorQjNRTEJrL2M5T1RWRk00a1lrVC9jNzFIdXhIUlRrSmNt?=
 =?utf-8?B?Y3R4VW8yT2g3TWZHU3FZYkdManNodTk2eTZFbEIyb0gxQkI0S1lVTTBsR2x6?=
 =?utf-8?B?NThjNHM2T3g1eDJoeWZBemhRNnhJNHAyOWRDRkh3NExUZFY4ZlJZWkF3KzEw?=
 =?utf-8?B?dTY3WGtDT2w1Zks1STk4VmdmYWFMa3dOYTViMEFHSGFhL1ZldDhvM3ZtbS83?=
 =?utf-8?B?cGtZSGtWTkRKemRaVGJMYmxVVHhEdFpWWlVrSlp0L0t6cTJSY2xtVEczYzgr?=
 =?utf-8?B?Z3BaempraVFGbzhkalBCbnBGUmU1ZlZSOGxnelJCeTZ1VjdhRWN3Vk0vRGxP?=
 =?utf-8?B?TU1OVnlRTWhud1NFUlhwOWRqdEpwNWtlWUdWQVpxTWxaUGRuU0pFSmNpYlJ0?=
 =?utf-8?B?ZVpTUEJvM0pvakI4azhDVlhKdVlHU0ovMEZvZTlON1Ivbmd6T1VSZUNBQ0lh?=
 =?utf-8?B?blF3UkVBcWp4WkZSN21IYTAvUHdiSXVOcEpCZnhNaEtXcHJqSHYyOTlrcFpz?=
 =?utf-8?B?RFljQ0JKZnVBTFBEdkZvZ2dJa1dXTFhibmpET2tpdS9ITFYzUXdBb0VBTmpC?=
 =?utf-8?B?bnRXM3FvRUFlMy8rb0V2TFRnOUwwekJIL2RhSEZ2NWo5aWMrOW1TdzVlbEhF?=
 =?utf-8?B?WGcydWd2S3BmZmpIMnhmTVh4dHVMUUx3anZpQWRFOE5kNWhDMkFzWFI2L1gz?=
 =?utf-8?B?K1E3S1RUYWU0RDd2OXAzd1hDc0hiSEdSWWdtT3Z6NlRZdnZ0K29BcVk3YnV5?=
 =?utf-8?B?SVFUdmw1SExXNjM1TU82VGxLVTJtUjJQb2NkM3hvRnFXdHRLVzVsNUQ5MUdL?=
 =?utf-8?B?OEtOM0poTDdyWjRYZVJEbXI5dlJYNUdkYmh0T0pxMjJnemRoVVdVcDdiektj?=
 =?utf-8?B?SUFTNlY3VSt0UmZjVWFuMVUxR0RpaDhYSHdReE9GeUFKWXhrczJzYnZNT0F6?=
 =?utf-8?B?djV4RWNuOTBrVE5MSHRxazJ1TnZGVHJsUWZDeFdQYUJEMjcweU40cWRmTVQx?=
 =?utf-8?B?ZVB0akkyMTlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlpHdXRZaHJ3RkpJUHJvcXJPbU12Mml6SXM4WXR5RVUyTUIyRS9hSmM5cGxS?=
 =?utf-8?B?UFlDSzg2OUJMSUZkK1UxTW1wV2ZOMWlKRlg4MUpUQVcra25lLzBDRndzSHJp?=
 =?utf-8?B?a21HNnBqbm1qaFNaYzN6K1V4ak5IeDFMaG9LcUJ5OGNnL2ZGNG1Ya0V2amo2?=
 =?utf-8?B?QXA0Z0hoZVdwcm5Iak9DbVlBSm54QmE3eDU0OGRWVXhsVExLZ0MydHF0TXF3?=
 =?utf-8?B?OGp2RWJMUnpYbkF2TmNxdHlnVzYxSmVUandEV1RBbytUK1FXQnZxL1RueGJm?=
 =?utf-8?B?OWJJTk1XeXh2OTIxWEFKRitRenJqYzgwRDdaL0pCT2YrTUxFbVlQMnlOMm1r?=
 =?utf-8?B?a2Z2Q1FZZTl6NUhGcDB4YUo3b0NVTDZFbCtHN1BKR280eCtqM0NEUnVubkxM?=
 =?utf-8?B?d216bW83Um41ZVlPRUVlNHhRTFpNeFJ2dWNCbitrc09IcUJwb3VSdzhVYy9J?=
 =?utf-8?B?aU92YUhuK0V5NjREaE5wRjZ1eUVrVnV4N3lNVTJCYy90aWh0aEZSd1NSQTF1?=
 =?utf-8?B?Qm8yeDRDOXFLaVp0ZG9ZZzhOaVRCKzBkYmhVMW8yR3FvYlpWYW1VRFhXWW01?=
 =?utf-8?B?em1POU9IalFwQmJlaDVLYVNLY2Z1ZjRtRlE0L0ZSV2tUWGNJTENicFJkMmYz?=
 =?utf-8?B?VXc4M3lGeG5rY0VLS1FtaDF3SGdYS3kwSU45UFVNVis5d3VNYXZ2NkQ0SVJj?=
 =?utf-8?B?UzhiQnlMS0ZSaUdJWE92YkUreTFYL3pPNjNhYXp0VUNzcnZMQ0tjWFFEbjE1?=
 =?utf-8?B?WmhwdWZPVldiTktJUVJwRFMrZ1Q3WHFKWWFnMkZwRnRocU5ETE0xeWtwS1dR?=
 =?utf-8?B?am40ZGY2UmtSZmR3TnZwcFhiYkV2Q3hJYkE4ZzFlL3o0RjVPakRxMFJYZHZh?=
 =?utf-8?B?SmR4MWRjK2J2cENCb0U3ZGhDK0t0dHl3clZWVEdTemhMRW54UDZHbVBFU2JE?=
 =?utf-8?B?OFBOZ09PUzRHVnpZZGZ1YXdMTEFnQSsvSUFoUm5kQkE3NU5WRHVKYWlGWEkx?=
 =?utf-8?B?RmdLYUltRG9lRXFzNGJnNmZPMDdLQ2Q1YVUrMUZoWXdjWWg2T1A1clpaNkhM?=
 =?utf-8?B?QjI2a0d5RDNDYkx0RkxPdVRaTWRBQ3ZJV3pUUE9GUXBtSHVDM0h0OWRqM0Jv?=
 =?utf-8?B?QVRrWEl3RTl6cTBrazRuak0rOVNFSXdYNHE3c0IzK2FndFNiUFBsTjA1S2ZH?=
 =?utf-8?B?Wm9GcmM5V0h6K1lmWHdGT3k2UDEvUHNoTjJGMXNHUUI4VGQvcFd0U1cyY3pi?=
 =?utf-8?B?eGduY1dQbjJlWkdwQ3BJQTQ2K1Q3SysvUHAyZW44UW40RWtJdzlKL2p2dFhI?=
 =?utf-8?B?dFh0Q0R0NGFnOGh4UG1WWS8wTXZNeEhjU3k3TWFVazJCbHdIcmdQRVBWQkMv?=
 =?utf-8?B?VkI4czFuSDBhUEVvL1h4VWtNa0Q3TXZYam5jMWZ3RnZ4bTJ5NHZKYlNOd2Js?=
 =?utf-8?B?dTE0ekVhUWJMSTREaUlndmZxRk9KOEtLbGJyUFBUanNXejlUa0dWZlNKOVFa?=
 =?utf-8?B?b1V6YWhkYnFTQW5mTGZZMTBrRHljZXFtOGZnSnFIOGd6VTVSdytPT1Iwd2tV?=
 =?utf-8?B?VHl4Zmc0OHBwYzk0L0hSRlduNEdQQk5Gc2d3dktodEVPbWZHaHAvdkhJd2k4?=
 =?utf-8?B?NWpYcndhUzVuUnUxdmswWXpjWHV6NGVsY1RMQ0ZQRFZseXRIY2dtNSs4V2NF?=
 =?utf-8?B?N0o4N1BXVXRnd1czNFJJbVlFZ3BZWkc1enJLdWwrUlRIbmMzL1FCY3JoTStC?=
 =?utf-8?B?VmhsTWlOeDN2NkhScW4wWm5QTjFNMjczQ1M1dnh2MXFMSjZrc3pRMFB2Mmd0?=
 =?utf-8?B?SVh4MkpkcjBqOVNISG95SDFyVC8zbXFCR2JHWTA5dklkQ1FwOFJiSktEYjBt?=
 =?utf-8?B?WXpmVlJOSVkvdGptb0c1dDJKOWdpVU1GSTBidm1NdG9KdHYrMzZnd0pkM1ZH?=
 =?utf-8?B?dDJmVkhJQ3NvTmsvS0JnSlU5SmpXbmdlUUJseXVLT05aRWZ3a2ZZS0kwSWtj?=
 =?utf-8?B?SXBndm9HL1BrM1dxR2wxNmF4dzlmcDM5Sm1vUW5ZUndWb2dwRGFOTjdnVjFp?=
 =?utf-8?B?alpSQ3pyYmJIa09jQmxsWFNrK0M4YjM1ZkZPdjJTNG95QzkzMUZMZkhESnFJ?=
 =?utf-8?Q?+l7WBErHJc7xpLJxV1N8xnKwJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bf2eb8-aabd-41f4-0515-08ddcb23fcbf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:35:58.3095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R56w9EwWmdzaExnThTYT7M4FZFVpLf6TECZL+w9gEvPj/pcHyWFoeoNsU4om2B7s7jXju84q3mtwVjVl+DhvBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6954
X-OriginatorOrg: intel.com

--------------18s1F8WcBzGsUkBbG3AiQZxl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 7/9/2025 9:58 AM, Dave Hansen wrote:

>> +	 * Avoid using memcpy() here. Instead, open code it.
>> +	 */
>> +	asm volatile("rep movsb"
>> +		     : "+D" (dst), "+S" (src), "+c" (len) : : "memory");
>> +
>> +	lass_clac();
>>  }
> 
> This didn't turn out great. At the _very_ least, we could have a:
> 
> 	inline_memcpy_i_really_mean_it()
> 

It looks like we should go back to __inline_memcpy()/_memset()
implementation that PeterZ had initially proposed. It seems to fit all
the requirements, right? Patch attached.

https://lore.kernel.org/lkml/20241028160917.1380714-3-alexander.shishkin@linux.intel.com/

> with the rep mov. Or even a #define if we were super paranoid the
> compiler is out to get us.
> 
> But _actually_ open-coding inline assembly is far too ugly to live.
> 
--------------18s1F8WcBzGsUkBbG3AiQZxl
Content-Type: text/plain; charset="UTF-8";
	name="x86-asm-Introduce-inline-memcpy-and-memset.patch"
Content-Disposition: attachment;
	filename="x86-asm-Introduce-inline-memcpy-and-memset.patch"
Content-Transfer-Encoding: base64

RnJvbSBlYjNiNDViMzc3ZGY5MGQzYjM2N2UyYjNmZGRmZmYxYTcyNjI0YTRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
CkRhdGU6IE1vbiwgMjggT2N0IDIwMjQgMTg6MDc6NTAgKzAyMDAKU3ViamVjdDogW1BBVENIXSB4
ODYvYXNtOiBJbnRyb2R1Y2UgaW5saW5lIG1lbWNweSBhbmQgbWVtc2V0CgpQcm92aWRlIGlubGlu
ZSBtZW1jcHkgYW5kIG1lbXNldCBmdW5jdGlvbnMgdGhhdCBjYW4gYmUgdXNlZCBpbnN0ZWFkIG9m
CnRoZSBHQ0MgYnVpbHRpbnMgd2hlbmV2ZXIgbmVjZXNzYXJ5LgoKU2lnbmVkLW9mZi1ieTogUGV0
ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+ClNpZ25lZC1vZmYtYnk6
IFNvaGlsIE1laHRhIDxzb2hpbC5tZWh0YUBpbnRlbC5jb20+Ci0tLQogYXJjaC94ODYvaW5jbHVk
ZS9hc20vc3RyaW5nLmggfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDI2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9zdHJpbmcuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3N0cmluZy5oCmluZGV4IGMzYzJjMTkx
NGQ2NS4uOWNiNWFhZTdmYmE5IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zdHJp
bmcuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zdHJpbmcuaApAQCAtMSw2ICsxLDMyIEBA
CiAvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLworI2lmbmRlZiBfQVNNX1g4
Nl9TVFJJTkdfSAorI2RlZmluZSBfQVNNX1g4Nl9TVFJJTkdfSAorCiAjaWZkZWYgQ09ORklHX1g4
Nl8zMgogIyBpbmNsdWRlIDxhc20vc3RyaW5nXzMyLmg+CiAjZWxzZQogIyBpbmNsdWRlIDxhc20v
c3RyaW5nXzY0Lmg+CiAjZW5kaWYKKworc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkICpfX2lu
bGluZV9tZW1jcHkodm9pZCAqdG8sIGNvbnN0IHZvaWQgKmZyb20sIHNpemVfdCBsZW4pCit7CisJ
dm9pZCAqcmV0ID0gdG87CisKKwlhc20gdm9sYXRpbGUoInJlcCBtb3ZzYiIKKwkJICAgICA6ICIr
RCIgKHRvKSwgIitTIiAoZnJvbSksICIrYyIgKGxlbikKKwkJICAgICA6IDogIm1lbW9yeSIpOwor
CXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCAqX19pbmxpbmVf
bWVtc2V0KHZvaWQgKnMsIGludCB2LCBzaXplX3QgbikKK3sKKwl2b2lkICpyZXQgPSBzOworCisJ
YXNtIHZvbGF0aWxlKCJyZXAgc3Rvc2IiCisJCSAgICAgOiAiK0QiIChzKSwgIitjIiAobikKKwkJ
ICAgICA6ICJhIiAoKHVpbnQ4X3QpdikKKwkJICAgICA6ICJtZW1vcnkiKTsKKwlyZXR1cm4gcmV0
OworfQorCisjZW5kaWYgLyogX0FTTV9YODZfU1RSSU5HX0ggKi8KLS0gCjIuNDMuMAoK

--------------18s1F8WcBzGsUkBbG3AiQZxl--

