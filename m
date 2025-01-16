Return-Path: <linux-efi+bounces-2649-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6093EA13D06
	for <lists+linux-efi@lfdr.de>; Thu, 16 Jan 2025 15:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D373B3AA780
	for <lists+linux-efi@lfdr.de>; Thu, 16 Jan 2025 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0980722B8AA;
	Thu, 16 Jan 2025 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ithmcj/t"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1AC22B8CB;
	Thu, 16 Jan 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039507; cv=fail; b=GpyumfJjirNvHuC6O4aOTmPIjDLzO1PiFjFZDLK/Z+8ev54CyO6/q2SyD6EyFXmf7Ni/s40+2LZAqUUs8/l5fUn1QpOoo/qcVuzUukiHobA0Ce6EIUXRepKgUsYVVxMP2iEqk0C6kkesb+cAcIOCmwf69oHNi/PPMVy0xTrkx4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039507; c=relaxed/simple;
	bh=BK6lZ6rU/D8leZS5jHi5fXz7JOE/hx9He2h4bIdaHQ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jEE6geNoHsvJeO/KpyVHJjkUtBZ1cKikDXZocEEy8r3EIDxQ4E4JN9GfherRfdTFsGhqwwtsBSomaCOByvQ1yU6E/4z0sxBw5it0Wx31YM+UT4W7NpX4nzmiyC1RFGaA6YZHDKNMlMcyAAsaqvnUR0CkCLNXGKPeqZGrCilgTLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ithmcj/t; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737039507; x=1768575507;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BK6lZ6rU/D8leZS5jHi5fXz7JOE/hx9He2h4bIdaHQ4=;
  b=ithmcj/tDcT7wu3j+dFcnYzX/y9ZoajjeJnUXjCImNeBwMCz0CoN+HeO
   tbuFfEFjYh0vMuRa7l+E2U59BEzYMRDVDP5utDUXzcnpBdN080g5wfL5U
   4XhbZgtGDJ4osfwHXXd0SmuIahupMlzZbP8+mZYIVfMSh8pjzASROEwdI
   jua3BbHXIeuAvwbMp8Hj3vXBWtS+JwvPrcwhcRRz8HSBuqnuChstRLpOj
   BnoVJ8me0YkMo7BUDxxPDtKnG8qXmNNnttDJ+hOS5WnYqrMC3wLComtx3
   4H0xacCQVlQ7X4wq/1S/xXMmvq96dZbGlyVfujTF1wa+sIY/rusgYjVtC
   Q==;
