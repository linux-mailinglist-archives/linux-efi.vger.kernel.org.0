Return-Path: <linux-efi+bounces-2058-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12609B5714
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 00:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F251F238A9
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 23:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F3F20ADFC;
	Tue, 29 Oct 2024 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwXx+WkA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF78190665;
	Tue, 29 Oct 2024 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245320; cv=fail; b=XVDYxKFX9BcywYB1FivgiMeYoEOF1QebOPnw2b/QDoo1070zC4ohpZ7zhlmJ9JP19D5CUIn123Fz6oneo1kFNEQuE4omkS6LZxK0co7r9P1EuNE1gR4G0CbcJyNnnD1wA9i7viqwwvU7mcGPkDQrCqxT3S4fazkg7u7zHaCFsrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245320; c=relaxed/simple;
	bh=HOA0NKeoZIUvv0w+VzS12iqjz2VUG4AEN/LBWcfWHx8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RWC4p6PJOIUS5H44kBRHXJPOYuUY6F1V142SSZs4eFfCJ6MVAPmHedXFkV/YJb7FbNMsBbXYU9laj09+/nGKyzX0F1DP3++6NDMerWwpx0Hw0WswI3x71U2nkoev6lsudWnlNEJt/aoTdc3VZDhYsAko/fYQTQygB7THkLnNors=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwXx+WkA; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730245319; x=1761781319;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HOA0NKeoZIUvv0w+VzS12iqjz2VUG4AEN/LBWcfWHx8=;
  b=CwXx+WkAs8TKfEYkDgdI1KSl9oFUpqHQcY6GBGR3wuNpj8oUECFd6Avf
   t9NDq+klwWRpbNsg7ubQ1xoNv4sYWnA83fk5yY2PEP2Jqet/7LAYM9+us
   02Y22hN2Y/Fvf51S921xOVtAoCTp6vbRE0rFjHDZee2CqYxjUebqxrpjB
   iYCnTfReRSuksHUKfAbhIrrcSD2+Ca4RnjYCEm1PdGbSEF0Fp/AErU2im
   mMSe5l5CSndmv3ufrCqldYxgBTjQHCCkoCiGYB/BdrZjtM02j4KTEJXNF
   XtRqmZ2ibKqM5pwmPTbEUehW72dCGNO8u6mTB1rsTH5Al9RQlyWf0tvXL
   A==;
