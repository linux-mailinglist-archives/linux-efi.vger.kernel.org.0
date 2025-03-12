Return-Path: <linux-efi+bounces-2973-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E071A5E32A
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 18:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE381897659
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 17:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20341CD215;
	Wed, 12 Mar 2025 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bc93h2Yg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8B1C1F07;
	Wed, 12 Mar 2025 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802203; cv=fail; b=GkC4O720xgK0oK8Gz3AFMp9TjunO7C3LG7CeBlpDJm7AdRYqpqPrQ3Lc6TeR/TwUV2GT3gTWGWIDlXAHc2mi3fv+rtT6whm17ahwAowJPiWPwdbePip2PZOI4esXDldkg66IXc7G79iDdOGKGzh0JvQdIXTjrcXJXB2OBcrZNYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802203; c=relaxed/simple;
	bh=X24va5bFJ2xXPyjxdNUqJ2UELYUNR2y6Spg4r5JobrI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pQWnZ4QUepmdznPZxs+5yweePTABtoDQ5XQJDlcXoC5mfKl/1iScMyNcwthNmaOS1N/4npIgTcHTj/63LZO6UeZPSznkLBrh5lWo5EToeOLT1eQu7p86g0+u3ivG9DW4zUi8V2W2uPZWshtyT1rFMuo44fIbaAaZrOsIi2zC3yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bc93h2Yg; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741802202; x=1773338202;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X24va5bFJ2xXPyjxdNUqJ2UELYUNR2y6Spg4r5JobrI=;
  b=Bc93h2YgJHQD4vy12O9dUeC7pbtED3oeV80TAILO398YTb3wJLrw11VM
   M0pgAALLOSyBSrtjMrobyor3SDo78bztkK3XzV/7VdD+KyTswxiL6waeN
   eHWCYfU9fMnuXdlQonhzxeE2VfgjN94s4SySDRfNEWaZZrwr9oJhrzF0u
   HSw8Ww7/PS9AH89UdNgicSSCODI+oRxJ2GycveQq1B6efNVaSUMMZNI1l
   r/eavQoU6QyMZisv+WmRNhgpfg7+pHd2TvPynbgFzSqWsvuvcH5GN5wr4
   9TJoDqtfAxCgfDJ9382M1GMcJfffaaEJBJZtXBIyi/h1bpnr5SvUQBfps
   w==;
