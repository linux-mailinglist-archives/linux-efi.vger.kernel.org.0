Return-Path: <linux-efi+bounces-992-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A058B42DC
	for <lists+linux-efi@lfdr.de>; Sat, 27 Apr 2024 01:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03ECF1C22801
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 23:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231AB3BBED;
	Fri, 26 Apr 2024 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M32GEPOL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440263BBC5;
	Fri, 26 Apr 2024 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175585; cv=fail; b=snUKK4LV9wzoSZoEyhnlHDzhAWK4MDutBPMdla6+4AZiJm0HuLokTD2D1oLceZO/6+uTgeEeUP2ab5y9at1ym0x27Jgj1K4c/K55OvWnU8sUNv3sBOe7qUI2vSOdE4lJGJn4jalMWvsNmFaNLKqSEiSzyQkhiWWlL9M5ApKCbhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175585; c=relaxed/simple;
	bh=1tWtxOYdIKMeaOrcau3q63aP1QcQcnSP1mS1S9yKIDY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z2EwDo2rBDpA2gzoapl/DU/RLZRHhp53jVw2aIbsO2mDx7oTU8hKliy+InGDGxB56LzqrDoRPoL+pfdVgkn8FDdKv5ZXfHeIJLd0Qu9f0WUGP5U36tVhw380RWSfBktOgxUFH64ab3m+RbXlgQNhQC1mlbUvmQiLa/LKM1h/T+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M32GEPOL; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714175583; x=1745711583;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1tWtxOYdIKMeaOrcau3q63aP1QcQcnSP1mS1S9yKIDY=;
  b=M32GEPOLiaxKsnsFC80c4F5N49Yjb4CZDxT8sJPxKGeERnG37xYGevjZ
   SkuH6ODR0PIwihwve8UabGy6ek0xKUFgvFSVAulIZ0EqH+vZ2iLfancFX
   EoWjdso/UQScotba3/xSV3OkcoFWiLn3U3P8OXlLcqWLqmj4KI39e2rjy
   AiR74ZmoV7JNlcEY+RObLB0GUNqZvBAT61In0Cqe763f3O6qnyPes8fBa
   ZZ6hpqcgy2TpFPwRhBEoJ2W9xlPOKNvE91j6dLr0kj1CXKAh5PIEwdW3G
   lUxrNKS452OEjXCqSQMN8Bcl6eutyhgEcQGgSvwOVLs1SQ84jz7JrRuYE
   Q==;
X-CSE-ConnectionGUID: pmaJd4QCQbCes8TjqClrow==
X-CSE-MsgGUID: CvSkqIY7QxW2rUyV27Jrdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="13714945"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="13714945"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 16:53:02 -0700
X-CSE-ConnectionGUID: enb9PfHTSx23TDREOqTsWA==
X-CSE-MsgGUID: 993OJHVTQjeKJKUz6h4TpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="63044035"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 16:53:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 16:53:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 16:53:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 16:53:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYzS2P8lwuEler2hPf1yI1q8LcCtYvMirRQsX6jKxkrGAD6lQrCy2x5YHql93EBLcAZmDYFVUp9XBq2PsRX19pftZb21Nfbbgcb6cDFASJvfZ9OtIhjSlHQjbCTH0xATk4NJeDpISrc0lclR8UzDRr61BS5w8W/CGHGwOTwc5klFjpq+lpmkdsshExW3T7vAN4FNsYdQbAq15SuXrEhPHIHvR9Us3E0BwLn0IBTcLBs1Yzt2MWPr2o8D55RnLdkqv1QjLuT2sZIZsd5WMl4wkdnyDg/GFi8Oc2xcsuFpSKVyCmoehQjnfqlxolc0hCLmMMmAoBosBmG+dZMADDnYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf7Bf5PkHMzZv5tAy3Lh4BAyz58ysAzIm5cvUmV+jzo=;
 b=LBUeY14si08GxrnaSIk+p0UtpzPRQgws113h3RXyISCVE8ORzZEq9eXmYR/YM9XSO8W7NhWRI/1ezAaY6O1eAJf6uW/6sidDXn8M9iVFqmc9JJmw1LVb65WWD8sLH5Z54iMvKX2fQSp75znn/4O5yXRS+GTIk9u5IOvY1+UCWMf33buwXDHFEk3vGhfzr3Gj63yWWm9rkG7vOgf2MgSMxvhlpCJ6jW3GT1yhs/HkYUhHsauhFGlJdr3icd8rScsNbc6O1qik7uVwaQCgBQ5jrPDu6ZYrnTDj72B7OefaqkXXQhYqGiPCAqQ207wrr4bWdsKMDuQsjLky6vKZ93gCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 23:52:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Fri, 26 Apr 2024
 23:52:59 +0000