X-CSE-ConnectionGUID: cqvmHEavTQu2otxIK4SLfw==
X-CSE-MsgGUID: c7gtXKwpQHiSx54TuCZO6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37456012"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="37456012"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 06:58:26 -0800
X-CSE-ConnectionGUID: Q/p0jkcOQT6H4DiZY5Q71Q==
X-CSE-MsgGUID: a8elMEAUQ4Sxz87p3DDn9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110488422"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 06:58:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 06:58:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 06:58:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 06:58:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRfuwnoo/8fSB6vJmDKof049lyZ0UTEVFchm7zQ+1TPz/QDXCC/gPSyRu9cnsANJUo31K+xPIVgBReo2xQ7a6M5DzVczdcqj2Ofa7fOOLVRTVVzj14d/paD2y0ldt/7YE4Yrkv0MXUnHH4SB+MdVx1vF0l1hw/p8LQt4Wp9CaveEuN2ZK2YjxKewkk7IcjOhaXQlCGAb76SEUjc9oY4lPkyhWM4yYXxRinL/i2kzffITLq5q4aDXg8WqikU3xvSg1VTr8elvbjKZ/o5+P/cEiIHyHwZqS8MufLg6f+F3m+cx3Ps/hMo99fnaCEepzOYLJ/cdak3mwc/vXrl8SUjtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsw/+/kWAetOuhZteOE1t2EIXgXrJSCPkCWYm9RGi/E=;
 b=B5CNUOgqIoLR2j6GPZ6tqQguWh/1advwUQMxYz9b77qVBGO5hML0v48lg3hNOMNwUo9OCopvsJkPVcWffVKddBbxA92ayndFkoVlJAIYV8a3j4IorS6bmPnoWxdvSBRYsTDHhPNt+rIGIJ/TlaUTKhg2MPqSXgZqzEM34tjxttsXm0ncIwQ2mU/x14TdY8/0GbhpVhm7XoZAGMP51er1Dt1P88cldeW7jl+bZtarzT2WwvJo3xnD8TzEzXyYIUkmv4+MVhato20M4kuAKSa8WixDjIb7xpDzXThtDzkEUVLLvNVTLApXMyWkREQO+omVsNsLGB4y6Y5KvwA9eMTa/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6752.namprd11.prod.outlook.com (2603:10b6:806:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 14:57:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 14:57:36 +0000
Date: Thu, 16 Jan 2025 08:57:31 -0600
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
Subject: Re: [PATCH v5 4/5] acpi/ghes, cper: Recognize and cache CXL Protocol
 errors
Message-ID: <67891e5ba9b32_1be18a29417@iweiny-mobl.notmuch>
References: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250114120427.149260-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250114120427.149260-5-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d500c84-8d47-4e78-de41-08dd363e1d6b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UfSiq45xq0eAFwANrcm7EVE2mhaWQP5ZLlWW8StjUea+T7bJhN89jZg759hq?=
 =?us-ascii?Q?em4knSKL4qkZZBe70kUqXjFi6YpeiHF0L2egCFPnGe2V/GmOY6stHolGTPXB?=
 =?us-ascii?Q?J0DwOwmR/RExyRXTMKExTwvB+IBnnoJxnYxbmKM4I8AnJKfQ+twTg2rAQ2Bk?=
 =?us-ascii?Q?cZ+N9R7N0hK3UK/Lwmm/YHIJGTJJJ2osEI42dSkx2gcrpN8N/X/1G5d/DGG2?=
 =?us-ascii?Q?8ORsIXX1+j6yJ8S5BJIwO9yZsAsqbEDvxJHyWoJNQWBQhl0p/o+4PVK6uYvq?=
 =?us-ascii?Q?cHFOI+aKO7aZWVmScvDzgbwGR/OBpcuN6ZGJbiKpi9wa8Z+OWgxbf+RDVX1H?=
 =?us-ascii?Q?4otAvg/wdyZaBF1YclBl5hzmXKwZ/KG6FcCcogXnel16mgmR9nCizNoU5z3c?=
 =?us-ascii?Q?vJ86P3kffrNgekMDNIgeV2lC9QSIfghL0wMVD6z0ua8cyRa9Gqgfq0LG3QIB?=
 =?us-ascii?Q?UoT2RkpZk7uX90dg6182YUQTV8bmBbmjXVjhypDbgf35Dk4Txx+ha6S2Qbk6?=
 =?us-ascii?Q?Z8ZHoKjIwrrZubg72ialpiVpuYS9ym504fVThNZOXQD8HUyArMdaGS7yuacA?=
 =?us-ascii?Q?CjWEFlWOScLdirFIbKQbumx6bJX3YgZvXWa1tG33gTv77XetRlWMXrcUyJTc?=
 =?us-ascii?Q?b2eMywv/Q0Dzy24HfVSFd2r15tPjLOfVDHOfFkjGDDu0/IGlH84rRpkvc03Y?=
 =?us-ascii?Q?8pu1CBftVEWvbEhGgKCyIlBswKbBH3hHyZJxmz1oyfkkoNykpBls3TSoemQH?=
 =?us-ascii?Q?Ie4zcpKTtW53StaWaAo0ueg3GqicJFAW6CSMU9n2JawhkZk6hKyPRx4ZtQGc?=
 =?us-ascii?Q?zjphF55sYDxPOUW0Dxl/hcS2b5XbYiWZ1BEJilhl4KJRYAv4pLQENM03ulvv?=
 =?us-ascii?Q?+/GW3OA/iRZmdVN0WGHTFo3zcsyUoBqWLkwlzUBMEdCD3VTRo0A+RrSau5gi?=
 =?us-ascii?Q?JfKvFnCb0UvtYkpKFKpyyLRFDp523qgEdyUsoJCX766r2evlWNAHJOzZOJ6q?=
 =?us-ascii?Q?ahIjdUrZyXLBRupiL8LqpSsRPCpQmzLS5AERhnrZOI5p5C+Sn3Qm/SWWZRq0?=
 =?us-ascii?Q?92RtjscRkyvsxZxdIAfVrH6UmRNU3bb2h0MBh+rQD9jtvMYBxphKajUuuRl3?=
 =?us-ascii?Q?/jM+WCCEe3gZMftPDjFgX8VSqVbH0m2nxH+8GYN0K0AwubTkUYL9JKS+6rAm?=
 =?us-ascii?Q?UWH/riyh9f920zeJuuGgp5OWSspIij9aaVQuXvnKqHuNrTkOqAPUyibpsAR3?=
 =?us-ascii?Q?/EGlZo0AiS9PjOmSKq9oHvAQYq9hWUqZtMPSj+ucLGmUBG/qTTwfLSnEMkj9?=
 =?us-ascii?Q?CAes0GYLM5S9e4S6BdLtNvoo7f5dAla8kXGD/0IzDomk7PY43RAdsaiTC37D?=
 =?us-ascii?Q?Dx9ZogXXU4k7WvM7COB8OINi0hds?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8CE8TUtbXT+BBYGdc0Mvi3n59oiyHF9F6FTk5OGD5WUQ6YA/4REKykgfe9bj?=
 =?us-ascii?Q?C54tArbBIWu1o+rs/Kwt0YKdjm+QHg5WP3t5Y72xebM4oBgKP8baGcBQd/v4?=
 =?us-ascii?Q?Nz2++Xq7uwaVG0fprjxWANh2nk+CwiEHT9GhPLEglAXgJ+BkIr6jF0Moo/N8?=
 =?us-ascii?Q?Y7hLEJ0NZmEyCclTq6980Y0UVAoR7JdowoqXbm1hjNrX9NRGq5XZ2JTQXseR?=
 =?us-ascii?Q?iWhOHKW8wVadDtU0Z565AVotw8RyTwdMjneME7lX5BWLCsOcXS+GxviP4XVM?=
 =?us-ascii?Q?UA7AHWQwRYqRBdqUwKo5XlLC4cZVo61997lyA81gutouz032N+wLBDxYKWmp?=
 =?us-ascii?Q?4eNHw7mHuN2Oml8Lvz78WyFg58MPcMzcnlioXF5rtDW27TttTRJHxqbBJghm?=
 =?us-ascii?Q?6R+nBVfxwur/404cwVHPfdBZj33XIKrxrIBzel6LmtWas/cBDiBpWpq5Ynyk?=
 =?us-ascii?Q?HT4LTGRgk9+aHkCTHIzFKm3TrCk8mh9ZlPxk9nLtNi03G41+qfxFXoPXaWJE?=
 =?us-ascii?Q?VOR5/E/Kzb0UumCjXMAAvLCo64cFrOWTcVTpciHvCxGC4U5KK/etEFYyWW+0?=
 =?us-ascii?Q?7xr+nQgbH8qsGwKyodBD7ylbuMwg/kpnQIb0nUvqXKIaAUI9JBmG2bO1ETd2?=
 =?us-ascii?Q?ZvMZMxbDdsfbsMRolYsO2c0+QaGY/pz4dfvdryW8DcW7Q8O688OeMTl7cs/D?=
 =?us-ascii?Q?r9EAblnunPymAb1UHu7ORj3yncWjKaTS4H7FXSWRnNYbUt64IXl0hrjcGLwV?=
 =?us-ascii?Q?tKA4j72hCHrP+ENW0V/W3hl97LLB+tdCeP0tiY+cB7E5GbMZFewbyZ2bVBmY?=
 =?us-ascii?Q?j7ZpsxwkfO1+rx/8RCACGfu0AXNQc4g47DVje94fLbiTyJAVyLqL19vROAeI?=
 =?us-ascii?Q?5CDgELcfzTNqIquN8GThn94RKQdXN3dRDEQFlVlqDxMed5vjB4FNDNixloU/?=
 =?us-ascii?Q?JPYPfXHC+ESRjcFI4tGGYhbhUGkLKrskDJtChrqd74Jc29VCLbMg2sSvqIIQ?=
 =?us-ascii?Q?maV92HVmSukJjg3WSOcz51pssAfHW2u+9jAg8ke5rE5ctpPDddspbAhbKd+p?=
 =?us-ascii?Q?SIZSQUhT6w+dCDtiwxz2VX9bGuVUu+y2/nepsD8C+qSsfoq7SWo/xf21FlQ7?=
 =?us-ascii?Q?4Ig7xTVmppYk4enaNrrOzjFFWClzXPRHo77lJLEjabnlcQuT96SoVF6rOgWo?=
 =?us-ascii?Q?5p0pbbpDI+Ax99cUtjJotf/xiea8Omr419VfRJQoYyLaF7mF+u8y0512/2Ru?=
 =?us-ascii?Q?YcrguAgzQ/ZVqch6APMAqr+5z/PFwQS0svHVukCVgsExiA+c4hf8Iw50qoFU?=
 =?us-ascii?Q?r1rU03FjKWG8ZLarnV2xux9qY1IBPkYPFQ3QoicMw+A7lkWDVG0VGL3jVIj5?=
 =?us-ascii?Q?zCoftChi5nMj4ua2zLz2jcKPtKjslFQm/Srl8bKMC1MvLUuNFjnUQNY7tQlH?=
 =?us-ascii?Q?6jes2Nv8pR1gT82cWQUSZHS3HJujDyN6MhNHDd6ExwPQuC0CmBczuI/pJrct?=
 =?us-ascii?Q?5a9hIQYaQjYQVfxlSVRUfoyQz+NhULvVmxO7/ZuUg4tLYDNDV2DfOrVTQFT1?=
 =?us-ascii?Q?YzwM+xe6DNkkf2vyBdSp13PEJvkH1msAfZJ6fPM0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d500c84-8d47-4e78-de41-08dd363e1d6b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:57:36.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 010iNJslLWiEGZu4gudmkL5Z1HegMD4LijE9AZyiv13k72rmLod5tTtJnp5BduUeHARnhtl39UWhEJ703ABurg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6752
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Add support in GHES to detect and process CXL CPER Protocol errors, as
> defined in UEFI v2.10, section N.2.13.
> 
> Define struct cxl_cper_prot_err_work_data to cache CXL protocol error
> information, including RAS capabilities and severity, for further
> handling.
> 
> These cached CXL CPER records will later be processed by workqueues
> within the CXL subsystem.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewe,-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

