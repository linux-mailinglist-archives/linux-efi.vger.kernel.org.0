Return-Path: <linux-efi+bounces-1003-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E518B5F5C
	for <lists+linux-efi@lfdr.de>; Mon, 29 Apr 2024 18:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AF61F21AEB
	for <lists+linux-efi@lfdr.de>; Mon, 29 Apr 2024 16:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597898612C;
	Mon, 29 Apr 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSFYfTBB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E804484055;
	Mon, 29 Apr 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409265; cv=fail; b=dzfoXWVpcuz9WhKadTJJg3ZAfMycYQYDvLC5Q8/SYtGIRa/7HItPO5vefVcIrC00qCjM+0/8GLi5bu/vbVTMuNf0q4Kj7S4ifuHOOtrqYvDZ58+aNMuFVIPXfbgtZUbP4O8FmfHyDyFheAoPVQDh5CTsjP8l/zIQH01N88wYPqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409265; c=relaxed/simple;
	bh=4mQ7HjCveMYiMEdXKpuWTXDQ0Mc/9JjZoWnsjeT6Wws=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V4bPupw9TZTEQpvBuU9ndOHoVdoYNLC7ArsJGuYW3R3fvT2TzYdTiFQFUoBS1pM9nsmwH5wGYKc31UaM/ze5gKma51PAzQhCS5CfwRvEGrSsN5pM3CX7lmMNEaAQjLMiQNUVtl6OUtDL/p3arAFyKPnwNJlJV+twxoNmvshbjGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSFYfTBB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714409263; x=1745945263;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4mQ7HjCveMYiMEdXKpuWTXDQ0Mc/9JjZoWnsjeT6Wws=;
  b=ZSFYfTBBcWfid7LKrMTg447IQt8HTgTAEC7ZG1sHpsmokqGp8B5LRR3D
   k5qlBZdOgyHNtTj6a+3Crh18CILluV5cLruWn0qfA0LcdpVty8mkstYLo
   7jpCWTiUycYVGzYbW14h9NyaWQGNDv1N5/Ny9TYkoZKlPSLOutcNGyWw0
   eDFRBX+sWPtX76/5x3sg/cqvUTJF/kthpH/sPRfvWqgePtmAMQfpYkJg6
   zc6AWVhx/gWbWhY08mOeujf27kvLT6LmC366TdBZGgNP38TTX1gmyPT5Y
   feQpceZjH2bbbSFWVKJGdN1nZUa4WkS9VtheYpxRlLs2BFn3v4xgeEQPs
   g==;
X-CSE-ConnectionGUID: agIAxZPvRVOs2/jtYFI2gg==
X-CSE-MsgGUID: Icl++JMYR4iPebOKxana2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="20767699"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="20767699"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 09:47:41 -0700
X-CSE-ConnectionGUID: kMpML4EIQSSVc0VEQT1fsw==
X-CSE-MsgGUID: YpHJPKdQSdOLk50VrqQKGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26154187"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 09:47:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 09:47:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 09:47:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 09:47:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 09:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhlcxUmoR3uePu3BeA2CpiQrlzEKDdrZBbeC7GrQtERgeD4yYFrAhvRIP1lNaiFvbqIrgPcpInJsRB+EUjY1RBOG54xE5KCA791tK9Fom7ZHdSuXL75YPHXQQtGMO6k8CKTdXGEFaKyYU1YNS4LR8246+ZquIO977PK9reT+JHihRVcwSa1mBt7Ar/uGEzBLZHI3DZn+SG8iIHzOKxZ3EVtvqLJUGhUCHUZZMG8iATAys/SZ0navLyo2PBZ61cESRd19Xuou1t0qOb+TRQoXpTsrPrNeQ8E/7LTjLJenjHb8nmtXi06IsDvUhOLYVnTF0KPgkKwpoRuApCtw+n2+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PWAqL5Q0f9+yoypzpZscutOpbgXZ6pXm6Ti3inxRyU=;
 b=TnRmgoI62GkQit5QK4lNHBw3R4aFBR4ijyUw8ex2W4GHIMMx0Y+rCTWFGMeDKMts4iZnpgzl0GYRGYsojfaIxfMKuyeFiHo8gk2kSN0dBd34RXVOpVNwxiQb9tcMNOyoNu8pE3AbJtc/YE17eTRlsLnsgJyBeIFAuqpZwF+7ZAOYwUywYHebMnkvEUHf1ukyrnBW8KOpeIFzdRN+0pxHKh7YkmDZhvmLwVUCcvzQLnLv21oyW/c3fXhNcrv70UnUq1arSmlUm3JXBO10p0fhZ7/9eNujUYneyLb14Z8INjgDsns+tLigKbmocwG6JFQRb1jUAI5Qgy2CjR/DDrw3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6339.namprd11.prod.outlook.com (2603:10b6:208:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 16:47:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 16:47:37 +0000
Date: Mon, 29 Apr 2024 09:47:33 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Rafael J.
  Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] acpi/ghes: Process CXL Component Events