Date: Fri, 26 Apr 2024 16:52:56 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 2/2] cxl/pci: Process CPER events
Message-ID: <662c3e581f029_b6e029487@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240426-cxl-cper3-v3-0-6ade7dfc849e@intel.com>
 <20240426-cxl-cper3-v3-2-6ade7dfc849e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240426-cxl-cper3-v3-2-6ade7dfc849e@intel.com>
X-ClientProxiedBy: MW4PR04CA0318.namprd04.prod.outlook.com
 (2603:10b6:303:82::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe0554e-bd27-418e-cc6b-08dc664c008c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Alq9qQ53yYSYFLnkWXXB69x+BTazazwf/Q5RPZvknyujWnWV/0+HSJ43kf4?=
 =?us-ascii?Q?B1nCZa9K47dPAtKcZTSZUCs0DYYN7pc0OY1/r0rr7VX6RNdF7z4NGxVJzDWL?=
 =?us-ascii?Q?Pz5OueyOKi1tbCaHG/lRKCgAEebt9th5/JwRLEkPtTKVPfABdQ5ZsMXUrykU?=
 =?us-ascii?Q?/jv6I0Mme9PgangWOLtCjiucsis32ZS/hQmzllBkgglAr71zDIw/Swp4J8PM?=
 =?us-ascii?Q?3rfKHO6GzUugNsZbofVzZosgCrWF52kvc4Vh3sfY3CaBDMk+YhJkchCCb7dC?=
 =?us-ascii?Q?WB1iPRHz13Vv+61UDU8Us6vaWhjp2Bjz2MpFYLe+A2N0a8SyHnuJn0C2DEiW?=
 =?us-ascii?Q?OeUzO3jo3hKXCI3Df5PqIbSQiPWYf2YBptQUYZhYryzx2Envo3M0wlPubNz7?=
 =?us-ascii?Q?0GVfhWCKkrp9dXHHvhfW0hmToyJzlpshd2pzPNE3ODl5iMCKy/MgHt4f/dmA?=
 =?us-ascii?Q?IhOCTRVuCWUrDs70PQXeyYcMqXJ+C2VgDhJ2p6PFnZ2xw/beMdUb8BqKTnmn?=
 =?us-ascii?Q?vC59OHyLwHNhBXNjivCZFjsVqYOz/Qhn6VVtr3JDX8wWUb+IDZcKGC1mRbgR?=
 =?us-ascii?Q?v8ivoSxk9niKTP2YaRlng91OghzkE3flZDNiKonqtrzsN43dY0UR+kpVRXFG?=
 =?us-ascii?Q?2F826p251zVdlSePbEPGS0KexqrpBl24S6p8Ej+f0T5UDVNHw1DXVpRVmWTy?=
 =?us-ascii?Q?r+/7KAEEFT5/4hbsyCyl3qiTkYgu4ddl8C8FShP9A3/DoE5UMyrQ1sGlYmzQ?=
 =?us-ascii?Q?eoydxA27BplGudjdaWIeq+oMzb5Q8/DpOqvSerZ/7a91uDdA4e6s5FyoGBkC?=
 =?us-ascii?Q?5n4yPgIips602XiyuNHseAxEdU945/Kdg45Rmloy+oxoZ2ZUeccexfPP3+sj?=
 =?us-ascii?Q?+J+66YIVzwS1w0VA+ouNIDxQwh72nla4djllADKAfSB2NRsafQW/tf/hV3A1?=
 =?us-ascii?Q?QzvH8O8QtK2hl2wA50V+VxpY/ostAj0dZ8JlWjMVGYJBSuyHUnYO1CAA+5YY?=
 =?us-ascii?Q?fhztqfXNf1ZPFgM6Ppb2XlXoSIiPSx28iEkAIhFCJCjVDQytii4wC5vb+g0J?=
 =?us-ascii?Q?6KJm8dciJ5H3U4vl3xCs6E5gs/++Yzu9FJR+Bqy6PjzmfRZkP9FsoeFluIGX?=
 =?us-ascii?Q?WU1uvrJ8NbewcZxlODtO8eGGl/3C+phzRTTKhRL/JhTu4p33BhDHXtIQ4gqy?=
 =?us-ascii?Q?ob4Lc1KBsMHHKAtu1kYQA+UwNIXcHG4YgJnVQFwpDUFyqX+ONM+F4XFkIjY?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZMbAyoX1IcxvawFMhNB40789+0adH1iuSKru/IY3vmgkmYqxw54S2rBW97C?=
 =?us-ascii?Q?nqGfC4GNsWv6cHUvEOmGhY3PRcjEJ+Ufc/fltg75cNJWShTWC+zrciG5IK3W?=
 =?us-ascii?Q?zBiVhJBIFlaiEZH53fNkkivKO6I9lSP9EpkGptwTAKtfR+y7qlqGVOqX1vU2?=
 =?us-ascii?Q?g5ODUJGgM3L8wTZN0yPFfjwnHw9KCXudX65TFfdvAOMu7FnBeptP5c2pv1h9?=
 =?us-ascii?Q?XqI1CX482WAWwpwfeYlUP4yDeW8nyXw/tMGH917gk5D4x/ns5RfaH+Khn1y4?=
 =?us-ascii?Q?UwbNc+vzXZ9KLW4MdzfbyDx1Qmf1GJyUnqGK6KPRj6TEThZ4O0kzWjcMNA/t?=
 =?us-ascii?Q?eeD4M7bTzwPWojbtTB9uXu63G47lJlyQ4C42SJ3c0sUKjBc0qyHNDlvLMEpS?=
 =?us-ascii?Q?Qezc/XiOjSmAwzkBORfzZQqQL5scbKWju41ZN0v5fy7vvGpNLibB/Z5iWXZm?=
 =?us-ascii?Q?n3bD4M4sTPhln06DlqpxyWJIAK/9R8xjU8Djwq6k/hTp81RtRebjKCmM8ikm?=
 =?us-ascii?Q?w+B0RLuZf0rVQAz4cSe3PTYM3KDhOJcqtq8JiLJUQcrbWMecsIn8MIhDvbKZ?=
 =?us-ascii?Q?GoUSnIzqc1CmD1/QxGJ1brqfaRKGTqfoFkglH4po4X7xp0hgZlsMPthuT9qr?=
 =?us-ascii?Q?nMMPL+VNtt89vyNG6/dG49A1oWkvDVEoifXkfcdRpbJoHC2YUbMBoHlX6BaZ?=
 =?us-ascii?Q?pcOWnVm/lwfiVNCWESTnSWB3N3TPtttMbvIEB0s40QNzDIbj05Dp0098zcuh?=
 =?us-ascii?Q?qkJuFMvheiR3m75vlheNBSFIBxxgKbAvHQaCJY34+5/xyUkPZREuA54rJqux?=
 =?us-ascii?Q?O7b8H8YdGJ6Ug2Xa1OlPJnC66EUDYqQqIfqSYhmj2qHiIG3LyNkXrzK/t7vY?=
 =?us-ascii?Q?PeOgwaen91zjKgnCa6xRqCu48IbPfxE720vlqWMI3zq57VBVnA0v9HiLQIH9?=
 =?us-ascii?Q?tqVRHn9N2DYJ6voD87lBILEo860dUpqjuHs+PMEBBG0329DnQHHYlu031njN?=
 =?us-ascii?Q?0jfgWjv8d0MVw4LXfmo5/NQNhJhZG5MHJrcBImDOGi4nPFGUl22yZ28TImRD?=
 =?us-ascii?Q?eeYFHEEr+Lw35VjPh6JVE031PD/zZnKE9XKeFK+Z55cuXeVWJmzKijG/hHvj?=
 =?us-ascii?Q?mUNEjKeEjxRh4pSkQFZNSoFciQE5ZnvtH68K4sNEDL+P1AY07XoMi8cDKi/E?=
 =?us-ascii?Q?fn2zd+ToETK/S6KAiqaPbiwRG2lsADacEasQlhC5nbpQ/oWe+Aw1T08Ncfrs?=
 =?us-ascii?Q?Zzd3DiARf1MKm/xxj20Pf21UIu6YzsfEeGoVYF5dXfsIfnq0erALvQMdk/EU?=
 =?us-ascii?Q?PhBsSv6KZVVT22rz7tVFxE36kw+/WodmyoLsqJj7RonWrdd1odK2oPnQ2KWu?=
 =?us-ascii?Q?C62pL8OsaqUFxlqFT+ksVdas61mJuC6ahTov3judL9rhILlonfpASo0IKAKq?=
 =?us-ascii?Q?rCptW4QulPPpVNPRmbebJ6EXQPiutwcOrD9B7HZEWBnpKt7ObsvUy4icaHMa?=
 =?us-ascii?Q?7RkxUwMvzaU2ZIprwumrDIFL1l+YTRJgzKRv1UuLQ3ggpFBYyVna/HuA0GTk?=
 =?us-ascii?Q?wtAwUYzyXFmGj3dfXw3LbaBIP3Tvw/WMylo+yADPVmydV+knd9WIyPrYK1gR?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe0554e-bd27-418e-cc6b-08dc664c008c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 23:52:59.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWKOAsfFg8Xy800jGujWyJK7pjDzy3ppb8sWY7zzEP4vf3altyZo1IAIA7vCtbiFvulTPE7q3tB6u5Bj6GfClE2S1fKWeXExFAl4NjmQ1ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> If the firmware has configured CXL event support to be firmware first
> the OS will receive those events through CPER records.  The CXL layer has
> unique DPA to HPA knowledge and existing event trace parsing in
> place.[0]
> 
> Add a CXL CPER work item and register it with the GHES code to process
> CPER events.
> 
> [0]
> Link: https://lore.kernel.org/all/cover.1711598777.git.alison.schofield@intel.com/

Link: http://lore.kernel.org/r/cover.1711598777.git.alison.schofield@intel.com [0]

Otherwise, looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

