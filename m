Return-Path: <linux-efi+bounces-2072-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF2A9B70E2
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 01:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C31AB21001
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 00:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADFF819;
	Thu, 31 Oct 2024 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0cA10mz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF84A18;
	Thu, 31 Oct 2024 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730333195; cv=fail; b=qxls2HUIbjoKaGw06EsyO+juUjLDGBUc9D5DMqi1lkHfJ1S2vLuaov6TOZB1V3UJFf4qdjgExUkeuleGyotwHapmr5dyTTjnFU0ry1nzWqrZrvUG0gxX6buxXkQU71yp8/V+n42GIt21l4lzigPiMA38KhesINr4n4uy1+rgCFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730333195; c=relaxed/simple;
	bh=6M6J/IcvFcjO1CFHftvpdLENnwU5NSalbuQhz5fYmk8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oe/p1aQXCgILP5orZprxabGza0MkQqxLC6czjCX+XysUsT0zQLhtC4aBh85gS3PaNu/irCfET6Ru/jQhyveQdhYPgt8u/806fG8kQdizjDTYyipfKEuBIQKqYqWtH8PLcY5cTqbWG8DRqFqeBQQlMVGGMLzx02MecMTy2bMHXLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0cA10mz; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730333194; x=1761869194;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6M6J/IcvFcjO1CFHftvpdLENnwU5NSalbuQhz5fYmk8=;
  b=L0cA10mzE4XOJy9kg59uXcooWbdriDfDDT8Kqnp5PJmrn3YXIwcJmzBO
   hrhltTUOIEV9Ysw2n4Ub4TPSNG0JnceXw8d0V+C2w4LVdhg4mDWdwM0v0
   1/XZ9KjbwbaKNRkTPBIOYB6VA13xFUhyIK/+F0Lu2Sx2m48AzoWX5OlY9
   zBgycR+sE/G5Lzb+DSSVanyk6KKsNmiYbkryAk2IkoLXsn9i94+QXD9hE
   xThrQCuCWzuoVIgSP61XkUagnRe4JLTApUha3XyJo3ugJBW4ppMq+thk3
   t/QT2gQToJXhNGV8Kfz7J2+rzAlk3A7g/HQl9/qhLRcLShoqSN0faf/O7
   A==;
