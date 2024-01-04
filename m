Return-Path: <linux-efi+bounces-319-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4B1823994
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 01:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2941F24EEC
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 00:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9EB36B;
	Thu,  4 Jan 2024 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jx3NKAH6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650231FA4;
	Thu,  4 Jan 2024 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704327672; x=1735863672;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p9StygUA1+lXduofiqL3tKNhGzwJRt0DoulhLB99/WU=;
  b=jx3NKAH6weU1b7NtirLygw9SP8jnncS71RqkIidRopnNv9nsEr9+IG0i
   4l6tmHszrKenm0gGCYbyLeZAVg7oGpB9SmWZSUM5IJi5lHXtw2QeXvGYU
   6OiPgQiZ8AAU9C29JminUihyy9ysHr9XmpGTPWJRzgCHyaGlKD/dwOlWS
   NXnCOSXKJn3ACPAU2VK3MdntL27O8t78FRsY9YTQZyLYmAj1wZpbBM9Qv
   VYmfCuII72axPvnIbZJPaGaveukE5tGG7hrX+Scia1PACo+XLEbGCfI44
   IWzZcpHlghgacvO02+IWXXq3/46uPwYPx/CJL3MdOb7s51xQ2UcINqsXF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="387553463"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="387553463"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 16:21:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="923729863"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="923729863"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 16:21:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 16:21:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 16:21:10 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 16:21:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VN3u10NAU4TwLMwvi3XIe4pG7wzmJ9Wh6XPeHvEYHjqt9mj33QbKXOnqbZSKgb6Clmx6LPtaHX8qpdOc8b9t/3lqOXLY0az8pBsjHrmv3HqnUvXYoeTEcgxm+hznNnayAJuC46kMB0A/HMHzwloVOVZELfee/GnVOF4JM0IgG/WR27XThIq3W0tRm/AfNxLcov8wznsXz2ghX7xXdnzE/Yo3LeBYBaJsF1Zc7gwZXpRAR9qOp38tYKoYce0YCXyOYnYcxVi2+Dn3CtH8Bjhdyv9WP7nUYE4wwnU2qZKUe8q/uLr8pkl3NSuh/8tqWZaZlMNkPHyzgBqyLnV60Qg3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZUAJqwfdIja/y1ES/GqfJD4xUwe9KKJMJZD+bSbFMY=;
 b=gPJd+qGSRV9lW3zuLkb1euunQZquCqL90U5U0pQZyGCpclFstnvmIjKM62hZuJlKz7HMq3XBfNSZtp8BAYaeReGT1R/ltmm6dq/qkf9yBOHYZrDMbL0XrEAW8NOxFaMS3Qx7SqWrwfL8+IFeZyKpfx/609dGPiznl0UlxRgEOaPTQfkMQPyfeFLnfGjTa71FtmDJO5rdn91tC1/cEfZwlrRFJhk5A0y06RgxZm1RFhm287P91hQjIGXXAwq6fUFt4fMif30XwhdluSdIQUIP7cikz+qFUSbrDeVOPNPCyd4kTJvUjKilagB65hNI5HxkRAtVVrhETmd4g9ORVNG+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5436.namprd11.prod.outlook.com (2603:10b6:408:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 00:21:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 00:21:07 +0000
Date: Wed, 3 Jan 2024 16:21:02 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 8/9] PCI: Define scoped based management functions
Message-ID: <6595f9eec5986_be70229443@dwillia2-xfh.jf.intel.com.notmuch>
References: <6595e201beb4_be7022944d@dwillia2-xfh.jf.intel.com.notmuch>
 <20240103230147.GA1800245@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240103230147.GA1800245@bhelgaas>
