Return-Path: <linux-efi+bounces-2246-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47D59E0AC2
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2024 19:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A308280DC4
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2024 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA721DACBE;
	Mon,  2 Dec 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOwKxiK2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289EA7080E;
	Mon,  2 Dec 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163317; cv=fail; b=Fhcb/xAFQruJe+9FD3qFxKrGTlHR2dznj5cuddBCCe7JQNly1YhGGuW2WCEfCJAfsi8LegzdI4V6nf2Fn0wKLNhlfMIO5UCv/rvUW+f29bHGhjfOj7UmHyJOFU1P5mNY8mtbPtPaOJbnMYvnyA3Ovpmw1GHiOsEohJngzZDVt6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163317; c=relaxed/simple;
	bh=Ek3p6pz5bI/EjDzwLPaXqJeCxrtl7ynwjaxxL5xJDVY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AXqh3ZfFLl0zQi7WayctFcRPM/Ug9u7w+3qkdqtm2ol9Wm+ryxXNMF5MBf5V5v8FW2+7Zi3ROSa0pzuGUMnU+jtZ/yJouCuI9zjRZdRK9jcQoEHdtM/IM6dT/TCxtFmCLsg/wyMCxrqDl0IwM7Wk9uAPUzLB0RXxK6sgJLo/Y8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOwKxiK2; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733163315; x=1764699315;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ek3p6pz5bI/EjDzwLPaXqJeCxrtl7ynwjaxxL5xJDVY=;
  b=nOwKxiK2g2ZtdapFAjViwCcx3H4vs3chV89YEPtYq9WPPWO6r0GXgcRX
   vNCKFsSuDGMoa3716wmRElLpP44nVCT9bidkBfY3jzxSORTfxPRVRpHcO
   9wBBtgu5ix9fw9Pi0QE7TxmrDC6mheKM1mSiR304PndjRGYH1TFK3qUfe
   UAfw4hy7G0Qbl2oRMiuCZKPyJstNWJGc/YCaLNbA9CK8/Cizn1/MuE4Tr
   WRJtU+EaG49T1S45gmFBqvqf0ylz5qa2k6hW8LoT+fiyLO1AnlUcSBuG6
   CfaOsDlyIdz8Vj1MZzaHXJnWYZCmuMDE6BOU1lL8xnE5zlfz1rIuFYBbQ
   Q==;
X-CSE-ConnectionGUID: tklMDyYRRbyu80V2dhOAmw==
X-CSE-MsgGUID: iql6gf2JR5yUzSVrmgRy+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33499205"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33499205"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 10:15:14 -0800
X-CSE-ConnectionGUID: hIITnEZdQBqm6Y67TisNSg==
X-CSE-MsgGUID: Pnszp5gXTkGWg+x2+i51Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93653690"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 10:15:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 10:15:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 10:15:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 10:15:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRsGI7a4qTSXAhnnKcPNU4jFe2kClV/lwugSC5HF6TKvKX0JhOEGUypxSdlhJIBMfXg8IG21/uhjHC8Z8t1xyOP4rcmV3OoWb/s1ZgS4dQpPC9vs76C0nzoLYhxnAKTVkoYUH+Oi0KIMqCx/zrmN9sKy2h3ldgkqsfHtAjeYeUr5LrTKxqEE1Pc6zRMbNIcMW9GMerc54uI4xRDWRU+kgXwJfpVO8cUxP5RtNlKEKH0rkPLJSwnavKIQFDpzez6hDQLs6/yL5Mf0Y5IHjcL+jPF8L/2BlVnUhRMIE0gRQnIFvEP7FoCR8BlWLlbooEwuFovN28rI7nJHl9I0QZrWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4jyLHykVPUHgBfNfwZr+zJhJC0T0g6+Cv8HQ7Kxrds=;
 b=IbrRbkE0ZaWWFeEUrZsWqpbInZR9k+pHfwCQo8sKbpqa3ZPECEBYsSY9X+WDW0Hvsph8gs7NfqxHaKMYE279RUTVI6uDyt6SYR2jyQw296cJy386l9RUM4JUdQntrOtdIdq83MipO1HM1iDBiraH08EqW8anK83BjsG6sg+J/AfljRRHWtzSsGUmCPl/Y6ytgtAOCioTpztGMZiFKNzqaDJfL12H5cgA2m8UM/fEp9aw+M94sRxfRo3rmqoup4haLTZbewDlIgc3h9dNplC7gA4vwwczGNubB12vFcDIbE4LmEi2DroO2LmHx4pwDh6ZOaqVzo0HFAunBgjVNAFpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Mon, 2 Dec
 2024 18:15:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8207.010; Mon, 2 Dec 2024
 18:15:07 +0000
