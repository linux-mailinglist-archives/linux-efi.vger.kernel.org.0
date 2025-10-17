Return-Path: <linux-efi+bounces-5072-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0386DBEC630
	for <lists+linux-efi@lfdr.de>; Sat, 18 Oct 2025 04:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB1B34E433C
	for <lists+linux-efi@lfdr.de>; Sat, 18 Oct 2025 02:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE8026CE25;
	Sat, 18 Oct 2025 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCIDjYJB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB0242D84;
	Sat, 18 Oct 2025 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760756114; cv=fail; b=s+OkkVf5fjcL1zUmNNlOXmoy3Mf7r2fMHINl2KrrZszPSLJ/hdtaScyetV6CK+S4nLZ051fCt6kcfKMHaeC2FqOg5Rqo3K/gltfaEqfQw2BbilyfZP8TJ5q3BiWyrPuKIuDqBjYep8aL6Xy9bvYVfzZekPbDSmAOlYisx/yuTIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760756114; c=relaxed/simple;
	bh=wdNPSQTWjAljyIDN6pYUanlxEIkS8xpiq+3paeTVFkg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SQ6gT1DOLVw3mCFhnie5FpeUuNbhL9hdjBZ1YP3hS+ClNJiXdzi36+QeHYDeUE8l/C1ylAINozO1qSZVyU2Xri9zSP1LOioGGpM1wSl+k9fzw2o0NRONuS6clB3XNGnU9bvFDZeYehw0xMg88vCTA16f1h+o8WVDnHDp7rvSKdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCIDjYJB; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760756113; x=1792292113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wdNPSQTWjAljyIDN6pYUanlxEIkS8xpiq+3paeTVFkg=;
  b=lCIDjYJBm+B08gcmb+YVkARFBIVKWYKUdUJ+VUHTFPQVyuCj08H9pU+/
   edTAcmX9f7IQUEmz1siCVPY32uLjjv9Cfi/DN79ugpXjX2bIBmxlvlamw
   hAq8KF0lIg29dmaWw9klwzsSGOf7vbOnMadcHaZ1pdJ96IFMvUzGPhagE
   WAWlS9QAYqFJim/6dLmOt/5+IS/yF23SJ/N5Icvbi57wDYtQsCACP/lZo
   t5NJ6GJ11Qy22Uf+dsofp+fuYmgreC0RNREKhXe11C4DC5eNAGFmIz+SQ
   bzzgoZhwpxMAhXhXwXVzehuWWNHJMH+h4ryct/rE6luYgr7vCAQGB3Kwt
   w==;
