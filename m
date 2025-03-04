Return-Path: <linux-efi+bounces-2877-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B11A4EAB2
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 19:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE60F4231AE
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 18:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D568E27E1DE;
	Tue,  4 Mar 2025 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5h2maXD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816DD2080D0;
	Tue,  4 Mar 2025 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110273; cv=fail; b=sFAPDxb5x9plPk9F8+wRa3LClRYdEUn7E5JmS3KXtTCGC4ihERhWaDaHorLgMkDvIPaLy4H3SCer7TZH3QiH5zbUAP9vD+ZFIfoOcfcgzStaO4ain3AiBQSRyisPIcNCtUARqVkoGwrNj2EPkCEBkAUaEB49IMe0aWKBN6beKQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110273; c=relaxed/simple;
	bh=yTY1AYoEwiGpWPYT0PUMzf29m0h44ctINpYmvjiiqgE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rV0hETEJLPjkhnecs4lnz4wToRN6HgxCUK9b+sXgSkz8y3mf1oV5yV5IPldNt6lKm1oivQwNkDH+ssVO7PnZZGDL00ZBHN67EsZME/aY0M1FDZ34VON0uKVymOLKCJmvntYfAFwq18nlmNYSpLOOTDxu7zP1cTMBU5pxsBRpe+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5h2maXD; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741110272; x=1772646272;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yTY1AYoEwiGpWPYT0PUMzf29m0h44ctINpYmvjiiqgE=;
  b=e5h2maXD1Zu2r5BaWzfrJOrztHP6D62c22bV2QCIaG0sYR4lyKht9cC3
   8AP8bMygXYjMKjgabMjb3rEHAuW5RiaJCQA515L7pEmymAnkz38kGchv7
   E4UaexvT8L0hyB1Ah8P84z5IfmSMFpTom/FaCD/O6Ag79qaNCVRHfOTf4
   oqZ0RMJ9QJ98APAbZlBHESILmtauAZ6NrRmtTLqR/Gx3fJjuGj5Iuw/Mk
   fnqLd6HBRpkoHD1brMtwe/BuhVoCEHrTikMaI3nuCuCi4p5QyZGKerKmk
   QI+T82dYZaB4HzCjREP8IeomvKCqM6+MUDmhqASfistsMpTCLcfUQchGB
   A==;
X-CSE-ConnectionGUID: OBzwc6xbT3m6EDUJbw+9XA==
X-CSE-MsgGUID: 84g6ViOATSS96uNVitxwdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45819363"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="45819363"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:44:28 -0800
X-CSE-ConnectionGUID: ufAuMecSRPuSHfd2vPgeOQ==
X-CSE-MsgGUID: KcL1apJ7TOK9ZRb+2a0aXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118336874"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 09:44:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 09:44:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 09:44:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 09:44:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6kmXdW3fwajQahVAk1iYkilfs3V559BgO3VOWDPjkcXLeJ5U1eX864K0Sov/0P5NFU8nNJBlpN/dGdFmtSIdcVfiBlXITH6nQ7exf3LTQj5h9JJSvkSk885bUxHhwbqMj3gVYWW0Yy5M8tJX3/HZtzORCXP6cDZbjYPTpoS28D+1IoZcOsQbUtgVqhuiRW9a7TPmhRTMSrIpvz0a0PBk20ipjFGABZiyGPnx3Kh1bnRft9rNS0RI4uqR267NLeJqrLgeb4ZJW+lXAK/6NoAlbkLyXptO4qitJZK6J7n0UocI5tWxvFYoI6kUnw9ATASKnET8Qsg3aTOgg0+nB7SoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ho5FQp99uiMQcSVV/vXSEpao+UDyq+9Lu90A0J0gYhI=;
 b=a7rgC/WrJy5lGlgAj41CuF5kvgiVPhbnbY4avXM/V3n4PvC+2NCXZZ1ZlcVU4T4hEmF/EV3tE3foMlvGcRHH2dw2b6qYnNWREPOp9BHxKqfHH7CQ1pdkqzEkbQQbnnMoxbAlnr9B99Bm7yJfye32eg0Dy6SSXm0E1d1KfQeb4Krwp1pMbNmfs4CY952dKaRegqSAFEQUK4LxvDoP2fI31PCCdKvlPWapxxvrDlXiZ0KiAopE1YQvwmGBSpZrv44n+T/z//UFcwFytdbtyPwxCDdMtyWwadBad3369DN5hnhSsSdxK9u9wqwzHHgfCbourjFIe37SlFoaanhhu8NEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 17:44:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 17:44:24 +0000