X-CSE-ConnectionGUID: cY27YOJ9QaOBs+RfyZFkTA==
X-CSE-MsgGUID: kanjwq1TQ2GrwMPonC3NVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29502374"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="29502374"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 17:06:32 -0700
X-CSE-ConnectionGUID: DGCm1hMJSwCyMMsZEpn4gQ==
X-CSE-MsgGUID: AydWcOU4QT2OylLcHEYTOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="113268465"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 17:06:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 17:06:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 17:06:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 17:06:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkpANgi+h7UfijmGCtc9bY6sMkZDvbV67BnXBdjmyWYYmmcsslc6YzcW3YCuD3SXwPC7EHDIXHUt568IiJEjmUFQzYwWYVM1g+W1MiEgtS+FJB8pGL/IaHDcwUUdfzUURnLqgKZdcOU3Dv7jKQly4mvjBf6uKlFTmgLgxj3msCj0K33CUabVcCF/mSkeJVVQ3KTwArSIgSbZzviI3/FjuBykHLNpkxoVg53zSCYzhKoYFYOmj7AWRHRi7WMZ3HyvX17YqVyaqCna0YP7DgH70pcFlrUztZUkrr+tAQ09EBkIUFyvu6ppg1utaJTOhisfUdJCJhTvhqeqlXQkLFZZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uey6PyYBdWOOkYn5WAkZavZqBl91S9sqSnLpI3VooV4=;
 b=ld9pr0eVq+IH5yiOYEGF4TZ2tGc2IEh2cvqxCa4J1MNwQMtYE8yC7h3u6l18LjV0o0ch9bUZoDkxBZH8wYvxB6qhmJAzw+QPPZoZKIcTLskUvGii5tCldoeZUsnvfnyXDrwMHsuDX+0mX5NwcYR2lgJsZ/UUwGIYoDfcxk4XVO41n5pOnEU2HngM5iqpZN9tGIhoHHgnKLQ6hl5BdGTS9jZRH1LRW1cwGN8gvTsnnVDYY3ds7yVtLRpVZPJnvzCRfCxu4uHwGzNJ8PCT6MyNYYOSUF0M43aOT4w4dg2YHwKmX3ZTlGiZIvxi2f64Zi3SmFSAfx9/oteW/Arj6rVTjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CY5PR11MB6137.namprd11.prod.outlook.com (2603:10b6:930:2b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 00:06:28 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 00:06:28 +0000
Message-ID: <9e0645cd-9162-44fa-8fa6-971bb08fa755@intel.com>
Date: Wed, 30 Oct 2024 17:06:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/16] x86/cpu: Make LAM depend on LASS
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
	<xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Alexey Kardashevskiy <aik@amd.com>
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
	<linux-efi@vger.kernel.org>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-15-alexander.shishkin@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241028160917.1380714-15-alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0066.namprd08.prod.outlook.com
 (2603:10b6:a03:117::43) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CY5PR11MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9eb171-8772-4c85-bc7c-08dcf93fddcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXcwTk5oVmlRbytzcVI2T2YyYzQ2VzNDU2twWWk3V2F1WVFrOExTajBudmFR?=
 =?utf-8?B?azc1WDlaM2lUQ3FMemhuaUxsUGVxME00Q2UrbkMrUmEra2RNRU5zMmlpdGdW?=
 =?utf-8?B?YldMWHF0Sk94WjFHNVNCR3MwNFk3T1FDRy9IRWlnQmJ2OXoyTzAvWWxUVTlI?=
 =?utf-8?B?bCt0VXpXd25kSWplb01UUjdPMWpDNDh0NlJwOWpsYTBmaCtMZGViS0xUdkEy?=
 =?utf-8?B?VzBVR1RaU2NqZXR4OFBNU3QxZTFNaE9pZnBGNWcwcjlQVkJxRlJERWhYNFFC?=
 =?utf-8?B?NWUvMWswdFVTMWJPcHMzbTVZcXNtSXd4aXVoaW53U0xJb3FNNjFtWGt2WHhy?=
 =?utf-8?B?QnpOSGRDdjJudzVRTEpKeWw0R1gxcy81MnBxdGFmRkc3aXRpbU54Vk5sZkFq?=
 =?utf-8?B?OEEzVitTRjFkYU5hdkF6MEtBU3VUdDlrQXliTmQyQndCeVFjdUN5bk5GaDJp?=
 =?utf-8?B?NjJNZEQzbWh5Z0l3U0c3NHNsY0Z3YmF4bGFIVGNEcXhvaWFGcWkwbFNnZC9P?=
 =?utf-8?B?MmJsVXVVUldnQzZLR25jQU10cXRXYzBsUExzODVjbmNGaGtRU3EvRVBRRmpW?=
 =?utf-8?B?QW95WUM0bG5INWZWYmdldjRvSGhNN0dGejViS0FpN0NEZjNheW1xd1JvaTZM?=
 =?utf-8?B?UXNVSk5IQS9DYW1sNDJaVHEycWhHeXdMaXc5UGZWSlI0VzJxQzFGQ2Y0TFAw?=
 =?utf-8?B?WERpOUZYeHJJMDhkaW1iS1ZTam5DdTV0QTBTTXhxOWpsMlV0eTdkYTM0N0lw?=
 =?utf-8?B?N0tMd0RnWkI3ZE8rRzI0bGxnTmhjYjZzcXlBY1UwN2FyNEN2VW1VaWt1ZXlP?=
 =?utf-8?B?bGMyaVVuTlB0MlpQQXAwbmg5azU5MnZybEw5bUdib1dTTnNlVHZTaTZzdlFW?=
 =?utf-8?B?MnF0MlJhOEptYk5ZMFltdGtIZStZL2xWS3BYVXlQSytnNmVkL2dWSEY4Mnpp?=
 =?utf-8?B?SVJ2Sk0wT2pmczgxWldPZ20zRzRkdEI2TlRZK3J6VHh6QUNxNkxaZGpONUps?=
 =?utf-8?B?WnVJZ1UvdXZXUzB1UkxLYXZaVk5ydnQ0SDN2S1FSbHIwWGpCK3daU29YTmZE?=
 =?utf-8?B?VGhQcHY5RUkzWm1WOGkyWitoTFJUOUwzVU9mT0hrZmpJWjNjb3lxakhPZERy?=
 =?utf-8?B?bm9OM3ZHcDhXRUluVW5TVDFoQlIwcTVOWm4rdUc4Y2F1ekUxVHZBeEFBRnNw?=
 =?utf-8?B?Y2NER1pFc1JaSHc4VVdQRzFGaytPemZNRUpvc0x0dHZBUk55Y3lCNk1EQkNH?=
 =?utf-8?B?cTRCbWllNStUaHg4MUxuTml4ZEdJTm1GbktyWmRCWkIvcncyRjQvQmZjZXNx?=
 =?utf-8?B?blNQTHZCSTd0ZW1ycG9kNmhRQzhTanZ2WjJvbThzcmJ1cUVJc0hMR0ZjblMz?=
 =?utf-8?B?M0YrSkRXZDVMMngzYk1oMit2aHZ2RDNjbGpiVXZNWEt4SmN4RXY4ak5hYytM?=
 =?utf-8?B?MUxjZTE3ZTNab1RCSTFYakZ4alowTmtOWGlNdE1HNExFdjVmUVlTdXFaWlNv?=
 =?utf-8?B?cEZ4NUxxSXlCelYwY240VnNDRWlJb2J3MGp6bkprT0FJakJ5KzdGbHNJNzVk?=
 =?utf-8?B?Y3c3d205bEc0Y3FWc2VKdGRyTjczM3hoYnl2U3h4d3h1WXQvVTRyenN5ZU9w?=
 =?utf-8?B?S3REK3JUQkxNR3JTV2psYjl5dVpoVVo1bi84aTRsdFIyREdNV3pyUU9iRGJq?=
 =?utf-8?B?YWdyTWlKVlVIY2xHRURmTjNSVll2QWMvZitJSVZ5ZUdrTXVvNG9pSWk4dEVF?=
 =?utf-8?Q?2YgtDDShJFMr7vSc/Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZKbXl4THFFdHlsdjJoR0thN0lVNEoyZWxhYWlaeVFienp2VVd4UksxT3cx?=
 =?utf-8?B?OVo4bVBTVzFuMUdSRlRsQTArRnFDQlhLTU1GdVJFRTZnYlQ4ZFNYTVZSaXBE?=
 =?utf-8?B?dlM3U25Hd1B4Uk1sSndiUDlJNGE0L0lSaWhsVFFXazRFdVd1T25tVXpiTW1S?=
 =?utf-8?B?R2huckdhRkJnQW44SFo3TU5vRExXNy9Zc3RKLzJmM1drUFNmeU5aTE85a0tM?=
 =?utf-8?B?TVpwSHcyTGFodHV6U0RjUUpaRnV1bXRONFQ4eWNIUllIWmNPUDg2VzJWbVlO?=
 =?utf-8?B?WWlzSkl5eWd3cHJ2cGVmY3RnaVlHMnFNTkJtRW1GVktad3p3RGJwK1ZQRHNz?=
 =?utf-8?B?dkxXeGZPekkzeXRodzZra20wZnM1N2VCdk55QWxNWU5rSzdaSVd3cWdkS3or?=
 =?utf-8?B?aWxYbGNvMVhRcDQ2OWJiWTV5T3V2eEN3USt0N0R4S3E5UmdzWXpUbkhQUm1h?=
 =?utf-8?B?MVM2dm1GUnlEZWRrdjcxMStVMGJsdTVnMmlpM2tQWGtQU0xkODM0VXYxN2di?=
 =?utf-8?B?bkJOeHBRVXhDOGlTWjB6bjBwWUp5Z0NMUzdNYUJzY2FUcDRIT1hZZlFCN0lS?=
 =?utf-8?B?TlQxb2NNZjA1N2Z1aTVLNlBxUVNDQlByekhzVzR3SWpKaWRrOXNpSURlNUJl?=
 =?utf-8?B?MDFqL2hjREQ5N2czSUIwT01YVTZMU25FbWp0RVhpdXVSMFdWS1VueGFQSmQz?=
 =?utf-8?B?NE1DUGVQUUw1NEN6Ry9ES2c5TW1PNUdLK2FXZHpva0dhNEU3eFNqTGcwaUc3?=
 =?utf-8?B?RU1ZcEcxNm1BZDRjZUt0dmM4UGZ5cjU5UWZLTmpyRWlmTkFMVXF4bi9pMVd4?=
 =?utf-8?B?K1JtNEkwV1FVYkQrK0JGTHpGS3VXLzdvaGlURVBoakcyL2wzVWhJYVVXd3Nl?=
 =?utf-8?B?WmhTY3IyM2hSRGs5UlFFTlRQaElLYVZxa25qVTlyUHlTNjY4Z0xSeVh3M3dt?=
 =?utf-8?B?VFZEOFQvUDVsdGZwZlhpOFY5OFVrVUJQOUdOMzJONHllYUFweEcwTzFZdEZR?=
 =?utf-8?B?eVhQYUVLNWRLaXpncHpFNVBDZEZVeUxLR1ZYenl6cGF1Vjg0K3E2RmlYTmYx?=
 =?utf-8?B?QjhabXFMSUdhaHlZNEE2b3B4RU1IUm51U1gwbWJHMU8wOUxIYXQ1MlJjT290?=
 =?utf-8?B?T1ZzZ1FZUlRtQThnMExpRS8rdWNKNUo4TVcxZFZ3Zk9FMW52UERGWk1GZmRk?=
 =?utf-8?B?UnpOTUszd1dKSnJqRWlsK1hta0JUYXdESStVSkhUZ0FHWURmbFdvTXBHUjJT?=
 =?utf-8?B?R0UrZlhXVzZPQUhPYmZJL2hxMHB5a3hBYmRnaHJINFBFNmZqS1pCL0tOQU1y?=
 =?utf-8?B?ZW5WNGs3LzUycStUYS8wTUl6cXkrTFlpL0xqOThldldqZXFuV0JaMXRBSUNQ?=
 =?utf-8?B?SGVYUndWZk9CNnZsdUJUd3lFelgwMkNXazhUTVBhOGxKYzdjRkZJUS9mWGZS?=
 =?utf-8?B?UXVmcS9ibHRiQUxHM1VCYWZvYlp1cG5tMWRGeW0wMlVVdWlxRlZ2RWNSbVBn?=
 =?utf-8?B?Q1JaYmxwNWdQSGdWWGhlSkpwNU56L1NkaEs1dmVXOFcxcjM4czJySjF3QnU0?=
 =?utf-8?B?Qzg4ZUhIU0RNOUJpaFoydk8zSGNRY0VOWjVPOGtMK0dHVEZWc1BDMEUyTkhI?=
 =?utf-8?B?VEpDcmtnUnlOazZCSTd5SHVyNUE3VFI1UkQ4RmpENktyMEk1MGd2aVRUV2tQ?=
 =?utf-8?B?cHZ4LzJiT2tNZTJnOHRvNmhiQXpBeTlBT0FnVnBJdGZiVU9mcmtkSnJnSlZB?=
 =?utf-8?B?ZzBnRzBUdUZwUHh1SVI4eU1yZWNCUTg4Vy9ZV3BBVjJJRkpZSnA4UDVkcHI5?=
 =?utf-8?B?aUo4eGYrVXJ3Wm9sM1dONFI3K0toOHE1ckNDYUwvRDVYSkJkUFh0NmZLb1Br?=
 =?utf-8?B?QU96a21IK3JKODFJQnhkZ2FYVnNWSWtEL3R2REFCWjVGS3BTdHJWWHZxY0RO?=
 =?utf-8?B?bW1Bby9iZHZDWlRDRFo3alBpa0lHVHIvZnVxd1ZOdXNrRFJzMjdzMmZCdzh6?=
 =?utf-8?B?MWpxUG82eFA1b0JDS2ZTeFNHVHZ4WEFuMnp3MmYyaExyeG9vV1RycWJtdzJO?=
 =?utf-8?B?cDNkOHc2aGROTGlrakQ3K3RRbUNRbitjNDRneXZiZjRlZ3JobGdaaUlKdTZW?=
 =?utf-8?Q?vdQ3pS8dJ6cPvCFwvCY5oWUxh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9eb171-8772-4c85-bc7c-08dcf93fddcb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 00:06:28.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ur7jcvUtUgVVSBaaEiD0/HzlDmKsv52W2vpeb3FILmXdPF29HyNCFD2zLKzaB3oteTUWlxwsoPtPKk6xPnGB9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6137
X-OriginatorOrg: intel.com

On 10/28/2024 9:08 AM, Alexander Shishkin wrote:
> To prevent exploits for Spectre based on LAM as demonstrated by the
> whitepaper [1], make LAM depend on LASS, which avoids this type of
> vulnerability.
> 
> [1] https://download.vusec.net/papers/slam_sp24.pdf
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/cpuid-deps.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index 3f73c4b03348..d9fb2423605e 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -84,6 +84,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>  	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
>  	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
>  	{ X86_FEATURE_LASS,			X86_FEATURE_SMAP      },
> +	{ X86_FEATURE_LAM,			X86_FEATURE_LASS      },

The dependencies listed in cpuid_deps[] are only enforced when a feature
such as LASS is explicitly disabled. If the system is missing LASS at
boot then LAM would still be enabled.

We would need this patch to enforce it:
https://lore.kernel.org/lkml/20241030233118.615493-1-sohil.mehta@intel.com/

Sohil

