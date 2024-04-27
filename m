Return-Path: <linux-efi+bounces-993-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848B38B43F0
	for <lists+linux-efi@lfdr.de>; Sat, 27 Apr 2024 05:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CA01C21EDB
	for <lists+linux-efi@lfdr.de>; Sat, 27 Apr 2024 03:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F296F3BBED;
	Sat, 27 Apr 2024 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlL5odD7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76639AF4;
	Sat, 27 Apr 2024 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714188695; cv=fail; b=vB3NNjtXATrxjyydQD2FrwBMKUH5ln+lJCum+nllFPtzm81XsCJ6NCYd3I8I0OIyiu/LGfYRhgoO9eaxkReN73seP+R8cs2q1E4kOEql5k/9Xi1dTu22synIwRsJDbftLr4T1oxDCZZnLKdd4heh09Rzv0vAQlEIWiHzYzUzwR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714188695; c=relaxed/simple;
	bh=sQ1FHCC3/+mEFQg5it8Uvg4vHBk2MYjAqt8sdjdYxVg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ba3TAXe26vvf0XhdAjOAwq3sN/9fEPDZxXWcAysBpqgrdKjPAdRyp9XgzNeWNRLzfyxjJqHH7UiEMDyaxalc29PhafiP3uVxKH/Gs0amnG5VrkNuxwS2SPdbMsxrZj/zKot/aJVra3Sy5Tluzd1Kew59DYFVZ5S/NqHcY2jC9DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlL5odD7; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714188694; x=1745724694;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sQ1FHCC3/+mEFQg5it8Uvg4vHBk2MYjAqt8sdjdYxVg=;
  b=AlL5odD71TV/q6odhOups3PD5OgXriDyU5j5gK+p06JMz8VNn+GThh4w
   T3apOtAFajzYeqbgWKgWskisPB65ePRejKCgjT956MViMe2XoiVY3stbD
   /iLkSX726FhzLN1To2q1Kvew1T2O3FyTljMLGsXIBGMpcQsYoSdbgzl2/
   0sYaoycKeED3a9fEplBDC4ST1j+SXDLE5gEnzb7kJb1HV59Afv1cOhRH9
   yeycSpDJrzoogFUHqUaWzc0XdeGL/1LcZqjydwBdeo5LmhwMyBUm8NFn1
   BtgJHVWDLiXc5/geuWaBmB/U81QH4P2jKbvFV8+xjMZk3NAjszTw9DqO/
   A==;
