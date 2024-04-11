Return-Path: <linux-efi+bounces-936-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319588A04D6
	for <lists+linux-efi@lfdr.de>; Thu, 11 Apr 2024 02:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5571E1C228EF
	for <lists+linux-efi@lfdr.de>; Thu, 11 Apr 2024 00:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB76FD0;
	Thu, 11 Apr 2024 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCvB+UdC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C917F3;
	Thu, 11 Apr 2024 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712795810; cv=fail; b=EOGyC+/U+AGwyYE8Z6mMCnc9bmD7MeFnLBBdLKUTTjq7C+bu71Fb/KQNfhQw8XPcxWkFLgDGGchJkGUAfGLShNW0gC1G5WW+Zkpcu64Bxo7Ry2dlErC8fgPEqnxisHY7GZfF4xxn4dZcLIM4VvlKe1ck0IcLaPbzo03D6ONGoyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712795810; c=relaxed/simple;
	bh=qOXq0msocJHzC05tH0ZhexUIdzcMzuM5L7lgOCuk5Xw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GgZWPRAVD3HrYiZ65IHwov9X7C/uk5VCfweuBJxQa5T0TCkR0F9Zjm3zyvLHWC3aN+/je7nXzb9tYcKfnDNc/4C0EO4MDs7XveplswuBD5zDGS/NUtr534fc3hk8JAmhFhaWj9ZI9uYIMiwCOV9PAyLmAJWzqifq1C9AhKC46vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCvB+UdC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712795808; x=1744331808;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qOXq0msocJHzC05tH0ZhexUIdzcMzuM5L7lgOCuk5Xw=;
  b=oCvB+UdCBvFC0xkUrep/dCHEdsc8V46Kb8JS+dP29O8emVm2/Swa3dfc
   R2Lce5UcYDlTV5+AeOlaHVqvuw6qeqdQ9Ei7SrqxtcxSWHE3GWkH+wJLW
   5jpWziJbwxXSNlEA9WvPT9DE2ZTj3PwkhLDAE0HXF0NHiSm7ptyDKb1vf
   1jpV7r9unXVIq4eqI6hovxRCkI6FWXBEb+6dAzUjagvLSHSlyz8khJnuo
   WLB/XrCqnph6SBQc1M0nYlJDf4+AlBZeSSQpLEi2jvW/nzsu4VGdW6Ckd
   tBoziPny4hHiSIOKFESkRfJa8PJnq2bNx8LFu4ApesYrDDNJyO+kmBRb+
   w==;
