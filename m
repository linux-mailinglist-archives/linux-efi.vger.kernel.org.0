Return-Path: <linux-efi+bounces-683-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D0C86EB93
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 23:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219181F24230
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 22:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF8158ABF;
	Fri,  1 Mar 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hn2FDubB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B558AA6;
	Fri,  1 Mar 2024 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330722; cv=fail; b=qZC4M7y7idZ7VCPg/ea98NK0uehSBoJ1yQ8haL7D8r7GDGPDdN9C6XkvRALwvkPBKnzky4KUj1N15gITVyZf2ZmyMLnGD9l7nGChPdjC4IiP/SATDM6ezH6ChmPs4YLIWFSLCcgn+MsGbWAlRzuXe2veO8e4HFS27BNZCQTzNKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330722; c=relaxed/simple;
	bh=K2N+hVFGK+oRNcaZDe/C7qLg6r2Cgq90RLtz+YkDUnk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nElyFYnTIhYGZv1JjoAzLpzNSZVGrTQYbqgfVU1uDWmQ4S3/OqYJAMBh7QlLrFe7QeZYYA3zFoFUXaN2bZ0ffmK5Yl/OpW7/hSuGss2zv7uaeZdibY7fnqioKeKSU046nK23BlhwP1mORgsDiUKtV1FRJN8NlXJRxqKAviSQ+U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hn2FDubB; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709330720; x=1740866720;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K2N+hVFGK+oRNcaZDe/C7qLg6r2Cgq90RLtz+YkDUnk=;
  b=Hn2FDubBh5QQKz5+0vpBmPnhaGV5b3NGdl5HbZZ/X8EnApuSU7fK8STH
   Y8HGvkniVXAyjV8UY1fNyGM0nm/T5M5knmNCQ6iLs28aA4CVW1rez2NkV
   915yh8J/Gu98fAMFeDFv7T3P+AgsP4ehHoqHxGRSktKM2gBq1eBcS6oq6
   CK9jhkah6Xfs9xvQNqctitpkhJ4uO/bua5uh/tDhkO1lb7Ug6tSyfxlKO
   Moki9MIlORY9EGWFOR6ajjPcHaS1hvP07C1R5MceAKHqV5jqU7iolb7dT
   jZVy4rlJIVM2Vu6RTkpjr/R5jhA1J2XnvkgZq7Id58ShFs1M5Ge2Dhqgm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="29309587"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="29309587"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 14:05:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8262357"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 14:05:19 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 14:05:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 14:05:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 14:05:17 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 14:05:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihlziY75RRZbV9uzIQNIFi7sCpXoFbwY9sXeZ3AMY1s2mFEnahu6WZX4WZ8CVKOqobSI+JVv6EpF/3Pouepej486UBPedMUFSVdEhEatxhMycghyJxVTJbxvRl7xlsM6hTunEO7EuYmCmXLCIjzANNKH3dKG+yeUhtKTeDjcImlL/fYgpn9+uq4//kB83eMp6VYfs7TlbZKibpGVM+PR+crJKa0IUTAVC1FboREk045cE5+4LVDPwj3wRJbZJGiUiu88TSy+s3e7vjA2Y+WtmSErEK53/2+qlwnwVCuiMTygmHKvo54LitgJglXZzLRLt3/EM3bstW4tH3PQ04Idnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPcbxBsc7RdNlUukV/aymNDGrSwkCOQ2B6SQ0uhBcoI=;
 b=UgO3dSrX30qQVz9uqxbLqwCnY53Xa3U1Kc82szCqTL6NS8UmmtLzCVMSSx+Avm86mn1zH3Vw/tmdm8CXgHlGImejcDHDzvz5lNJGkk/D3NP5xIS4hTZ1nJ/3hLmA6bpr5WvzS/mIz5cQtsx46hQb5GlN0DYfuiAzbrzkaHObmoircduYeEpb6JdQnzNcwYHOg1+mRDfiH4Wtojl5n20c2z9d/RxLaVGsQtIchmh5IKjn5JMQiXhj4ZtSyelMO68ji9jTLkDuvJqqUpSjugoiS/XmRu2tD6BXOo3ModxtM3j+x96n17suBN+lTPavArXi1k79LaYRGGjK26tjDP9IFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Fri, 1 Mar
 2024 22:05:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7339.024; Fri, 1 Mar 2024
 22:05:15 +0000