Date: Tue, 4 Mar 2025 11:44:31 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Alejandro Lucero Palau <alucerop@amd.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v7 1/2] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <67c73bff37ef7_f1e0294a@iweiny-mobl.notmuch>
References: <20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250226221157.149406-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226221157.149406-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:303:dd::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: a7836d32-28ef-4a5d-64c8-08dd5b4433e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cL6+T61rmixRE2mUn4qP42yVQPl4jvxkW22EmH2V9zPMC6ZV67FeFZMaQU4X?=
 =?us-ascii?Q?TOEq+0iVipMuRJW8ZtCmMzjQPX9HtRppipLRd3IkT2gH+GVL7jsu6CR7twWK?=
 =?us-ascii?Q?+YfGGUzVAMvpJhCbzN46T6sOWpiO68edDGqYePgYqVU9P2Pg/61R8gUf3tjw?=
 =?us-ascii?Q?hr/v/6PDl3tk1qKnU1vxhnFQcHn//62twcuWseN0nrl4GleF5ABQsI4gE6My?=
 =?us-ascii?Q?GfeZXb9xTS8E6Sx/D2BiDFyvYNuQNhoa+L7I6wv9/q1L8eBdgut1cKBqsIMe?=
 =?us-ascii?Q?7BUTOj/4G7Ykh1AP5U24cm4QN2YI+dsCL7tkchTGDczHx5Dem9A8d3fpk4l9?=
 =?us-ascii?Q?SkPPKogSf6z7DG5o0DzSEPOLxVHXz8zCg3bFPDNIki3jyNdZlB5ljEi4Lzqy?=
 =?us-ascii?Q?q8b154Xa6e/KVpkxvvcYThF7Y0qAX08BnSOtGEgeL6fp8ZBHQWgArO/Fjf1X?=
 =?us-ascii?Q?8RK9/jn8A5g2b5KGVt4tXx+1+gW0312lvodnX9QLp9tNukHAqd05XpzF6oKF?=
 =?us-ascii?Q?zD81leVZkCynTKnvHaaWn5ObwMNgcMb9Dyh0hTOj0B0MxverMpQ4crpC78ab?=
 =?us-ascii?Q?YDGCZ7Z7AqOp5RGtXrwx2tzeMocUUNHXIn277E0vdqOce+gY51p0Wiy7Fxba?=
 =?us-ascii?Q?3bfBw1JtkB4BPEg8PMo+Vxi3dz9Eh7s6+BVRoHDXs2QBQOf12RO3Z04DiI+x?=
 =?us-ascii?Q?jn8xMm+scsSdYFjcWFEG3KW53oyjlba/pmYDrfckW6GTUi6Mzy1KZimrmZZf?=
 =?us-ascii?Q?ohWUDjjXPgBKVlHhff8kLEXk36uLaFJpHdh65Sgs4eGLiiRLHERAr8/CJ8IN?=
 =?us-ascii?Q?9eETkQOCrV8uwK79c1cSCw8VKk1To+jqiMOfuP/i3LWCPNl2AqWI9JD9OUMy?=
 =?us-ascii?Q?BK/18fndqEXVPXEuFn4tu8lcUNHxtPsvz7ysXKErtLI9lH85fcfQgI1JhE9/?=
 =?us-ascii?Q?2NLkmmjBR1iB864KBG4W9tbSD2MxYeyyRMqKA9Dy5CpD9k/gZriJt2BmVnNY?=
 =?us-ascii?Q?xX6C64vpLddgm1qYWgF6VTdaSk6j50NQRgjyheNX0Gh5l5xv+EneqjfnxvQ6?=
 =?us-ascii?Q?o8J8pV6yP43OOiBp9fvkHirgBbTTIoQAaumOAqmDChHe3UXk2c9ivfNM5C+9?=
 =?us-ascii?Q?hcwpAVUiWZLR3AK5+JnCzOAp/Sk35JZPo/lJTwzGN/Ifuv2SmRlPp4U1x2cP?=
 =?us-ascii?Q?whIKfvw2VH7JfYbiKTyfBBKPhZk9xn+biXz1LA4N6qYOtLHJ3in2bkgvYSjG?=
 =?us-ascii?Q?Cg4NI9EyptITEe1NHRJc5BWQ+36LspllOms+fRRNypWF9XiH3uLw1P1LtYSx?=
 =?us-ascii?Q?tUg5+qlvV+KMS5fn1g/XhuyEIE1WD33biWU2iMY/KDPsE5JV7eyate8Qz4kU?=
 =?us-ascii?Q?b5C82re9z41RVl8N2SGoYv530UZr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GFmi3L/Gi5lgBIdN9vuScAGWNzGq/iFsQl95StLaOKQGqkYJzIDNtcUCdIAb?=
 =?us-ascii?Q?xX61W94pIjomDVnvXzeTDpz8SSBhDe5PhrwC2Q7gPnbFGyAarDsNi98R8SV+?=
 =?us-ascii?Q?qXQSweNsAA4Uy/rvn0CG3jgTv5lKK+AUJgGU+fp5DOh5SmLkOdU5tjiMaJXG?=
 =?us-ascii?Q?jWXKGnf39NsavqzEJEtqwOboHAlG8g63QUJQPhRYlD0VJf8EPr5/7jh2LDTo?=
 =?us-ascii?Q?iOdEETBGTsOSVJzD2atgPaZ/uEjqCcTsdKcXUN1IeDevexhF7TshEOuhAe/i?=
 =?us-ascii?Q?+BB//ksIC4/SipuTiGBBjKb5FS5NKvVB1thL+geSGYZRigWrN9GwZt/VWY83?=
 =?us-ascii?Q?JMTQ04PBNISksVWHV/HBvU+sp70JlXz6dGOnbzuqnBv9GxbtUpOtTfnK4u46?=
 =?us-ascii?Q?oKcf+R0Mg7QO8iPDf1/UeRyev2BoMSkcEl56XdrOx1RjGUaOn8Y0rQmiTlmx?=
 =?us-ascii?Q?4j0wkVV8f4r94eHTLeBcuEg+DBtlUJRdM3OX+yHaicuemxVaNOMS9w+0yWDX?=
 =?us-ascii?Q?yxvprRuokcZiFdYOSKktU/Hvf2x9Aq5hg3+w3mswW0rliGHL3rDwfQ8cCyP1?=
 =?us-ascii?Q?g7HLQl4Df7e7/VQ8T1HTCZMutHhcruOf2hZlkxOXICjit7j75a8jBO25pwbj?=
 =?us-ascii?Q?Ftn2aG5AkQKy50R4eW8x98dDupHp914ERI2J8GXt6HeUzL+1yY0/UgBoW+Ec?=
 =?us-ascii?Q?2SyDtWR53ACRCPL6dLicLlmGQ/VPeVTSxyJF5jGj3l5X02puXN07k5QbQYmt?=
 =?us-ascii?Q?Q321kL4EGDOXr5DO1MbygboJ3UMcQdvFLZnUrU0sH84TAMb43iDkvxIvm1Xd?=
 =?us-ascii?Q?0C5b33lq04tDePRBI3QPqz/88KL9LLFZzgSiOMuMBBKTU1eQMq53fnNmAAwS?=
 =?us-ascii?Q?pFWi+abnrlUe+v0RPGl2XKQNXbqFwtREt6vD87N73mn0CyOtEgC2BhLpEC1C?=
 =?us-ascii?Q?Yy4Ko/t9lViR9/WDlCxuKzUC46gO9b3Gk1CAQ74f2SkVOqg8q4MRhCOeOMx0?=
 =?us-ascii?Q?L9rtofbcPEFyKfcYoXAE1zZ2dPM0N9MIBiXVUjrvJEiGdHGJ9AEm5TAmlpmW?=
 =?us-ascii?Q?L/qAkjJ4b3/SqqxxQ+qMvF/blbHMGGM2BuZePHHtzGhDj5JAfQmTMqhI3i3X?=
 =?us-ascii?Q?4Jvi8/hNv5DK1stinmZD0M+3xocB47y1uOx6p+oJv9IcH0tmdZuauX7evnf/?=
 =?us-ascii?Q?ASVY0Td9DxZQBkdhVWX9TMLbWBe51U4iWkcHKAPP1N5tl6VPK52hkt4UYyrS?=
 =?us-ascii?Q?WynrCJsXNqlur76788sOY19mjkCIPxePHdtvTgBNiGx7CSv4pvqq1vB1EOPe?=
 =?us-ascii?Q?/OCHhVfO3YlnZ9+CbBe4xGunxiHY+cDYbp2/l44fB8DWvh6XX9FYkplLruIv?=
 =?us-ascii?Q?99COVnabKF/yI+gNUNEJhwOuPVrgLKZzqQZlpcl8a0OXjuHfw7E1y24wM10w?=
 =?us-ascii?Q?ybCtJQpCguTtfJPRu/ZMqV7IzpFMTmIsvsenf15RZ+1HW+UYxVhfWdg4wpKy?=
 =?us-ascii?Q?V/rtVw7pUtzCBB8LBWd/vmtGTR6xNwjyEfFicrbpP1Hog3kLgS6oGOuRbcuY?=
 =?us-ascii?Q?cd14rzxpa9LRNJVzOUF8GrIz8xGuNE9w07j4y75H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7836d32-28ef-4a5d-64c8-08dd5b4433e4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:44:24.6212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHFZ/hDw4j2YmUaKw4nkvzpDzcUHlu6/tO8oJFlJz3bFtF5U98A406EwnRh8Jy/uDjzkS3BLczz5x5O70iQ03w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records. Introduce support for handling and logging CXL Protocol
