Return-Path: <linux-efi+bounces-331-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C88824753
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 18:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE282284CD1
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8924528DB4;
	Thu,  4 Jan 2024 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVtcOeM7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72AE286AD;
	Thu,  4 Jan 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704388682; x=1735924682;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cH3HkodL9PGsGg28dKubhWRYOpdfI68lLcFrFmpq5mY=;
  b=DVtcOeM7FDy7IgIAgjKyLRA5HRWD+coUlKM6RsOT/jK5iAW8ogVjA78G
   f1+NItfFx8OM/oFI8kb9bFTRJDQfTLC4jvSXKpaI8YCNlxuGFhTJ/PIDv
   jybX3MLPBEJeyfQJBxmjFJxx1kNaOYPnTBJVoh28/vIgLKgCVr0JCC2K6
   /FC9MZfyygRsT8AEYm1C7yt2JP5m7IbREkjdk7eMrdJXky7iR4yLMvJE7
   d9PQFf6SbX+sRYXOlkvHoyUs2bw76mjAFYgn+SUiZ8xkhDoVRFqw/9qwc
   t4wrCH/ANAlvc+9my2Fm6fouGpG7v6WlvDqKCDJMyawLV0HrCvVJW6Tij
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="483479639"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="483479639"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:18:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="846313110"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="846313110"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 09:18:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 09:17:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 09:17:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 09:17:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 09:17:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5PvmQ4uJaPGsna49z72X1FMjvhWafwcB6vf2Iy90wXM0VvRYDz7Vt7muWDisxEUU8oD/8MbhJXcET3RGg8jTfJDj+JvzyUq3Wi4nizYj7QYVYgiKqf5eyw7JCJazDkyhuCmzvGOAE3BGTuJXhVNYH2diSdWFFh5ZJnOX9kvDODnWfT4kx2prBkQqkHSF9BqDUVoIHH/CdfVarGGi/OklSv5VyPPj+ODN4Z64nns83EDvPEHY1v7BaelBtjtW6LHnFnIA0DT1hKQkcCKaWMPQZmDkN0NJW+PG9g91WBIsy/+MFMsKuXLoK5GdtZVpj9Rg1E3KRr2n/Nhw0W+fk3prw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/Go10zzQviITp8WLPR9dANexNsdMxzCpaPa4mtTTWE=;
 b=ecZjGp1X/ixSDQeed62ionsOVE80y9q80DJv6OSTtDacbA/dnv/AfttQtLdFd4oJZX2DjaOSdv3DDyz2TgnxLPwYd76Uel/ifNo2BB77k0C5d/HtV/Dko4xuEYVBptXfwPWfrAdkjGXd9CxAQfkuEVoz77svvmTgLG8fZzWBGA7aA0gQZC6lbNi6KQisK2J0OAsnVV+8ux8ZwqqQP38SRwpH4jlHwWuQHNlTW6OHhb5d/g1D1Ir4QgEO/e5iRnl+p2pAB7DAt6G8l+mLUWR0cmlNLdwa+XbUbuiw6dQYHy9xg+jCnAGQX5wfzz4n5MpZAndy88iu2Aa1rncY81r+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6215.namprd11.prod.outlook.com (2603:10b6:8:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 17:17:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:17:55 +0000
Date: Thu, 4 Jan 2024 09:17:42 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
	<helgaas@kernel.org>
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
Message-ID: <6596e836a783a_1587c29412@iweiny-mobl.notmuch>
References: <6595e201beb4_be7022944d@dwillia2-xfh.jf.intel.com.notmuch>
 <20240103230147.GA1800245@bhelgaas>
 <6595f9eec5986_be70229443@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6595f9eec5986_be70229443@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: b61efcf1-e6d0-4a84-0b7a-08dc0d4916e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qimJ12/hZQIQA6kDjSi/Q/6UZJPeseHeJh8xDn6O6ecKzE6+UceXAK8fuBod+eLTdvyXTSoPPi59wsRr4vgtH36G2oCwB2VcN22w4ltzTM2tZY2MswkOxCS3b6k6foqikdvuVr8o6XJecy5dFBvdOhK/FJTzGAFg0sD65yT7TDneYhexT4E3W2FD308ag567QZdC8g/sgSBmkiDyKmaNgYr/Tyu7KDo3SiUVXYU01lruIyArpOIN5qf74dkU3QApg7/uw3oMKCBgzQ2BD0suQ5iH0yUX64KO2OSBGhTxHcqFbNC8HP9LN6k1D4q4g8ppGC/SXeV5mB7INDYXVCSprzBKTkuepZVcKYgAqGHB9Cr8dsU6pjs0xoK2JNcrtqUggFVoBbXhw/i+DDR9IwzUQZE9BaXqz3Bueog2mfe//Vo24tOP/9uvyT0Lpo3HtTGTXa6RcUbjCG6U6bi2NP/K7SrvXcSMItljGxC6cfjuMK70YCyJbkPbNilB67bMKbe5pgPQVjyMDMWF+dOR0x2b69yJkFg6kyUE2g5j1xBWfwsibH18SCMS9KFiEjC3LaG3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38100700002)(66556008)(66946007)(66476007)(110136005)(54906003)(82960400001)(44832011)(83380400001)(86362001)(2906002)(26005)(41300700001)(5660300002)(7416002)(6512007)(6506007)(6666004)(9686003)(478600001)(8676002)(8936002)(6486002)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9I1KpEd932XKXqhx0bGXat+no66milJv2KINa0YSZ3v7gwJBaF585WONy7u2?=
 =?us-ascii?Q?vXvh4He+EM41ZuyWsCzxDfkk94hNmVtcCMJR0ZVy/ewSrOE2D7cWSKDUGz1E?=
 =?us-ascii?Q?NwoECXwqBNn3+njeJNb+fHXxiTlhKZJzYNbQVMtnWccpxGsVr5K3HNEeTpde?=
 =?us-ascii?Q?fzhh7OuiuXDzjU51UXS5zgMqOTCXkabziTNzNKq2cC4rGLX/M4E0eym6RgQ3?=
 =?us-ascii?Q?5cgVUuHH2manIiV3z+t0U9aXgn1k4+EaDT7FTo/MQL4H1dzIuXJ1ZmdWIFKb?=
 =?us-ascii?Q?RZ+tmFSgeRTVgH3A4uFxlK9UR7ssA+5OUdY0RYk+Sw54OaqrLGxwTFfPBfdi?=
 =?us-ascii?Q?KOMmYIsYf09ISHeXMqxP9R5QQt0C+nyEAmmGNFDgl15dlZj+/2lW9Z9hNNkQ?=
 =?us-ascii?Q?jCW1nXL+Y1G+Gj6neoz1asymU8XQ0ogPtw1j2SWU4eUpxejuR/+ZyBo3jo7f?=
 =?us-ascii?Q?dP4pZ29tJstSFiTOOwSg6qkjBkjODV1NpRHXjUz2BZrfKc5YcYLUd5bhbj/S?=
 =?us-ascii?Q?e6WxGr5uBLJpbmbzK5iYqoKGR01I/I32OVZ4FA0cu/6GwN3ehE8H/pG6kJcr?=
 =?us-ascii?Q?mPWKTDuZ6j76oCkFuwmCDKboBdNLbQ/p3Ss4eHhHesZIFNVfTCd4SbhJLdvE?=
 =?us-ascii?Q?r69VB3BC7/TVaMGfwswGLemEBx9LwsoYiOfZtbVPXuauhIKbRTn6klkCuonT?=
 =?us-ascii?Q?QXCrkduOVoxZMeVcXXRbLlsxTulR2zSDPdnxlbmkl05jXk4JhiYXg6gbECDI?=
 =?us-ascii?Q?MIf1AobLZGONxpCGJ5jCnuxZpKHL9gsMQ8QEDv56tsjNsMXRuA/ioIrQKmyn?=
 =?us-ascii?Q?aKQ9jBTGybpPSqX5RKm7FsjQPXmxdZDlnwSWKgDQDruwfPlSxNeQrIuCTr/+?=
 =?us-ascii?Q?GV8LjprWgiQ6pI/3MPUTYYgkqrckKqrjvLOIOxY5Ah5/NRCuIcDzFVPLg3kH?=
 =?us-ascii?Q?+QWDqskUG2NCSNrml+FqItX3AFEavOfW0A5AvmTmxCGsaVhgvNEUIS/aIr3O?=
 =?us-ascii?Q?hAykkG6PqPCUE7kWUZrwA1C9Z9fpBknfRunmCobv2JIESBiITyzrCIPwGMVp?=
 =?us-ascii?Q?NBUIN8R6cAcmnAzGlSJg32J0mF1UgkYFUjjmDae/IHJ08qwJ4EY+zeM2vzIZ?=
 =?us-ascii?Q?v4ClJRkO1/Y+AM2J2zkICdU08ypW9NqBLkML485OlQeepdIfoLkCD1ZFnwxH?=
 =?us-ascii?Q?ORocYqUucV/b5i0EOfgKZtS4yoFD7IETD57jq2wmCzX9UWRfN9lqDv1VTKB2?=
 =?us-ascii?Q?VJR+4RcyIBnhz+xgY3zeuOdIJuVod48T4gpVOYWQ0ONDE0d2Rz5pQ8u0T0aq?=
 =?us-ascii?Q?pEQ8J6omm93ogBJtTV//Jh6OsiI0yal+OHBe9+eItoEeqwGSAQ26/8t6VbS8?=
 =?us-ascii?Q?khXzaF64WZ4P/sdVxIchUy5YMHRsguUdeT2myFK9zgQ1PZPWTueE2YK08B18?=
 =?us-ascii?Q?QTlC6naiG0NvDYsDAQS8i9LZqNb5bnVoaA3d1MZ3bs/6t/bE8+kT9MDlKs2S?=
 =?us-ascii?Q?9r+waCw/uj6+UiGR6FfwAsvl4N5X1ga4oG6CD55Y+GW8+9UnA55CLcNTekqi?=
 =?us-ascii?Q?zqCC3sz3HUPbfImYirI8RK3/h/LtNvBNsPBddtTO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b61efcf1-e6d0-4a84-0b7a-08dc0d4916e4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:17:54.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4B+MZoMvsWq4mQKTWIh49leJ8CtDyt4HbyCGhJXMsofRDbSxMgJ4TrJeLUAl8FAJF0Su7pbTPga9M64eYDsWkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6215
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Bjorn Helgaas wrote:
> > On Wed, Jan 03, 2024 at 02:38:57PM -0800, Dan Williams wrote:
> > > Ira Weiny wrote:
> > > > Users of pci_dev_get() can benefit from a scoped based put.  Also,
> > > > locking a PCI device is often done within a single scope.
> > > > 
> > > > Define a pci_dev_put() free function and a PCI device lock guard.  These
> > > > will initially be used in new CXL event processing code but is defined
> > > > in a separate patch for others to pickup and use/backport easier.
> > > 
> > > Any heartburn if I take this through cxl.git with the rest in this
> > > series? Patch 9 has a dependency on this one.
> > 
> > No real heartburn.  I was trying to figure out what this does
> > since I'm not familiar with the "scoped based put" idea and
> > 'git grep -i "scope.*base"' wasn't much help.
> > 
> > I would kind of like the commit log to say a little more about what
> > the "scoped based put" (does that have too many past tenses in it?)
> > means and how users of pci_dev_get() will benefit.
> 
> That is completely fair, and I should have checked to make sure that the
> changelog clarified the impact of the change.

Agreed.  Apologies for the brevity.

> 
> > I don't know what "locking a PCI device is often done within a single
> > scope" is trying to tell me either.  What if it's *not* done within a
> > single scope?

I was not trying to fix that but Dan covers it below indicating that the
pointer can be returned outside the scope if needed with no_free_ptr().

> > 
> > Does this change anything for callers of pci_dev_get() and
> > pci_dev_put()?

Current callers don't need to use this.

> > 
> > Does this avoid a common programming error?  I just don't know what
> > the benefit of this is yet.

Dan covered it well below.

> > 
> > I'm sure this is really cool stuff, but there's little documentation,
> > few existing users, and I don't know what I need to look for when
> > reviewing things.
> 
> Here a is a re-write of the changelog:

FWIW

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

> 
> ---
> PCI: Introduce cleanup helpers for device reference counts and locks
> 
> The "goto error" pattern is notorious for introducing subtle resource
> leaks. Use the new cleanup.h helpers for PCI device reference counts and
> locks.
> 
> Similar to the new put_device() and device_lock() cleanup helpers,
> __free(put_device) and guard(device), define the same for PCI devices,
> __free(pci_dev_put) and guard(pci_dev).  These helpers eliminate the
> need for "goto free;" and "goto unlock;" patterns. For example, A
> 'struct pci_dev *' instance declared as:
> 
> 	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> 
> ...will automatically call pci_dev_put() if @pdev is non-NULL when @pdev
> goes out of scope (automatic variable scope). If a function wants to
> invoke pci_dev_put() on error, but return @pdev on success, it can do:
> 
> 	return no_free_ptr(pdev);
> 
> ...or:
> 
> 	return_ptr(pdev);
> 
> For potential cleanup opportunity there are 587 open-coded calls to
> pci_dev_put() in the kernel with 65 instances within 10 lines of a goto
> statement with the CXL driver threatening to add another one.
> 
> The guard() helper holds the associated lock for the remainder of the
> current scope in which it was invoked. So, for example:
> 
> 	func(...)
> 	{
> 		if (...) {
> 			...
> 			guard(pci_dev); /* pci_dev_lock() invoked here */
> 			...
> 		} /* <- implied pci_dev_unlock() triggered here */
> 	}
> 
> There are 15 invocations of pci_dev_unlock() in the kernel with 5
> instances within 10 lines of a goto statement. Again, the CXL driver is
> threatening to add another.
> 
> Introduce these helpers to preclude the addition of new more error prone
> goto put; / goto unlock; sequences. For now, these helpers are used in
> drivers/cxl/pci.c to allow ACPI error reports to be fed back into the
> CXL driver associated with the PCI device identified in the report.
> 
> ---
> 
> As for reviewing conversions that use these new helpers, one of the
> gotchas I have found is that it is easy to make a mistake if a goto
> still exists in the function after the conversion. So unless and until
> all of the resources a function acquires, that currently need a goto to
> unwind them on error, can be converted to cleanup.h based helpers it is
> best not to mix styles.
> 
> I think the function documentation in include/linux/cleanup.h does a
> decent job of explaining how to use the helpers. However, I am happy to
> suggest some updates if you think it would help.