Date: Fri, 1 Mar 2024 14:05:11 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>
Subject: Re: [PATCH 2/4] acpi/ghes: Process CXL Component Events
Message-ID: <65e2511735a41_314b3329450@iweiny-mobl.notmuch>
References: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
 <20240228-cxl-cper3-v1-2-6aa3f1343c6c@intel.com>
 <65e23fc5402c1_3651e29483@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65e23fc5402c1_3651e29483@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac88ee9-dd07-430e-b6f5-08dc3a3bac98
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vd1SjyoL15Zp7kH/1CtNmMkUrUncHViI530ZJfhHql+VqtrUfi647Hey4vRdZTylWjveBZ+Nmeiaagh2wp9JZaY7dD6yjjV4VncmFvMA6JhaDY3BSIJbVhJsdm0s7iq1fLP33mDFvRjV11DKBj2ZkUVFWPU8xwRWbYSTgtb6hIDmeFVM6PVgJuZVFigARcXtyKDvZZJdZQhj6ea2/aHOK9LmoJaU+nCB9WiAuNg7/unFfY3WguvwcT+8+G2aVfspzRQpQpCkn76VIHKYB3NgnvzVLH8J2mdHaR6Q2xhxtIHTvGdXgkj9HG0p+jGcC7PwRDCoa/cq+7elq0Ik1710PxjGuENLFLdRoWesVBSMl6dfo0tCZh1qKhIC1VZIeH6wEF9C4X4wGrfsHl4hKuXAJlUkZ5LnU9Ybz6PepygWwKu+1gpSnAhCiQ6umLmosuDTOLdous5Y76FfHFBu5rUfTlAORQY8i0LH3jRoeY7kny/XHuH9a2bIsiLrY+nHvsjzJX4lkQVayLkOR2D+HvVBn5DSExQMnSuyRkR08y/Sl9oxEJJlCK/w16udL6VTzy5iWzbvVz5/gU/nc6yuMsAJrICPB5zgd3kZVZ8BDxKjKqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bJFeoGkwK6AgvvNQWtLcwT+kHY4J+vX1BB+bOhfXKwMVF7CCFMlH6OgdPF7t?=
 =?us-ascii?Q?vS36bzgo89+ubBTjuZjXD0aRLLl7u6Txjq3QJqgncudn+9IVGhUtb6+qbetO?=
 =?us-ascii?Q?fN92m46Y4OOH3psEHSaI3MswXhTqE7ZQGZDt2gbFFFhlKZ7LQ/PmRXqmrTI0?=
 =?us-ascii?Q?bb3DEEc9fbgUn8LzZhmG9ubAP555q8feXYTk5C7CcCxtqib464cOnLtyEZwg?=
 =?us-ascii?Q?pNoX12hFy7Vwr43GUHALIe72XrtGTEpGyjNm6d0a13e73rzQ5CUX42iwe3BV?=
 =?us-ascii?Q?QJFzadSM/4YuLVWbHwitx58uESde6iOeeiMDA2r5uOlFyaGdgzMsH5IVVjNj?=
 =?us-ascii?Q?Q4HlXxyQLk3iYuDwFCawAhV5pzu2Q05+tz2T0sibTadRPeSywsV+VCaQ+omG?=
 =?us-ascii?Q?Ksin2kc+I3ThLMoFxUA285CbsMuYLecesGKyiD6TMalj3jnqqnJJtNG9/v81?=
 =?us-ascii?Q?c7F/t2NSipdXjm1CKhd4s0bBTqttnU335uijlQqrmMvdMsYAnCe5yw+i1u1l?=
 =?us-ascii?Q?gnPtP6cmm9br8FHukXLM652iBny3B8Vy2hVlklhVCkD6cUESVk75wCZ1m8Qk?=
 =?us-ascii?Q?2JrBcl9SLpgANeUJY6f6Nv+2EaJJp+HRM7TA3UuqsI4Uk0Lh7SoIvkFAgcPm?=
 =?us-ascii?Q?Pz/Lz0i6RMQeZjuIhnd4t2UmLQxCVakS00jecR1S/051zmxDsq7QshZjiu/Y?=
 =?us-ascii?Q?rBQBurjFWHx0cZk9hCrHQPZLOlvHs5LmqeYMRmo7RR1FHpun17JZBPAHfadQ?=
 =?us-ascii?Q?uLYbVOXbYY8XQTp25RTcztwp2dHU5TEpQbJ+qQqAqWPxIacdYIcx1tz1UcOZ?=
 =?us-ascii?Q?nlvRHJPVE9+b1ipUGx/GergUtut/9naJA4m3Mcr9a7h/6i86PgFpkWDEIO2p?=
 =?us-ascii?Q?ZzshtM3YHNopyjWlgMgbdxBBO5dnE4bY07e8cs2qdVErJD3OIQ1ZSXZHTky2?=
 =?us-ascii?Q?IWxljPeRRengWpcz/wDb9dXRFbXC4SFcowG8IKQ+L99mUf2IbHK2uCwgLqqo?=
 =?us-ascii?Q?zLusz0h4OiEd/CvbNrvoytT3oF4N9zVCEJtFvF0I2Tawba+fkqC2iESFiEGW?=
 =?us-ascii?Q?5cfp6i/zKq/Poa4Jp3WOGYk4xuRACulQmbQsxJFnb12tQ7VHgPue3BscUnWE?=
 =?us-ascii?Q?r+nQ3giKF4d2B3OK0UYdLk+gPJDWdWnd6N0uArkpbd8gdMzBYKaDnjP7rIFm?=
 =?us-ascii?Q?IZ5ly3liREuS0in6UMwdWst+9tjOzj4rvzlDxhMIVWpLDAB/N0DWLCX3jp9A?=
 =?us-ascii?Q?dtcrn1ZVIHOIMXZ+Ec2ce2BMk6ni/NAYDtMMTUDHYn7FaX2HvMV+EU6ocCvL?=
 =?us-ascii?Q?KUCbqoBOXbmG5vDoqNM/FaX4nJo9+DcaM7+dT/gvyDdZiKjL4GsalfYgFFsP?=
 =?us-ascii?Q?89HBHgupiXd6l+Fxt9uDeTTrPuoqChFKPPyFMfob5x53KDzau78SQYLCTC6c?=
 =?us-ascii?Q?7UvafkiB9f5QbFsiVc5S30RWzrOGkTS6Fxg0qbu1ttTWdE1wTERT86Y0NUyf?=
 =?us-ascii?Q?uYsVpLHY9tvYn/Y0Ytd+MXAqeOB/2F011VdzFuCdW8KXYW6lnBA8NGQP/qZu?=
 =?us-ascii?Q?KaPk0FQEdUyB9L5cmOCGGtF/25rhryZPntWk2PC6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac88ee9-dd07-430e-b6f5-08dc3a3bac98
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 22:05:15.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKbaHqueBYaCjq+twfkW2DOYCANBDeIGQ7aTzp7aMaj4K26AEdjtQ0KzcjC5ZTzIMNoiymdDOas7hvYOHownrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8498
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > BIOS can configure memory devices as firmware first.  This will send CXL
> > events to the firmware instead of the OS.  The firmware can then send
> > these events to the OS via UEFI.  Currently a configuration such as this
> > will trace a non standard event in the log.  Using the specific CXL
> > trace points with the additional information CXL can provide is much
                         ^^^^^^^^^^^^^^^^^^^^^^^^
			 See below.