Message-ID: <662fcf25d0eb8_19ca3929452@iweiny-mobl.notmuch>
References: <20240426-cxl-cper3-v4-0-58076cce1624@intel.com>
 <20240426-cxl-cper3-v4-1-58076cce1624@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240426-cxl-cper3-v4-1-58076cce1624@intel.com>
X-ClientProxiedBy: SJ0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 556e00fb-2974-4efe-9ed1-08dc686c1393
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WhB3+nfE03pWz6Dm808gjAhglz1vThEZcKXgRfd33f/CjhvDc/mvVy4JqluA?=
 =?us-ascii?Q?tzg7purPgx73tE6GF0X/IU2rqD+pN/TrjKmDQHDOyKco7zmkBYiV93a0XJtR?=
 =?us-ascii?Q?ax7GBag3A+UOvFrvz6Jb/Ai6+zfheER2n2LaVIKKE+mLVxrCqQCNWPJCZzMu?=
 =?us-ascii?Q?U+2pvp9wVEEjLuSs5Gdg/9eBNatAhMAh7PlkmsnRMNf1N4cHHqM3Ay0ihmw5?=
 =?us-ascii?Q?jPQhi+S11UWZWxKWQ9BQ87HO7mTkpxWSBU0E1ed7kB3Q5L+3dTRcymR4uXoV?=
 =?us-ascii?Q?IPwRiB43MbGN/Vf5Q/0CmlkpaZBMsUDvJrZU7PZkAe6oOPF0Pn1iIxdY81oP?=
 =?us-ascii?Q?9QOnjudGr4uZsWGXVB1lHS3151cR95oVpP+RQyfIkUEjPpWa5S63TcJP8a1P?=
 =?us-ascii?Q?KVf65CA2EiHyacN/pVwmdbqdegT9bbjhUAqXjd+Tmuj9tg/vOt4cRya0cwPc?=
 =?us-ascii?Q?F+o+V45JKcgDSTRGxn21+4PH+hQNMtVa/CGh0mZFx0HJv0lUzEC6kUzORuki?=
 =?us-ascii?Q?YE3C/jgCuTWqstjnRBZZEZclwAju9SMFV4exwttzUGkHga3XFtxJIDzMTnbe?=
 =?us-ascii?Q?GiU++FpZsNfBsdWZL3KDM7qNBJEsJG7uhgMkK8OWErH+2KevlXauG/A5Ad5C?=
 =?us-ascii?Q?Uvl5CLfXClEFtPqcu1IPkaCiyR/aNVrIEs9NZZefPpQNK25Wsi6LVB9Et6Dr?=
 =?us-ascii?Q?CgA7gGhzO8+WII8HGQ+ckE8Tr2aV2+eOSaYaUN/9Coi3lGsuwzXtugNkFuSA?=
 =?us-ascii?Q?DpmwZOD6qjXaI+CIDvApGtnxh5r5fWg9xV0fNwm1QpD4oHlxEHLLjG/g3D8F?=
 =?us-ascii?Q?Tz8f55TvLw+47IkW5/Maez9TSwc2aVTe6rXKMEPnAMeZlc41dCqa93kNe0bs?=
 =?us-ascii?Q?LccqTBXnVCGVnav17w5QDkPpmseYwPDQZpB0HhPLVlQ7X2czph0SHMaJlLNL?=
 =?us-ascii?Q?r+jY78tB0bQBC4afvlJNKFgursA3OrfMa6AB223Jmgn3cbGEfIWm+nroya2v?=
 =?us-ascii?Q?vNtI3mDKr/RW8wZs1maCtmS22TDAppAUkGGirlulu3mvJOlpwJgS7ejyJbkM?=
 =?us-ascii?Q?GtOVLPr+7UksU+0NxArmdtReSJImwQbfQgL8Ml66OaK/UsX6OZa5G52rsV9x?=
 =?us-ascii?Q?ib0YHqp2XPxtgTv/68d6KBSITO5oCFH4MxbrHU82hnyq/7VuT39/mdAx5ua8?=
 =?us-ascii?Q?txX9XgK1wb8zHhFhBvonv91wnTMqGmJG/PtZHDTWxqyztN7r0pO18BfDmxw?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mNrGyAiADKJ6H8WHy92gH3FcN2QIGbPW6Ua21zEfTJkmo4453/zUiY6C8cTK?=
 =?us-ascii?Q?xAzIBClhqxkZpn0MCL5CEKympA93NJIN8FRcQKxRde0eTFrcyxVAelDn6gVw?=
 =?us-ascii?Q?6qy/WwrmA0Lnl0Nn2EB2uMtZsfXrr6EyvBli6nAhRu+mzoEUmiZHtfcXpF2C?=
 =?us-ascii?Q?cGDtD2AN7Gt7JQieDEOA8uYIXYqQM66a7ODK6kOwh3BSD7bPHM2R1QR7Lb9I?=
 =?us-ascii?Q?4lqN4CuX/0uVK/eYA0VquBlrwLLldnH4ifwhXNJADMEN8h2CIMo0xT3p9SUv?=
 =?us-ascii?Q?VxUZHpWOViZj3nPkKGNUX9GO25btMfpGNKiyH/pXkks9PhQbDrqsV3At6avj?=
 =?us-ascii?Q?7ybamRo3MPFRBo3kLTB16ETKspCVl/ErwKCtup0XPr5SC6oLnhRuAIQ5uF1Y?=
 =?us-ascii?Q?37cU36TBOZBK5H75SeC1ULhLe0XY2gVFV725FyA89VU/wNzr7hUUKLNWWInR?=
 =?us-ascii?Q?gmuhB0KnXjMyw5J49PmwM61bfevE23e8uQR7wyAEtriFRStCsEH8XNv2FaG0?=
 =?us-ascii?Q?UeI5S5Cur7u9GZVJV7Qa+bgii1Y7HaPtcuNEpa2rRHEbPVKDxjQt7CQeNLVf?=
 =?us-ascii?Q?Ldoig4Q3VOU7wQfEc8mb8v9zBCnyoU52fUTAGAZhlQosRMj/gavjs394inzy?=
 =?us-ascii?Q?DiiAXMWxuWU45Oyr6jQdeHDXcpUTdjar86ZThKGRpmD7q1EnrbXlh0EHU6RE?=
 =?us-ascii?Q?gTWYEpDLH7ZWbfCtVvVZeaixyXdjd+ryi/ZiQEDsFEckZLAAHi5x8tLi1ia4?=
 =?us-ascii?Q?G1nMEYuP4xErDoi8zKpgp7BGiz3NvOw+9ztPwAgnlAwYoNUg7iwA80uvrdIM?=
 =?us-ascii?Q?pQKGl1EUfCfqEimGDUZc5O3pl4HyR1MqpWj8nc5EVjsLDqrpVZyFdE5iB6wp?=
 =?us-ascii?Q?mNicN4cuBnPf/2aC63l/MJs//o6LzWPOgpKZDD1luz0XOHxwE3I3eCvvnRHQ?=
 =?us-ascii?Q?HtkrEVDUCDJiaPVNPCI0EiEiBXYYbCXGgysf59oafTxdFfbYiTS62wcvRiXl?=
 =?us-ascii?Q?GAgDDu2SoHAsD7NjWgjZfOmeWh+F4dVxQSZnatOclVHl/E33Xz4pufmZ5kRa?=
 =?us-ascii?Q?f5PXrH0xSHW5Tal7T4bKKw0/uAOegufxQgiuzLp2fOdPLemKR05mfN5xZbLR?=
 =?us-ascii?Q?8hzSd2+8n5V7rkiBaH5sR4bt5U4ZmFzxCXA6rS8cNTCICTvEMEyeoDWS8Msq?=
 =?us-ascii?Q?uNQswYwDzyEMSrO3ehSE0/M1pwAkGsEXg0IzTsJHuJX9H18SYqsbi8bQOur0?=
 =?us-ascii?Q?d/CfwNBmwfBoWH+TJjypI0068xu9t0CXIWVhkrrSawc8sHuQN/dICZNl5AQW?=
 =?us-ascii?Q?rxf0+GkRUNVIiyBcUpnmpg++6dkknBfKrIdlckSgbBXF2R4GMz/fBMQlIyeF?=
 =?us-ascii?Q?0UHeS++Bxxb1ubZWyBOefHnOe1vml5rwa5M/2HAaG+/P6+vJkkMfAeILKHfR?=
 =?us-ascii?Q?ott4DTDyKeubbkxqtUFT0uP77bv7rlQxvvFi6oTmanU4OD1yq4AdCM2zmY6z?=
 =?us-ascii?Q?IMKQnXfK1xR3ZzAgJvLcvApRq1qpSvZc6ARG7IxqUyUyeKnc4sHymQhRqNn4?=
 =?us-ascii?Q?JSA4EkqYckVpPuKvkeZ2u6GtEsbz0UwsiR1HVkXT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 556e00fb-2974-4efe-9ed1-08dc686c1393
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 16:47:37.5483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAhc0qgjgMcPNNAweLBfokcIwzsLYKzEkNRx5KBz/HSVCGOZYQ9WGcxLmmYkPF5vjkZMY/ZBYOeyKO8EXeQS3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6339
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then inform
> the OS of these events via UEFI.

