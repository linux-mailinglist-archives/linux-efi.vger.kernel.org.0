Return-Path: <linux-efi+bounces-4077-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED4AF074E
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 02:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3D83B01AE
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 00:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BFCD299;
	Wed,  2 Jul 2025 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jg0N0hTO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC44C62;
	Wed,  2 Jul 2025 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751416576; cv=fail; b=MqQOXexs1z4nkveLhrMs/RCVzaXRtRTrUctjIHVpP4tTKNXTSM7WWsbJCH190rmMO5yE4u11mFBC6A+lhmRmgV7I16jP7qGUGoB7CRQDRheqpRvzKSeKqWWrKXiT6WzZMeW4viCICK44HoIlgPYRpogNVBcG9PYonEuGitHNeTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751416576; c=relaxed/simple;
	bh=4u2pp4oadtkcvLh8ijY5WOVxKvnb9r4PT9Lmmwy+Vy0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KFYelX2Mfm90AIRPwpRPbnrANZk+REOtZRtC8y094ivfB9k5MT281bIptnNpwLBR/tUQDYblhWQtKGcaTMfI4s5X6cI6C5rdMlSB2pb2//xbNBUppnNHbhUSkpIAt3Uqm/m62DOH87Jgqh/MBmg2H4WGUTtwjf/jhbp2tUkkiYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jg0N0hTO; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751416574; x=1782952574;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4u2pp4oadtkcvLh8ijY5WOVxKvnb9r4PT9Lmmwy+Vy0=;
  b=Jg0N0hTOOZMI/pIh/W1y2kALvm7mQZjsGAbKJrIt2AFuIXTnmobwAx2Z
   q8XTPWjr5vaGXQ7ka/lS0DrqOvpmzBZQbour/Oo8ayFJ60VUI9jVAROUx
   6jPDdussLuctpArsmQyPDicgWB5UwgMFeSfoo9nIFnq2jqCIKKADztuew
   RK2g6590hrahCXUta4Bmt0T5LTOGUu5ZzK04qtDDrsRaTSrCd8bzSkrEH
   3bfwLKPNZojkdS6ABW27nGwCGSX9g/hx3IpjA2kQ8A3++R9K1s+kLk6W8
   waBMM3T3+K4FCO9jgr6XIBe984sbgbxOP9IAimDZ+orydQ30O7/XqGwk1
   g==;
