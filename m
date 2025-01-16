Return-Path: <linux-efi+bounces-2648-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 599C2A13CF6
	for <lists+linux-efi@lfdr.de>; Thu, 16 Jan 2025 15:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969367A276B
	for <lists+linux-efi@lfdr.de>; Thu, 16 Jan 2025 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4752222A81F;
	Thu, 16 Jan 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4ousqnL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11022A7E2;
	Thu, 16 Jan 2025 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039345; cv=fail; b=tBYhKGNbVQZqXVPhjfwU28huDZfckdlYEXafig6b8op+E6zdYh11qK96YBb/+rt4Vbsy8+0e6wmAjK3XwTwHOgoBJyTpF0SAJidJYlW2IkWxt0cecxOnV5ucQX6gxvPfbJQY61Gkyy/PbZxLfLkcJ3GDWI1GCAIkGirPz4TsC0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039345; c=relaxed/simple;
	bh=bxGnt2BVpqx/+88faDvFoiCKI5k3Oy7npXA6ptzv7aQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LanlNbVI+9LA9Bvjlkb8g5jqW4WdA3hYMk7ZIe5fTckSGD3HOFSsI+nDWZN2X1lWB32FeJG/yNXztUxIRux8jKb+L3yw141FQ+Nf/gQ1nAqLLZhkVFSg64qutlsOuhouLmkIUvtteochyMMCJXu8hei/K6N6DKuIo7T7tvISWU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4ousqnL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737039344; x=1768575344;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bxGnt2BVpqx/+88faDvFoiCKI5k3Oy7npXA6ptzv7aQ=;
  b=U4ousqnL9TQ3P5Bc4r3BwrrYaAl3kMSwTgFGYQ6Jv6Yfgr05UMFQgI7o
   7OueovvRXCwvV7PynNcLe54A+OMkhuCsirezJdV9zMI7JIBEUBHuFk2W/
   f2eAxzDEYxN4/6G4e/j25ayWfyo4URQjRploRKOgMx80clWyahIOuNo1c
   G9lQ0CxIlSWbtsQQV8pDWIlrPfbzgmpHREwCs7LKcd865633Q42PDpeL7
   i0XeGgjttuXTXn3GvlQmhKyvPVOCocHuDlISewcBOwZ+NQMOLp/pL2rSd
   gXDGrPlNazhTUMxZHgNbcW/Z+yCczpTrD8haO3HAc9zhEoQ6C+nwBwOXU
   g==;
