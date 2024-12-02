Return-Path: <linux-efi+bounces-2245-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BF29E0C5A
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2024 20:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A293B2922E
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF84970814;
	Mon,  2 Dec 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRpTwPAl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331F1DD9D3;
	Mon,  2 Dec 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163167; cv=fail; b=sCBDFe4Mh2gT06Vyb38dHz2b35PEcaTn8YtoBJ3pcNESnc9MGjSocTxnrb60GLf10QW6A4AGmBmw5ipKQeqDuRBvI3h/i6KRjde/cpKz41LihkS9kzs7v1tLwvMqOYd6VJf/KBKdYrhgcJ9QnFIaYsV/lGCY9MauQwCMN/0DwIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163167; c=relaxed/simple;
	bh=HILSM/7dv91KDigDQjyg0OfvlI28C6FfQ62rHS0ZBKo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nS6/WegjklDLH9y1U6vgNrXU4LgtlrI/kqZMVm1Aq4oNiNW91GyxxYz3v79BaupOLKB4TUZT2pI8P+qdHu4vU5STTSfQTsSJh7l7dzoueXZRBYVrxRpJZkyoqxd/wkUnt2BgIDfX5Eo5W2j2jM+UZR84PVNplm+qwy+YrAwd3ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRpTwPAl; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733163166; x=1764699166;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HILSM/7dv91KDigDQjyg0OfvlI28C6FfQ62rHS0ZBKo=;
  b=fRpTwPAlYnN/12NQdhgBYkn73bymMJLO/CVZijkqv4Rm9U1Nhp0vslZP
   NwuIWKwV+Hc+10pcGcag8pjb6oSy6h8eQLuBqoU+Gp7gIOOWKemj6Suu0
   QnZZiMntt6iAYgV2ScrZ2pzAu3gC2n3weCeRD9RbyroOK75DKxeaIlI0K
   Y7YHTZWfEchVHdIRNKK4On4SW/yocu0R2Kcx2xuD1L+/rPFxC+nO+FBMN
   sBaWSmscjZSEcyb/2oC1eg6zgXFbUSzPfMcxJ/Z8RvrCu4Lj55lgXqpE1
   0N7lSAUuNocEGCgDuYo4nQQaOGUQxi7z5gYEqCIU/9uO5SjshER+UdaH3
   g==;