X-CSE-ConnectionGUID: xVHzzjr5SoeG5XwsSluipA==
X-CSE-MsgGUID: HIZ4UV8qS0i/KXhqhK5Pcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71124616"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="71124616"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 17:36:13 -0700
X-CSE-ConnectionGUID: +SABrGlLTX29gdE7iB6JIg==
X-CSE-MsgGUID: rsNtyVRFTC+hc4O/w4/c0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="159630731"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 17:36:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 17:36:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 17:36:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.67)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 17:36:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vm4lxL4ad1YxX+2o9Zq6otPYzWsVMh9dkBWmcWtl1Y1VDsebR1yPZxnmOaC6/rIxMqdi3yXeX2YtFyuwYfHQm/j95UK7wNJxh73SIJEJZ2kQBzt9iCDvEoYtpuIHNOMr3QsY/QwBgR/9HewTp3oRMdJi3Oszqe8g2xNPrrp0oeMsnWqylZkB0V8rHY3qxdvpei+wme8JYaz4N1itz0nEwFH3uO31ycLdj503qwvNCor6Q3zeC7HTXwP4XGBvxdMghbbnO19NDAEpUaHCyKCqwe83UYiRcHF4GBe0vwyf8zPdIoqspTCcvLg1cHo8t6zn7OUm/zb2bULxXlDT3HiGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNn1461+EsTgTLpE+kP98e6vaXUjboh9gTsZynxR3xA=;
 b=xLB6qpaBGt5SF1Ug+wHhQaFX2bE3mg1KQy3VXFS1/opYi87EvWLSgsR5erswQAgWtXvr4SN8/8+Xp6cVg/Qd7liDknXSs+Gir7VoSgN8zyat5X/QIh+YGC7Ve/Dk+X4V6SQhqRC7bbLYCjMlear3gyBoSAA4hsRiBWssn7z5WDf/UWadmIcEH9EV/SisEqWhlkFfR/kWfIkhtWXOCO42zo0Qyd8+CR6VGpB2oqmiUZB2HMgLFLR5MMgciXYqP0LMz/xbloQ4kmvqKcqqHUaWrnvtfsfgcQFdgaylaBCHbaBIO4IfMddx2lfxkSxSzPK8ua0NlcOyQK20889ety7/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH0PR11MB8213.namprd11.prod.outlook.com (2603:10b6:610:18b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 2 Jul
 2025 00:36:10 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 00:36:09 +0000
Message-ID: <63a44def-fd5d-4f21-8d09-bb608cfab524@intel.com>
Date: Tue, 1 Jul 2025 17:36:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 12/17] x86/traps: Communicate a LASS violation in #GP
 message
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
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-13-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250701095849.2360685-13-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH0PR11MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fde7347-1963-4bba-16e3-08ddb900706d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDEvNnFEbk9Ra2kxTy94V0pIaTJUdHV0dVNDRWpKeDhCTExQZkR6VmxvSmlP?=
 =?utf-8?B?Nk5OYlFZZ3M5Lzh2Y3QrU1ltVlcrSG00WGVQRG5vZ0ZmVmRzSGZ0YUg4UnB1?=
 =?utf-8?B?YWQ0b2xHVTd3eFh2enhNMDlERXphYi9rSGdpdmtzeEt5U2FLOE5sZUJSMkJF?=
 =?utf-8?B?bitCRGV0c0lEcmJUR0xGa2t6MDl4ZGErRjFwUittbmR2cmVBcFhVNXJ6QlRY?=
 =?utf-8?B?RUd4cFJKQW5HeHNxRUZ2SVUyQXpQYjJjZDQ2M0pyZG00Ym83NGMxTUNEV3NT?=
 =?utf-8?B?SjU2REthcy9Hd2xkMVBVMCs4amViQk1TWnZFYmo2SWwxMWJXYitIdWVZUTlN?=
 =?utf-8?B?aHo4am9tVGlxS25JNVlzQXE2V3hZV2FSOW8vNk1kZmZ1bERpSnErOEt4UlZk?=
 =?utf-8?B?VFcwdUVNdEEvWDAvTGsrK3d3bWhKUGJ1UU0zY2lMNGdmOFllRkhHaHk0UkpO?=
 =?utf-8?B?RUliQkYwVDN2WFRCR1JTcDZqRVhnQWJGWmtreGdBYmEyNU5xWGplTWJTK2po?=
 =?utf-8?B?RnNjckZRdjFCRGhJMVhDNER6YWtqOFhUc1A3RVpWaU11alVOY1V2dlVqdHNM?=
 =?utf-8?B?SVFTS09QZ0FVS1Fra1dkS25KQzJRTjNUbTdKTis1dWRHaGhWNDRRZ0hyN1Jk?=
 =?utf-8?B?SEJzcjZzb3VlZnpWek5KU3hreDN1SkhVM0lzTDZMbngzRlRFd05BNWhnYjVj?=
 =?utf-8?B?SUhNR01UVFdsQzR6R2RWU1RWZGc2VitPbi82aW8wbWhrZGlyQjJwWkFpTTJy?=
 =?utf-8?B?ZDBRd2VnTXVlMzlFMS9LNkFWYlJ5WjF3K0w2YW51K0hYSzBrL2x0WmZjd1hG?=
 =?utf-8?B?cDNUdkhaQVFvcVllVTdtUkprajgyMHBCeGwwOXUrdm1ZdWpDSVgvd1NwUDlk?=
 =?utf-8?B?QlFGclk4N3hBcUVaeWc1ekcwcGU3QXoyaGp1U0FvY0d3Z2pZRzZIY3ZGeFhB?=
 =?utf-8?B?a1ROYzd6bE1xaFhKbXY1WnE1ZFdEMTdDWi85SE9pY09UQWhKRXNxVXhzT01j?=
 =?utf-8?B?WXp4MlFiNE1ZTGJiWmdGckhCZHI4ZkRqRU10dzNtNHhlQnJwNXIxRDhwcWx1?=
 =?utf-8?B?N21VRnpIa0MwUlBEVkVqWFRWWFh4ajZPVkJkTkVTSlJvWlZwZjlpN3hPeVpt?=
 =?utf-8?B?ZE91ejVMTERRU1lURmJUM3FZRzJPVk1qN3MwdkFyYk5NSmtaeHp5elZCaW1E?=
 =?utf-8?B?bnluVDJkOXhBUTg0R05DYzg1aHRYeG81bUZlKzJDWjlrTUJUNTR6eHZNQ1pS?=
 =?utf-8?B?K2tTbE1wT1Zlc3c2VmY1WVpTSHM1ZEVvTEYvb2huQ2wvN1hhUDd3SVFoRlA0?=
 =?utf-8?B?d2xYQUozaVBLTWZUbzUrcHlQTVNQUmp0eUlzclZDUW45RlZMWlJTTTIrUDY5?=
 =?utf-8?B?Mk0rMVlXMzBkVFg0RkdiSll3b0VLN2lnbjhveXlweHZDampXQloweFVLaG82?=
 =?utf-8?B?NzkwVDVxVVAxcHhITkRGLzJHSzl1dk4zWG1ta2ZMRGJPdTlCdm0rWDhMSzR4?=
 =?utf-8?B?Q0F5WTlwMi9iaTNTc0ZhMmZKVmw4VmpIemNUbkF5UVVPY3BrU056MDk0eTlj?=
 =?utf-8?B?OE9PL1lBNjlNU3ZrbXdXQnpWVnc2MWJFUEp2c3lUSnBZZnliYzRQY0kvTXpj?=
 =?utf-8?B?N2gvR3dERFdQUmpVNWZZd3pnQ2cyRDJjakJLTFpWcWZJeS9wdWtSWERhU2FL?=
 =?utf-8?B?UU1CRTBMMnpPK1o3M3cwUWpYSy9iOXNwN3lBcHMvQTVZS1FET0hOZmlqM0FX?=
 =?utf-8?B?QVRUb09qOGUwZHBkdjNvTVpna3lTNDAvR2ZHaXRwZ05JOVZPYTBTdXlyZ0RN?=
 =?utf-8?B?QlkwTXM0c1h6ZDFLMncyc3F4Y3Azc0hxN0VpczZRWFJGSlluWm95eEVqbkdP?=
 =?utf-8?B?UmZEN1FDb3l3V0xFYXlkdmRZeVVZU3k4U2oxL2t0VUp1SkIxZkcza0tvOWJN?=
 =?utf-8?B?OFNhKzZwMDBrRDVqSlZ1WjJEOVFhbDVvbjJyVWhXejZWbDFLbVhWNUgzSXUr?=
 =?utf-8?B?MmVLck9IMVd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnA1bUs5MDQzTmRTLzRuVDhaNVRNZkdXLytsK0hKQTByQVo2Q3JqdjVseCt4?=
 =?utf-8?B?aUxocWNXRnZXdkExd3NkbDNOSjJvRW9ENzB0bzFJS1Z3V3Z0T1EwZjZad2tV?=
 =?utf-8?B?MC9PaG9GbWlsaUloUHpZS3Z4UzFMejVVWWlNc1ZBK2h5Y1U1aisrMURIRXNq?=
 =?utf-8?B?Vk1vNEFCV2hlVytnamphRm92Y2xoUFAyQXRRaUdkU3lSbVFlK0VZZ1VGNlN0?=
 =?utf-8?B?bzNaY2xSTTlNbDl0MWtvTjYyalBnWjRqN3JFLzVpeUhsZzl4dkUxb0kxVEhW?=
 =?utf-8?B?MFFycTJKTENZODd5cXlWZ1lINlV0WkR5QU9ESzRXZkxuMlVyRHRpcG4zZ3F4?=
 =?utf-8?B?T3BqSFExME1tUmtRQzV6QTFmYnZLTU9oZzI4YXBsWU8xcGhweXBITTVESDhC?=
 =?utf-8?B?amN0bndKVWZaM1VOSG5rZzZlWHpBelJiYmtXazRCaHRtZ0kyRTV0WTJEY3RR?=
 =?utf-8?B?ZWhCUDhra0k2OTNMbmtMM2ZQYU9aZ3l1M1pXVEtnMi9UUVoyRVZBbVNjRkhZ?=
 =?utf-8?B?K1oxZ0ZSRzYrVTJPZlFORWVoT1BHQTA3VjdIZ242MEJZVDBYdVVMVFE4c0Nz?=
 =?utf-8?B?VUNLTnhrUWFXNVFjd2tvYTI3Mm5Va1Bza0JyTjBmS3I0N25VOFpLVExSVDFn?=
 =?utf-8?B?dG1wRlNPMTJjakptSE0yMkZGeFlaQVdKUzl1bjhCL29RaFdETkRXSURPWk5p?=
 =?utf-8?B?S3RoSTkxMElTRVJGNkgyREZmbUFqWXJMKzl5MVo5eG5KQmM0encyTURvK1da?=
 =?utf-8?B?dU1DcHM1Rk8zWU9mNi9MQkdnYkh6NHNHMkcxK2s1eU91dUZEYm1kQVB6QjZD?=
 =?utf-8?B?d1hQNFZYcDJmZ2dDQndtUjNBRU5DNUZXMWtXNWRMVndoU051bnZsSGU3Mk56?=
 =?utf-8?B?NjZyajV6RWZieFBiTnY1VmlURkQrWjVyVWllbmtvVHNncTM3akhlTm8waURC?=
 =?utf-8?B?Q0dzbUd0WUp2bmFWbHJBem1TVit5K0RpN2R3cGhPZmUyMDVmY21qbDE0dHk5?=
 =?utf-8?B?U2pGZldMSDdiOHlaMjNkVGRxdjlqTUhCZjZ4NDdpRjV5T3ZrUmtxNXBWem1a?=
 =?utf-8?B?ZFFLcmc4ZXQvMG85b29VNzhyVFdVMDdDS0tQei9DVmdhT01HNENRYlpYczVV?=
 =?utf-8?B?NS8wRDk4QmplYXpWcG9DdW5sYkdSVllDRFdlcHZ0aUxsY1VqeW9La1dhQi9x?=
 =?utf-8?B?ZlQzS0lmeVdmZkYwZGw4Q1dXTllVd25mdHU3SzhVa1phQTRDcDJnQy9EdERi?=
 =?utf-8?B?TVBKbWpNN0tOT0xid2lxN3hmRXFzb2swR3VFYzVhaGtJZ08zREdYL0NqeElk?=
 =?utf-8?B?bS94M2NrRStmSVFOMTZyWHNQdkx2eUlGK3JjbXZGUHlOVng5amVPNkQvVUZP?=
 =?utf-8?B?UlYrdTVVT0lzUWR4Z2ZxVVh1RW5Bckpsai9tK3VWY2NDRytCN0lRNmI0aDEw?=
 =?utf-8?B?dk43UjdFNU42T0o1WUtCV3l6VVJIRHdEdkxMdGVIeE0rQS85c21CRk8wNnNN?=
 =?utf-8?B?dktBMldUanlzMVhUcDhjeEFxS2lFdGZUU0lMNG1Ibm1rdU5YN1hLMVBYTGpj?=
 =?utf-8?B?RWZLOEc1WmVWQThtbG5KaXZ2WWptaWNaTlVRM0R3QmFjRkFVcnY0cXB6NGl5?=
 =?utf-8?B?VHFMYzNnSjJKcUQySmlFMmFLN1F4MGF2UTEvc05XeFNINGIyYU9uZVBsNCth?=
 =?utf-8?B?YnpoZFNFbTNMU3MvUDlLQzZKQzBOMlNNV1N6RmRJZ2diZzZpaVMrQVlTN0lN?=
 =?utf-8?B?NTNtY2wzQWQ2T0ZlT21tc0UyUzIycDNjVTZhSnpHSXE1MmpmcVlqc0tid2tO?=
 =?utf-8?B?ZUxiWDUxVGJJTmtxcUlxUFBxcGZYalAvL0QzNk56azhweE1jWDFSZTNncHNC?=
 =?utf-8?B?dkhINExzSGRpVGdLUUF5M2t6MjVySExha2t1MFVlM29KSXZJMTJ2aU1lR1F0?=
 =?utf-8?B?czJsWUpmVVVjWE5Fb3liYnZaMDVMeFVmeWhMcEhHelVyWk5YTGZUQnJyWXF6?=
 =?utf-8?B?d0Urd25EYytLWWl2ZFVXcEptRWdoODhQVEdvd0U0QVNPejNsTmFoRnBRK0tp?=
 =?utf-8?B?eThOSjdFVUtjTmgwSzZIZEVnMWxBckRqZml1WG5NMC9XWHNLUWR2bWNPajZM?=
 =?utf-8?Q?ErF9ZWOY5ZGeHA4Pw9Toe269q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fde7347-1963-4bba-16e3-08ddb900706d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 00:36:09.5328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdUMcPTzERYZep+Z2eiiXQYcGWxaevcZWq2Os57kLYc/JhDZyd9optosORpWGuUwQ27W5ei4OWeShOpcONG6ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8213
