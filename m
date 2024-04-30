Return-Path: <linux-efi+bounces-1006-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3688B801B
	for <lists+linux-efi@lfdr.de>; Tue, 30 Apr 2024 20:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E73828165C
	for <lists+linux-efi@lfdr.de>; Tue, 30 Apr 2024 18:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2425190667;
	Tue, 30 Apr 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ND6jEKVi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB017BB25;
	Tue, 30 Apr 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503065; cv=fail; b=FN23Ro5YrbZmv5WaRfAU+PwNrqFtOuEIRIMz1vdJZDofDVLPR7tw9wxTXSoAc5uYQVwLJawpa05Y6etFY2i0+xj691wSvpxza4GjX9mU+Tm37XPDNfWnrazqaZh7swz6WQrw/1aca0/PNEkzldVkAzSuQtp5DrwYpdJzpD2AoKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503065; c=relaxed/simple;
	bh=jaJESIVXn225X3sH0qR6zp8R4c0/rky0LjYkP/DGiPU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pS7lFduAQ2JAlwqLjZI8ZOMc7qBP2tT1XFNEvKZLVBCJrEvqjnrvqpwP2Ru3L4oLD2luoJzA5nXy2letWSMmbnPLjqeTPA8W4c5i4vaUtZU+UHWpAtJtpzwcf2ZP96rP1NYb39H59zmbTjAqhrSmyddxUkPBKwPi29YSY9WyOng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ND6jEKVi; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714503064; x=1746039064;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jaJESIVXn225X3sH0qR6zp8R4c0/rky0LjYkP/DGiPU=;
  b=ND6jEKViF3PZjekV/pvc5QoOy1isyxbRB4Peqk1RHedBXyvvv1f6w9Co
   coKNAOtJKNoTDAZiGkmlmQplp+vye+u9/mgWhR7ytUjJnwdesi6nTYg/i
   LcV3Z99X3QG3MtL+vnwg/dOMS419uXD3tiDeKaxJMIStZ0mn1DXN3ETkX
   jrUeXeoA49t7Kb0ujB8p7P8D4XISASe6YUl9RVbclc1bniqi9yEMHfsJg
   UwXsXyh+eT9uQB4AgPJEzbkfdvgD3vAb5zUt4w96W0b4g4bVqJK5eXQgk
   qYdEh/uf9CgYeewUTjWFllMJbGtDXw1pn1bpAuMdlKmse3NoXPN3z0HzL
   w==;