> > more useful to users.
> > Specifically, future support can be added to CXL
> > provide the DPA to HPA mapping configured at the time of the event.
> 
> One could argue that support should have happened first and taken the
> event all the way to EDAC, so this needs to merged on faith that that
> those patches are in flight.

Sure but then you also don't get the additional information already
provided by the CXL trace points.  Reading this back I see that my use of
'Specifically' masked the fact that the CXL code already has better
support to decode these records and we want to leverage that.

> 
> > UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> > format for CXL Component Events.  The format is mostly the same as the
> > CXL Common Event Record Format.  The difference is the use of a GUID in
> > the Section Type rather than a UUID as part of the event itself.
> > 
> > Add GHES support to detect CXL CPER records and call into the CXL code
> > to process the event.
> > 
> > Multiple methods were considered for the call into the CXL code.  A
> > notifier chain was considered for the callback but the complexity did
> > not justify the use case.
> 
> Not sure what this adds. If you want to talk about alternatives and
> tradeoffs, great, but that should be a comparative analysis in support
> of the chosen direction.

I'll remove it.  This was carried from the previous versions.

> 
> > Furthermore, the CXL code is required to be called from process
> > context as it needs to take a device lock so a simple callback
> > register proved difficult.  Dan Williams suggested using 2 work items
> > as an atomic way of switching between a callback being registered and
> > not.  This allows the callback to run without any locking.[1]
> > 
> > Note that a local work item is required to dump any messages seen during
> > a race between any check done in cxl_cper_post_event() and the
> > scheduling of work.  That said, no attempt is made to stop the addition
> > of messages into the kfifo because this local work item provides a hook
> > to add a local CXL CPER trace point in a future patch.
> > 
> > This new combined patch addresses the report by Dan Carpenter[2].  Thus
> > the reported by tag.
> > 
> > [1] https://lore.kernel.org/all/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch/
> > [2] https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/
> > 
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> checkpatch will whine about a missing Closes: tag.