X-CSE-ConnectionGUID: v0QC07+rQqaAWEwyZIgujA==
X-CSE-MsgGUID: ly6VyHmXSYqTpM2/20TPRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53889609"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="53889609"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:56:41 -0700
X-CSE-ConnectionGUID: ktU2ZJuNQaaNRPQI0yauDg==
X-CSE-MsgGUID: ssgYph6ARiCZ7vbpUoPs3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125780536"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:56:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 10:56:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 10:56:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 10:56:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pR9I2sYQQt3D+AsK8Fn83f3/8hQH6HV23aDjCLwUu3eTdfKG0I0VuhnEmC/PNSq/THqeTwAdyZudk4WEP1pQ1FZfi6Xlw0fFbyAzSZzOfjfwMHS9aEANG9tjfCYCboAjScycOSMtBFex6+59mX4IpRrfv3ggIEls2Faw/XAJdFS0Y6ijcbw2Os9JoazvHAYvl2pnKjSOjzq5iD9Lz8+6pXTTLEl0Sl3waGPqKxcAm7hsayHccrJ7t4/z+lvL0e1y9K0eOgw6073TxposT9HMXmtlQnc0HaLoLn9GGPipboQmKvNjnGa+671Cfu3F06n/w8APkT5JEpP6OH9MF2aEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2+UZEQnbNFw3MdrRxSr6Lv5+CJwMma351xxU42EKzc=;
 b=V561tLC5IvoVBqy6cw0joCZtA2mGAV1qE/A50TaNEg6EI6+/SJDz5OQ03gl1lj2pZnJAzlfigkmzoD67wxT672aRi0w1VYKyXNMt8XHfIcL7LC7FjCfRkYehk3OFs7sAnqLfDA1mYjuruGw5cEYROXDssPCLnVnDQflXLPVKRiVo2qFCnLA5ec/zvHJXL5/GFb65sB9gHp2kFeTx9nsQdQ7F+UT554oMKXScoyZLepJA6hfxZOoyYxNpmhuswBHeKcaVx/GX/I01ZluNY1HDyPWbMsiDw3brFHPh9aDzO3jDxMCcgbrsW90xwkgztN4qt/Dr9odWQggOX04+nxryVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW5PR11MB5809.namprd11.prod.outlook.com (2603:10b6:303:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 17:55:56 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 17:55:56 +0000
Date: Wed, 12 Mar 2025 12:56:05 -0500
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
Subject: Re: [PATCH v8 1/2] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <67d1cab5e4210_eb013294b3@iweiny-mobl.notmuch>
References: <20250310223839.31342-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250310223839.31342-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250310223839.31342-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:303:b6::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW5PR11MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e60aff3-e660-4775-cc05-08dd618f23a4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?10YTfKCJ90bto1f6lkhq3neJhbYO7nRxs/RkcvIT8ve1u7dqHJK8/v/72Qky?=
 =?us-ascii?Q?UakQyHuujTetkb9tCJmM4gi2W6X93yszypcMpMat57B0ONYl+5mkSh4RAHrc?=
 =?us-ascii?Q?biZKrThuMShBGcjEEwypdH+BbBLY9ZzxD/DY2DkBpPdBgiuGb97Y8wDcwuoX?=
 =?us-ascii?Q?6uht3wBd5RSWCQKN//EzwXYEv3WhPek2o2H9wgMZ1Ent6J9PGA1J2d2MKjSc?=
 =?us-ascii?Q?ke3zIrfxUIKRxlSIlKUM8MiSc5tDQuPdpr7GPLXdIrWo8Yyldy6fZZi3nxUZ?=
 =?us-ascii?Q?rfW/XeEdkYgToljOyYStO35PPCRsXJ4hLoKHPplyhm8FOTXQBwmbvgwzhlMq?=
 =?us-ascii?Q?deEeGLagjPjiE9HZvz/d7Ala8C4q+OP3isNTKKL+s2oHXyXXLg7RxlkVDJ7j?=
 =?us-ascii?Q?mOYhab+fm/IQs2Jxj+VZ4Jp/nAa9Ko0AUfaf2gcPGlRKDuSBKekvcDRqfa+2?=
 =?us-ascii?Q?G4Zwbuqi+bIGG9j5vczI8DQXiHjaba7tT6qHS768ZMsfeB7soOnz10LgwuR+?=
 =?us-ascii?Q?a6HDbPEsy9jornlQ5xI1IV9RBo3AZmpTMRkui2SIPqHwDhEFIoTsLrlpeUt/?=
 =?us-ascii?Q?6j810BfXeuv7yQfgw1szmps6IOmyzxRZsTmzXgSyBjplHZ+WIKSgQj7Ief+0?=
 =?us-ascii?Q?L1d1o4V4modwexTYE0p2ha2wKCyvKi9x+m7fRZvzNQlSMSWX9TBwciCXQfp0?=
 =?us-ascii?Q?NvdP+fjX0OEJHENMBZqoc9yuRt0k5ILlNFeswqB4BmeUC2CZBYyLDFfZnX7O?=
 =?us-ascii?Q?LhbqVZbieML+TNklq74vJIaIQlq2tskQSxEnZUYNOFsZq1lOANqWoGfCpqQ6?=
 =?us-ascii?Q?zWRSmqCZNllPE23dZnNa2p7e/icsA2o9ZPXJNeAWtC3bzQoARisGkAOm5RMh?=
 =?us-ascii?Q?I/joPPyrTPxKuryKHAsLs5lnWCYkZwuaWlNlV31jQOFRBb+Bm0V+szEAsgMt?=
 =?us-ascii?Q?Y5f1qSB5WMGtTnu9AA3AZBNFmzISUnnrH/fPYShKUR4MtTpjBR7l+y7VWgpq?=
 =?us-ascii?Q?KA6HBI8fbS0aKQUHDbrk9Y3ztraulRhjyazhcYeowQSUUdo3Qq9b3ucnXUTw?=
 =?us-ascii?Q?voCx8+X2nCDXUEwNRLJ4SqJwZZ0h2HYPkqMJnMlGuXLQOFqXNTzinpgmVYZ7?=
 =?us-ascii?Q?rDVvZx9NMEJXj23jrQjiYxquD2a7HhS3kckfoTF0ct8iAWlk9etjdXhaRMiD?=
 =?us-ascii?Q?kitGZrBd2McWLyZ3fOkt+no0pRHIeURNKAFYWzXjGr/XqU9360Z68ZFMR028?=
 =?us-ascii?Q?lt270PGAEhJEP67wAJd4UbWGlN8/WfRJCO7XOBMcoCy7v8G9w7tYpKLxmbwO?=
 =?us-ascii?Q?XSRViXLiGKj0ZwAvTQFA9FdWpu5j62mRJFCnaw6NDrFmQZNw1P+RMlxFeDBk?=
 =?us-ascii?Q?GAJ1TSL9ZndrTRXMWp1HYPD1tDqr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DK5tSx8nrDcBcoDCG1ZMe0SA/dSNIdc7mB9G70tDR3Tt2XmBU/SOLkPjbkU?=
 =?us-ascii?Q?9+L4cL2FEYa4bguSO+yY+Lc1ZRCDoUmgiVBhBdo7d4cCeW/E++jov379dxCI?=
 =?us-ascii?Q?KkBgJn16K8eAWVi25dT4yMCJg6FmuDbZ4BcGUm1HUkSOU6P5HrfHFj4YGzgJ?=
 =?us-ascii?Q?baPGnMV3R7JAcz0OAGiOgEHXb/lD58Rz3W+nGXF/nt/r/gWNSEEbIXnE+BeF?=
 =?us-ascii?Q?Wsl71kp9aOpyLzq//rSqesIIUcx7F5Fgj/Y0ajSbeYcy1c67Oh3qBKoPrQeT?=
 =?us-ascii?Q?wz/5NKue6yxiCPCXF9mRdCO0NmUll2tbt8nNjW2Oex+VFa/vnB+Yz2tqD9r0?=
 =?us-ascii?Q?WG2UM+8ksy5QsqrDu5ecifjJJ1EE6a2nhfwYqw5np19KSSkGcJeI25PtyQ/k?=
 =?us-ascii?Q?AcnQynOX/7U3VvsWP9eD9OVxlzbEvkrR8ZwVSK3wfxmr6NHCQB5IsP0Y2m8O?=
 =?us-ascii?Q?IBQXrgARKcCtYqVFbOIcwX+Q6G2C/P9vReT7sZd6YK/UP5S4yMDBRyJB8/Yg?=
 =?us-ascii?Q?M5350PB4598GdxdnLGVIqJA7OVp3TVTeKV+WSSoR2581ar4dLqsKyKrUPP5h?=
 =?us-ascii?Q?bymYU5yemCkjiYoV2GbdC4zoTfb6X/tFR9I8r+4TDSVyWJc+ocw/I1jZEimL?=
 =?us-ascii?Q?ATfoRKVOP5WVoc8DtjiGykkYBRNvJKMj6AYmbojYd16Hdp5k8wL85FvbCbyS?=
 =?us-ascii?Q?r+GO4c4xl4uM1dyYyvJp10Vk1QR2HjlWd+JoMOxGfhYcjRSAZpAnQ/Jd5pio?=
 =?us-ascii?Q?WHFvGETRq6SdEaJE+oI9X9mLWqiOxLXH8+6UA/He201dcjIJusWi0XK4CPOY?=
 =?us-ascii?Q?2BpdT52QPCDfAZm1GOjFlYKToSjExmRfq2g4A0F0RmMbtYeB6x5r/ZG6oI9v?=
 =?us-ascii?Q?mOZD/oMs6zFLMxZARE5eqMBYU2wfBXrJUAPs9adAg6OgBGWBkhmZGKsachk0?=
 =?us-ascii?Q?ADf5VNMvF3DrEefHvOGg3lUNRqPsmIsVPIOOHTU21VQsD9uH1z45c7H44nLf?=
 =?us-ascii?Q?Jx5xwEAO3eEpWiG9j/1vIfDkS8EvjirE0V3ZrwhVvww0D8OZQvgvCV4+qiTt?=
 =?us-ascii?Q?wJOCzkR3ap06PZdVJV+vTD25hJayWi1/fTCDXb/GXVaO0uN9EO2gLuAGHAWX?=
 =?us-ascii?Q?XthJln0BTV5fveWp58npMCm09DZuWO4hf18EjXuPUQnCxA9CrqQlZun+2TXp?=
 =?us-ascii?Q?WQORHYkzSnh33MRhyFZWxOPYuFv/Fa3XXUboRWwTPDGWQWHod1BlR9RoTMwd?=
 =?us-ascii?Q?W1itvXRdyJegYNDuwnrwQrEFFvJx4RCd8oowRKDV8cS1yQWOZto3xag3mEPf?=
 =?us-ascii?Q?z+VOzZlsNH2Ioaz7gMxw4qPove4Cvy4j0eYG27zEw1/goTKrhNaPTd6+WaJj?=
 =?us-ascii?Q?Z3UIDQdjfClMfWKvEDYlPJ6W5rXtx/FQXvtH30Uw1RyButjTTt21dgKw66gw?=
 =?us-ascii?Q?QrG2yWUw/Gx147IbHdfdFBKCVUM86tMS+ei3GVTv5F6q3Ed+Vkvhx8ZrDOJ/?=
 =?us-ascii?Q?14/H8TPCdBIW5WxIBEKLqA0qFciARmRDaxKFjyKOXP66UT9FGIjrBMXHUR3p?=
 =?us-ascii?Q?6jFvqglelE6z70s6y0mtK8ZZGIG/+ZLG9BOE5gf5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e60aff3-e660-4775-cc05-08dd618f23a4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 17:55:56.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPPO6HbhS5orUa/UlVTZAceR+ybnMpwWp5x8LyxQ2hvJeYKnPamXG7+8Sf7LUUgMp68bvvlP5LeWMnrOU/Py/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5809
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

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