Date: Mon, 2 Dec 2024 12:15:03 -0600
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
Subject: Re: [PATCH v3 3/7] efi/cper, cxl: Remove cper_cxl.h
Message-ID: <674df927bf89_3cb8e029470@iweiny-mobl.notmuch>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241119003915.174386-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119003915.174386-4-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR04CA0296.namprd04.prod.outlook.com
 (2603:10b6:303:89::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e19a44d-c87e-4576-c864-08dd12fd40a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oUdYGUoyPgkOhCHiKiT4Ay2WIfXZM43mk4hnrAzYZ30uO76207s7JXbM2d5/?=
 =?us-ascii?Q?t2gFzi89+igObXZugvuT9K2ntd9gUMmWBKh2l6jzcJT2GtuMtW8lVkt50tcB?=
 =?us-ascii?Q?Ed3vChKdrqD+8XaCFxEeBqOjZnn71VEbR2wOEaTB8+5tROc/lipx0XZiApMI?=
 =?us-ascii?Q?3Pdd9URIS5X48wUJKBg/wJuN3Gk5QnRIH1/62FJXNc4MrRGQoeq1OpSnxOV0?=
 =?us-ascii?Q?EbSchbN2zUlXur8YOLpelJUtaMjDmvkZnBCsylpYCg/R+RBpApPIQIjGVBWt?=
 =?us-ascii?Q?sOnXa6hMkHaAi4xNnCvlFgqA7XiKw8QrOrU5Jw6ZTr2UcDTFaVZVo1WulEM4?=
 =?us-ascii?Q?2IAf6ZtW957SAucxrPWMlLig3ZeEvi9ZKdqJ9yPKJPg40yQGRbc+YEROcY0T?=
 =?us-ascii?Q?jsHTLwoC3S03xPWfPmPGEQYdcJHlmJAibo5HAKrvi+KYVCtUg+YPpJLljk22?=
 =?us-ascii?Q?DMHu5m4Tj/b03mmYcb0BSMfSnbyNt4mgP2dtdb/o3N3SLaG/r5KQdDtJVt7w?=
 =?us-ascii?Q?Q5OYWqeBatS+dA8dOf7KmY5SNjHNv5hKiY9ZQ6ZEv4DgPrjIy159/qsoUn7H?=
 =?us-ascii?Q?LNGfqsiD31G4chnVKkUtBVuAKMEkjdo7fAuAPNMVhA7c6yLxHZG5fLUz58zO?=
 =?us-ascii?Q?gyvH0+utOgH3WUTfWfXutALkzNwlvRoNQKMnR2SfazOJRARMrUut+GISLQ77?=
 =?us-ascii?Q?UnKrvEBWUprycMmg51bePdd7m+7qZOZ4YFqIqf+Zmn54xYrNQ6Bbk3bBYAA8?=
 =?us-ascii?Q?2+yFVUgsipr2hYZtaKVosfGV2LgKvZtND4PNUK9N/pZYDpwUpawimEMoA7Oc?=
 =?us-ascii?Q?gLiMafAXFGjLpFmrZXJNsfZTxE0Z9BvAVcxo9x/tGAKZ7hU3AbAIqiqURaMR?=
 =?us-ascii?Q?T5K556yadzWu/h6sUY9aiOQ6YFYw9hjeJ5Mweu++UxraMldZd1t9oYuJ8Lan?=
 =?us-ascii?Q?Bc1EZ5NtX2YdwZQhjlUXH4oyo80RBkhZl1I0h8btO8AKz92g45J39hUDOesF?=
 =?us-ascii?Q?eapsuawzI4EhteROf5oHZzL7uHkqfPem8OIDDnfnBq9uYs7WBK0noSl3eqpe?=
 =?us-ascii?Q?wu5En8TdQQmT8d0tF0WhsW+P3P9z4ypCHnQH5/tZiE+M0kNkzwXZfu2v2w5D?=
 =?us-ascii?Q?5bm8zAcysyBkAocUA6k5I4PG0JPGVOUePJ6rQglccRtuDlMVG8zP1f76Sc1v?=
 =?us-ascii?Q?SIrgP/9JXJvpAE79rqfcLCPbWEX+7g1RIDSMLNgZc5dG2fZs7B+nxOtG0zgP?=
 =?us-ascii?Q?XC+JD54qzQBUxL/Gh+o9G7B3niiI0C768F3S2A+ewLmcAJHQ4LUV+Glk4d7Z?=
 =?us-ascii?Q?ddSemCLicr3roD8d6d4aNEsnA/RwYjGX8eHm6JVs0mkiFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pOaY8yE7aIRiQeSJtZFVgJHCMk+Fe5OOs0/fWdB5LjGdwSy0keYY85JflSHd?=
 =?us-ascii?Q?PM61s2lRV5pE78UzgsV63VQsQgN5fg+N3YfHiHaFb3DoQ0jNqEznu8avhF4I?=
 =?us-ascii?Q?NxQe4s1pMBJtOV1CIbWKbBGFI6n+gzoI/MMg0vUEOnaHPscmLY5MURs2Ks2f?=
 =?us-ascii?Q?xc9Ka8QrWCEbUQGqFq2d3aagOexrUrtxNevuYDrmcmNq0cDjuLNO9gP7ALR+?=
 =?us-ascii?Q?ZqldX1TzmMMHmmGCF4L+uSRLB0SXqbtL4lMjnpHrphhQU9CBgtZ9R5AVa7F9?=
 =?us-ascii?Q?YPB9BGSY8MhXi7DJ7hZ+I/jyZOMgqG8md7AsLlZ5ChuZfK5GRK/MJmeC5Vhg?=
 =?us-ascii?Q?iD64PazNZXRSTepPvuCrhxmcKFkHWLJjEFjE9HOX2DXVu4T7wJvSESmIKJnH?=
 =?us-ascii?Q?cuw8Yy2mOQ7hk5lGEIfLf4vTeGy7IzeEjl0sY7zzkkqUaKHmr6K+hJ+mtpVa?=
 =?us-ascii?Q?bS2fK/7/Swy8yeZkGBbyp3qcHlbWO+3b2JKWVeiuXFbrZnqog05A/jzOHBA2?=
 =?us-ascii?Q?yaGiiT1vSiEaPCm+AAgCKV3QCrPgAUR7uFTxQ5YmpP90ZgTKEM83sq74u9hx?=
 =?us-ascii?Q?K+pp96QUvAXN2Vcn4gsip3JCuIHLgU9aTlASdICCarEhblncHtEc/kyK+BNV?=
 =?us-ascii?Q?kWCmYRoa5qXX3ymo9EWJY/anRGNiIShtQxsB/CGPsr38Ji/UDxqPCq4DsVEE?=
 =?us-ascii?Q?NFC3tV9TCIouizbQ+qfckS2elImb6FvNIkmZ6mM9Mu16ZxTZ9bS7XIFIHwfU?=
 =?us-ascii?Q?FB3BH2biuqtRu79D1zBywGywpoJpW8WmKTSeQFWebxs/o6RO3NWJCWlz0rUc?=
 =?us-ascii?Q?Kb6XrJsFYW6/pZS+7OgE5v3xk/+bw+1MzRfJHwOoaIjCC/Rbi9V6WF1hqTgu?=
 =?us-ascii?Q?XYJHQE+9YY4IvhCMHK4qr4v2hMoP0GNiZMQFSCPhnjLbmDixML6EuVXvo94i?=
 =?us-ascii?Q?c3qI7619XNzwdlVqBN8ub2vqmU+w60gV0gEK4c1XHXuiWknBIyFcjBHfBPW2?=
 =?us-ascii?Q?6XjCgJIe3cTJEOoRtkhg9UBVAErPjgTzF6HjVJQZJn+YMDsdp2XonQ48PcPv?=
 =?us-ascii?Q?4mxESsVxP6G3ylYZIoIBLaEm73jJBDRKc5vpcu8vhFYhUEfRO33Jsa0fel3c?=
 =?us-ascii?Q?eoaPTwP335w1Xm3GoPVGrEWUYpWOgB/3h5vY2Z0boPEW2fpoUgxyjrPd3Enw?=
 =?us-ascii?Q?+4uwODwLy+hJoRSStG2IbfTXbWoYkHNK7iqbz3KuLe+NeHfVc4B6WUbEKzrN?=
 =?us-ascii?Q?VkD50VxnlDWzVyRTnLoFvoLRfrm5nDzNHOabhL5pNG/eB0Y7JZqYjB82bGAF?=
 =?us-ascii?Q?YcPUDCM4gNZ+p+xoZi3bsq/dypv3x/QMAa4B5BWCYloLlPMsidpDxh0u6A1b?=
 =?us-ascii?Q?jWD0MRS6wjqEksLRVhd5HOA1m5aVi9F4OMneYDHjsgigNrtj+tH3+1FSMALK?=
 =?us-ascii?Q?bn2KebpD2KcF9+4I1us+eOK1VbVTipg3gojHnGGW4tVvvuEd36aWf/MH56cG?=
 =?us-ascii?Q?nUF/DKU5tQa1+SIwUCLEdYIuREuJh6lVWfeRk0t1VKxW/GU/GCX5rfL6Z5zc?=
 =?us-ascii?Q?Q/H7PvHT5ahkAdPaUv7s5ujNTgCbm20n2hdpkrO8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e19a44d-c87e-4576-c864-08dd12fd40a7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:15:07.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lYSzAGmPT8Plyq3IYcfpQEa0uuKOvPvUPulx87dGUSy9mhd9ucm7JbA9MpEDBCemQ4IBwdYFQuf1mp4iaMayQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5912
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Move the declaration of cxl_cper_print_prot_err() to include/linux/cper.h
> to avoid maintaining a separate header file just for this function
> declaration. Remove drivers/firmware/efi/cper_cxl.h as its contents have
> been reorganized.
> 
> Eliminate its corresponding #include directives from source files that
> previously included it, since the header file has been removed.
> 
> No functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

I was going to make a comment on this header being pretty sparse after
patch 2.  Thanks!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