X-CSE-ConnectionGUID: j8M8ghldTmSP3RrafQBadg==
X-CSE-MsgGUID: peAWtK4qR9ikHuDXlTNerg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10148045"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="10148045"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 20:31:33 -0700
X-CSE-ConnectionGUID: Sd3iXj0uTmyoIFuPKdCowQ==
X-CSE-MsgGUID: KHbABvCcTy+Y8WMWoya4rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="25484477"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 20:31:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 20:31:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 20:31:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 20:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wck6/q+Z+pmov/PaOAT1YeEzY/FtLArNPuIJGROlrEjSujG4lteGJEJktf4b1GIcEx4Z22YR9zKcrXiJee41Ee7P2MyGcmhjKJSxwZVy46JymhGUkw8QvwE6QtheJ3TfctwPp5A0Sz5S4/7D5H+SjNd892CZoyMN4k7aZDGsv4ABuUsW02YTbtPpWG/cOOnWm5Q7Z6fF63mmQ3NYLYeJV+KnbqhhWKkzufeiFeCG38qGGfAaOGJQoFm5aVtncJj6TSGf4+JZBYrjcs5K4NTs9ucml3KjailZcMZOvQaqBr2xGagyp5MKI3VAReFCOq3Dzw/QrKjaS01Dga19rMQn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOAaMpOb/tjqV/UF47wCC50sMZw+y1uQtowGoIqQ/no=;
 b=l47ubFZbecPl0KXoTehC5TZxT4gi2WoByVMTog9dBaIOoZNZdPK4oeMo/H4YNbSkUuNE9BCzw2t+U3yQR2uvKtlVIB7wPiHm8oW3vNQ3VyEQvf+4du8599GM+kOEsdX9BV+jFy4mmCeT21w7ElqP5+QH+pYUKe59Lexw8ygKLFAxTOvTkjpCCg8RL2rs7Nl2exV9MHiI9BEVyvB52eZGg43Xd1jbMriYLIBPaidSF5B9Jmxtysy2E155BdzysH98/r4ty9iLhyPBwRU3tldMrK3JaQiTA+NKdBlkI8ycbOmebnd5FCrjYNgDqKyIebvLgqN9M8g81Cy25Y32HMOa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7687.namprd11.prod.outlook.com (2603:10b6:930:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Sat, 27 Apr
 2024 03:31:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.030; Sat, 27 Apr 2024
 03:31:30 +0000
Date: Fri, 26 Apr 2024 20:31:26 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>
Subject: Re: [PATCH v3 1/2] acpi/ghes: Process CXL Component Events
Message-ID: <662c718e590de_15addb294d1@iweiny-mobl.notmuch>
References: <20240426-cxl-cper3-v3-0-6ade7dfc849e@intel.com>
 <20240426-cxl-cper3-v3-1-6ade7dfc849e@intel.com>
 <662c3db180909_b6e02942e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <662c3db180909_b6e02942e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3b3f89-14ed-4270-c2fb-08dc666a8747
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CKOiqlLa7fEcXv6wjVVG+CgDhk7fmEij6KwXV0KSvFWs56Ayq8AOrO0/XVEl?=
 =?us-ascii?Q?s1ETlxGYIilHBP6f0rlHYdhY546UeZUs4j0P15SbklYrewVLsO5r3MpdBTm+?=
 =?us-ascii?Q?dEgyDyG67JTRFqvtZnnM7WsnlC+BNuxfbwSgP1APRVeK5W5c67EJ2b44Wa/g?=
 =?us-ascii?Q?PCHA/UBrIk1nFTigjAnH7pBcnGoe4gJYcxTW/+LU77mT1fYJ+nmIw/lf/hoa?=
 =?us-ascii?Q?tKZCRWnTy1Wjik6xSdNbJUaEBBG2emMYneTQqHW3AY+KwOjzLdgWLCNnClhX?=
 =?us-ascii?Q?bZqoo+8rnI9W/alLbqUu8QCdrDJW0fpCbtWRqnIu0yriWYP7ZbDbuI9/LrK/?=
 =?us-ascii?Q?h0SAZdPpaaO+PJUNGT99Iwv+kbAGneada0y87nG9QrvWyV1I3Gj4kQHJ4Do1?=
 =?us-ascii?Q?Wu4qBc3thhKJEAakKbLY1rC/WEQAHPJ3VrIDpa4JDHDP51kZTbKVuSfltJ/H?=
 =?us-ascii?Q?WwgRr2zqMTulyGcaCGiTcZcnMT42slJEsRIAcZwt1+duGbdQvAvCuXoi9LJy?=
 =?us-ascii?Q?sQ6S8Lu78D3Jmm8OZxZfMcNc/Nsaa56mK5c7XvInKrW93dI/wlOD1Lp3fLeW?=
 =?us-ascii?Q?2aSjpaqrDZJwaS1GSo+hq4e0yHdzkiylPxgzWG9AEqNfqwvqbzj1BUIuQnz0?=
 =?us-ascii?Q?BZIddowCj8WIKAkj+GLlmxRwKurtlZ94MfEanWgLPEZ/TKDE1xziDkydlDaI?=
 =?us-ascii?Q?nN5q88iES6LUIQnp92p7gw2qqc1DLdMW9Qv4N8h4l+3A6Nh8z6T7NVDucWdh?=
 =?us-ascii?Q?1m45T84FI996Wen8ZKaER3BiF7Ku3nHgPe+4jtulCsfkqWAd1CXlMlhtG9QH?=
 =?us-ascii?Q?PjO/ljsK2VbIX6mrMdtDCD0eQo5ymhsWeAKmX/8BLz+r6JZtn1YKr8L+z4jl?=
 =?us-ascii?Q?79LRbspxeTtfGOcWQpgaMWoR4o/h59qqaEMBh/Lj8GUJbV7Pv0hUUfjPVA8t?=
 =?us-ascii?Q?OTL27sGqr3bwr7Mze8lfmkKKWDq4xl5i+Y9I5KcmBKC/WLOARoPFhxkP7mVd?=
 =?us-ascii?Q?5F3KoHzd8FtP5anBMT/xveXj2XnlXJHjpQYFjkb6L4rY+eyfeDMOOKg9vYrI?=
 =?us-ascii?Q?APlbCo/6Znn/JnWj6gJFuS3ZUO0hYXBz3mZDs0puqJ02wPMnbFJDAKsHCkeG?=
 =?us-ascii?Q?Zw/u1tNn+ct57eIuS8Z1GvvrWTYfVs17+p8FG9YLxD3yBnjWERIYNQcSBZh+?=
 =?us-ascii?Q?AkWNt4N/txGiQuAGzDMeeiBcxJ/ubrUCSJjbMSBuOihza/BSiWzgXB4MjMQ?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4Yh9jEdCNmNTicg69TbG/Q2B7AocKqMPsc9xPPgEZGbTg6+5adMv66K4hng?=
 =?us-ascii?Q?Rh8wRts9ZNepaM4/bSTcIx9gUm6pJc4/nlYzNFgUmuA/EbI3ApaxW4BGgroj?=
 =?us-ascii?Q?jpkPfrE1eQsRLZNk1R0bbCQlLPQjx9VUYSC+TzL17eYVeFpKJDbv4U0Obrug?=
 =?us-ascii?Q?4juA4y+nvxtY5gSLSOPJauH3nfvzNdi8IQzRenKx0b2r+pnGF/GSlmj4AfQR?=
 =?us-ascii?Q?BI5KbOLDFHrHkphWxZYWJkwEOq95fVcZe8Ndt3za5lMbPkjlxL8e99hTDw92?=
 =?us-ascii?Q?4HxFw1Sh3Ara7FXqIKDOXDcpnCoNuZEVmb0pQxWURCcz5LDTKVTkAlDgfkB0?=
 =?us-ascii?Q?Jne1TWG9CQH39PwcIXi+zvYRwpHQbS/4RIRGgvs4AnzsvZV+cFkgT8t69DPs?=
 =?us-ascii?Q?pVzrQCgvs1UgL5Mxydjbxl0UQWunksohQXtbKOC+mbrqRg7nj2d9ttKb+l95?=
 =?us-ascii?Q?QllZrbofak9ONtoXb2uY+86Ru7Kh58sWhVcdVLPH3V8+/dDGTppaukGkRjTv?=
 =?us-ascii?Q?X7pprXJZbt7D4gg/PQsdPeRtqhr9nKYQICAsF9ZvpB7T+P/7avG35Q83TotJ?=
 =?us-ascii?Q?8Jprbo4cluovZjre6nD/I8FrHV0r4vfdIttc4KEzZs+a4eC41+Xt+OiwWoOQ?=
 =?us-ascii?Q?kd0oNPhSlKzkagrIrhtxQCs4fIdF72KCSfHY68YCUx1seiGI6rcWrt6JoZE6?=
 =?us-ascii?Q?6IdQIF6I0XmLZy7mvn6anYvBKRVA5GIwcd0sr7XS5S6Zo5iqRyCVwhPulWwr?=
 =?us-ascii?Q?RW/GwYcNeE2AQ5kcfsOAVcT3htYeMCb/3zwmMsL342J5tCgiQoApKzXHRfMY?=
 =?us-ascii?Q?iTC5+g5KGLtSjL9n/vaVCa2VE1UmHb9SdTxH654GV1Rkd6QyfiUoW5yoTHyA?=
 =?us-ascii?Q?j6SflkhgACEhgXpMEy8uDnjzRe2utYRIenyobQ92P93jIIh3JS2A8olqTrD+?=
 =?us-ascii?Q?rdYv1ho+QbQN5Z86B0Bla4AlFjR2nyqMX8luR/m9QuShf/YZr7MfVOebN3hD?=
 =?us-ascii?Q?7ENbZeerSZeN3A6sHlseZOFVLCKzbxmEHj9cRx38iLdQ4Z0Aqn3U2zsJiy0o?=
 =?us-ascii?Q?Wbr35s5ccwu58bLJS3QWcjEf7mnYafva/AKgDZt+lBA3VTSVx/SsQVbykWWG?=
 =?us-ascii?Q?V+gELauWkoPQFP0zqAmRr8NMhUCk7+viHikZIh6VQ2eW2RCZ0DbkHTkHiADw?=
 =?us-ascii?Q?o5DC+tgf+JioeQbF/3/taXSG7tlhL+Bv77DKYr47baV/KvfpkcG5uFFRdbjd?=
 =?us-ascii?Q?dt0pk8e3jwLF3uOArudShi5mS49zc23AWkUgsdp12pY7Yn3P6iLkHi8047Wy?=
 =?us-ascii?Q?z8u+WjLHbQxOhca02cf2f1g2rYhGuNPBm0exco0m9NHAIay5RObjAePoWPK4?=
 =?us-ascii?Q?MavE3bAP4Wgo4N+BLfHPEOaYwY0aE5GBz5zSd5ClPzLGliIrAovUOG9jRETW?=
 =?us-ascii?Q?iDxex6d+lz08w3rvTKZO/MMpHSseoA9zzRtZLcmg2pjF37G2b/V8lOyMKaJP?=
 =?us-ascii?Q?tIwrqPM2pxz5wP09wo8dCbpIQapp5NoTz0lFfCJPJKc5g5BzZup19wyJIbN3?=
 =?us-ascii?Q?U9w72cd4JLj17AXQ+WJFmlmbWS5Q21V+nsRTyIx0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3b3f89-14ed-4270-c2fb-08dc666a8747
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 03:31:30.3641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbuEk6RJ4t9yfMxRbS7OGBDJ8SSBQhcpwgMQNVISM2Hc4AWFgLI1g6YWp22OnYZ8S5RpbEHy4HnjZ8OFjjZ41g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7687
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:

[snip]

> > 
> > [0]
> > Link: https://lore.kernel.org/all/cover.1711598777.git.alison.schofield@intel.com/
> > [1]
> > Link: https://lore.kernel.org/all/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch/
> > [2]
> > Link: https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/
> 
> Like I mentioned last time, perhaps Dave can reformat these lines on
> applying to:

Yes you did and I rushed these out today.

> 
> Link: http://lore.kernel.org/r/cover.1711598777.git.alison.schofield@intel.com [0]
> Link: http://lore.kernel.org/r/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch [1]
> Link: http://lore.kernel.org/r/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain [2]
> 
> Other than that, this looks good to me:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Wow!  B4 actually picked these up and added them for me!

I'll respin v4 is like 5 min.

Thanks for the review,
Ira

