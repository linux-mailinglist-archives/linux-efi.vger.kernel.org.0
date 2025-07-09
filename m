Return-Path: <linux-efi+bounces-4200-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E374AFDEEF
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 07:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C173B4112
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 05:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19D81CAA85;
	Wed,  9 Jul 2025 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzeunpcP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9C2AD22;
	Wed,  9 Jul 2025 05:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037249; cv=fail; b=TNSiSPr870ZiTtvutZY9PDiK9Fpo85LeaBEoyxFDf848z+ShFMYd5R9uIH+PnwDJcdHbl/jvOWnFstLDcvbq5kSog3rpxLiq2OpOEQSgSHsxPyyh14cdD8Ya13dG9C3EXtRyhzBdhHO5M8yr+18ihUeCxpGwV/DMDl4sZxksE5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037249; c=relaxed/simple;
	bh=alFFIiCAlcRwyIbUjPHM07/xYM2kezh1nZBQJynMTYk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uFiSTQ81Xe2COPPWJP+tvjSovf1OcU8DZnRVNaNcx5dNUpmbaUMNcIeuOnaxdDx2WI3pjyXjOgFR2beKpI56qeCmfepj6hu2O7pB/Qcx2S7hDbpbfOpLw80lwwjgRSmmmlGaJvyKIFoFkQlWmoWtc5rJ1XUlDB2X77+lF1IhkgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzeunpcP; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037248; x=1783573248;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=alFFIiCAlcRwyIbUjPHM07/xYM2kezh1nZBQJynMTYk=;
  b=gzeunpcPco5Q4XKia6F3uvyPUyKtnipSnSjfj5BRpufFGJmlBLxIPpKC
   KhY8EhcFvcdpUQ5wMO0hi8strA/1S8Xo0Up76mwAFz9otaCnz1J6xBkjB
   DnmEbyI5WqTqyY2zjdO+Ighg6QJbwMvvbuIvBwynEMTByKdpqqwDpReiB
   vlH2DVmTeYulRAhjBZBWha4Iiz90GoQqXm/1MLLaRqthXQxSt9/bjVMQc
   Y3JbR8UiddF7oUY9RDCsi/Gvqetu6ol5JlMDk2go8c20k6YIvQgyOmK0Q
   V4VEnWRNtnFLAKVNdEoHULTDPmBktf8QfyLKjIo4/MLA+A8V3RxBDOpU5
   w==;