+ linux-acpi

[I missed adding this list.]

> 
> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The difference lies in the use of a
> GUID as the CPER Section Type which matches the UUID defined in CXL 3.1
> Table 8-43.
> 
> Currently a configuration such as this will trace a non standard event
> in the log omitting useful details of the event.  In addition the CXL
> sub-system contains additional region and HPA information useful to the
> user.[0]
> 
> The CXL code is required to be called from process context as it needs
> to take a device lock.  The GHES code may be in interrupt context.  This
> complicated the use of a callback.  Dan Williams suggested the use of
> work items as an atomic way of switching between the callback execution
> and a default handler.[1]
> 
> The use of a kfifo simplifies queue processing by providing lock free
> fifo operations.  cxl_cper_kfifo_get() allows easier management of the
> kfifo between the ghes and cxl modules.
> 
> CXL 3.1 Table 8-127 requires a device to have a queue depth of 1 for
> each of the four event logs.  A combined queue depth of 32 is chosen to
> provide room for 8 entries of each log type.
> 
> Add GHES support to detect CXL CPER records.  Add the ability for the
> CXL sub-system to register a work queue to process the events.
> 
> This patch adds back the functionality which was removed to fix the
> report by Dan Carpenter[2].
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Link: http://lore.kernel.org/r/cover.1711598777.git.alison.schofield@intel.com [0]
> Link: http://lore.kernel.org/r/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch [1]
> Link: http://lore.kernel.org/r/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain [2]
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes:
> [iweiny: pick up tag]
> [djbw: use proper link format]
> ---
>  drivers/acpi/apei/ghes.c  | 110 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cxl-event.h |  27 ++++++++++++
>  2 files changed, 137 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 512067cac170..2247a1535b52 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -26,6 +26,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/timer.h>
>  #include <linux/cper.h>
> +#include <linux/cleanup.h>
> +#include <linux/cxl-event.h>
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
>  #include <linux/ratelimit.h>
> @@ -33,6 +35,7 @@
>  #include <linux/irq_work.h>
>  #include <linux/llist.h>
>  #include <linux/genalloc.h>
> +#include <linux/kfifo.h>
>  #include <linux/pci.h>
>  #include <linux/pfn.h>
>  #include <linux/aer.h>
> @@ -673,6 +676,101 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  	schedule_work(&entry->work);
>  }
>  
> +/* CXL Event record UUIDs are formated as GUIDs and reported in section type */
> +
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
> +	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> +
> +/*
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +#define CPER_SEC_CXL_DRAM_GUID						\
> +	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
> +		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
> +
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CPER_SEC_CXL_MEM_MODULE_GUID					\
> +	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
> +		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
> +
> +/* Room for 8 entries for each of the 4 event log queues */
> +#define CXL_CPER_FIFO_DEPTH 32
> +DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
> +
> +/* Synchronize schedule_work() with cxl_cper_work changes */
> +static DEFINE_SPINLOCK(cxl_cper_work_lock);
> +struct work_struct *cxl_cper_work;
> +
> +static void cxl_cper_post_event(enum cxl_event_type event_type,
> +				struct cxl_cper_event_rec *rec)
> +{
> +	struct cxl_cper_work_data wd;
> +
> +	if (rec->hdr.length <= sizeof(rec->hdr) ||
> +	    rec->hdr.length > sizeof(*rec)) {
> +		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> +		       rec->hdr.length);
> +		return;
> +	}
> +
> +	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> +		pr_err(FW_WARN "CXL CPER invalid event\n");
> +		return;
> +	}
> +
> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> +
> +	if (!cxl_cper_work)
> +		return;
> +
> +	wd.event_type = event_type;
> +	memcpy(&wd.rec, rec, sizeof(wd.rec));
> +
> +	if (!kfifo_put(&cxl_cper_fifo, wd)) {
> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_cper_work);
> +}
> +
> +int cxl_cper_register_work(struct work_struct *work)
> +{
> +	if (cxl_cper_work)
> +		return -EINVAL;
> +
> +	guard(spinlock)(&cxl_cper_work_lock);
> +	cxl_cper_work = work;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, CXL);
> +
> +int cxl_cper_unregister_work(struct work_struct *work)
> +{
> +	if (cxl_cper_work != work)
> +		return -EINVAL;
> +
> +	guard(spinlock)(&cxl_cper_work_lock);
> +	cxl_cper_work = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, CXL);
> +
> +int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
> +{
> +	return kfifo_get(&cxl_cper_fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, CXL);
> +
>  static bool ghes_do_proc(struct ghes *ghes,
>  			 const struct acpi_hest_generic_status *estatus)
>  {
> @@ -707,6 +805,18 @@ static bool ghes_do_proc(struct ghes *ghes,
>  		}
>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>  			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
> +			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> +
> +			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
> +			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> +
> +			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
> +			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> +
> +			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);
>  
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 03fa6d50d46f..a0067c49e2ca 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -3,6 +3,8 @@
>  #ifndef _LINUX_CXL_EVENT_H
>  #define _LINUX_CXL_EVENT_H
>  
> +#include <linux/workqueue_types.h>
> +
>  /*
>   * Common Event Record Format
>   * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> @@ -140,4 +142,29 @@ struct cxl_cper_event_rec {
>  	union cxl_event event;
>  } __packed;
>  
> +struct cxl_cper_work_data {
> +	enum cxl_event_type event_type;
> +	struct cxl_cper_event_rec rec;
> +};
> +
> +#ifdef CONFIG_ACPI_APEI_GHES
> +int cxl_cper_register_work(struct work_struct *work);
> +int cxl_cper_unregister_work(struct work_struct *work);
> +int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
> +#else
> +static inline int cxl_cper_register_work(struct work_struct *work);
> +{
> +	return 0;
> +}
> +
> +static inline int cxl_cper_unregister_work(struct work_struct *work);
> +{
> +	return 0;
> +}
> +static inline int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif /* _LINUX_CXL_EVENT_H */
> 
> -- 
> 2.44.0
> 