X-CSE-ConnectionGUID: ciwJOHSbSrOsJPUAP13ivQ==
X-CSE-MsgGUID: dg7NcQQYSMGwLYAAzaWbyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10390485"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10390485"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:51:03 -0700
X-CSE-ConnectionGUID: a4wA2vbETYOTWw2Q/yt85g==
X-CSE-MsgGUID: ehQWplCzTpi1PcDsc4tDPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26646489"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 11:51:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 11:51:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 11:51:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 11:50:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLBDF4KfVAkAz9Co+113Pk326c7jrhL43sqAl5Obn3p5xVSTZOmX2NV5FN0TfguooVcZLS2uIGC84hGrV0NQt/IB1rvOaALMRzorxyeyTksr9k6JmO5BRLNzlQI456CyDR+6h1kdcR9BKOGInZBWHosMxkHgriw+toTceBfwU5TaAVBXl7l+tI1mQmCrvvotUbli07/QOLVB7OF9fYIoQt5Q4G8BGLzLjrKUK1S3YB2jqQAMIUufuin1Dls2VectXZRnnIPI87Dtcz1kKrHHAN7lJeIQZ45rfDhkjFTczECbhQxsC8qPoLGTc8CXZshWEIvcIV0RiB/rU2dUPRxgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4K1SH3UN2L9k854j6abzOIFXdJQXZKyp05UGFr0e4g=;
 b=Kfyb3GRPIdVY/69Hy35BBdSxRAQF2hbE0DRYn27ypfL1A2qKrvv+mwjqarDmcUUVPnyBO+UdAmQfEhG+fA1IOgC6OVTu0eWHZSRdIDX2reYWTmaXDymfGeAkgBrVpulMZhHFB8aIa8b3JNlBHc908UYkAOMQIKROGkExSsEX2rkJH5LN126JRZ2BqWCAh8B1RVeD3MJoxcaHusyGowPFCAvbVMayCTQB9JBAeg1+MvGqKKs3NDeGsyjaJ3hQgL9GesIXaNtMDc4GH6cVhZ1eTyqgeFHAqZ6VVoWU7TdHWCmgp05B1hOiNvMtegjEcu5WnWea+MrI8naK5n1cGWD7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4520.namprd11.prod.outlook.com (2603:10b6:208:265::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 18:50:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 18:50:51 +0000
Date: Tue, 30 Apr 2024 11:50:46 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Tony Luck <tony.luck@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose
	<shiju.jose@huawei.com>, Dan Carpenter <dan.carpenter@linaro.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	"Alison Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 1/2] acpi/ghes: Process CXL Component Events
Message-ID: <66313d869fff9_1c68422945a@iweiny-mobl.notmuch>
References: <20240426-cxl-cper3-v4-0-58076cce1624@intel.com>
 <20240426-cxl-cper3-v4-1-58076cce1624@intel.com>
 <ZjE5O87IxxMAoaFz@agluck-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZjE5O87IxxMAoaFz@agluck-desk3>
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d91210-c05e-4362-a42a-08dc694674dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OGcMhdFu/I3nNuHisaprkiav4Vjx+eQ1oLDvFC7NhY1JY2SsFwOnwKL3h/6X?=
 =?us-ascii?Q?h4Slv7iAyqIIXNYLhWIDoDYjxFzLjL3H6BGCu/VS2/vvI7DSBhsBYv6by3jI?=
 =?us-ascii?Q?85NiVExZGYKOmvnZoR6BOVKkn66m2byl2EHzK6QUen3g0CGaFs2wkDKMvUMs?=
 =?us-ascii?Q?lFySbbttgLbf0FigX5IIZZZCT0KMV3vo2RmJXgOgnWu54e7LHuvpKOu5ZtND?=
 =?us-ascii?Q?mIqe+8dFZneYP6ETPKw0Hb520J6obxPAKxhQSY3VPdkINigCYkfMrY6tJlq5?=
 =?us-ascii?Q?8KM6QZkXWOzMIxGJK4KlbM4u+M7NtZ+5Qb7NUEgmKDxY13ESRwCkbP5QGJuk?=
 =?us-ascii?Q?LDzubJdV46rJn4mmGwOQToXtsUcvI+2+UKCl2FxNilkOaC/N5BhEz8AwD+ti?=
 =?us-ascii?Q?g0dbOw/71BqIFhyIzJXh4J0/to3JhpmDmak+WgPEOqmNTyBd/zNE8zgxtHuP?=
 =?us-ascii?Q?WD1C09J15l1aw6EvNGLzpFkBpVYXLMUN54leLFWecfMsPPgmm5TYEq2xmcUX?=
 =?us-ascii?Q?JW3EZhljNeXIqh2J5QgGvjZZ9o8b6LYjNvBv+6io9OoFPfupgDleH9x7XOdx?=
 =?us-ascii?Q?g9VIC6+/ENtxkWPBvdQlrp6LGLzPPInVoHbXe80f6VxLLfspMVT+P0L01mnF?=
 =?us-ascii?Q?zv/ob3xGgmazUnvQ7U6uYzo4SWdEhsar/5IVa5nJTJx/GVtrvC71eEYyMV/2?=
 =?us-ascii?Q?eEsp0wd5Hg0R7hMaaVv5hiyYZnmx0iTKo1W++a15THe6DhR771y7HrMyyvII?=
 =?us-ascii?Q?46ze4q2IjDeoEOXiPAJMkLkPXhHgj8tRAMzyFW2dEto6JXosBEpID+VILQLx?=
 =?us-ascii?Q?Bn8r4TCnop8zIdwfsFUVqMYPkmWIQ6k4R8mXF/LGdcOpB1GXHzITuiVsCOqi?=
 =?us-ascii?Q?ZdQB9Q9Dir4ubXSckaEJHI1vzftE6Yx7ZNl3AtncjANRK7c/kKPkajyCHtf0?=
 =?us-ascii?Q?rxK2fB/fkQ8oyLfpwYJ10EcZwjvGXbcwPxuuV8L/0dOPpTtG2DzsmcdNaXQj?=
 =?us-ascii?Q?91fL0jR0Iu+EZfSprT5IWOyYt/hPpyJeVnynPlsGA87kIjdryoFIguj1VeYK?=
 =?us-ascii?Q?FGyNhA/MPbI+qTTrXDPwAO8dGeEB6vT64peWZpg2n/8drrCjIB6JP3nGBFnC?=
 =?us-ascii?Q?7oA13upE/zgUYn52gp4k6Np69G05soA6jMk2Ns5V9hayzs5Q6vmeSkRewvsL?=
 =?us-ascii?Q?NWrVR3OPwKu5wu3ItDGcRUzeYtSw/dAoR2GLFQf4QC5nWE1kqgersQigaUO0?=
 =?us-ascii?Q?M+wV3xbsKaP2EIIWivOXNeKQIrHQtJLH1wn27/33qg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HOHyX3D5LJB84D0JnUSkN8kMiYWOhPaFrkm5f+JqJNw2iqwwt9DIXE18Cc/q?=
 =?us-ascii?Q?G3fDqyRwY1GFyo+8kQMf0uXw8HqdbBO2Ji6x9z6H8JbDxZNRW++6cjVXj9ud?=
 =?us-ascii?Q?ChbKL0nTByYtAGK6S3bUcwDCPHADeGQg+0Dh2s2TvAs0t0k0SuT4Md1aYIUV?=
 =?us-ascii?Q?+q05QXF3q5E2Pfa28/zsWHN3m59h1DI9/tXUS9VAP0+W2aK0/oCLbo7YbKci?=
 =?us-ascii?Q?qyb6y7SosLo05cnfVC7kGy4i6Sr/jcaA4f3luehXDhp+xIEhpm+TCEflFwbE?=
 =?us-ascii?Q?YwQ/7471CDl+7ngikFHeuYM4oQ91aMeOoQuUhU5bK5kkPMbiHSmTaTx++1P2?=
 =?us-ascii?Q?dMCL59aFRxmMEjEBirFKDzyp3hyY0eKkZud9fjg6RkBQBo5zPPijNQ8sl7tw?=
 =?us-ascii?Q?3n4qrPt8jMiuoPrzp4giF8kP/Re7BEuv3esJPuSrAsrLvdDfovHtja5BmRTJ?=
 =?us-ascii?Q?XzukceiqJh33XutDeZA9WVnwwKnmspZ79SEOZHns006sLnWrMptb20GgSdll?=
 =?us-ascii?Q?tMETGcsWzDpyGOPl2kUlSw+fKZxbuURZ1T5yJYyd4N9hygt4ge+dV5CAXVnj?=
 =?us-ascii?Q?3pO6aMoaTqv9eY9E/Zt3MlnRjnvckJf8Md8DAGxQ7y0JvtzrYBI9cAAF+jGv?=
 =?us-ascii?Q?ntrQ+tlnkiBi37odl56pDnp/hpgqNpKruTEN+ouqwXfiMiVPtEeb5xNkLf1w?=
 =?us-ascii?Q?uqZcHFM6kBT/90C0tVI1R2+S7NgoMOjGx+5v5V5jnA+iSA+t2k0VACd7qsev?=
 =?us-ascii?Q?0INYxjMCqoxF4C0qJBNX+XIksFghTKtq1eV7tNqZlgdE3bBtmZ/9v00LPMGf?=
 =?us-ascii?Q?a4jdFKEgFRLbw7UzB5lkZbwUusjS2NBSRK6BMvIObPdFwDkxJBSPOl/7c1IM?=
 =?us-ascii?Q?4QFTTYiI4rtkd8oEJcQ2/aD9NiiQgbt10Sl5/j09CdXDaNuF7JySgnEdFD41?=
 =?us-ascii?Q?woqrOg9Fu5NSSvPXanlHYQoSGw44gVJQKJRnxCBZ1HBRc2XsA5UzeEJycchu?=
 =?us-ascii?Q?FffCR/D8619zQP/NG7oQNDKfwDKB+kLH35dLmy1J0f1KWOa4qz/KsDXGhL5Z?=
 =?us-ascii?Q?IpIVK8LxpUpREAzkfNCTsE4/lyLvdd2uoANJ8IqG9yv7xptlKhkCeBQ7zxBj?=
 =?us-ascii?Q?lG2/sNLf5fFYC6xmVl7yFBsqYmkKhnQYwtIkyAqfSEo6k2Gx3Cp7/37tite/?=
 =?us-ascii?Q?jlAdvi9ArJeiZqBsEWc3zNZZY3rswrC5fM2lkt3Eaxp4uZAIVWeOskC0FGUg?=
 =?us-ascii?Q?GnAotIgwaUCy8XICoRw7+akBSgzBnZcSeBpeb3D7PpPYOQ0/bJes/BZceUkg?=
 =?us-ascii?Q?a5ij3PJHj8G52imrQElQiGNLrghnHSreo5hHyIOpJ7R8zdvXhvwfBG28VIQy?=
 =?us-ascii?Q?xapUjs7/b1YOy9c0ceF2QKu+cRcjGOknopbRWeTzpuiRMjEji1E4CHpTTsJh?=
 =?us-ascii?Q?FEB0ivFHCS7rrk3xMGA+ehGB4tuv92+MlU9ywuBombuF6vWn0SuuPmUcxgMP?=
 =?us-ascii?Q?tBXH/rnINVjbUdaYmSlGLWWCFFNbJH2JkuSZJIK66Bv6+yUv+tRVpvbNOUqA?=
 =?us-ascii?Q?kHzNXyoXnjw80SUQmEc41iNtn/XRP+VBxijFOMGB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d91210-c05e-4362-a42a-08dc694674dc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 18:50:51.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAAr+owm9Y33WmJyfqs+fPvrnsaDwDfIfBf8g0eo2II1olEHHP4Pkkvkg2m+odNSEDGyHb6eEcn0QeYo2zJ85Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4520
X-OriginatorOrg: intel.com

Tony Luck wrote:
> On Fri, Apr 26, 2024 at 08:34:00PM -0700, Ira Weiny wrote:
> > @@ -707,6 +805,18 @@ static bool ghes_do_proc(struct ghes *ghes,
> >  		}
> >  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
> >  			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
> > +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
> > +			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> > +
> > +			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
> > +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
> > +			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> > +
> > +			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
> > +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
> > +			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> > +
> > +			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
> >  		} else {
> >  			void *err = acpi_hest_get_payload(gdata);
> 
> You pass "rec" to cxl_cper_post_event() in all these cases for later
> processing in context where you can sleep to get locks. But that's
> just a pointer somewhere into the "gdata" error record received from
> BIOS.
> 
> What's the lifetime of that record?
>

The lifetime is contained to the cxl_cper_post_envent() which does not
block.  The kfifo_put() copies the data to a cxl specific record to be
used by the CXL thread for processing.

>
> Can it be re-used/overwritten
> before that other kernel thread gets around to looking at it?

Yes because the CXL kernel thread has its own copy in the kfifo.

Ira

