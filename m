Return-Path: <linux-efi+bounces-2557-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF418A08201
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 22:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA3C7A39FC
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF68A1FECB1;
	Thu,  9 Jan 2025 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lE7eEn2s"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8CF20103A;
	Thu,  9 Jan 2025 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457082; cv=fail; b=mYruLeNtuZ4RJuSJbTRTqfe+us5DRgd/1MIhlwBGESlxSmdeA6REfCBGyJ4VLRPei05m8EFbgE4rboGynuu/Jt8wIMX8b8+3N1IniSmrDrFplbDg2vrm5+f21pcOrUnnZxBapaK9JQrsBUQzwRTO1kzOP1k6S9Mf40jTZZp/LF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457082; c=relaxed/simple;
	bh=ScooNUV1El1rWTAXgMVCkW/RK9glsMsyGNQ+kHP/6sk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kBr6df6M7Y02ntBLQoWZFeUpfk+oERAGh7d1EAVGrwmYbtfH4WTRS8KrR3UOfQeUwknao3oATY9U+fc0i9b+t392ND3h0Y3Htmq9vKYL1onCDsY93p8lfOEDspv28s1/Lcjt1ecrC7xUGe1GyTslxNj1yCfEoqS2+PFXWoqwPF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lE7eEn2s; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736457081; x=1767993081;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ScooNUV1El1rWTAXgMVCkW/RK9glsMsyGNQ+kHP/6sk=;
  b=lE7eEn2segB2s2e5ZMzO6+XPy/ZPgwoPH9H4TK28oeCv3yhsPHO2eJ7G
   jlixDYp8Sqi/ER7IWxr7l/Hct6Gel3R87UHb+ZnhhfMqCaTvyY3AVAfHB
   EMGPzqKXZKhytCiRG1qFTCJqx3zeGiKA8JIYuThzdoCSATV2Yw8CHG7R6
   i0mcuiQPRZzlZb2KEGhDqPpHSAwTT/IymyzfnffKxT4rxDEFEN2Qbu14X
   ePTnhDzxAvkg8xwcERAndKjR+BNq7GwQW2vk+7VLYLBDr6z+BLIepdJfp
   Xs7Oo4z2D4Az27cScTy2hX9+bAYedL8rNaNG4w1x0nuPnbhyxMVTeJfMg
   w==;
X-CSE-ConnectionGUID: WNro4dy3QA21BvcPxPK81Q==
X-CSE-MsgGUID: yBg4XL3XT3SH+q0ch6/V5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36898900"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36898900"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 13:11:01 -0800
X-CSE-ConnectionGUID: e6MJIIXaSeaOIduohwiBkg==
X-CSE-MsgGUID: l4mAWx04Rr6GBeqRMN8fJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="108436569"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 13:10:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 13:10:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 13:10:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 13:10:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPJbmI/2m3oRddk0/4hASU9kU5337gfepPsbC+zMMrpI/aMbDUOMdX2AHeoU86IUUG8RNhYgTAjaPc1HLGsqmukbZDq+DUkg/CGsGXor1U0cG4auPd+sOxbr30J9Bh+fC2L+sZx51getbHwnejRDXqLN6TQfwoitG0sMBS3r4MjU4PcC2ayrIAO0/VoKkqzWR96X2O9zMjSakviG31qmISlKQ1UaIYWThfj8Z5QG072+mRpUxRLbLMcfzqEHXvxcNhHIW6uiZ7fSEXM6L22KlQKsykbuqRE43BDQGhmFU+DaIH4LgU47vuhHn7SkQMt0JbyZH6esinEVDaoYEYR1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E179Bf+8pkqp0X1b5P9MzN+KoqqSU/Y1+xlJzLwbTOg=;
 b=n0tTw3Zvch4+ZtvYuhiSvtZuoseOmfVjh6LV7ZK5ccjCNyEk1dneWkuW/rNS4ZwRI2KFyBYlM9OvOMaDc6aD+QSdvG48SrkdGE5BRToFvX1Fdr2YRpuRT3Ve26X5J707ctSHNm32DnmFOcnh2KeZ5nPSR7MhnlExTp9bsVV7oJsyqsuNuUsETzsl+uG/b4kMm2KcW3gKVYT2Vsbb4XJvYRfhb/UzjTWtH33foIEOt51/hgpDYyHJxUKbNQjmlN70XA1m80mOf6eiJ8FMwL02lvG6EGnwY0bUnXZ+JxJ4jGb/woaBLn9++b6N1hsd7cVvhem9Y0G5sNz1RcQI5mKcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 21:10:46 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 21:10:46 +0000