X-CSE-ConnectionGUID: MbSC3n+sR/G6jHPm6iH7KQ==
X-CSE-MsgGUID: FFsLaxUURci124OnIIFidw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8050037"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8050037"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 17:36:47 -0700
X-CSE-ConnectionGUID: UWekP76yRTGNQzAP4iz9FQ==
X-CSE-MsgGUID: FQdx2nnzQym8TITn588uLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="51931442"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 17:36:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 17:36:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 17:36:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 17:36:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqsOV1vOWpJICwNEWF23xjG03oCQ9Mfoc3QH809YuTsEMURlj2CwzjCHq3bo3qBtZ6dJqOu/9FpzoMQwf72uLWz2Huv5SfeVWMoTtzzomnmrvehz8orRNtaXLr5Ofl+nSAgzO+216vJn3hpZBaOGia2Pj4C7yZwAgjhxZvXHzzfp2+YFUyL7SbEFGcc+Uw64loYaJ7nm4O1xR7Pi3duWtXB7sh+3I5hY13fpzZuVNo+2fqGHKFN6fbjqHdT6S4EONDyQ8KD8lYZYuOczSGV+PES/jQmgF4FD4SnqNaErJ0/acAph7rT9RfNVOXtuVULSZb0JrmlMIEPiecZ3jiKSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0EIR/fop6dgAViv6wAhuAyBqF8Nui8mOtXe4jgJ3Y0=;
 b=T2UDHC7MhbtFvxZrVM0GOu/4d4JeqnpmJmxUk4x1SXEvv9tLz9v619Zz6o4yzsLqz4e9kz4XQhPdaPQrvgx0ujrkmJ2Ozqzvv1z2y2ZgdSSV+suIaN313AuzbQs5bu1B7iicMBX7fkRYjZqtV001yVy5SxhbDw/DVX7m0njxNEszdCbRqd476qNiPmb7j3lKf8qzRrfzE6zgjxoRT+Xzz/3gnBWDSnwzobN+32MVKrTyL7FVJc0nYexM89Nta9C9c+roVSAzj/qilA3usUmWcbximqVwvqJDFM6KuYAK6R6X/3SBFkLhDyRjVweM9/8wJGx0XTQCbZ3+g/kCy+/4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CO1PR11MB4817.namprd11.prod.outlook.com (2603:10b6:303:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.26; Thu, 11 Apr 2024 00:36:45 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 00:36:45 +0000
Date: Thu, 11 Apr 2024 08:36:37 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: <linux-efi@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Chao Gao
	<chao.gao@intel.com>, <linux-kernel@vger.kernel.org>, "Hossain, Md Iqbal"
	<md.iqbal.hossain@intel.com>
Subject: Re: [PATCH] efi/unaccepted: touch soft lockup during memory accept
Message-ID: <ZhcwlY+W54aTe1d8@chenyu5-mobl2>
References: <20240410102301.634677-1-yu.c.chen@intel.com>
 <btc6xpiw3kvo4tj6a7cn7uahvcvge7g3jqkutrwmlnuz6g55lr@fu3lsytwhfpy>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <btc6xpiw3kvo4tj6a7cn7uahvcvge7g3jqkutrwmlnuz6g55lr@fu3lsytwhfpy>
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CO1PR11MB4817:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /L6VOkeS8aBgRF5iWbQxeQyLsO0zHQpNwETy7/BlT5cZh2mX6k33hTrgebXOOLia8t3I4cOt3tV12k8QjhdMq33kiFJaJB1fBn5tfVsRHTLv0VrZzd4PWVV663x3gb3Z3hl4y9TiCPH5+hc7AwBMUrBOl97HbbnDgmQrZirFhm3/0ttXoTTKkIE/lvaS2+ZKrS1QJIa27kyfNWGxG3gUtmbxV2r9ZcyKf+xK6Lm/fL8vAr3ZEb60D58qP7C2NId2jfeeO3eIerYa+5gqXODgRtJHmaK3Kbbs6sgCygfzFvmY4cL+7//BUxRtNq3chV6FcgYBEQyXzqcJYxOd2RL+RB/D90AuNbpiPJ0hTL0n5STl49uPbUC16yRFeTJz7hN1eQVSQoB1+SoImom3NoS88w1hE8XUOBUjE57jyf5RqOY8NpzDeciCMxI5mj+A/i1+UDYzCYC0crvI1vsvqoj6ZRR+tWk6Gcs+QWNXF2quO8tTNOgRZU7DLuMOSsF/uVMh4F0osdZ8ZtZbxheEDcbqTL2ZTPX9HQJLhnvEIYqIpxyLTlOV3DfXK+dpmRi7gvtdOb1UpQOriKSbIUhGAhf7ror0D/ZjvivnR+CdsIVAMFadYh6A2rsSNTVtmBgm4CsxO0ZcVai+e6z2aYl9G0ozv72P5lxz1H5ZnuJk3LNQhSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lYR0BydquNlii+r3BGuwkNH6x7suhzI8EAdpjGpQpBSOIYSWh7QchZU7pbDE?=
 =?us-ascii?Q?oEXrmTfXo0ukCTIQsQG6urZwfjfI7SBH2e6xHfrsQ4OOoiGMyoCql+zCh+y1?=
 =?us-ascii?Q?1TbaKSdnybqes/1qWHRxgq6zAmlNHVfBeNszPr+Bf1oGwnGD5HuEfAQjXujB?=
 =?us-ascii?Q?t6UMfX5pHLtb78UiGZWnEi5+1VawLgu+AzF3Qg4HQu9p7oesZwot25yBZV1U?=
 =?us-ascii?Q?qpt/DuIhPTL/zn+n27LCQCT4WHtsuaHmouTQDUolUdJNWmCKS2vhlpB4FhPi?=
 =?us-ascii?Q?dBTfAi35OLGKHOEQnGfiUM6G+JXjUphjDoMfTyUDo+MgsX2Tjl2Sm/cCHkzp?=
 =?us-ascii?Q?ULM15NoJK7I9fHAdkRH14vlLkYv6WkSB9AimOg8LJGKENClzBrfOPVOeZ+TZ?=
 =?us-ascii?Q?dwwz0ELRquT67aruuED8RWaFQItbgWZMimxZqqlaZhmUbbCSe4BhGPuV9ZhV?=
 =?us-ascii?Q?zxbfSAX4BR1Jl7Ytfxq6sZI/IKiKwt/B9i4xg/BLDE7TfZeDVsH3Ad8CR0z7?=
 =?us-ascii?Q?YwKKSXqxAiXSin6rupDEXHOYn9myaFMNMSs68N20G0INFtJ+o/hSLw/+vC/y?=
 =?us-ascii?Q?OJ+Yxk9DGhNUnQ/yaHN+T1EoHBd36jrTEwJgA4Yl10/awo9rLiIbE4GJ5a5f?=
 =?us-ascii?Q?EGDWFymgsKa6asnnygwxH+7PPaupnzacpEsTcFNj/KdL6eYh5WXKEOwARZp4?=
 =?us-ascii?Q?Ilnc1WE4hkTxLj7FHUzM0igjzh1SFDRCeog1wlL+mLfcL9efIcUpAF8+3s96?=
 =?us-ascii?Q?aOj8gBQk8PJYBPUzYBXrjqRLQLZHW+HaAsZVuTyFoM9oqWoHPFYfpVGCTU4Y?=
 =?us-ascii?Q?NJ4okaYtcWcPHOz39cHcvuZSVIYNdxsf8fBmLwyDd37Axu3ccpZRhcS+l3KZ?=
 =?us-ascii?Q?KobalDidkkIYw9mnFylZZYYUGp/bqOSqQ1coVJFCsLZyWxq/GlBbBN+pRXAU?=
 =?us-ascii?Q?trtSRbO0gkJe/+/lVJrSuln8PGK8bV8C8fvmvAi6JJWz6ZqK1VLq6ZYfVDNE?=
 =?us-ascii?Q?ij9pC4CnJdo8tdr57lAmaRF9Ozuo/Xb7fHOuEWGuUZkspGDSKjJpUm5TiJc+?=
 =?us-ascii?Q?JwYupMK3c44M5H4ujaXmAvKsn1JkLol40GQsXhGnERX+o5dhsCVjzaZQsmXC?=
 =?us-ascii?Q?zgUT96xXhiIhL+M2z2LJmTt6OY+iJ4d+igrFHvXJhcbit1DroapGPoP1y2Ot?=
 =?us-ascii?Q?VylgfkhWpFNUw4kELE3Lwb9eJokfYwRIK7YNaUjY7Yymn6nWFLQT6ONcjc1A?=
 =?us-ascii?Q?hbgQnc+VbM4UZpyeaAeRQPgWV39A8GaNhi6r9H042XCR4daG9wDI0lmLVOU2?=
 =?us-ascii?Q?VJu/TPxl2qYC6PrTaxQf5RvcY1R7eir5JAmNCAqNS4PKksvruhJbFLZZcB/p?=
 =?us-ascii?Q?FBOap+FymaDjQEW/hmjirFz/1ElkLVpLmNDlfSkCztq985Q1Tw2mjLuH3Fe7?=
 =?us-ascii?Q?jRf0neDq63bfaqVfJiLZvDXxkwYVCJQPlKFLmIIEOlKRAfqlSFCtkOR4N1K0?=
 =?us-ascii?Q?khKNCjk0KT9GTd77xHGd10jwFU1Kk8fLO3gIFLXMiVXpX5HvKPCZ+2oAEMlY?=
 =?us-ascii?Q?GkRLOadnlupIJ8d+oESpkYhJ41hi02Kb7SaTO1JA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13873b8a-7207-4ab9-f3b2-08dc59bf7714
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:36:45.3231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRUzG5O4dwwfoSeHLYR9tw+yep/R/EQ0d00Pv8A+sFYdolt5h2mofvYJZgAtvNlMQVscdkeiu6ltxt6yXTyvkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4817
X-OriginatorOrg: intel.com

On 2024-04-10 at 15:35:39 +0300, Kirill A. Shutemov wrote:
> On Wed, Apr 10, 2024 at 06:23:01PM +0800, Chen Yu wrote:
> > Commit 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused
> > by parallel memory acceptance") has released the spinlock so
> > other CPUs can do memory acceptance in parallel and not
> > triggers softlockup on other CPUs.
> > 
> > However the softlock up was intermittent shown up if the memory
> > of the TD guest is large, and the timeout of softlockup is set
> > to 1 second:
> > 
> >  RIP: 0010:_raw_spin_unlock_irqrestore
> >  Call Trace:
> >  ? __hrtimer_run_queues
> >  <IRQ>
> >  ? hrtimer_interrupt
> >  ? watchdog_timer_fn
> >  ? __sysvec_apic_timer_interrupt
> >  ? __pfx_watchdog_timer_fn
> >  ? sysvec_apic_timer_interrupt
> >  </IRQ>
> >  ? __hrtimer_run_queues
> >  <TASK>
> >  ? hrtimer_interrupt
> >  ? asm_sysvec_apic_timer_interrupt
> >  ? _raw_spin_unlock_irqrestore
> >  ? __sysvec_apic_timer_interrupt
> >  ? sysvec_apic_timer_interrupt
> >  accept_memory
> >  try_to_accept_memory
> >  do_huge_pmd_anonymous_page
> >  get_page_from_freelist
> >  __handle_mm_fault
> >  __alloc_pages
> >  __folio_alloc
> >  ? __tdx_hypercall
> >  handle_mm_fault
> >  vma_alloc_folio
> >  do_user_addr_fault
> >  do_huge_pmd_anonymous_page
> >  exc_page_fault
> >  ? __do_huge_pmd_anonymous_page
> >  asm_exc_page_fault
> >  __handle_mm_fault
> 
> Stacktrace doesn't add much value here. Just drop it.
>

OK, will do.
 
> > When the local irq is enabled at the end of accept_memory(),
> > the softlockup detects that the watchdog on single CPU has
> > not been fed for a while. That is to say, even other CPUs
> > will not be blocked by spinlock, the current CPU might be
> > stunk with local irq disabled for a while, which hurts not
> > only nmi watchdog but also softlockup.
> > 
> > Chao Gao pointed out that the memory accept could be time
> > costly and there was similar report before. Thus to avoid
> > any softlocup detection during this stage, give the
> > softlockup a flag to skip the timeout check at the end of
> > accept_memory(), by invoking touch_softlockup_watchdog().
> > 
> > Reported-by: "Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> And I think it is justified to add Fixes tag:
> 
> Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
>

OK, I'll refine the patch and send v2, thanks!


thanks,Chenyu