X-ClientProxiedBy: MW4PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:303:8f::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5436:EE_
X-MS-Office365-Filtering-Correlation-Id: d70e80a6-57df-4324-08c6-08dc0cbb0b6c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLNVx1KAkScppS5H5ZE7avgGX/oHX7scjgnEqC/LWjxN8bIYVhO7/GV/zBlAeqI4Pj45C52K3NGxV4TMTlHHS7nA4BcfUKc3YryhAKpZIQ9B0Zh54uxLbvZ24EcAmC8VMaZ+1addlSP4VL537JBp5057eNMgaEBEaqcMp1i8vlqc0RLUHPx7QPelneZI49bhkZb+2zNmcm9mDGZwwexQkoDAxzQSAyNZQN+V2YcDFvmaQ2kPfcD4Q4EA5HIrr/MOm/8FUAhDEjpXG20uRyhdiOnsWgJP6dLl/vlQJVSEdm8VHLJnRVzoCMq8ibZrRLkTkCVJiSa1SQhRi/BIGx/vK/Yr0Nu31DuEd0L7XORXJer7zpF5CoaMJNxoy4uWdUy0CsFn6/DVTMQ5xvQjsWKfRc8nkkYWJ3AAXMSwc44HP/AvMrnXjvgrq9TgirmWaJEnG3iP3Eykxr2xo65f8aXXtvOdVcT19SnnvLIKyBgfZ5rwjDnZbnDu4NbadglwDBykUM/FARK8ToRq5I1gzb5Kt/FcZu25hC9CgCsxevgFq+SELXUQY5XiQKhK392dYVVh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(86362001)(82960400001)(6486002)(478600001)(6506007)(6666004)(66476007)(66556008)(110136005)(54906003)(66946007)(9686003)(6512007)(26005)(2906002)(7416002)(5660300002)(8676002)(8936002)(316002)(4326008)(38100700002)(83380400001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O8aburBUOLzBiA+FO5aVrBguM3WSpdwm0HXEDA9dvuCa70Ld1tW1HlB7My+i?=
 =?us-ascii?Q?Qny/5I162jdOeT2K/S1dmkqDKzJelPKOV/QxPpmMvy1+7ELXnsP45wph3yeT?=
 =?us-ascii?Q?jt+Y+ahGggtdYHu5xbxMlxNbWT0yQumj/Z8DH0fsFYh/WLtBUkuNCKckMyjB?=
 =?us-ascii?Q?wGjEn7AyYvNytzJKsXOQ3Bp8gdFLd27+7sTR5/eQSzyDtcRj264iwEYbbHrs?=
 =?us-ascii?Q?DjO46NAO457dKyPwiF9mq6dYxbwlRYfFVr52+63Skb8O/IzDz1LjDQ9GxTcF?=
 =?us-ascii?Q?U8CFA+3yNe1rmvmJFEI8jUqfJ/AbBi6HwvsCkfW050YOKT+PcslyemQNsz3p?=
 =?us-ascii?Q?pDpZkXAx+JFyueRd3bpyZkBDeP45/1xXUnUu0vKplMPTF2cKOEOouzu9Prbs?=
 =?us-ascii?Q?jc6oTCGpEZcbmzXhHQLF3D5vgWU3zXv/O3Mg1qsGybFGBZSZvOf5WApuktd8?=
 =?us-ascii?Q?6bbtCRGG57W0lTf6j+p6q7p2Z4UgyPih5VTYO6GAgpfwJtEbASHAxdLv7VTu?=
 =?us-ascii?Q?1QuiVaAYEheI4eTmlx9igKWEfSdVVQ5KpaQipvTi6gsCBtJZlmMUwQL9whfa?=
 =?us-ascii?Q?NqpqSc6iQjx2Vjvc72GUNk/EQiuNc9FVGA++mmbw/x7iFI7hN1Uw7LSj5Ke6?=
 =?us-ascii?Q?joyqezYklMDIUJTrfT6O90Jri37OpnCcLcFXFAapkeC6g3OP9KGytpk+hccI?=
 =?us-ascii?Q?vTm3l4lCB9k7TCJUVrtwqdkudBUBsymTD9Fg0Y9wH9srBxUJoCN2Xvu3Qh7r?=
 =?us-ascii?Q?/9F5x1qM16YeuTJrsYBANJp8csgLfbeFMo6JHyw0FaXgHdoSS3iLhlowy0tY?=
 =?us-ascii?Q?nLoVE2yK7oho39Z3BXVDl8xfj53xslLlPLMTwjc0UbVSUiLIVZJSkRZdgtb3?=
 =?us-ascii?Q?w/zG/ovAUcBbdNk8lbdImyRL+w7UlkBh9vml8CM9KeCctNG499KeXcJLLdD3?=
 =?us-ascii?Q?WTaavt1uvmz2wmfXyZJHABj9NcmyEjzgf6CGFRqB0MMGSE+pURpwxKeLxd7+?=
 =?us-ascii?Q?8MZ/9FDFZRgEymRHLB8YIhZAfl3GjfknXF2KXNo4E1dNfSnq47b1YZriwVmQ?=
 =?us-ascii?Q?GciEBzXPyL/WvAyzr97UF+Vaz8Pqbz5CMJygtyFRkZvs4qyELo0+biiSSkmM?=
 =?us-ascii?Q?somA/YBnx5Sbwy3UMWPzQfbS72n/M9fo5AEAhuUsS4GqIFJUkpIvFXC+Zu67?=
 =?us-ascii?Q?9tbIZvs5usS6VNmoy41nvjKKuk/CRt412LTo2YW40jH/1ge+E30xIUdemJKm?=
 =?us-ascii?Q?UW1yc5UTrbjKmr/IE6bK/OcO6khOjZZGMkhO8nYYZI4mchgrW2/MifXOTegr?=
 =?us-ascii?Q?GtS4/ddRMBPIp4EAZQL8V4f09jnZSFTT/NZK6oQarWs/W7L3jkPBbycMfexs?=
 =?us-ascii?Q?4TJFyELO9OZyoBvX+RYwuCB8vRXw+drfAoBoZxvt+2fPomxnEhI+eFxm5oKJ?=
 =?us-ascii?Q?F0lJf7O/HDVcRbt9CsUSA3JjYCSEfzb0nQsiR3VAexZzXMAvxJxgRGwXHoVA?=
 =?us-ascii?Q?JzzpSthw1fi5JbMgV1rKlyhSyJjR4FZRCZWlgv9Gt6FOILHXcacwJEaxifDb?=
 =?us-ascii?Q?MKMQK1r+0sqg8GzC6SE/mrl13hSNmlxwf8h9nV6+1WD+eE2rW6PkOVaJIZNb?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d70e80a6-57df-4324-08c6-08dc0cbb0b6c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 00:21:07.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4l1DgrOjlWk+A4DHobHnzNgfXV+GNFToGpcPF7bBbN0YY8zboNzZyhDFC3Pdv9W5xKSzmJ/XKqlGd5xgV/X/mgyiDy5h5ubsvG9HmcuiL0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5436
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Wed, Jan 03, 2024 at 02:38:57PM -0800, Dan Williams wrote:
> > Ira Weiny wrote:
> > > Users of pci_dev_get() can benefit from a scoped based put.  Also,
> > > locking a PCI device is often done within a single scope.
> > > 
> > > Define a pci_dev_put() free function and a PCI device lock guard.  These
> > > will initially be used in new CXL event processing code but is defined
> > > in a separate patch for others to pickup and use/backport easier.
> > 
> > Any heartburn if I take this through cxl.git with the rest in this
> > series? Patch 9 has a dependency on this one.
> 
> No real heartburn.  I was trying to figure out what this does
> since I'm not familiar with the "scoped based put" idea and
> 'git grep -i "scope.*base"' wasn't much help.
> 
> I would kind of like the commit log to say a little more about what
> the "scoped based put" (does that have too many past tenses in it?)
> means and how users of pci_dev_get() will benefit.

That is completely fair, and I should have checked to make sure that the
changelog clarified the impact of the change.

> I don't know what "locking a PCI device is often done within a single
> scope" is trying to tell me either.  What if it's *not* done within a
> single scope?
> 
> Does this change anything for callers of pci_dev_get() and
> pci_dev_put()?
> 
> Does this avoid a common programming error?  I just don't know what
> the benefit of this is yet.
> 
> I'm sure this is really cool stuff, but there's little documentation,
> few existing users, and I don't know what I need to look for when
> reviewing things.

Here a is a re-write of the changelog:

---
PCI: Introduce cleanup helpers for device reference counts and locks

The "goto error" pattern is notorious for introducing subtle resource
leaks. Use the new cleanup.h helpers for PCI device reference counts and
locks.

Similar to the new put_device() and device_lock() cleanup helpers,
__free(put_device) and guard(device), define the same for PCI devices,
__free(pci_dev_put) and guard(pci_dev).  These helpers eliminate the
need for "goto free;" and "goto unlock;" patterns. For example, A
'struct pci_dev *' instance declared as:

	struct pci_dev *pdev __free(pci_dev_put) = NULL;

...will automatically call pci_dev_put() if @pdev is non-NULL when @pdev
goes out of scope (automatic variable scope). If a function wants to
invoke pci_dev_put() on error, but return @pdev on success, it can do:

	return no_free_ptr(pdev);

...or:

	return_ptr(pdev);

For potential cleanup opportunity there are 587 open-coded calls to
pci_dev_put() in the kernel with 65 instances within 10 lines of a goto
statement with the CXL driver threatening to add another one.

The guard() helper holds the associated lock for the remainder of the
current scope in which it was invoked. So, for example:

	func(...)
	{
		if (...) {
			...
			guard(pci_dev); /* pci_dev_lock() invoked here */
			...
		} /* <- implied pci_dev_unlock() triggered here */
	}

There are 15 invocations of pci_dev_unlock() in the kernel with 5
instances within 10 lines of a goto statement. Again, the CXL driver is
threatening to add another.

Introduce these helpers to preclude the addition of new more error prone
goto put; / goto unlock; sequences. For now, these helpers are used in
drivers/cxl/pci.c to allow ACPI error reports to be fed back into the
CXL driver associated with the PCI device identified in the report.

---

As for reviewing conversions that use these new helpers, one of the
gotchas I have found is that it is easy to make a mistake if a goto
still exists in the function after the conversion. So unless and until
all of the resources a function acquires, that currently need a goto to
unwind them on error, can be converted to cleanup.h based helpers it is
best not to mix styles.

I think the function documentation in include/linux/cleanup.h does a
decent job of explaining how to use the helpers. However, I am happy to
suggest some updates if you think it would help.