Date: Thu, 9 Jan 2025 15:10:41 -0600
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
Subject: Re: [PATCH v4 4/5] acpi/ghes, cper: Recognize and cache CXL Protocol
 errors
Message-ID: <67803b5167b9_15ec99294cf@iweiny-mobl.notmuch>
References: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241217022032.87298-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241217022032.87298-5-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dce9b18-8323-48fd-7984-08dd30f2159f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FBUsH1Dsfj4PjnACVx1jKyZv6i1DMePq6jB6MJ4L43tkgGaqxf8zyrVj73Cy?=
 =?us-ascii?Q?vtDJDG76TXBipxhmdo6+X4R6IA3IWXJMZ7QNdKj+0Xe3zFxO2/Koxq/CU6GJ?=
 =?us-ascii?Q?Gjr00fmCJj/+Nyq83PBg1YwUdXcUQb24HZ+2lN1LgcFU1IPiRyX6OiI+kO43?=
 =?us-ascii?Q?zjMXIYxJjY6xn2vkE8QpOA4ed08S/eqr/v3Cs4AdV06N9itiVu2QgWB1iGjA?=
 =?us-ascii?Q?lqajV04A5Wt4uknpssAvlfrHs2/sslePKJQ4E+cbx2l0S3AW8k+3z5NaFDVr?=
 =?us-ascii?Q?FBWQ3JmpBlk/Zd1aKzQJLC+QkTjOhoeIImgzvsE1rb8NgC6yPwle9ZC3o5/A?=
 =?us-ascii?Q?UBoTsM9RZSdpht+2YpXK6ox5qhI2j8TZO65pec9/5C2pqjalX2kSuLOXzvNb?=
 =?us-ascii?Q?rCFngHxfxxFr8Ki30srOewWAm2jGYyplhgewvx5g2SB+X0srxXHtrcPz9/dx?=
 =?us-ascii?Q?xZd7oc+4K2MD3VUrK+r4N/IcarUzFozD4guICAaFl/fRUEDpjiW5xinWEElG?=
 =?us-ascii?Q?r7APeh8D550SZaYotDoVQl9ANoSl+y4KQHPAXNQDfeDIuzh58T0rTbGR19Zd?=
 =?us-ascii?Q?2BXel/VO1LeSQG4MGKMtU4eFh7YyjjpJ7MCZ1AbEGSRl/AgiHGX+geq7ZiFX?=
 =?us-ascii?Q?f23NhKWYTDzzQa5oR8DhLAeLFW1sI6Miw+tweplfx/MtgaKLetoFNnkEzSlt?=
 =?us-ascii?Q?aE6wcuXGoOxndBesEH2Xz8Fi3UMURFuz29WBNpnn1HpHD8ia/X7omQQy0R7i?=
 =?us-ascii?Q?JCbAG9evbe0wE2mOZu8BtgTlbqiEI4FOzI4JcW0DU1O5BrF1/i42KubKZl7n?=
 =?us-ascii?Q?cVWdT54LEOSfuF7FuAQkSryDvXeaQvdsR5qD0SBA/OVRbdali+B/dT6RjMHT?=
 =?us-ascii?Q?9I45YOMOVOSFmxiBMofuJYq/hsWo721LsOpO8PPOxCcc2PODdkiePlG89uS+?=
 =?us-ascii?Q?2lNZRmZIQ06fpwLyOHhgkJHMTSqFE0RnyLYh9YCacfoNbBg63wi7Yws8gGVC?=
 =?us-ascii?Q?elu+FNiz642HBVhazFldB17bKdPZMHXaDEVENcDYmwmCTwIMe835r6Ep6qgs?=
 =?us-ascii?Q?vFt5gm6v9s/+mZ5eLowhSkKz+ZC0cWdRL1+UhmvEUQCxJD+2Ht8VLFTTVkbC?=
 =?us-ascii?Q?QvdrnmipZhGfFBdb92no34Xknni41U+ph600faqccHdXuuua0SssdfSrJFlR?=
 =?us-ascii?Q?Dr/EowCXQBYLjeJ05KYq36UAKeGPswi/94I4IOP2YWK+0nEdp8nQvrhdWT4m?=
 =?us-ascii?Q?kCHqquwXBjEha1hXB+UzujCpk/V+DN18HLRe7d8nIsubh2rcmPn4Sogq9IU/?=
 =?us-ascii?Q?gn+6MrjErmwXo9fE3fh8CiyOBiJJKmSwLVX/lVtFtaE1NnJxbJ8KO8bEeVib?=
 =?us-ascii?Q?+1VfFDTzCMImzsvDAGR6IiJXqW6c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdWBDB7CrkbX8gZoxYJiGjv2j9hTig3IKT6Jf52rZ6W0Z/Qz4TpqeV1T9zfW?=
 =?us-ascii?Q?U4U9gZF8g7m9CG0/eqKX+M0pIl98SvHuzgm5MjHMZOcmNv/O449DgXX3Z3BN?=
 =?us-ascii?Q?rQ9pYG2MNyaCLoZbFTe9wdWSfQZwEZisG5B9714DEs96y3B1BfQ1XIXvFOfp?=
 =?us-ascii?Q?sI2v6bq+krzwip+qYs1OM9uXu8PtS9y2l/5pk/w9LXLzsXuSFDpgFwXlRIIf?=
 =?us-ascii?Q?nUluEcTV0k5n2oblnzj7GunchX5rWydFpIA7RzrnpKus7ijdkRYfFAv8U0VV?=
 =?us-ascii?Q?Y00FnHNePTLsVptWl0n4iHv0C7KcTJUU18L+sI0uUf9cGLSOVzUwDJ3IbFDq?=
 =?us-ascii?Q?l12fNYNDkQYIFn6dH+KldWhoySJYiwjxmA80UvEkRkH09nowUl3ReoXy8RpE?=
 =?us-ascii?Q?NrXNbxfw6RE2MUxJUYH5m/jHyphvYFY3RCrE3TwkvrX5EnnHzR10asllnUTW?=
 =?us-ascii?Q?rW8eRKelrc7AA9oA5KOIUy1TpF/Y5Kaz+LxsOzXVmp0Xvt2hz1vCnR5QTuhE?=
 =?us-ascii?Q?qjHZ/3QZ1H0jzuunTVokww1AsRq/L21ghwbEIFFTlZ0J+VEjGGYt6jkyul9P?=
 =?us-ascii?Q?olEx7qn/0PATMJhlb8ePj5ai/cl+mqkRoEO3UVamnOobDQlNYPffTJ0Mgc1O?=
 =?us-ascii?Q?guYFbRRiEThuZqqpWUWphis9zG9FF4U0OO1zgr5JpkE788Br7h2XdGqqEB7C?=
 =?us-ascii?Q?4ANUtyA5Uv0HKTWQyyQ0Ibx8PCilUs3XB1mujxcIyQynW/LCCKwxgUwBdvR7?=
 =?us-ascii?Q?aeWG/7nhjOkVIDbahG4uTTYS3vAGAd8qgu5KKO1m7f68TxBNqYLUacNuBYn8?=
 =?us-ascii?Q?ltmVJIlHThjNxptzMUnZs96vWDq+V4aF+OQAzcdPIBPLcN6sg7oHEDUYA+om?=
 =?us-ascii?Q?+pe5HQLwKmPSWoL1Z1uArbSEDooPOi1eikW1IU33KUSR+uzJKh5hgG7T4FIH?=
 =?us-ascii?Q?QQbbnpMr9/jnaQOwJzmdwWNOGhZLhgNwwxzaiiGDnIR87UnjkE7xzPGuBzrN?=
 =?us-ascii?Q?oFEiVbVeIvRuf4/M/fzDQwbBJ5R1MELrC0nS6Syy2DovP0qtsozwTe2IIrCW?=
 =?us-ascii?Q?e7LAqCJEjJb7FCoiAWFFGYPSIrYmCwcu1d+dgPpHMb28V6xwZsYITsvvDMmg?=
 =?us-ascii?Q?OxJkAc/3hzqxRaw4/95Et3Zhm+sx8MMp+4TvMn6hgmXNcat436wW/H7PYZp2?=
 =?us-ascii?Q?0/idhnSsGuFIa8cC1PmVWMMsmnepRjPi5kC8/LGbzt3fBJYkmztvfsiJJcCF?=
 =?us-ascii?Q?d1y0KyLavrdve9uQjoqIhggXmzVwQsEFBzyWTEdvTeqP8NYzrzd0VQGFLmip?=
 =?us-ascii?Q?sXPFKQuJo1bE6Nveke2sZcrF5DrfHtuRf0QDU0TFwl9u3B8spKpqtFG9Yy5R?=
 =?us-ascii?Q?La1iLzT6PbE+coy7SFfvqZblfCIV6HyfDfj+tWBEKlLdC7MauMj+DiaebRCk?=
 =?us-ascii?Q?seDOTSrKzJN2mHmOxgQU+crw2hmDFJZ5bYGjfN24lV11+bO1vFKSSDkgZ0Al?=
 =?us-ascii?Q?koLTAm4GLDwoBrTiKZJIAJX7JvAFqT0LcZWrOpOsrFA8swexJ0xDJUaIQkky?=
 =?us-ascii?Q?Tqp2B5OziIaRaX2Oc0aJy38nG8Lul9QYCJWCFfa/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dce9b18-8323-48fd-7984-08dd30f2159f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 21:10:46.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhhSSD1T9UjxSrhQSx/d2LMyOPMhMO7dZ+F8cJ0Lv0QnsIn+E7Pmqwi36VBUdkLJRtG/BsPHC2L62ZYyHFFiYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:

[snip]

> +static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +				   int severity)
> +{
> +	struct cxl_cper_prot_err_work_data wd;
> +	u8 *dvsec_start, *cap_start;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
> +		pr_err_ratelimited("CXL CPER invalid agent type\n");
> +		return;
> +	}
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> +		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
> +		return;
> +	}
> +
> +	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
> +		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
> +				   prot_err->err_len);
> +		return;
> +	}
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> +		pr_warn(FW_WARN "CXL CPER no device serial number\n");
> +
> +	switch (prot_err->agent_type) {
> +	case RCD:
> +	case DEVICE:
> +	case LD:
> +	case FMLD:
> +	case RP:
> +	case DSP:
> +	case USP:
> +		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
> +
> +		dvsec_start = (u8 *)(prot_err + 1);
> +		cap_start = dvsec_start + prot_err->dvsec_len;
> +
> +		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
> +		wd.severity = cper_severity_to_aer(severity);

cper_severity_to_aer() is predicated on 

#ifdef CONFIG_ACPI_APEI_PCIEAER
int cper_severity_to_aer(int cper_severity)
{
...

So if that is not set this does not compile.

Other than that it looks good,
Ira

[snip]

