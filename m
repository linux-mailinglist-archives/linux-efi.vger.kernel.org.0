Return-Path: <linux-efi+bounces-309-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284998236A6
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 21:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912D51F259DE
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 20:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BAE1C696;
	Wed,  3 Jan 2024 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYerX//q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424431D52E;
	Wed,  3 Jan 2024 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704314164; x=1735850164;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=20yALfPxupwUwg/JImIjtsTMxPU3VzsbifwigbBHbM8=;
  b=BYerX//qA6P2Dxon24YT1hcFXM60tZnt3cbxI10ZHzc9BX67HRcMRgvV
   gjYEgHIF2ASJK02LO+9T95FfXf9zDi6557NHSy7w9d7vG0CLO6UVPYUcz
   mu+02mmDgYGRPDKDIGJnofz//9ZbZvdfQhBtE32+6hUwDJ4mRUBMv009P
   oTv4ydF/TsQxo79pvf5Gmwra2XmCwUrBxwSP5hoN+DpjEgkodGKEq+wIc
   mTsY/y5pNOsfQrRSS5xeQ4JkaZIyvPbBtbw/bEmmb/7ZTr6hAvqzMvWf0
   irSWHFnqxpWWptZ2kwdQVbfqGRmcqNK8S/sp9iSwJ348rYli05vyYwuoQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="483242226"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="483242226"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 12:36:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="14600725"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 12:36:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 12:36:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 12:36:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 12:36:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 12:36:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDrIEpvaQ19qsTjCaMw5s0tCnxXv+AMXzHkpz3VA/LMUmx0tKry8H5byDESCnt7Te1whfSm5lz3umse05+/uMI8xO3jZ3hkxL6HuGkZdJ6yxUF515Tfy/zKZ8/7x5FKyRaYoG85KVLSzy0FKA98f6L2wGzm+OwvX876wRUrKDTSwh+8Ci67LdcFNr5szmVP2vEtuex0Y7ezsV9vtwDW+AV7LsgmzTdaEqPrQudVIMcLTObRrA8xCLzkqs55s0UUkTHAROxwNAyB+AlqB4u9/fT5TsdJ+PtvB4UuTx8KL4wDSW4wo7mOrwy7MC9+U+qMdFoZ585PTSUw2gbwqb3s4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3jJZZplqilQAIBc27jIPN6/Gx0J5ypN9D5/VQGpQq8=;
 b=m3qZTy4MRcrsPxM/SjfFRuEoaxOQpHuB4NR3x6x4lqw0Arjk4OPmql+RO5Sg3NzwLFoIFUPf5qDdUljGm0TyFuEKeaKsfv0tnAfBLxqfO+5GJNMvUFUGuz+Q+S+wjTUUpPLVD98M7/hIVuQ7oCMkA6lhpe/fmUmRSlbUdjjWGdIRBetV+A32mP5q13FeaGxLRst6nELSwaWZGXo926LO5VCGtfR0sYK40apJgzZPOW9BISoUTp2/gRYNdIeoiG980sRlAneGWxWk/xZpJ+qgi5V52SkowYzFhIjo48c668J6roP3SAjxZtX3bKkCKT+vm22j5eB6nx7BxlVnVNCVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB5084.namprd11.prod.outlook.com (2603:10b6:806:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Wed, 3 Jan
 2024 20:35:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 20:35:55 +0000
Date: Wed, 3 Jan 2024 12:35:52 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 1/4] acpi/ghes, cxl: Create a common CXL struct to handle
 different CXL CPER records
Message-ID: <6595c5283a043_2308294bb@iweiny-mobl.notmuch>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240102150933.161009-2-Smita.KoralahalliChannabasappa@amd.com>
 <6594387015431_151dc12949a@iweiny-mobl.notmuch>
 <321f2cd2-ec64-3def-857c-61c4054f8be2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <321f2cd2-ec64-3def-857c-61c4054f8be2@amd.com>