X-CSE-ConnectionGUID: jSxQL1BfTNit3RDOWre4Gw==
X-CSE-MsgGUID: BdSxt3g/Q/GddvJmp2nwaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29344455"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="29344455"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 16:41:57 -0700
X-CSE-ConnectionGUID: WGzxJZahRHaWW5ZpGW9l0w==
X-CSE-MsgGUID: iGShF16NT7K0JwqmGHDQOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82053421"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 16:41:57 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 16:41:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 16:41:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 16:41:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwUcO1MEATV/X+Ljifcda95n386kst9bZEWCVlU90K9ofNDnR2wRWDZM5cvaip58bQAGWQ9FyjdYMVLW80ZfIql52oW9XmbTViHUuX29SFvt5SpLpxPAUGA6jZgKtJrFmSuhdl3m+5EifZQT/3opNkweMJnA7N5kNC98kBOoYidTo0IdNiahBqSjmtl/ukSRXCf2lTpw+OWxhPHGvKFoG6L+D3AJY4I2aYujpIXAKiyhJ0RZ9o/w5J4SelE0ss42oviNBTzJoGz/q1Ur2cEXFxnbUs7lLobLca9rTPam3DAHblOpGyzZAn24AWQ5ctRcwBCDTKDDTKC8mV3rtVhXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Mv88GwO97lbySZSjJ6rpDbqI1HSfHXLUhDVLuQM2qA=;
 b=kn0pCENW5bLdQdDLByGTSSvm5J9NMaq0gaI0482FBkgcyu6dOXCdIDMY1dn5IkrCJwDBE8D8Sosr8Kn7IbR/lSt4NSL/34MhN+nNmBYiIshBeDqndghpklWz5pZMaVEuRUfmyqne2YoYO9U8VuffikhZcogjGOMwunIyNXw+pfrmXuFve32Jslm9Pt1MhYNYI5QZ0KTxz5IXCTTZwY2D3W4yLZYWaVVg8YJMZurMfOgz+gW5HUjAQtLttmVBpuHp4DQfi97J1ftkjqQLY3qfOa5gk+sDMfaCbzD21PUJwHu+kOtYb40/DG1CEYdn4c3+GZmBk+XAv9St9M6aXr/WRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW4PR11MB7101.namprd11.prod.outlook.com (2603:10b6:303:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 23:41:53 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 23:41:53 +0000
Message-ID: <576e3c53-6417-4027-8d4c-b9f5703b634f@intel.com>
Date: Tue, 29 Oct 2024 16:41:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] x86/vsyscall: Document the fact that
 vsyscall=emulate disables LASS
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
	<linux-efi@vger.kernel.org>, Dave Hansen <dave.hansen@intel.com>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-12-alexander.shishkin@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241028160917.1380714-12-alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW4PR11MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e28d0b-5f76-44dc-c461-08dcf8734433
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGhMdjZ1T1lTbmsrc0dlbGlONHQzVGZaSmQrYTdFczlobkFIN3BoWjREbW9T?=
 =?utf-8?B?Y1RQeVJicnBJL0hWc0dFdmpYS05lN0NPUXNKL0tzQW1YYkw4OERUc2pRQWZq?=
 =?utf-8?B?MS9ONUNHM3dyN0Z2Sno3bElkMURmbDUrTTZlakhqNGVJeUkrN2ZEWGZweFdC?=
 =?utf-8?B?SkdBVXY5ejJuVlJRUi9IckJCd0JqNnE0NHVIK0dVU1NQSnc4enBnd1JJNGls?=
 =?utf-8?B?ZmpOdGZJeDhEUFg0bXB1bjAyRzBScnlpcnQ5d25JaHBpRHRyTURKL1hMVTl5?=
 =?utf-8?B?dGpTbXRISk5GSHJpakxpU1hkbDNEMmxmN0xrMGRkTURCS01nRE5tc3JMUjFF?=
 =?utf-8?B?ZDI2a2Q5c05TSHFEYkVjV1RybnlHdHI5eklvMHRiajkrMTg4a0NuSjJYWGx1?=
 =?utf-8?B?ZC9RZE5sYkhSMDA4MjNhaXJUUGJpRkR6b1NUdis1Y2hMb0NzVGtoWmVYV25V?=
 =?utf-8?B?bG43Z29FTXg5YXZYYUIydVdJR1ArVlUrTThrWnZnSldESW52VVROM2kvdXUw?=
 =?utf-8?B?UkpkcDI4K2k3bnI1RHV3bzF4ZGlCRE94MEsxdGFad2pVVlFpaVFSVS91TmZO?=
 =?utf-8?B?R2tnQlNPSXUrcFdGWjcrYXR2Rnhrd251SEJTYktMRDRGNlJlTWZLeDR3ZEhi?=
 =?utf-8?B?Rmk5NTd4Wkw3TlMvT0h5UzZCT1BWdzdCZElsTEpCcCtQSW9ja2NUaitZVCt4?=
 =?utf-8?B?emRCM2lYVmVIemhsdHFvMGdBK09jYjBRUkFHbktvcFVkTEZQT0xCK3RkNWRU?=
 =?utf-8?B?eFpram5KbzNQb0lIdlBWeFhUNHFqcUhaaDlzRE9TMjdvdDE5ajVwSHQySjBE?=
 =?utf-8?B?bVdoUklxR0lSQWlTTXRzOGVNa1Z3cTNJMEV6VmpSRW00bFI2SkJSUVMrcTZz?=
 =?utf-8?B?dVdtOCtRcElQaFBuMHZ4VjJqZkE0Q2h0R0Z0emZGNDJBc0R2Nk9mdzFKOEhH?=
 =?utf-8?B?azVEdEk1RUMvbGJwdFd2REplUlp3c0JEV3ZpVlJMcW5GY0l3VkgzenFqamNR?=
 =?utf-8?B?WjBTQm1La2FYWjJwRTZzRDMvMUZtamV5eFZYOVhBZTMwRWJzdEtnSmNPQU52?=
 =?utf-8?B?UVZOYVNBZFhjNCtuZysrQ2MvbXFUZnBOUklNVXUvZ1hDOWJWN0dvVHVMUDdr?=
 =?utf-8?B?L0lBdU83cExadlBSUzJOUk9FdmN2WUtCNWFHMXcxOGUwbU9vYTBjdjZYeVZl?=
 =?utf-8?B?K2I1NlZoa1hqdllkWmVHTXl0ZTFXWUhHTHJWa2hmTWtyZFk0WU9mckd1MHhN?=
 =?utf-8?B?YnVZVDMrQnNuUEtMT0tTamhUamd0cGRUYk1wY1N6Zm1RWG1WditTMEZUcTlo?=
 =?utf-8?B?VFRYRURlUSs1TzluY1Z3SDJpUmNTMzBPSmVQTXdKempLcWcrSExwMkEremlI?=
 =?utf-8?B?QkpiT0QrRkFHL0paaE5qcjN5Mm9lYUFIbkhwSXU2TkVwN3dqajl6UmxDMytH?=
 =?utf-8?B?bnRVVHJnbG5kaklpNUR0aGNnekZKU3UzclhMVGpYZy9lTDhyR2ptQ3pia3BO?=
 =?utf-8?B?U1IxOVIyYmQrQ0ZCaERDT1p2WU0yOGs4cGhtMkRWdFhoaGxZWVM5bEVBUkFN?=
 =?utf-8?B?Z2FDTENNRitaOUc2ZFM3ZnQ5bFhJeDc3cEVZQWdHYjRUQTU4OXh2bUYrOWlO?=
 =?utf-8?B?VGl1MkVrSTJoVXRyemU0MnNVNllPQTFER085ZGJsS2U4OVRTaEtBWDhqVHBu?=
 =?utf-8?B?cWlKbHJCbXFPcFJNN3Q3R0U2R3V2RFRtd2l1RTRRR256MzQwOTZQakhKVk11?=
 =?utf-8?B?OEtDaW1wRXJUZXFNRTZDZktSU25oZHNsckhya2pBVmFhd0ZORW1TWXRFR2JP?=
 =?utf-8?Q?IseWSzWaXTAi2W1vSvD6mArOGKHjLRJMlPVhE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUthME5USGlkK2Z6WFRrSk1XeW5mSW9zZTExQnJIZ05UbGxOdFM0Y2xxV1Zo?=
 =?utf-8?B?eXU4RXFoQWM4aHVxcjRnVG5Oakd0dDZYRzhIYm11WWFwU29qamZsM3B0WTdO?=
 =?utf-8?B?SmE3MzJOOUluVDQzNUNRWEFKMVdBSzAwWUdkTS9SaitpUWpkTjc1MmtEZzdx?=
 =?utf-8?B?dUVlS2pKRUgzMEZKb1hFWVlKT0tMUjdXSFM2UjlQZ245V2JDZENCNDgxMkdu?=
 =?utf-8?B?REJSQ0hXeUV3N29kMWRlQU5HckZCL08xZUVqMko2S0gwcnRHU1VYdVU5ak5k?=
 =?utf-8?B?L2VsNlVFNWZXZzE5NUJzU1lZRGNwcUR5eDZzNm5TOGd1UVArNkR0L1RIUXlX?=
 =?utf-8?B?Y04wRldJWGIyR2lnVWJyeit3ZU1BNFN2SHFMcFZoYnVpbnl5Y1FoRnV1M0dS?=
 =?utf-8?B?TU9Tc3Z6czEzRE85N0ZmdVFIZVRYUzhJaTdOa0p4bWZ2L21lU3htQkZPdGtq?=
 =?utf-8?B?OTVva05kZERJZ1pYOC94N0RjakhWNkoyeENqK1M1WE8zZlN6cXA0Zmx0VnY2?=
 =?utf-8?B?bUFxdExtZVhDZ1FuNFl2enRNV2U5Z041bFdmZ2MrSUFKOXpsWWNKeGNlTG45?=
 =?utf-8?B?Z0xoaytIeTUzY3lqVitZMndJUFJqb1pTd0JJdzhsN2lpOG5RN0U5TDBaQk44?=
 =?utf-8?B?OUNOWDM3aVJUZ28rK2xuOFdmb0Z4K3NCVGlHWHNsNHpqdERieWJwVG5OYlNF?=
 =?utf-8?B?bEVEVDNtU1l4TTJJRWxXVmxpYzEyU3hMdW80TWIzNkhSWTlqLy9YbkthWG9F?=
 =?utf-8?B?WnJhSXRaU1FKWnUzYWpEWTVOTkZBd0t1Z2pjSEVzZDdRRk9oMk4vODZFVWl3?=
 =?utf-8?B?Q285WkMrODlpemVmUnQrRVY4V3R6SDVwNW5MUzJQYnFsdDRjS1BFTjBjVDBo?=
 =?utf-8?B?bUgyTk5LNWJ5L0xSeWhDTE5DWEdUeENTbTNoTVBrbnQ2LzZMUkIvUUk5b2c1?=
 =?utf-8?B?NGxwSlMzV29CZEtxczNhQ2xtYWw0M1RGV0Vqc2xSSUJVRXNxOTUxdzNCaTBn?=
 =?utf-8?B?KzVIVFA0enFQcGZjcTRtYkE0RE5XQ3k3NFcxa0FGZW5Xc2M1RitBTnF0cWdH?=
 =?utf-8?B?TVRveWVESFgxY0NBYWhtQmJTQVVzcVgzVURiTVU2TTg0ZGhxOEJQUzlwV2ho?=
 =?utf-8?B?cUwxRGRSYzBkZzZ2QzBNY3YxOUJyNm1mZ0RlZ28vUlhscXNGRUUyT2hkWDZL?=
 =?utf-8?B?N1QvMVBuNytITE1aOHF4Zi9ZRjJMcEoxSTQvMVY2WHh0NDVxTm9OWXRrTy9t?=
 =?utf-8?B?WURKUnhZcGhhOUxuY0FHKzlTNmh1WkFVSHVObXNSSUlIY3lpV3Mrd3l3RUNh?=
 =?utf-8?B?S2w4UWk3UGNXNlJRMjdqMnQzRG42U2NSN3pJWVNlaTE2WFMxLzBIb0VGOURo?=
 =?utf-8?B?VVgrSkNYdHd5Vk1Tb0JuL2o0TnJPcUZ6ckhBWDhWM1JYYmlRcFdtWGZYbFJr?=
 =?utf-8?B?aXJkQ0Z0WVp2OFFqNzEzMlZMUnExTnQ2Z0pwUUE4eHloS1p4K2R2SkI1UDR6?=
 =?utf-8?B?V3NjQ3QvSEF2eVFXSXJNajZnbHBaV2dQcDQySVRlMmlEcmt3S05hRkpBeGFw?=
 =?utf-8?B?MWtmU3EySXQycU1aTVFnVWRzRVJjbDk5bHFxUFlzazMzdmtCYytOT2ordnlP?=
 =?utf-8?B?cTZlN1gzdnJBSmgzYnZ3cU5EaEovME9vL1dDVXNBck8yUmpCOXNXcGdwOGRI?=
 =?utf-8?B?SFdHczZEUGJWYm9HTkZGUm93VGxQMjZaekN3UVMzYUZZTkhUR0kzaVJyRkhO?=
 =?utf-8?B?MkFNemVLeFNabjhRamtDVkxpZW5WTU13NjBrK0RFSmpaa080OTdXeHoybjRS?=
 =?utf-8?B?THFZZ2VPanRoRG5seFM0RTNPTTErQTdOL0JmMlJGOWJJTytaSE5tRklMWjZB?=
 =?utf-8?B?S1NNN1A1RDlxV2V2VDU5b0lrYnhpcVpKdlA2NlliQTBhTjJGQzRsWmtob09k?=
 =?utf-8?B?bWRWaTQveE9Xa0RjZ1pVYnJZQ1J2ZEdBOFVEL3ZKejluZ3BJdmJ0WXpvN2p1?=
 =?utf-8?B?SytIZ0pGOXR5aEVrRndQUzBuK2J4Q3dXQ3dYSmxyOXJwSVlYWDc5cC83V2R2?=
 =?utf-8?B?L0s0ajlIa1lxR1kwOURkaHB4Nko1Zk9FeXFXUVo5TWg2bDR0T1ltVjlTWlpP?=
 =?utf-8?Q?i85ZeImTGhz9RoKJgfp8PN5pN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e28d0b-5f76-44dc-c461-08dcf8734433
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:41:53.0199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AFTsoSWBIa2/S1RPf2f5+fpBlJwwmKy5NqEwrNhq0wsdPGx+BMk+QS/Dzu3Uot82vlQFS/gMCHDhWskovTpHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7101
X-OriginatorOrg: intel.com

On 10/28/2024 9:07 AM, Alexander Shishkin wrote:
> Since EMULATE mode of vsyscall disables LASS, because fixing the LASS
> violations during the EMULATE mode would need complex instruction
> decoding, document this fact in kernel-parameters.txt.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

It might be better to combine this patch with the previous one. Both the
patches are small enough and related to the same thing.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1518343bbe22..4091dc48670a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7391,7 +7391,9 @@
>  
>  			emulate     Vsyscalls turn into traps and are emulated
>  			            reasonably safely.  The vsyscall page is
> -				    readable.
> +				    readable.  This also disables the LASS
> +				    feature to allow userspace to poke around
> +				    the vsyscall page.
>  

I am not sure if the person reading this guide would be aware of LASS.
Also the way the sentence is structured it might be easy to misinterpret
its meaning.

How about something like:

emulate     Vsyscalls turn into traps and are emulated
            reasonably safely.  The vsyscall page is
	    readable.  This disables the linear
	    address space separation (LASS) security
	    feature and makes the system less secure.


>  			xonly       [default] Vsyscalls turn into traps and are
>  			            emulated reasonably safely.  The vsyscall