X-CSE-ConnectionGUID: NHsN3FwYTsGvgvrMHvJbOQ==
X-CSE-MsgGUID: SM/oAYwXQpCCPOv3u8arnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="43957605"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="43957605"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 10:12:45 -0800
X-CSE-ConnectionGUID: YxJe7OO9Tg6xUyRseTdyaQ==
X-CSE-MsgGUID: vejserriTXmKvsvLFUZrcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="124022632"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 10:12:44 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 10:12:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 10:12:44 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 10:12:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyqKcT/oUBVwxcUFNkIRLdi9cJq0aZ2NrNbARGBChLzlv6uZjl6sdgNPdARhflTIR7WZdDhiPj5hAhaEtYzySTXugj8vM78eT3qnEVfGLH5+rL/EPSqmOaaecDj6oTa/31zy696I5MzT3C82meYdYY4udTvQ8X1yDmNKQss1pF2qjS7KMdCUg9Q2lbTi9M6xmtLVcs1Tih1j9eXltoie4kYjbNxUnvQYW4sQwkfMb+/RVq0xgN5vUe0YdblL10Bc502TlnabdMBiloFoBep+2p5yZE4wvlvEu84pyGbIDgxe415O9pDzCBPQJXirDeIsqEDjpPPu9VyL215dAJ7u3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecO/bBUwD8UYM2gJRfugr7PlhtCpU3FRDyZg6T4xeC4=;
 b=dIFeTbXczOKkLYwcEZB9w096TucIw3nTX7dcetuu0tb0YCha2bvUcDicHfPqe+3e4uOvg1VLyfMCodbDGTE+UThMmQPaJM5STEMw2NZNgq/CXv9mt94arhKs7rDKb7ugFUnWpiJflnNpnjsJ0hRuCJG/8jBqNYAMA1d7ZnTNmfsyaOMkqz5TNWhPI3yvaeI1O69d6j/ywsSlvRaVpRf2fGj4WBl268NerrDMt43f5O1hvS4SvnraVcd8JXiGv9h/BFBm9kQds9FAfPWDe+qXNK3KeqJs4yq0TiKFWBiyZgIWGrBEJvTEgA0iZMVEcoh9AUFr+fX1FVIcczGnSbAQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB8547.namprd11.prod.outlook.com (2603:10b6:610:1bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 18:12:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8207.010; Mon, 2 Dec 2024
 18:12:40 +0000
Date: Mon, 2 Dec 2024 12:12:33 -0600
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
Subject: Re: [PATCH v3 1/7] efi/cper, cxl: Prefix protocol error struct and
 function names with cxl_
Message-ID: <674df891e30c1_3cb8e029432@iweiny-mobl.notmuch>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241119003915.174386-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119003915.174386-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4c8041-b23d-413d-7532-08dd12fce890
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8byCOzoeuhBXN4pRafwFGkatYsYZaydLjgqxojAeG76NlTU7bV4Lm26hzZAa?=
 =?us-ascii?Q?N8+9SU6MJnGEvujN1rw2to1gJFcXG7VH/B/g6JUDw7LP5EFs5rXlZ80bICSR?=
 =?us-ascii?Q?Fr9VSVhvvk3hZ/YR7t7CwywcPHguExdRHLkEHmK2lia7mrYfgmDc9bsUAucI?=
 =?us-ascii?Q?+TbvXlDdfIB0RICcQTwg1JrrulYogClTeh86y+844m0cWtFL6ZJ8I+0vqcb4?=
 =?us-ascii?Q?TmEfpOlWjKAfF4VYqC0EDWCr3MncQBV/glmK0sx8xKyyX/qjVQ8XmIQsa6xm?=
 =?us-ascii?Q?ogGIu+x4/+OJ/V1A2hJt02Nx9FqakTUBVwQe0amYERya6rGOwh+UHqCR9G+/?=
 =?us-ascii?Q?K50smcXorWl2K5kJdtVqLxFtLSwhSaKZgbe67aS1jAVjJtv5y7ZxbkwKikDa?=
 =?us-ascii?Q?x2uCttNOPms2uAu5CgIrlWmjgYj6UT3UJInLLgFpOrdv6YpRjG/ndTD7wH2M?=
 =?us-ascii?Q?EJ3AVE66uNu43R4OBjTH4kjqeEbzmpPnfF32i/KF99XxsPbVLAGEpnRDppXK?=
 =?us-ascii?Q?MWh4Aemnpz4YL+E7TDPeXxjXZ/pslGpy5gqQea6oZyDTlo75Nydf+XhIKd34?=
 =?us-ascii?Q?nLzq0hEwEb4Jtoa6WZztB1T0WLFERzMMj2kXR+2TMMxUZqK7ydZaz92jb0U/?=
 =?us-ascii?Q?bjT1maGI0PRwQEEEG9h00uglwWehVBTGVmAfFUkN1E9C80+w5AqwAtl40cPS?=
 =?us-ascii?Q?CYEP0S3QcjOOjg+/2L1JUH8UUUCXIHlLPzhUUPVr1UEpqz58AqC0vQ0fekLe?=
 =?us-ascii?Q?3RdJXnolzjmYmI3O49ES3maiqj/s9x5aTHRxyhBZcx+OG50F7Rtmc0ll8eXr?=
 =?us-ascii?Q?4UGPcFtsQjGGpQ8meZP8zeHpIXyseeoS9c802NpChBbWkNdS5etutOoelRlL?=
 =?us-ascii?Q?14+WEeRUC5QMnLsUdcYoU49oNBt35CxP6GWvJQ4wcB8Qbx+VrWaLN6a3KX3y?=
 =?us-ascii?Q?sRPvS2Hkssgz/l6WoRb6gXMsT5zwHA68V0HO0V8BZEFO5PzozIHz0YY/xRK9?=
 =?us-ascii?Q?9lP6AYJKpqbmYvDBH/uGlMio/0SeKhXHL44ERgvX6rr3RWTAreS0tr8+OEcJ?=
 =?us-ascii?Q?NjKO/5n3FY/+FCdaIU20MVJT+lfDhGvsO7mz54QOvAZt2AeGDhPDH/D2mFIL?=
 =?us-ascii?Q?5NGzTM7g4I9DplcgIG0TaOQ+7DuC2+CunqKmopdtpAkFpXZeoA+t4isUG/o2?=
 =?us-ascii?Q?SbQ05bk0sIhZsqta8/1p/KfBVuSlFh6YheDSzljsEqEtugenioXpHJyEVYVp?=
 =?us-ascii?Q?6vqf5W9SVTeM4/0NEtOArmdJAi79qu4BtTrpOVnCMjlpVcomMbkLSrA3YZf6?=
 =?us-ascii?Q?0wPv4UqB2yH0XnrDAiZmU+n58qMh1hTCDcnXx5kf4f5l/g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SqH9eZeHsbUDFNQ1bVElP3+VonlrDfL8RyCAAhQvMsgi3vBC/LsfPNgljVo/?=
 =?us-ascii?Q?mcyMHLDIB7sxeOPlIadH88//gp8iZ21/7QoOvdmkkIjNcOtl2TxAMcBbeawB?=
 =?us-ascii?Q?vgD6dMmIDmU6qQyfK7xbIfkmjx+Mfym884lvqCWxI9izO5pmhbbB5JwBP7sG?=
 =?us-ascii?Q?/aWVvxFnfmM3znN6kHKHqqVUgwcldCzTDsEtHJn8TBcLQkPwSe9MIYj+5EpY?=
 =?us-ascii?Q?0gx1of+nw8OdBUwk3TnzEdppbJPZUbPquZJnb+Mc/2TWb7npb2AfTn/mStiW?=
 =?us-ascii?Q?dCgg9aJbP6zfnQPBIdmwZmzDNuz8TAi+F92pWEukcwNCwYg6lOKwZnL9Khoo?=
 =?us-ascii?Q?zrEQn3GJ9w+0Q7pACInu1Es4/bYgc8iK4/n+ZufiN4GE+lF6j9XjNMwTdcMG?=
 =?us-ascii?Q?BAyPQH54xQb8CqiC9iWumC8dFuZhbwOGzH0BXwMah9DOOGu4S5kh/PNSGzD2?=
 =?us-ascii?Q?HflQobscNfXMvIIuuN+gmV1lbeQTCA7j6jvqBQaCtqR4AKAnskNP2pok0uyR?=
 =?us-ascii?Q?F5y/EF5gcKpv91gQEKDvlm+5lxfRax6beyq8ataNpivU8kFi/+qpsGAZA9gH?=
 =?us-ascii?Q?OyvMTG1OvVhSrG17sKtI0mGAFK+R5dhUWnHKByNCZ3y7NRlaNHJ3+qiao899?=
 =?us-ascii?Q?MXQw67y0BDgBLMcapD2MTl+9BFlNdctIIjCFrnB6KLlScVKi9yC7dnegPGVs?=
 =?us-ascii?Q?f9R/QUPHFfjnda3wQCIk46Gmpg6VH5EbWJvYhpnAdz54Tq1m+NlcPB6xR4IH?=
 =?us-ascii?Q?4y7A17fOhbkiyPNmi4YtOJmsy+UC/YR4pXrGaFautrqxQ1O3i+b6GxnZsF1c?=
 =?us-ascii?Q?6AzQEhCiByQ+o9Fe7u/+GY9n5k/Ikhn8m8sbsl5okxjaZ15aSEt5Q+oSXqQL?=
 =?us-ascii?Q?G7k/3wX3uZKLgBDto5I7gLUhAvrNiZRi6uUW3oHYveY7HFUczEHnzbcBkZkm?=
 =?us-ascii?Q?dGgATQ5bZIFUVHldkl3dFVq1z3PmVILCq9j4f460Hr8EQv7oTJWUHHGIeQFP?=
 =?us-ascii?Q?10TPseJ+L5EeFRcLdfvXyVI4itj7DhRDGiPbFYwfLguxS05tphd2rSy6VkCw?=
 =?us-ascii?Q?wqPi6eOXNXp4l4u6/Hd+P4dCLBPrliFWGKfmsysOLbitap8y2oEyGIhkt/27?=
 =?us-ascii?Q?t9uhakibCzvXyxmIWdrA7IoN3OAN7Tq89UYASbshNlpWNaKE9NAzY3Ffiwnq?=
 =?us-ascii?Q?IVKIMGrcOhDh4dGNIoAqW2EGWgaKosBTPeVoOYYR+msGiVfeCKb19MGO24yL?=
 =?us-ascii?Q?oKZmwLgSD/OvbqNEso05kzZ/KsA7JzRb85aVJltIND+/amoQ2zAgNOuxJjeT?=
 =?us-ascii?Q?cYYf/XJeoPQW5Q3E+7fbpYYCLbn+OUB1MiatWeHbuG8wou21o4819gim/qBh?=
 =?us-ascii?Q?vseTU+kv8FAgFkl0qmHxoOjZU+CtFMemc/ns6y8soD/GHEzpt4+GNk76z2Nu?=
 =?us-ascii?Q?xrc3MwGPpR7Zqn+wtioqLkr+x7QgsG7hBBVXiJr0Ldw21/jXwO9kWblEhdvS?=
 =?us-ascii?Q?wUGl+r7Rns2nUVjonl2HIcmhU02uizA4RxJOjt3RbgL73dErZlVC9psPNGKS?=
 =?us-ascii?Q?Hy+hTIZW6JAImh0zr4vBF8OvxJsk80bHCsM03VLp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4c8041-b23d-413d-7532-08dd12fce890
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:12:40.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0RcBJIiPjxPfiKwza5X1YSGFbVwK60IuuNWspdBt1SfCLLzJHqmU9o4fkwGeaNkwj/kchVMmWDUIbXi8zs0Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8547
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Rename the protocol error struct from struct cper_sec_prot_err to
> struct cxl_cper_sec_prot_err and cper_print_prot_err() to
> cxl_cper_print_prot_err() to maintain naming consistency. No
> functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