X-OriginatorOrg: intel.com

On 7/1/2025 2:58 AM, Kirill A. Shutemov wrote:
>  /*
> @@ -672,6 +681,12 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
>  	if (*addr < ~__VIRTUAL_MASK &&
>  	    *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
>  		return GP_NON_CANONICAL;
> +	else if (*addr < ~__VIRTUAL_MASK &&
> +		 cpu_feature_enabled(X86_FEATURE_LASS)) {
> +		if (*addr < PAGE_SIZE)
> +			return GP_NULL_POINTER;
> +		return GP_LASS_VIOLATION;
> +	}

The comments above this section of code say:

/*
 * Check that:
 *  - the operand is not in the kernel half
 *  - the last byte of the operand is not in the user canonical half
 */

They should be updated since we are updating the logic.

Also, below is easier to read than above:

	if (*addr < ~__VIRTUAL_MASK) {

		if (*addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
			return EXC_NON_CANONICAL;

		if (cpu_feature_enabled(X86_FEATURE_LASS)) {
			if (*addr < PAGE_SIZE)
				return EXC_NULL_POINTER;
			return EXC_LASS_VIOLATION;
		}
	}

I am wondering if the NULL pointer exception should be made
unconditional, even if it is unlikely to reach here without LASS. So
maybe something like this:

	if (*addr < ~__VIRTUAL_MASK) {

		if (*addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
			return EXC_NON_CANONICAL;

		if (*addr < PAGE_SIZE)
			return EXC_NULL_POINTER;

		if (cpu_feature_enabled(X86_FEATURE_LASS))
			return EXC_LASS_VIOLATION;
	}