X-ClientProxiedBy: SJ0PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB5084:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b522213-3449-4b22-7e85-08dc0c9b95ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4AYtKJ5HDLhiBp2sQ+q3TMs7K3k9P3tlrGid9MIxT++qIgTtbDObMAPlFCEF7dE4FgR+3T+BkShvaU2X3i9qhzm0CQw7aCD+TzxkRu0+hVdJTc8G/OxZLD1PtqkwY3EElJwYEUobQR1zH8NE9xQlUQnMa6Y9ZuJpTktkBA6Bpm6htxAd9DS381aRzyqEY3iV3hSdy/hEZwQfyg/KIxBlyj/saSABmLUmXmJDWz68I3VreIKUNFA/H/MpsRAq0VwEgs0QQahDrXzDMcCp7htS7tloswl3V8VKrs/4xV9IO26+WEIq7GKikCnrVEnLVJUQmtZUg2Jy7vAj2ZbDTam3x7fmUgh5VFhVEmDp9cY0GyoVWQR8ntJqriZROdGAe+OuTdubtoRpvlhgJM99F7V4jZr39BoXvqfo4fWZyOCek13aLACVmTPcMgGszLtGOG4Jts+4Tw0W8jMj6odkoWT4BI0ANcXNkyOfptmUeXPIrDUMtxBkvFlTb6DKAPqOxH2BEutkZXAMx627KcpAmSPqGtFu7I8U1cvO3th0j5ZT6mDMXhP0NWd6sDH7rKrNY7OJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66476007)(66946007)(66556008)(82960400001)(478600001)(6486002)(26005)(4326008)(110136005)(316002)(53546011)(54906003)(6666004)(9686003)(6512007)(6506007)(41300700001)(8936002)(8676002)(86362001)(44832011)(5660300002)(4744005)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZaveNLt3xqyZodd9Cujzqw/W2f4KBApfu8xENhGvdmtZ51heQoUJa1EtZSTF?=
 =?us-ascii?Q?lPb6XEHebBNY+T7iYlol/9bhCLLpyY/OgzBkRWJ1zuXyvNlrHTyejEH10aOR?=
 =?us-ascii?Q?TvTc3gOpzybrPd5SUbcLLpGTUcDHqAS8Dr3F7oQBV599I24y1FfypPQnyiWM?=
 =?us-ascii?Q?lZtQN8t3l1bxPyFPqsIVpjGl1ZhPIC33QclpSzrY5ur14MBQCq3aad+IQVtz?=
 =?us-ascii?Q?xsO5oSkC8AL+iAQUYP9p3Q2XLckVuRhhcQWxTXekSHNpxzi0KLxx5LSpUpY1?=
 =?us-ascii?Q?EIwRcpkP8OWXB3enL7sava2mNVUkRoHfxmz58AgpgkNGHG9L0uAb5daYAL4a?=
 =?us-ascii?Q?J4KtV69NmbaQl99lCUN3TzcRuhu/eUWqWb36P2k7afh34yXZAr4eXsnIwBHM?=
 =?us-ascii?Q?OTIVtRSwqmGXX/AqA56APH3lGc5sMb8RdlfTr0BDeGYAanjPILUnxXiM22EP?=
 =?us-ascii?Q?U07GlFOjtnnHPv2sYoEDYyuH7B7g6SLAQbs8PuGkYQfO6uXgt9R+gVvQyjVC?=
 =?us-ascii?Q?c7oqO+tNK6rOs6fjM+h1TPqwn0grabaa6UHqU0c6dL9s7nUQ5H8KpJ1m75fs?=
 =?us-ascii?Q?eT31Qf3LzNXNtGSzLu4tCl98VMTAbP9Ni7RXgEoIGOVcDdrxvHYheE99pyJY?=
 =?us-ascii?Q?dx24NwnvR4XeZiKBX0QgcBc1CQe6MZu3GUtpe+w/5KNFOAPsEClUmmQo83fQ?=
 =?us-ascii?Q?xcMol+aj4PSqPKzfCRntUr6b4x+lKHlzXOJTYJfiiKSi463K3bju6FzKxGFZ?=
 =?us-ascii?Q?C/W7UnX7QAvKSZRUODk6YGDY+lNuYQanzA6a2W+FnpMpIxATMTPN+3/oG1ZV?=
 =?us-ascii?Q?mm5CBkiR2x5avKHbmZPK/r2RvPy4TnMAGclObfv0DmGMb4hoJWn1yzyFv+2M?=
 =?us-ascii?Q?fWykovvC/Yq+xMVn0ZNHAVhDOJzOEOWWVZC8HNB8Xl2uBBzFIsvhcuiDJKb7?=
 =?us-ascii?Q?02xKPR/RU0eKNRGNcBKdpTRtapMPnrg+9xe24gH+9rFgYATtaTwkb2iINtr7?=
 =?us-ascii?Q?PH66C9h56CmMJrAONiYl3DWVZUGw7eGFyGNtZ7qWtiZ6ibA51MC9pP3L8k4L?=
 =?us-ascii?Q?wDI8Z/wcQyeqA52v1/oRsekOMgpuronO7YIC2FFmnOoxAbbo362pZgqqrBjW?=
 =?us-ascii?Q?bzCIwXtMx4tP/UVme0ygHCAxnxPTDJ+MGunJUKTx6eIcqgUR2c3hZbdSxOvt?=
 =?us-ascii?Q?vhpcIJksLAfNKkI4VaCsVqQEXWI2DXXXg3iISEPmo/bmApsj/tOiCa2v8uca?=
 =?us-ascii?Q?n8wuUJvFalhIsWr3WGzElhhJ6/UpKWsrymiqAGvJDaowPufLgOq3rH+gnkH5?=
 =?us-ascii?Q?eBQRQtx4PYiJ6KuoLAQj8231OMTe4qdBiHEMnVGYGYTtKvFOjtf3OrVkwg3w?=
 =?us-ascii?Q?BDSBodMbRumgEJYx3Qw5+Wrs2fozOuEjf/kY9Qb7BonHWVIMgst08IQwCEyA?=
 =?us-ascii?Q?VdmNrNkjQFZ95XgadV/jqHIQeQb88GZZOKDcJM33+Ie+Bnc9xzdyf89Eogtb?=
 =?us-ascii?Q?7eOzfIpCjnNkbGqEdR0As17ienGt7j27QNSrpyWgpAlpdXBwOX5KkltofE36?=
 =?us-ascii?Q?Fag90wuOdvp3RHDSNMbx7t7I0Mnk0o8vUbPatra1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b522213-3449-4b22-7e85-08dc0c9b95ed
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 20:35:55.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqLBub7WZAoL2EaGxvubddcTgKvvN3j2fk7RPMndBdroPdqPRHc7s8W93yo2efjz7SO6QMqQtsTaUYaFVBvNcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5084
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> On 1/2/2024 8:23 AM, Ira Weiny wrote:
> > Smita Koralahalli wrote:

[snip]

> >> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> >> index 17eadee819b6..afa71ee0437c 100644
> >> --- a/include/linux/cxl-event.h
> >> +++ b/include/linux/cxl-event.h
> >> @@ -141,8 +141,12 @@ struct cxl_cper_event_rec {
> >>   	union cxl_event event;
> >>   } __packed;
> >>   
> >> +struct cxl_cper_rec_data {
> >> +	struct cxl_cper_event_rec rec;
> > 
> > NIT: I would call this something like event to distinguish it from other
> > record data.
> 
> What do you think of the below?
> 
> struct cxl_cper_event_info {
> 	struct cxl_cper_event_rec rec;
> 	struct cxl_cper_prot_err {
> 		struct cxl_ras_capability_regs cxl_ras;
> 		int severity;
> 	} p_err;
> };
> 
> Addressed changing to sub-struct and copying the struct rather than 
> pointer comments in patch 3..

That is much better.  Thanks!
Ira