X-CSE-ConnectionGUID: Hiu8fRp+SE2O3rRskj+Mzw==
X-CSE-MsgGUID: yNiNqdbbSTas0otHbClYJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="74315785"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="74315785"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:55:12 -0700
X-CSE-ConnectionGUID: PBquSH8UQSa3qS64jzKt8g==
X-CSE-MsgGUID: ubrU364dSL6V5GtpDsMurQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="188180686"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:51:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 12:52:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 12:52:29 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 12:52:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJ4Uk7q3tXbyPmQEhfBoNuSLi4VMqGE6vQsNwoEd+uRb1vMfTvIh84KhjMKBrBhCu+1+HAi+Mt/HRZ22pTRv194OsnWFSNuC6sqh/e+0IYOjzLrWpykMABCs9ea6GYutSKskUfL7dgXdFZNglY0J/1Uymqft6pzcxhPdm+Gal3gMs3iHfl9nObd/za2OXkq0/QUrjTD2V2HNv2ov+HQJkxPAuINhcnZQ5piYJIAbnFIQfYQqwtn1071RV2WNKIebYoCA9J26bxiRpQ9yDOIxO4hwZ+HICIaelrp2uESeXVxoxGGuipqvv1fFuZQ7g37g60O8b/G6SyBhk+zQVuficA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZAF31WHdufltnnFyskVVAeuDW+irsV/CCbJ2ZRpLqs=;
 b=BXb9LZ5lI9OVdjI34cWkJbVUj3a/YeBdDHQLbr2F2MMMHbUAWTkwbwZYHxQ0HSgQe3F3EykVGR5orNooO87qTIT1VcgbuV9W9FqLYxxlbYJ8WXBQrbgvjOBLQKurS2cYgjVChNm1NiaHrH/V2rVTh/h8nj+Kmax6CYZO/GxBN5ajaBjV3oZ4ljNZRfH6bBEvM7Tzi7+OVoIu4zbL9ep/1rNXOOrfVWZUh7Epvlob2IPKIIAADo2JdaYMGSItUDWQKVpBldHsfAOD/F+I70Z2lCQ94RTmKtNPmCgaRGRvsKHZ2LizU6RdZAdJvv2PxmNW5+AQnrXEUFpsmL0dTyGMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by PH0PR11MB5093.namprd11.prod.outlook.com (2603:10b6:510:3e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 19:52:28 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 19:52:27 +0000
Message-ID: <a4751ca0-8990-4e99-8ecb-e6c2732552eb@intel.com>
Date: Fri, 17 Oct 2025 12:52:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/15] x86: Enable Linear Address Space Separation
 support
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"luto@kernel.org" <luto@kernel.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "Luck, Tony" <tony.luck@intel.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "vegard.nossum@oracle.com" <vegard.nossum@oracle.com>,
	"xin@zytor.com" <xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <27fe1dedb151a606ae46ae3c2bccd80b9a64ff07.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <27fe1dedb151a606ae46ae3c2bccd80b9a64ff07.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|PH0PR11MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: f087702e-1357-4c27-5ca3-08de0db6b342
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGFHTmdoeXNydXcwb3dHUGtGSzAxNkx5MDRLQkx6NkFibHo4VjZuSExQQzVp?=
 =?utf-8?B?TXZMVE9vRXV2WDhjcytQZ2NsZU81QmlXNnhWRFYxS1c0aThwanJPUlVaaDV0?=
 =?utf-8?B?SVZGNHU0QzhJZEI2LytEOVY1amZnaERhb1FHWWM3cjlwbGR3c2hMTUp6cXl0?=
 =?utf-8?B?N2FVRUZ3UlFFSjRQVjFDZkNVSHY3WlFnbFp4UDJQSFNhU0ZhNmFwQWpBUFNG?=
 =?utf-8?B?QmR3ZFJUUUovZ3pwcXkyME9hR0FQZHkxVEdXOWVCNGR5NHdLV2NHdDhCbC9S?=
 =?utf-8?B?OVJMVzVxN2I1cWs1aFRkS1B2YXVSSzE5SWNKRnhoaURKWTd4NWtzQy9Xc2gv?=
 =?utf-8?B?bkpqMVhCSTFIVjJWM2N3TU1aMWVIZTk0c0tQeWMwY05QSVFodVhBZFl6UEls?=
 =?utf-8?B?RzJWcThFSithbmg0aGZ6VGV5TW5iVmc1WVRWc1QvR2NqT3pJZVVTRXlZNzcr?=
 =?utf-8?B?RVNBL01QbXM3SUljNEhCMHVKdUIvdG16UGI0dzJKQ3FnZUJZRVljMEU5QXBQ?=
 =?utf-8?B?VllIRHNzRGhtNm02SHB4VnJSVTd2azlpSHdRSUdiNVVzYTN3aUJJTkhJVTho?=
 =?utf-8?B?OWVqQXFsMUN1S05WSHVXMS95bURNelZUcVhac0xQR3k4TnhhWXQvUTVoVnl4?=
 =?utf-8?B?SnFKYklueExFMUZlNWJCYm1mWEtjTGNxMVpWVUJQZk5rUGlmV2luZi9Ya2pv?=
 =?utf-8?B?MG5HamEvNlRkS0piUzZZZ1Z2VjZ5OHlyQlIwWWFFWVR6M1NrVW9zc09mcUUx?=
 =?utf-8?B?UnZjRlFrdWtCZG9CdU1HTEo5bDdxMFUydU9oRStiUkcxR3AyY0Juc2dmNVpo?=
 =?utf-8?B?MC92NjExTUtSYWtUMnJTTU5aMVhrWjRKamhvOFhaTlgwaXlIbGozQmJDaStT?=
 =?utf-8?B?bnd2NEpQSGh3M2dnaVVtcU5VdnQ4dzB3VCs0MFZUNEo3bzlpTFM2aElCTktH?=
 =?utf-8?B?QUlzOTdQMTZyeXpUUmlTYjFBdTN4VUdDd1hEMXRvNW9Wdm5qMHNFWjhIbDFz?=
 =?utf-8?B?K05KK3ZvVjBhTnhGa0lEQ0tzUXNVT0dRYXFXcS90T3NsL2NkakxiS2hyOFhD?=
 =?utf-8?B?eGFlRmFtZ05wUXJGYk5KM1kxU3dCUmZqa1FpSmhXWnBQMkQ5SDAwc2dJSUxv?=
 =?utf-8?B?UTg5enV6b3d4SmpyVVZGL2dodGJ5amx2bkVQcUcvVkZYSlJ3L2ZPL1owTUhm?=
 =?utf-8?B?bTVVN2pSZW5LRlp3SnBFelFrejJOMk1GK2w0ZWZZRWhDbVd5OUh1TzcyTDEz?=
 =?utf-8?B?VDlmSHNzS0JUMStKTjQ5cEhRNEE0MWdOT0NZdjBTVzBjeVJTM29makhtL2N2?=
 =?utf-8?B?S2JMMzBBZXk3LytPUlI3WThjcjZVM0NmMDB4RmxYcmhtT2RRV2JsWmVwejhG?=
 =?utf-8?B?U0s2dm1Db1BCZlptVE05SFkvb3dNOUk1cW5pcmp0cFZlNjluV3ZvT1o3dUZu?=
 =?utf-8?B?NzM4T0RRYWE5QWt4NTIyS1kzbXdvVk5QZERuQTBiVU1lQVZuYzYwTEJjTjZm?=
 =?utf-8?B?YjJFODVvT0o1b2NNNGhwV042cU9zQVY0QjFqSEp5YWFvWFFCVGVlYWJYZTdP?=
 =?utf-8?B?Q3BxdXFUallRR1c1SExQUE1RY0VidE96SXllSmlOMW4xT1dBaVhGUDZHWlpn?=
 =?utf-8?B?TGxyMkhwMGJHYXVXR0Y0TFl2UWVVMFp1VHVhYU5QbklibmgwdGJYSkJyOFc5?=
 =?utf-8?B?YlNnSGFtMWRkMmFKcjRyUEc3NkVxWXRSZHFDZWFrZ1FBOVJVZWk2dzFUT0hn?=
 =?utf-8?B?RWtSbFJ0czlLZGVadEdVdS9MdHhpczJZU0s2aWt0V2JZcmkwdFIzb0MzUzZz?=
 =?utf-8?B?RDZraG5zSzJabTFBVlJVWFVPNUVUUXIzNnBSZDFXZDl0a2MxS2dwcUFUVkdv?=
 =?utf-8?B?UUpsVDY1VkozUTZrMlNJOVdZRzFtSVBjbU52UGI1SjNRaHZYT2xhdHRrYjNy?=
 =?utf-8?Q?Cl5zEUJszYuomKcFHyNWhv0nIIdcU0vh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVUV3B3eDdBaXgvODloK3N0WWRGcHc2bUtlbXA0Y3pUK0hqazZ3MFdUeFgx?=
 =?utf-8?B?NVBlSGJiREE3RWVOeUF5VWNmbHZBRERJVUVtb0FiUUVWdjZDR0NrelhVdnVZ?=
 =?utf-8?B?c2ljbHd1UzVWNlh1UTJEbkhYVGR2bU8wQXBsQitack9qa2xWYWtvREtzRWtn?=
 =?utf-8?B?THBZaHNUQkpJOXk1NEp4WHVNZVE2cTlyODBpWEVTWTJ4UENJM1Q2aG1Iam1C?=
 =?utf-8?B?alZMRE50c1drak9UQ2xkOTBZcHZiWDV6cEROVEl1eWVneEdFTktKU05rbUh3?=
 =?utf-8?B?Tm1JeDhDYmFSNHRPWUtGV0NFTXpCemJVU2ZjOE9sUmZSV09PSnBoVTkrOTlh?=
 =?utf-8?B?Mll3ZEJBU1Y5ZmdlUENtWFd4V0FsY1Z4SXE0MDQ3dVZ4dWZ5U09EMFV1cUFR?=
 =?utf-8?B?UjFOQ1l5UXEzWVJUSzBhUHFNRUZwS0V5UldPMk16WDh4V3JzRzJmeTF1SWty?=
 =?utf-8?B?UFdMT2c2M3h0Vk9ISUhCWUJFa1I3QUorMzRQbGhQWm1hakp1VENOS1F1azY0?=
 =?utf-8?B?WjgxaG5vLzdWUzlvR2tubDJjaDFmMXpSOGlBQThFd1JqT1FDeC9UNGxwM0R5?=
 =?utf-8?B?NGZPV0pGNGFsRUtVMFNRSHFUclpkMzMrUzAwMVg2ODg0Z0xnMXpmOW9WWlYy?=
 =?utf-8?B?cWg3OTJ3RkdNdVdzTU82ZGJOY3ZHd1Vpc2RMMC9yQTV3U09DYTNPNEJ0S2da?=
 =?utf-8?B?TkM2V0kyOHphK0hXc0dIZUdmSEZNZUIvNHdFcDhiU1ZTMU82dHduTnQ3aURp?=
 =?utf-8?B?WXZTQ3hLdWt0UHNtQW4wTG5sbzhtVC9hbys3eWtYelRTTjNHdXlhRWVHaTV5?=
 =?utf-8?B?NysxYkNCN1gweURKNzJqaFJqa1VSMVNRaEk0dVAxTnpGQnVHZHdQWjhjeWw5?=
 =?utf-8?B?dlVmS0ROc2paZUN2QzVFUVM5RXNhc2Y1dVlUQmNySzN0UXJQajdOc1ZEazZ6?=
 =?utf-8?B?WDdIem1EUE14UUNHSGF3V01ZZFIxR3lIMXYyRHdBcG1QZ2pzTEhvN3RUTWgv?=
 =?utf-8?B?b1Z3andCM3JyeHdZMDdNc0dobjVlb2JaNWR2MnpreVFGRWJOUkJaRzB2U1lE?=
 =?utf-8?B?WDVqNGE3V3E0Q2RQcHNFTm1QQWE3dGlnYnhJQm9yM3ZiYUZmZjE5SEdralYz?=
 =?utf-8?B?RVF5UWx6Q2dac0hzOEJVM3lSUmkraUI5cDZQcHRSVXREMlh6bXBNVnBIUGJU?=
 =?utf-8?B?U2hGbmhOd21WSUFTTHNoTnpIMkF5Y0pzNHFzc3N0Zm94OWh4WmxBblV3cWRG?=
 =?utf-8?B?citiRVQvWlMrdWV6dGV4ZC9pbXFQRWpiUURlNFpZNm1mZ0lCclZMUFlaUzdQ?=
 =?utf-8?B?MjBmbHpZdFlsb3FhVVFJYndMRllmZ1k2UWJBMHpoTUxuWk8rWkx1OG83YXhS?=
 =?utf-8?B?dVFBbnhod0hvVGFtYm1QeXdScllyVFBPaU5ybjcxa3VrYXcyZEk0MVRqbjFO?=
 =?utf-8?B?WXVqOVJaRWRldGJIS2hMWFp5QUJ3QlBaWklXV2p0M3ZCUDNSK20zQ2Y1V0hV?=
 =?utf-8?B?MFNPY0hWdDR2NWdLUWpGbHArSkxqU1RyU0x4OS9jcWFxejdDU3RFYkFqTnQ1?=
 =?utf-8?B?WmpwTUhud1g0VC93Q3J6MitYOUs0YnhnZ0dEWUdkSUlMTDZzaFRGQSs5Wmpy?=
 =?utf-8?B?ZWxDQ1JVNW4zRExqVTZCVkozSVkxYk13Y0NacFF0M0YzaWVJVDNEdVFGLzNn?=
 =?utf-8?B?QnhHQnlDRHEybjNJM2NCVFlnZVNsTjFXWExFU0wwQUVkWmt6VlJIemJZd2VS?=
 =?utf-8?B?MjdKL3ZYendGUXhaUXkxa21XQm5sUjgrZkVLSGZGYkFPQmY5cTd1Rmp3TkI5?=
 =?utf-8?B?RXFHTWRPRThIMVcvc3JvUThNZll6Nkp5VzR1bnlJUzNvb1lsMTBad0JSUG5i?=
 =?utf-8?B?VGZpRlNMSVBJT3JKODhzaE9ZMVp3UWNrWjViODFraWxLSzVubVJVNDRIS2Np?=
 =?utf-8?B?TXVPQjV2VXNiYVhFR2hsayswRzFiaHZzTkhoekFXR0RLTEJqb0xiTkFnaFcz?=
 =?utf-8?B?WXdKL0lwem9FSkpPL294VFBtS3NmdUgxeHJFTDRKSW5oRUdCMlF1ZmtQbHBx?=
 =?utf-8?B?bEFyWlBzQ2dEcW9sTU9wWU1FZUlkTmgrdXNPcXpHY0VacHFqUFAyZzhqSzJa?=
 =?utf-8?Q?jWiqRSimnC8D25QV3SE6qdv2E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f087702e-1357-4c27-5ca3-08de0db6b342
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 19:52:27.7680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0m6tQWCH7YhXNdQ4lZjTIXAZO461QURCst0Z0ohZpYks90I3Akm743mI//TNOOLM+UxoXjp6uEx1mSPlYqwdWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5093
X-OriginatorOrg: intel.com

On 10/7/2025 9:23 AM, Edgecombe, Rick P wrote:
> There is also an expected harmless UABI change around SIG_SEGV. For a user mode
> kernel address range access, the kernel can deliver a signal that provides the
> exception type and the address. Before it was #PF, now a #GP with no address.
> 

That's right. With LASS, the SIG_SEGV will be delivered with without any
address information to userspace. But these are illegal accesses anyway,
so it probably doesn't matter much. I'll include a note in the patch
that updates the #GP handler.

Thanks Rick, for the review tags and general thoughts on the series.

Apart from the minor change in Patch 5 (regarding CR pinning), I have
mainly gathered improvements to the commit message and code comments.

Is there any other feedback?