> errors.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error trace native CXL AER endpoint errors. Reuse them
> to trace FW-First Protocol errors.
> 
> Since the CXL code is required to be called from process context and
> GHES is in interrupt context, use workqueues for processing.
> 
> Similar to CXL CPER event handling, use kfifo to handle errors as it
> simplifies queue processing by providing lock free fifo operations.
> 
> Add the ability for the CXL sub-system to register a workqueue to
> process CXL CPER protocol errors.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> Comments: There is a potential failure case, and I am seeking feedback.
> 
> If a CXL Protocol Error occurs during boot: Both acpi_ghes_init() and
> cxl_core_init() are subsys_initcall. GHES might detect the error and
> trigger cxl_cper_post_prot_err() even before CXL device is completely
> enumerated. (i.e pdev might return NULL OR pdev might succeed and cxlds
> might be NULL as cxl_pci driver is not loaded.)
> 

I don't think this is something we should be overly concerned about.
If protocol errors are occurring that early then they are very likely to
be bad hardware which is going to happen once the subsystems are brought
up and start working with the devices.  So new errors will alert the user.

> Usage of delayed_workqueue(): Would delaying the handling/logging of
> errors, particularly uncorrectable errors, be acceptable?
> Any alternative suggestions for addressing this issue would be greatly
> appreciated.
> 
> Tony questioned choosing value 8 for FIFO_DEPTH in v6. That was just a
> random value that I picked. I would appreciate any suggestions in
> considering the appropriate value for number of entries.

FWIW I think this is fine until someone sees a reason to increase it.

[snip]

> +
> +static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> +				  struct cxl_ras_capability_regs ras_cap)
> +{
> +	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;
> +
> +	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);

I dug into this just a bit wondering if passing cxl_memdev is the best way
for this tracepoint to work given the type 2 work...

	+ Alejandro

For now I think this patch is fine.  So.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

