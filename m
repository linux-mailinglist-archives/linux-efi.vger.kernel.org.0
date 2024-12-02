Return-Path: <linux-efi+bounces-2247-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9EB9E0C8F
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2024 20:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D90B2A92F
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2024 18:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC281DA10A;
	Mon,  2 Dec 2024 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXnhkZJ5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDF7080E;
	Mon,  2 Dec 2024 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163349; cv=fail; b=mivv8jju/GGpegvmglHnNIoCRnBIAd4U9oauSIiQ7LrD1E+zo+5ILNi345kOYxIdAPuYhUmBYsfBRhRLQAYcPq4MoskDtERZ+qYJpaswbm1rBbQFfDhxmR8tCWRDfOhf0DdnnFYv6J27O67XIwlYt6Sr5GKhtje1grJOJO6HH9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163349; c=relaxed/simple;
	bh=E8WoL2HfVFHebJjHrsvcQ4R6c4bAAHiGl9iKybxnrCk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NQO4EHHNQxTBpc3fnnGoNNYmk223xe3yz+5WgDKki2mdXsyigLY7lPdvprI69doG+m3lbT6ZAaljSV7anzfkx6RFp+AbtHj9wmGpq4g9JGCzzMpts2UfNX4HG7cYheH2tSkkcGQoNtBuG2Q1NeQRr2bmmFb6i6l42/GLAwwMSEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXnhkZJ5; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733163348; x=1764699348;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=E8WoL2HfVFHebJjHrsvcQ4R6c4bAAHiGl9iKybxnrCk=;
  b=GXnhkZJ5ebVbXyoZgcQFlzDyY4oirWtkBiU4WdzPq5cUgeCrBUBf6lTR
   /Qz8uwez5ahxf5ynoAoMebAMWLyVPkhvEXk3jKmjsJdEs7rEOOLKSV5xt
   4jrLZrQNnzcoFGhgABGWbSNK41CbuNP5O69lioBHhsheAATO0e/tZwQyr
   P5gaYapn1uoQ8lscCDdbL9AirOeADirxCxRyqYCEXy+UTwEa1y8ETdt4M
   1YPB6WNhAbBOefEYvIQGMPesUcaigfXTjcuWzFX5yg9t6f+JuG2FS/rpl
   2tyV7COQ/LLLpPR5U3TsxhxEUD+Xfld0Tnp1LnYZA32aMliEis5R1V70f
   g==;
X-CSE-ConnectionGUID: rwzaDJxQQLW+p+14FhVdkA==
X-CSE-MsgGUID: MFrv1sRySyeNIBT4Koyk5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33592760"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33592760"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 10:15:47 -0800
X-CSE-ConnectionGUID: 8pBUqIwxTnSYB1dVgUtSuA==
X-CSE-MsgGUID: 9Mzf0ibyRta8iVJ3jLsBUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="124114482"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 10:15:47 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 10:15:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 10:15:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 10:15:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ombqMpKGkHHUPYHEQvxLteDORNpFqKhK+lQ81NPrBwr34v+/ybOUejGardMs1ZQky22c1kdGXD+afHuENdD8jzmihaZikeyywo2kram6jYGILNwlTeQCiKy3g8usmaRvLVtJuXPNeKMwmn/hQMjegMr3t6nPDYnorR7VEc4oDia15r100XKs3WGYWxcu9Ia2+XX1wvaGklQqoZWspU9GlsZ2bEjb0jhKnZ0/8lJ73M23XnaRcJ0I+Zx6RYjFP0dtnAvMG/rscAV/KpTqVo8btyXxbfTHD902gcmPsp1KQV0wTINForjHgK+6WTQSdaJwokAkBWW4n/qyhjO2P+9ENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzF/nZEIRmSD9dzerTFOOsensjItU8dctXV7EECXrLg=;
 b=T7z9iy1WuoPmu0r84UCyiqJYO+iuZfICpkH8BmMxbxRfneGhyOQ6GDv1lG6n4AigWydsTirdbk2EnUmNnydRFGNqHXdHWNew40sbc6jeLPw3TQEy/2q2bauWWZ/o5itZwurpLheybZbOssIajIWqvNbJO71WKWavbp0B7fI3XFTNZKmQnhtfsTBrE/kFw61wcl8Y00Xlv33FG04utTVgqU8m7ddSCOQOrTbHjWIhiVKxeSwPzaaMQNiGl9KDAAjnPXi4pFhAOD/iCMbyRLr1V8WwVJoKJhcszrm+4pn5xnEvZqefBPKUb7F8Vs6RLoHWnrrHU9metM+pExyYWAtWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Mon, 2 Dec
 2024 18:15:43 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8207.010; Mon, 2 Dec 2024
 18:15:43 +0000