I know.  How about Suggested-by?  I want to give Dan credit because your
revert already closed the actual bug.


[snip]

> > +
> > +DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, 32);
> > +static DEFINE_SPINLOCK(cxl_cper_read_lock);
> > +static DEFINE_SPINLOCK(cxl_cper_write_lock);
> > +
> > +static cxl_cper_callback cper_callback;
> > +/* cb function dumps the records */
> > +static void cxl_cper_cb_fn(struct work_struct *work)
> > +{
> > +	struct cxl_cper_work_data wd;
> > +
> > +	while (kfifo_out_spinlocked(&cxl_cper_fifo, &wd, 1,
> > +			&cxl_cper_read_lock)) {
> 
> Why is this taking the lock on retrieval? The work item is
> single-threaded. The only potential contention is between
> cxl_cper_local_fn() and cxl_cper_cb_fn() collision, but that can be
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Because of this collision, Yes.

> handled by a cancel_work_sync(&cxl_local_work) on registration to pair
> with the cancel_work_sync(&cxl_cb_work) on unregistration.

Ok yea I could use cancel_work_sync().

> 
> ...but I am not sure 2 work items are needed unless some default
> processing is going to happen in the "local" case.

I thought about merging patch 3 in this one and that would make the use of
this work function more clear.

> 
> > +		cper_callback(wd.event_type, &wd.rec);
> > +	}
> > +}
> > +static DECLARE_WORK(cxl_cb_work, cxl_cper_cb_fn);
> > +
> > +static void cxl_cper_local_fn(struct work_struct *work)
> > +{
> > +	struct cxl_cper_work_data wd;
> > +
> > +	while (kfifo_out_spinlocked(&cxl_cper_fifo, &wd, 1,
> > +			&cxl_cper_read_lock)) {
> 
> This just looks like open coded / less efficient kfifo_reset_out().
> 
> > +		/* drop msg */
> 
> If the proposal is to do nothing when no callback is registered then no
> need to have have cxl_local_work at all.

Patch 4 makes use of this.

> 
> > +	}
> > +}
> > +static DECLARE_WORK(cxl_local_work, cxl_cper_local_fn);
> > +
> > +/* Pointer for atomic switch of record processing */
> > +struct work_struct *cxl_cper_work = &cxl_local_work;
> > +
> > +static void cxl_cper_post_event(enum cxl_event_type event_type,
> > +				struct cxl_cper_event_rec *rec)
> > +{
> > +	struct cxl_cper_work_data wd;
> > +
> > +	if (rec->hdr.length <= sizeof(rec->hdr) ||
> > +	    rec->hdr.length > sizeof(*rec)) {
> > +		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> > +		       rec->hdr.length);
> > +		return;
> > +	}
> > +
> > +	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> > +		pr_err(FW_WARN "CXL CPER invalid event\n");
> > +		return;
> > +	}
> > +
> > +	wd.event_type = event_type;
> > +	memcpy(&wd.rec, rec, sizeof(wd.rec));
> 
> Unfortunate to have a double copy of the record into the stack variable
> and then again into the kfifo, but I can not immediately think of a way
> around that.

Yep.  I could not either.

> 
> > +
> > +	kfifo_in_spinlocked(&cxl_cper_fifo, &wd, 1, &cxl_cper_write_lock);
> > +	schedule_work(cxl_cper_work);
> 
> I think you don't need 2 work items if you write it this way:
> 
>         spin_lock_irqsave(&cxl_cper_write_lock, flags);
>         if (cxl_cper_work) {
>                 if (kfifo_put(&cxl_cper_fifo, &wd))
>                         schedule_work(cxl_cper_work);
>                 else
>                         pr_err_ratelimited(
>                                 "buffer overflow when queuing CXL CPER record\n");
>         }
>         spin_lock_irqrestore(&cxl_cper_write_lock, flags);
> 
> ...and then take the write lock when modifying that cxl_cper_work
> pointer between NULL and non-NULL.

I'll merge patch 4 here.  Then this will be used.

Ira