X-CSE-ConnectionGUID: R2V5/XDKRV+wSsNiS0dAKQ==
X-CSE-MsgGUID: lXWt6hbLQf2oxXdTvS5mXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37583186"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="37583186"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 06:55:39 -0800
X-CSE-ConnectionGUID: RS/gCd/uSXuAR+G25Nah7Q==
X-CSE-MsgGUID: n+4Kp45LQdu8kq15zC3+mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="106057627"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 06:55:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 06:55:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 06:55:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 06:55:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDVy4WIHXG+W6ItvK5znhAtdTU2c+9DUVY7bz9bSN4KkSz/7VCRyTa7rMtwzbDsCaeP7syhPLgeVxsLjlwiqWWUvRs8THo0+7oqxmaoFqQ9R+BYgUVUGhPqz6nX3QPE27IzvZmgy4WDsl26ztdQLnvygBSEJqac8kb4ksad7tfjXiPMXI3LPjJewOfL2ygpbYsrerNmT/t6DfUU60I0ggnYa15q++5ugHsopJ9QWTaL3vTCa/R1KQk4zGQWTiL4DjNyNMo84NT8ETKne8/kOfc+nPCFpNvcoDQoTiCDvQqoF3HWLg8QQZfwLWzT8bBTW23Vyjw5gMi2jYVy5/q/lOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1k/rZeZim4wyScu0lebZUbWRPKajiLDIiKNLNHSuos=;
 b=V9D5SCDsjwUPkIzsYtVEz8KXVckfqZbhR1QxCOHLyBxRv7liXEOp+8xh+I/cvzLpSr5W9YlIK5acXPkW+POqBlQKG/h05zsM1Mcy8Ge7FmMy0frWLhSMvf0NQyfrWEcrg/cYwGfqeCxc0p8DzHD1dEiXaT6UjIjxQ+53owsSAu2supdiKKa52IeH+uI8rkf0TQ7OtT5fal6vDV9QvvSWyB54dmnnzgLfnw0loGu9IGHEGWzMcvon0DchDQ5ox3LOmNBYhBWtak70ZnAT76GomUH7jPb0uO3dEeE4NbHatY3HYkpM9pcv9rs8kCP6iLNCjynkg9+MzcD8+AbiEBOfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6752.namprd11.prod.outlook.com (2603:10b6:806:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 14:55:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 14:55:36 +0000
Date: Thu, 16 Jan 2025 08:55:31 -0600
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
Subject: Re: [PATCH v5 5/5] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <67891de359b4b_1be18a29461@iweiny-mobl.notmuch>
References: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250114120427.149260-6-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250114120427.149260-6-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:303:8c::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c015d6-fee2-4433-19eb-08dd363dd58f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eEAvbXcjx6fTq59VXA7rSBIkyeTJCIIkGVYUinD1hn/qTmiPtWSfRDcG15O2?=
 =?us-ascii?Q?gLdVXSarTn6DBAHfHD61UKMoubDwGZ5w+Q3Ieg7A8m6/G59ic1tx2U78TGBa?=
 =?us-ascii?Q?fRCc5jn/dTIMwOsR8wVYPi6ecVsS430Oti+4gXYsRNjYq2ve7JuC7wVZSUIP?=
 =?us-ascii?Q?X9JbC4wYIYdCItuwyB48s6JDDDh/aS1AQd4Jtm51JCUfo5+kulkXIgWJSPnV?=
 =?us-ascii?Q?GaRHJBcbtLewDA/0Jb0mYKcwFWV3lnXalsTRmhv7A9I4PfyWMOzTLFlBWxC7?=
 =?us-ascii?Q?nKIC3hSQL29GLR+9xEoY85hZLs4pwKB8T+wqDsEXkd+HlQTenvFOJgm7C/sh?=
 =?us-ascii?Q?4XYiplRnxhAZ29rqpapu//4VJ5nIcIa/25RK4FIyOsf0FNkgKoO1K+tcwHID?=
 =?us-ascii?Q?erj7OoV6otn8HQsGXpgk34emUNSmtd63n+lvhbzwAy61aq3w3Isgz8XCwNki?=
 =?us-ascii?Q?aNoe9amkus2y/kxVER1Rb8YiASo5Ja9oAXBkWRBpTzJ8d5sXEqP0s8XjUXzM?=
 =?us-ascii?Q?ttlkCzjFJhhKPhtAlUxipuZf1Vg2x5LTqoaQlMt1IeFAEc3xVYw5CkhJjOMA?=
 =?us-ascii?Q?hqFLrp9dQApGjo5Swj/T8mcCaKZadt+cdIh+1cd5WuXCIxIYvmw6uI4B7KfC?=
 =?us-ascii?Q?QEbPuYg9w0h6gnMVF94v7+a10Li+Nd4BV+bREzJanUisFsUI2lWsz814nuDe?=
 =?us-ascii?Q?SmHm8lwjinmaQh28Ky2DHw+VaXvIsbB/gTJtzJ4VPeI34PJCaQ89dBqTRGUs?=
 =?us-ascii?Q?KEAkh4i40sqGZVd6rX0Zt+M2Scrvt6N8gC/DsLTZf76AVb+G0HhUgenlTthF?=
 =?us-ascii?Q?VKpysQ4bY28pcNsbIvXoO/VXpb/AMgbSCoKqtinpe7KeQX6Do6PNHVX5MbBq?=
 =?us-ascii?Q?mIRZFaFjuimn8eHtWp4kovVPqrNFkmLaqxJ+u6621xvr1Jobw5/PFJ0gVpqU?=
 =?us-ascii?Q?p9k9/qBdgABKM8qGTIwqxffWMb69D4KmrKywMNSH/ZOiZNZOF8GNHa22KTad?=
 =?us-ascii?Q?qgQlGohI4U3MkE2n6lk2WlO1UNEB6bvFPlWt9+y7iCc2l9KmEgTvHIgV2vos?=
 =?us-ascii?Q?10YRpjoClofpWm8svTiZx0QCzrdwdN2RSj+/fgBEqWfumoxnakZInjzIIUf8?=
 =?us-ascii?Q?oGmBLXUQH3zuUQfxqveV4oYjyoU64u20on/kw+vzv7kYS+DlHfMyOt+4rvx0?=
 =?us-ascii?Q?D6wk4ByJ1djrjud8b7HMEVdTQZ9eY6LrUMRt6A94bAPYYyg8Wl7H/EAx6woQ?=
 =?us-ascii?Q?1EKHekpupBrWL7/OeJUlxgzxwxYpUEfF3mKhBP0PsQxih9DxbKKXuKNkM5ud?=
 =?us-ascii?Q?rTyEYGrkd+pD+usqTzyFIsjcsKd77Y8e0DsRN6lu+WBe31EgqtCxgF+80lpd?=
 =?us-ascii?Q?KWe6a/s4zFYdRkPHZfN5dhtTLxzO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XNnn31hYhbX+w0p3uQ/SqkCjq0SWW1urzZ/ustusuUpqsSjfq/i4hNj75UaT?=
 =?us-ascii?Q?ZSIOXZntE+hSENGJ10r28fUDWAuK0vAKa8CHv0yC7ral85vVcKXJRQn9DRjg?=
 =?us-ascii?Q?CkWf9tZ89XIBWGF8pZanTWWiequKSwcftrWAdl6nRugNzDD0b607z2LOhbxq?=
 =?us-ascii?Q?jbw0IMnm+CeOxmUj95g19ntRWxK887dYM0nGQ7w7P49p5SZw5IlfHVxKpbT6?=
 =?us-ascii?Q?vHAa7OCtKhUEmlQeB+3nrShs0hgjvf8giO+Hz4AYtCCgkw8ab9gJ6eSUcSc/?=
 =?us-ascii?Q?tTbZC1PFKOU0ii6pMvBoxTcj22f9XElN+PPRstMycTIP0QmZDACZZKNqsI2C?=
 =?us-ascii?Q?dH59xN7ZHRAKF8W65OpxhHYbb1d/YC/Hl0mDYPR6u1YTQStMipMYoU4DEbZn?=
 =?us-ascii?Q?Cl95Oj+si+hi3Fv9bG91jnPW10IcREBFJc0ZflhM9oe6QTi6vd6S1kFke6y4?=
 =?us-ascii?Q?e0Pij2PzD9A/iyn4QV32PMBKmLbfzGSsAsLGBrZesR7my0iZMLj87tJoltQ8?=
 =?us-ascii?Q?2Hz5kqv8VJAu2cJsqXTnQeWcuRxXh27JdlleO07WrhdFOdvanzDFQheS+7gr?=
 =?us-ascii?Q?COyQIliC5XrewqpIn2+tiNpPqwuKY1mvBd+d6iDq7P9P7EOHqBj3N7QU+2o2?=
 =?us-ascii?Q?hoRZ2pbq4UfGn5yVNg95Ao0TKaTiGwnWER+8G16URoKgzRbfoTr76II/nQYT?=
 =?us-ascii?Q?MBmYVqBUKWmvoBmTsCWr2cyAI58ooJYMC/ASNf46qxiTw95EksQfbXwUI3l4?=
 =?us-ascii?Q?78sUeezcstGMv8VMkVxYTbX+h9LLE7LfSi9ybzM7KqzdTBXeaCU8biURBpN9?=
 =?us-ascii?Q?kc67bFNbVXtC5qbg4FyvnXkFZN2+XgclwZXWqixzrPcicHm/grspTLCV9hD8?=
 =?us-ascii?Q?gRIg/vXXQj1l6bsT1TxEuO+AmqRZ8end9NFxhX+2kbuxWKPJDYLe2lod8ZZa?=
 =?us-ascii?Q?vmWcIlIkhuVfBDmf/7GMaulIpj1/GGFz6sLkt0b3q57sF1CoovhAsmvSF1rc?=
 =?us-ascii?Q?jfFJV3SL3v8GqSxpHfBMTojcCt2NY2J+9xPzIJUHBwqIQigG+rM5LYUTTrbM?=
 =?us-ascii?Q?7/cfWJg8TIN9QIBgIOzZsI9TsUoKyzhSy6dNuoIXNoNYf4uGC8X8yb9iF0TZ?=
 =?us-ascii?Q?gZgyXDxsmGPG8sjBOZUJPSox6CrPOEZ7kE4iFkWpMUvgBvympcce1U3nZb48?=
 =?us-ascii?Q?f8Bo0/SuH3NapUXgTtzw4mTSVhEVevZWENfwsm9viPWqhZKESDgLAdD9Xzz2?=
 =?us-ascii?Q?dYIpBj7um66Kh39mtpeaJrAZwVQ5Ck1IwNUKYIC3JNZrAxomXtG/WT748cIt?=
 =?us-ascii?Q?s3klQ6QU1Lq5gSsq0OPaXvwu2kkLLps0RhGtZ9vlOipDCfytZst8TanwDyEU?=
 =?us-ascii?Q?uSBr1d5Xy7Nnl2BzE1l23msGHdnEhl9nQgtiralBdjY9guKbeQVpQrjVIppr?=
 =?us-ascii?Q?VHTkvxF4GYP/ZeiI/C5jCIarHkpZjxN47l+s7Dr3CuGZS/6fTUfVlHJeHzR9?=
 =?us-ascii?Q?2g+n4gbaJKaw0DI3J7Ah4zOqOeBt5Ya25OJmmypjDcBD8nBviVEbh0mI/+Pd?=
 =?us-ascii?Q?yYmMo+kalkCxbYDVnS8v+soEgy7aHo1o3uCIyfrO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c015d6-fee2-4433-19eb-08dd363dd58f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:55:36.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPp9gwziLsVVSz1V2CWNhIXBFRBuQXtsIFzkQ0mBJEbK84jR3pR9mbiVNcuZWTx2VR3GM+iucJb+P/TEhhkedA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6752
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records. Introduce support for handling and logging CXL Protocol
> errors.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error trace native CXL AER endpoint errors, while
> cxl_cper_trace_corr_prot_err and cxl_cper_trace_uncorr_prot_err
> trace native CXL AER port errors. Reuse both sets to trace FW-First
> protocol errors.
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

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