X-CSE-ConnectionGUID: YxB92K63TxWSuNtNIw31Yg==
X-CSE-MsgGUID: u7M/fnY5TE67Z1w2DV++Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54416969"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54416969"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:00:18 -0700
X-CSE-ConnectionGUID: qeFJQsTpRFyk68BifQvw4g==
X-CSE-MsgGUID: ASOBniFoQP+O21nUV3oPDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161222257"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:00:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 22:00:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 22:00:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.44)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 22:00:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqffD/aEQHTAmTYPxnP7jMgHucjEmpXxK2XDIv6OLZ4amFGDYzarMgmETWRNS5eW2fnMzb+gikT8MLXaTC9XVanAcpmbqnOPLkcLVwHAU+erDPj3zhAcfIy5KWN+HsIQf8sGXuPh5FUzUDt6jVWBmWYqt+N+u1Xfq1QJmRdhjaI9+qx+UmCB8movolUmi83UxJXVKkDMsonNClwZ6JIs71Xx3NmZakSWdPvKbrT6TSrBP6nLuvoLAYmKMohK3sbUHS+venj4hQGGsgtlYQgYoGpmDfRgwMcOFr1iwytELTrEqlk9P4HDpCx//JncKONKgK+71apxKQ6cUd3SafG5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RT3cac2VUnL8bVytITQYYv4s0CeR2mnAQCxtMY83VUE=;
 b=YcX9qnAtyLwuGu19jYyWaOU0hei/DkseDEqe1MVIlYmDOm1kHVDBYIgi6FPq76+2PrwfuONswwiR6t0MQIn4ZX9qlEfvxwwnHIpp3kO8aPQ7t9VVfjZbPtwMLLwJIR80yNpzB0BfcpWZIyhta5DX9HmQX1465ilrpTKK76ujFNb4yDsZplmhrvUZQvsePD8cyOO8L/bgOk5W3ekf237lGH+vEzNi0EG9dh5VPiwyTiTqsurt003G1d0WXLivwETbBXZ01ZhgadTF+0WFq8L3gL3IRqoLPXVP9F5HGVeZ1kocw93uMyFb7PN8wKLi5rtB7mnHvtqeTCqtHzV+iLq8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB5231.namprd11.prod.outlook.com (2603:10b6:5:38a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 05:00:02 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 05:00:02 +0000
Message-ID: <28173e1d-274e-4c37-9f2a-e3845bfd4d7b@intel.com>
Date: Tue, 8 Jul 2025 21:59:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 12/16] x86/traps: Generalize #GP address decode and hint
 code
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
 <20250707080317.3791624-13-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250707080317.3791624-13-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0156.namprd05.prod.outlook.com
 (2603:10b6:a03:339::11) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: f6bbdac4-5d41-4f27-94e0-08ddbea5760f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ly83WEMyUk1GQ3lXazB4NnZXVGx1Y3g2VnlHL1pDblN1Ti94V3pVV05UdnhZ?=
 =?utf-8?B?MGF5czBYWGIvRGl0bUM0Yjh4U01NanVVbHhrWXhCMk5qSWZBcVo4Y1VJNVkx?=
 =?utf-8?B?T0c3c3IvZXhmZjVzL2dwSFdWOFMvZ1JDRWwyRVZ1cDI0TWttd0NDNE9xVE1D?=
 =?utf-8?B?dFpkREVGU1gxZVo2RmFkaXEwTy91Vmt2SWlxNHVsa0RyZ3hOWDZ5Q3Zicjdz?=
 =?utf-8?B?TkdyZmxFY1VqdmVNZnFmeGprRnF6RElhODJWTXBoNWtOcXZRZ0JtVlFIK09o?=
 =?utf-8?B?N29SUklBZUtwaEgzUSt2ZmdHZDNHVGVybzI3QmhoUHl6OGlVa09MUkJqTUFK?=
 =?utf-8?B?YWRJVEt1S0xYUngrZlkwYkdvZy8vZU92Y1RRYWZUWHA5YnF1WmlFanorSXZ5?=
 =?utf-8?B?QmJBNk1ZSFVUMEJjc3dhWWhHVlJJTERDQVNONmpOWis4THp4RHBuNjhGc3B4?=
 =?utf-8?B?MEVKWm5mN3g4SVZNSDBjZUxwRlV6K0xUYjRiK05aeUhIdGFxSmFCVUdTRmlp?=
 =?utf-8?B?SlJuTGpMd2tKUEhCVERRODd4NWt6TW1jc2lLSkdYRzY5bjBFT093NFhKeXZU?=
 =?utf-8?B?TVpuTnd5YVJUOHc1M3k1UFU0ZC9ISTNxcVd6cFJMZmRNUkFQTmt0WUZVV0Uw?=
 =?utf-8?B?cGttTmkzZWdKaE9pQUdVSEhXL2FWY3JqckJ4U2NSNVU1cmU3aXVxNDkvakpk?=
 =?utf-8?B?SVhjZmtWMDZkZm1FeEwwZHlRVG10Syt3Y1hycUhRZDBOUUhRK1QyNWluWThY?=
 =?utf-8?B?ZXVsZXR4ZFdlaDZWSkZHODFmMHMyWm9Zb08wZzJVQ1VKL0RXeTdpai82aldH?=
 =?utf-8?B?M0xLcitRTEJCa3dUWW9PdEk2c1gwQk9UKzNoMUZJcUhsbEh2SVJzRVlQS09W?=
 =?utf-8?B?RVdKMG5mRUpKc283M0pVclloRy9WdUhnMk9HZHFGQUs3a1hpdGViZzRvdDdv?=
 =?utf-8?B?YnFkNml6UHJFSVlETGI0ODVrSVRJTFRlSDM0WU01UEIyMHRoa3llSVRVamtj?=
 =?utf-8?B?NXBHRmVmTVU3Z1FKcytSVm4raEN0OWdnWWc4MXMyUHZQcU5MQU9MTFRkZEpE?=
 =?utf-8?B?dVJIbHRsb3o0dE5QZHRPUlhNL2hOYThhazJKT0FOS3VtLy9WcVZDQjgvZkha?=
 =?utf-8?B?ZHdmTUtHR2Qxam9SQVU2V1k3cGpRN1NoQjZ4ZnlPb2g0RmE1a2w1U3RUdDNX?=
 =?utf-8?B?VTlwdGVvKzhVTHZXazRzSVJxU0VVQXhrUlpVNGNsTzVHY2tPa2lteGlwNWJ3?=
 =?utf-8?B?YVlnWmdXcG84NWd4WDVRZUJZdUdIQkdxeXd5a2ZteXcyN0syNU1iWHIwd21K?=
 =?utf-8?B?d0h2QTNmUVBCV2Qyekxnb0Y1UTQ5dmxKWFhRQUo5eDNGMC9UanpxVUFiU1o5?=
 =?utf-8?B?SUVGWE9VKzdrUTZhdzBUd3ozekp5YmVqR3daZWxQUDd6V1NrYnVJSEpta1VG?=
 =?utf-8?B?ZHZSc085ekFBd0g1TkFTYllsNENSNW9iTE5VaUk1ODB4YkRLdWt1Q3QvUitV?=
 =?utf-8?B?bjhmMFluRzM2M3Y5UDJHeU0zUmRKUDJmZWdXUnIyRE5vcVpQdzBpSCtvSEFE?=
 =?utf-8?B?cStma0hXWVJqN1p2RkprWUNhNEI1TW1TaDdlaHJ6Y0szWGVxRU1JMXFOeEhh?=
 =?utf-8?B?YVg1QUlUMjkvZE9BL3cyQVYzZ085NytOMW5COG5zS1o2VTAydkMzSzFMNDNo?=
 =?utf-8?B?OHFwSTB4Ynk3MFVJK21zdWJldjhPOU5nSDJvWjhjdTZwTngrYXY1dGtnSW1s?=
 =?utf-8?B?ZGNIUkNFZ2JsMnExME1vQ0lvRjh1c0dYZnNoakhvL1Y4TVBVUTE0ZEdHZ0FI?=
 =?utf-8?B?WDROaHIyK3pEcWg0MG9HSmVjclRDamh1dWFjaEJ0NE04bk14TnB1UzRvNHcy?=
 =?utf-8?B?SWhqVVJzT0NvTE9GWElOampyWGxlME5yNmZrOHAyY1pNc1l0Q2xRUzdhUmMr?=
 =?utf-8?B?bHZJMTlNYU93OXZLaTFJREVaUDdNUlJZZlVpMGs3ejd4dHdHN0lFWUxTeUN3?=
 =?utf-8?B?d0JTSEtObWFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUdPb2JJVnlRSmpOMHpuUkVJb245WXY3YUtFZ2JISi9TTVNmeHdtMmVTYXZI?=
 =?utf-8?B?ZlpZR0MyUkZQWnhVMEM5NlE5L2x2VTc0QjRjSDFsY2RZZ3RhOXhJVlZuTHdP?=
 =?utf-8?B?dlJsYmwzNUVHZnZDSEVJbERnS3pWOS94aklLMGJnRFhnOTdRNXBUYTdOdnU0?=
 =?utf-8?B?S1NJb1pxMUFzdnRBNnBYMkJtMERyRk5wL2Z1bTZsem9MSXVlOEpwNTFaQytm?=
 =?utf-8?B?RVlkUkd4SEZJWFJLR1Y2WFZlM2N5NTBFZkpUejl2T1dRMmRrVEZGcGdoSW9u?=
 =?utf-8?B?ZkIwN2Q2T2htZ0xUaTNCY08yc2lKcS9uNkx1bHJHVGF1Y3JYMUM1OHhHSThX?=
 =?utf-8?B?UmZDZFdsYTdySkdEeEw3OUVkQURNSmdIT0JtT003UGEvcEhqbkovelZKcGQx?=
 =?utf-8?B?WXhXb0RSSE1BYU9iZDNGcjdkOVlXTjVMZnNhMk90YzJXYlZSbVNRZTNyKzNv?=
 =?utf-8?B?WTl2Y0dITlVwYWNXQVlQMytlNzk4ajg2YWdjaDdsUkJCVFFvQjk0QjZJMnlt?=
 =?utf-8?B?bC9nRnJqN1VUR0RrL2crMVYwcnY4cjBzalE4N3AvTXdrQy9BYVRVRmc2cXJs?=
 =?utf-8?B?cS8ySGxyTTh5aGk3Sk9FS1FhUncrdE5uUi9ncjEycE4yNnI3ZHZoVmFJanNn?=
 =?utf-8?B?SWNkNlNXWGh5TmZWUGRuK0k5eERUY1RsTk9sUHp4MkVidk4wQjIyWFlpUlJq?=
 =?utf-8?B?WE8rL3lWMVU0aU1LcG9kUGVidlhsaWRrZ0hwTUMvcXV2T2VQdlA0ZEcxcTh4?=
 =?utf-8?B?R21vWHloV2lJVXl0TmZXNGo4REoxYkZHY1Q4cjd3RmFINWRqSHFrKzBpWTlo?=
 =?utf-8?B?MlByYTNNeEM3VXVqL2VLV1JqME9OaDJ3R2lGeWNqWklSWnhORHBZOUdSbWE2?=
 =?utf-8?B?a0FhMU01Zkg0UkswTml4bkx0MjFoWW44QzRTanp0TTMreXhaT0s3WjJFTUlo?=
 =?utf-8?B?SEpudTVWMGkxQ3JzMjcyUFRKTUhTUU0rbm5XUHB6Vi9keGhUK0NzbC9zaUto?=
 =?utf-8?B?M1I0NnBOSWpFbWxPcFJuVmVvUXhmNXZMVWF2MmZieCtGSFdGMFZ1clc0R2h3?=
 =?utf-8?B?Qy80Q0tzNzRKY0pPd0VjY0lUdWhKN1dDejNWZ0ZzUzlBeGpmdUZIekpLU0RJ?=
 =?utf-8?B?MVMwMDIvcGNESzUycGJCS2ZHSWE0N1lXUGgzM2UyMit2emVONDR6UXNIQXM3?=
 =?utf-8?B?WXVQOEVaczdxMTNZNHdvYzFiQzdkbVFoTnlXeEE1U1NXbi9ncHZSUXBRNzU1?=
 =?utf-8?B?VUFqNFdaQU96MFpKZDdxVnJaVHlST2IyUmR1ak1mRXNsMFpBSzJMeFNMNUJi?=
 =?utf-8?B?cXlYT1NyL3kxN0lHd2MrZHFCNUdYT2YrRnBiTGhjajJEeTJCVzlOTVFpaHo3?=
 =?utf-8?B?SG41bER4N2htTE9KYTlSY0NWdGN2Si9BQlZLQ3R5K0xrSkMyQ3U5ZlRDRlFj?=
 =?utf-8?B?N2xaVmZ2VDViQ2E2YnMySGZ4NGxESDErUHNaYVNObzRNckUraHo4eEN1TkFu?=
 =?utf-8?B?Tys5cWxzRzEyTHAxUHBMQkFCZ1hKcWJHVFpaM1hWRkJEOU1LQS8rQ1pta0pI?=
 =?utf-8?B?dFlxWVQ4d0Z4ajU5QU91SEZqTGFvaWdNMzhtUThzU2d1cjdESnZQL3ZNZktK?=
 =?utf-8?B?dWUwS25xNGx6akh2Uy9EbzJUMkZkT1ZxWVIzYk1JT2R4d1FGZlg1MDB2bFFX?=
 =?utf-8?B?QU1lejVYK25aTHhyenJMTXNuMHBSUmxLR0FGOEVEOERTamtveFY4bW5ueDNP?=
 =?utf-8?B?Nmk1RmJaRml0MlJhZWh5YkNISEtLR1lkbEE2NWlBNVZuMTg5SGtNYU1FNHZM?=
 =?utf-8?B?VDRWNVM2U0lmVzYwK2puUFo4VFVZZTdPNFQ3RndDWXJuUGlZS1Fac1pRUy94?=
 =?utf-8?B?SmhvT3dFTWx3ajFUd1RJRlY2dGJ0UW4vVjNZM25hQUYrVzFRYWtFb0d0N2R1?=
 =?utf-8?B?WFRmTWg2aFR5NU9KVC92dzJoNWNhd0ZlRFFxMVJpTlA2QmF4bGo2N285MXdU?=
 =?utf-8?B?Q1RBMzZ1TEhCYjdEcVAwU1l6UHcreGpiOGF0c2FEYmdsOGlSRTM3d2dBNlFN?=
 =?utf-8?B?ZHBwS0QweHh3YUJTVWpmMGJreUhTUEFsMmwxaWFMU1NuSzRqNXp0MEt4NjZH?=
 =?utf-8?Q?Mf4L4j6E9xILg8Am9rE/KO57V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bbdac4-5d41-4f27-94e0-08ddbea5760f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 05:00:02.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8Le/kFkQdAnynDjYjG3IUDdsTcTCNbpIXn488tUGVZDgokz4B15gxC4jkYXA1VJ/Kx9ZHw8xP7mjP53HTWlcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5231
X-OriginatorOrg: intel.com

On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:
> In most cases, an access causing a LASS violation results in a general
> protection exception (#GP); for stack accesses (those due to
> stack-oriented instructions, as well as accesses that implicitly or
> explicitly use the SS segment register), a stack fault (#SS) is
> generated.
> 
> Handlers for #GP and #SS will now share code to decode the exception
> address and retrieve the exception hint string.
> 
> The helper, enum, and array should be renamed as they are no longer
> specific to #GP.
> 
> No functional change intended.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/dumpstack.c |  6 ++--
>  arch/x86/kernel/traps.c     | 58 ++++++++++++++++++-------------------
>  2 files changed, 32 insertions(+), 32 deletions(-)
> 

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>