Date: Mon, 2 Dec 2024 12:15:38 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v3 2/7] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <674df94a247a9_3cb8e02942c@iweiny-mobl.notmuch>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241119003915.174386-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119003915.174386-3-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR04CA0364.namprd04.prod.outlook.com
 (2603:10b6:303:81::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: f112d376-a908-4c0d-97e4-08dd12fd5589
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nYZF2J7Li2Dfiin4bm5W7qTNB9SYXpA4tnqp8QDAfJ/9dyRd+For7KL6goAu?=
 =?us-ascii?Q?gwT/2n8Cv//R7SnwVXaN4aCEaYgQChKWy/zy2PjbT2coVMiuocDDKRv+jqIv?=
 =?us-ascii?Q?eRMzXlnTkB+Ax99wEgXkadS3G3E/qGb+W8ycR69lXGsBB2UdJASTL8rdvDf1?=
 =?us-ascii?Q?807B6quB+nfL4oOLA8ZztBzdfMRv3XndG1ilF/B0XA1RzI2pK9ng7+DuMLEW?=
 =?us-ascii?Q?KOz5e25tOa4vET5Os9jgHEHrShbQhKFgLlQdPYBW9SOQAFoO0yN+BxlghG1i?=
 =?us-ascii?Q?WD8b2Ld8kqcbopo+/3sdGUKPHk8dvnYdQ2/55S623b+ZhFV+4LJcuBhTzhSO?=
 =?us-ascii?Q?ge0Zeod+ZxYlebBYyjHNbaPvEUiCAOHDbhnEbAJdRyg2ls9SiWFpP5e2GA7a?=
 =?us-ascii?Q?wf7hqqRAFGl1Z2ne7mJ/aR2+nMTtNg/+17HDGgqLCirZCzaZgY4BSK70aHfm?=
 =?us-ascii?Q?LkfDrYRwHHgOOSTk86HP4EUk3SEVJ9O3sNlfdfrhNkYWvlDL57u7UWpuu3v/?=
 =?us-ascii?Q?fK57RxD9XL0N4MMO6wT7dLPwFOyNtg/hSBcEaoH9HS6glmq7JoXhHQBGdC+g?=
 =?us-ascii?Q?wFZpB0c534l0Rpq8GCk0FMigS+7hSL5uakfwlRPoqNEfN4s0GOfVjA5OJvPE?=
 =?us-ascii?Q?c6ukRSujMiVFUXh5V8Qmc0ARwv2qXwYlsm2vIpwSEPvKMi82qasj0rL10+Oc?=
 =?us-ascii?Q?iS+VJLPYiBLdtsTyUurrTPJb46IGhc/1nOFTz0idBMAn536LuRk+xpfG4aqM?=
 =?us-ascii?Q?upagv9RfVgBFT2DvQzpBrItU89aFT9DGd5u6wf7Ppndvl92s7iYaPzYQGH0r?=
 =?us-ascii?Q?sf2kxEsfD4lRhOYWSR8OJC2xiWK29BTaKv7g7EoBK992sSaWniUA86HRI77F?=
 =?us-ascii?Q?qBFLc7JwUMMGqltY4eBMYu5SOT4lHaJW8tmpbKXrWLcl7TDXbc2/EdhppWSI?=
 =?us-ascii?Q?vz6YQKUE1jjS3H8qHuwFSc6Y4lvK98eG9jqy0l1VxBGVytRX7tPS/XcCY354?=
 =?us-ascii?Q?pnvDnETr+jVUneQSmUtupB8HpPKu63ADfYTKxuZl5s75aFKCSziBrt2SZBkq?=
 =?us-ascii?Q?Oz4FeUPbzKcR+gNwzHuTpWcIzR4bz6i8qaREUKA7F1jkpr1Y+l5O23JMzJiJ?=
 =?us-ascii?Q?Z7dvgKQF9NMHMAP9KmB7VUZ5d+ZsYyA9FkqtrIQb4FPp1qMbZ05PgW57FkTz?=
 =?us-ascii?Q?/kMQasb8ucy4HCKNhVpZXsDg1iBDTLwIINdkO/ViaHk8bEbDLAs0MYMkZLpu?=
 =?us-ascii?Q?oofHOtktRJM9hYNPPx50s0ArF9LUiwCTJLAQu1UjgKoD7N/Nal77hsV5q/fl?=
 =?us-ascii?Q?s7rze979cSbzsiB1xUCu6RNMpOW6bWKph/ypYOFulpfkKQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WvpeirG+ZahRDUhx3tb+nTscv8aUAFBTdMTAHNGcxreRYCZpQ1yJCMpELTs5?=
 =?us-ascii?Q?1YPZnjj3g6sy3MaArKKhqppwruWlKFUzucxDNIgOCcaPxB9HgaQy1vfFlyKv?=
 =?us-ascii?Q?eE46gDt8RYJQCEAg26y1VTh6eyoTNet8sYfbCjrVZHvt3YEQG1vnPtSjpbHl?=
 =?us-ascii?Q?2Rk5BPapBenLxA0L/18cQ+2UOO+pPM+FKQIg8JFwFf/6wpyAeY0/W/Lv/6dw?=
 =?us-ascii?Q?58+OynTkeC0Pu8rsuYLo5ncaJ/xDVO2f8Tx6uUZx5AoeJN+bPAt5JZYYYj+h?=
 =?us-ascii?Q?RCTJ30jvegn3xix7wu9kNyauYb2/JlDfSb7EqA25an29EYrUYx4tylEl3yIw?=
 =?us-ascii?Q?f0w5Ka0pi/KUU50FyPY5ya51+3yAKEGXxcBVXKHY0o/mtQcnjft6wA/AEBpu?=
 =?us-ascii?Q?emeO49uMRBxvg3WqE7+W028PEIiXGd8vFjrZNfMoBMWcuIYGeOJc3XRAE4K/?=
 =?us-ascii?Q?ZX11mLUy7SAAZ69Rh41/lW2Sn+Ay/Sjf0JbONbUyTViZU3EgNr59Hcm0UmMw?=
 =?us-ascii?Q?j5qqkuYCaWKf7sRAD47cS/8PYcCHDj3J0FxH1faNGgUSqaZOAxQnaD8UMyLD?=
 =?us-ascii?Q?y3dZ0uJ6XHLRr0BTmJHuCI+LJxCR+383/vQwGfw1wANJXPA5QIfw2Puwys3X?=
 =?us-ascii?Q?yndAQoZcnxmQOlbQg2wHs0zCbKJ9iFlYnQRBqD3lYKVnq2ccE9IxdgICSdDQ?=
 =?us-ascii?Q?zgHQKzbhIRRnydlxV+j/F0iFyJKWy3mJc9cOhYDWAKXh+HicOX2unvHfVahx?=
 =?us-ascii?Q?1rm3h2TH0SU7HjyNLHvBztuQF7M5f0qsKv0Q+fKmHOTVwDOKWavKNwbI5yIT?=
 =?us-ascii?Q?m6ARXaeL/W8R9t3va3yjFZycK3L7TUh8+EMIADuHjtAexFM3FJOeKKpnMsc8?=
 =?us-ascii?Q?4xRfbMeizx0pjC+4SHbvcfaYOD+cNOojm7Cxh2V3mL95JHeCDVwFIW5Q5cjP?=
 =?us-ascii?Q?OPMGAiIsFbSs999vt6wrMqfQWU5YTvysUiqq6Y2+Ca1i0XvW+GyeMfxgagIV?=
 =?us-ascii?Q?a3PISAGJti7JApX6CUiWY2ZdWQ+5r0Impd1zZGjk9s24EeqTOTb8LTtP5344?=
 =?us-ascii?Q?vMHe5yzUbzuCGWzNfMfqwZpQARDWrQv6qI4tCYJ7WyP66luAVEOC+3WmUObs?=
 =?us-ascii?Q?N7s04JQHZHnKPWdm6K/9jglo/bA1sYNlI+YcgUFv8mrjRp9OHK+wlaQKiBnt?=
 =?us-ascii?Q?0IemO7pasMBEF8qrGOUm9Y9Aw77eVTi73P7w62nNvNlCkhZuHaMfCY1PW8yN?=
 =?us-ascii?Q?SM27qZK9NLyr3CUE/mwtn6zaP9BCtKiEZhqjJ1NthO9FYdGqhbU0MgffkLa9?=
 =?us-ascii?Q?mP9Ap8gNo2Ah5kVzAM1oJyUK4+2a5Uea8a+aPoYoJWeO1n06ADDnQ++6Wm/w?=
 =?us-ascii?Q?QxdjhQr77AdCEegXROjuUyso81rd+Un3iFdQFE7htp/fF5eLN9cF4T76aKIp?=
 =?us-ascii?Q?kYpBEYtVUfTREYpNvDid/bh9snDjJscx5ShK/offuaPy+m7pT+m3XjVY0JM0?=
 =?us-ascii?Q?/hU8l6wLDgZqKIxipnfbgvNICZUNtdcULl6asqlns+S1dRVYW9T03GWJLNrE?=
 =?us-ascii?Q?ae13TeyXD+yQUweJ2xNdnlYWMKG+npUqKC63Uwrh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f112d376-a908-4c0d-97e4-08dd12fd5589
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:15:42.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLP7bHJWSUlu1MoENs9Gaf7V7Byw6cATEd1HFbopD6xVMe0KZIGWNEr2j1eD2GfFB9Q1KofCgSgg3ZobDYfsEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5912
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> In preparation to add tracepoint support, move protocol error UUID
> definition to a common location, Also, make struct CXL RAS capability,
> cxl_cper_sec_prot_err and CPER validation flags global for use across
> different modules.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

After seeing patch 3.  :-D

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

