Return-Path: <linux-efi+bounces-964-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C208ADCB9
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 06:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504DA1F2298B
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 04:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4243F1CAA2;
	Tue, 23 Apr 2024 04:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrSOUKMe"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B791CA89;
	Tue, 23 Apr 2024 04:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713845771; cv=fail; b=VVt2fvXV2RE87LhmkB+IpF8jpzC7JXQMoK3wEohOXcU256ZDWrhFsXCB8vp7YbJJaVZX92Ius7u+q8wTcBOklS4gLEk4jvuaZArmoweEtnNE9Rp8NKI242eEpGQcQwPCkDn4l13HD2RBc3b2/7lQdtgL0lTSIAQSqXlNvIFLJAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713845771; c=relaxed/simple;
	bh=JLfK88UVBW9AJSbBHZmZIJMVC1z1gzv04r9RkS/Naw0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AABxOUjMWUo7v3r9uS4vW0xSu+aKV2hn7XoLrhhVkG8SU9NcriElvlY55OQM1ratc6/RSQ/ePb666KleYu3U+deCwznynzhiTSAl/URDtCpQ6XJpRPESiL1OpR411iWKh0Pcgw9ZFkNPW80DSZwEWW/KHiYat9Qeeix/V+hVejA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrSOUKMe; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713845769; x=1745381769;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JLfK88UVBW9AJSbBHZmZIJMVC1z1gzv04r9RkS/Naw0=;
  b=LrSOUKMeRZp/JsT/Ru7iUy/e0kkAoUi411jlVj9+mIFDfHZYuoD9kvaW
   aiF+m7BWzIb13tdA9T58FiC2uTWg67KLLoo1IfAsfLlR+md3J6gWdAzyR
   B1I25WytnL9se7VYRQyzWQUMN85XeVCh/Z/iW93Np9qjDzNPlOyelTJTz
   VFs4T+nDoRdUmt/C5uw+mquHp60J8+uIzfqiyDN702pzcPfrc0txvw8ux
   awigUoRrNdyZwnI2IE9DXfKowU6CaCaLP2+ih9NvDS85aN1VHrxz/c5vx
   waVtHFKVGXfVBrpOS/YypVzv3Dce1+x9BL5CvkihuRukkyCtPRs5VSEXl
   A==;
X-CSE-ConnectionGUID: ESp4QAA3RCK78VB/NNuQtQ==
X-CSE-MsgGUID: ynayqu9ESfiOGQYYwZ4NHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9536199"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9536199"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 21:16:08 -0700
X-CSE-ConnectionGUID: UDrc1IBNREWeYjs0dGuF+g==
X-CSE-MsgGUID: mFguh8RQR4m0mMTfK3JGaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24304691"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 21:16:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 21:16:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 21:16:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 21:16:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lviuefzXJcDXbepNUquO1n4V44/8YSWU3gE2Yeu2BUj/QN9m7/Su/7f1svd0n+UqiDrIhPmk7X+ydCz/qsAaEj5taeO0gjzsOrMPEUThN/F2XSzZNQFymIWNec7aYkLXZXoQJVgq7RMBN/I05vuDNzWmX8STtw7RPkrCqLZjUlEjc8u+ZoNJOpw4OSJ4iWKXMHhSvQXedCPD4Yia+svRyt+cMMC9qq3QTkZDFt+p0TaOrNTcd+Mb1zDtxFL4aiM71ywf30n1KpGdcWfRBDhPzLXcKTANLPIp3ojqaFx17PypN9AEh6SVayN4fzww7R/VLmxkehG69TJnIotavtvbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oPPgXY3KBjT8wUxEJi/k3ZLV3SGekZRI0XJKUcBX9c=;
 b=gOlYafGoElOmPPWUVzRjnUikZmy2S0sFZd4XkPUd87hpo1Vk2xT25CePgO+9Ku/iUrpQevMSsNTnMygqYlDxqUzYNezjsseclFzw89/X9hCC2CIg2/kGvFWEYv7oUJeMc3py2PqoimUGje0Gzoo6OzVCdtTH34yupvt/UaN8wNyyoQgHQu2N7zlFOTL6QsScYDLFNFOM2/t/NuCwbi3MqF0Z75nQ+UEky3UtQTyrOnFqKQ8Nkn6CDOXuRvJf50NsTz2gBcBJShsj81V7uM/kolWp68TCWDTIV1YdoIu1WwwUvI8Ne7PkaBrCNeYhNXVK2Hyuj6l+gWTs55VzkMldOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB7255.namprd11.prod.outlook.com (2603:10b6:8:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 04:16:04 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 04:16:04 +0000
Date: Mon, 22 Apr 2024 21:16:00 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
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
Subject: RE: [PATCH v2 1/3] acpi/ghes: Process CXL Component Events
Message-ID: <6627360078428_bd77929462@iweiny-mobl.notmuch>
References: <20240422-cxl-cper3-v2-0-5cdd378fcd0b@intel.com>
 <20240422-cxl-cper3-v2-1-5cdd378fcd0b@intel.com>
 <6626f8c9404f2_690a294d8@dwillia2-xfh.jf.intel.com.notmuch>
 <66272f40420e6_bbee62945d@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66272f40420e6_bbee62945d@iweiny-mobl.notmuch>
X-ClientProxiedBy: BYAPR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 575e45b9-a717-4c77-1ed4-08dc634c1774
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w1NUE8cw+MTzFvqeKbGjf8vI192Y0zxC3/Ik81wy+YOvin8GCzZIG3/I/5Wq?=
 =?us-ascii?Q?OhIHTazWDYE48jd1fhp3tHFflI+SM6C5ulYnWtXyYypGep/2ltkk2ZFH2nsz?=
 =?us-ascii?Q?Dvq1Rx2huiCnQ6HK+OuXeXIgL5uJ/X64Ftn078YM2bCw7gE68g/n+iEUOjin?=
 =?us-ascii?Q?O9zyz3TajIzAQaxVa1dypdKbESIboWRNZCWCEwpch5w2QteSXDYAgpkaptaB?=
 =?us-ascii?Q?dmtpQOzUfec7uZSuJNSv4tHUMc4WFrEiIvU1qbQCVYRoIN/9ruWttQ09uAP8?=
 =?us-ascii?Q?dimMDqS+jLAxCH54RJNRMh7W+I2vj6NjDqvz241o8GyMaI4Gx5tbId9gF5mi?=
 =?us-ascii?Q?N5mNsLtBHMjkERBiJ72oi4tldQ+37xY7NB6urqjyXmJXJXffyqdYi9fIeF7L?=
 =?us-ascii?Q?NcR5KP0H2Fd/kNgFifqOjDX26o1NdU+YKTZnHx2g8/Ctzr+E5Ka2K/561ZCm?=
 =?us-ascii?Q?OiUEUfDOX2/KJqx0TIJI7U6BRKw5t9cFMYGgySlYtZk09mAdTNg5H0PA1UHK?=
 =?us-ascii?Q?q3EGGf1pWULaJeTZPcmrdhbbngdEwjdO/x5nN68JPMeetu8NQ7XD1eeuzd85?=
 =?us-ascii?Q?jTWKE8orgRvF3AZVwpsipRZOTnY0qnr80NnRmVmNSKhibE5Y369AHHCzU7Zg?=
 =?us-ascii?Q?PzYKYuFrhj4aBeAupVi+31P7VJlsRpFvfT12xGy6/0jHEdULDVV/tXgXzTOn?=
 =?us-ascii?Q?PiUPiaRuge7yp3zwn5RMOldVTTPAZ4fqckogg4a4chAj0jQFQuDNDf1fQiFS?=
 =?us-ascii?Q?xGvpl6njOkAaubc5e7Zbh5sNC8n7F9RVH8H71DXmgsPkOuLiYdhiU8P2he6a?=
 =?us-ascii?Q?qtf1tCI47/DPIAev/dxb6u6e8Fyk/I3vHp31gUyLr1NCzeG8xmAl9HLxNoH5?=
 =?us-ascii?Q?pr2S4P/k1R2VTB6HrsDJhq9HM54y16GIrDwbOLvMCytcdFMjDbbVsGSST3ar?=
 =?us-ascii?Q?rQbiLamd9m9U4BGEyCI+a1HFobwr9Gi60wTRUjQZAarv1Qr+h/rxwA0TmiFT?=
 =?us-ascii?Q?xJhBBc/5THM298Ha2yBACm91Pens7PhVNe/kAr1SB3uyIMqk3FOnJP6U1mfY?=
 =?us-ascii?Q?ETACWZID8tq6Uro3yhSRWnE6mqoUu9OHSNgaZL8R8ABAaJk8rrtvlBXhBowB?=
 =?us-ascii?Q?1U2iOsORyb+iYHVxZrJ9+DbvLUCDSdgBFoghQtt0OiiBkdlRKKUxdQs1csnF?=
 =?us-ascii?Q?F6KNynO+5BxVbZe9FGKE7xEyz/022nCLEGMDs5B1HoRBpt6fGe6qlVqat71n?=
 =?us-ascii?Q?2cMKOlxaozEtB1OlI/tcXRdZh4aoOq+SQVZXZGrljQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZZ8bD+d0n4GQibjLarw4oWAF9nlHN/PEz43vQmorRq7vv4XkpTVhrrT4nrHz?=
 =?us-ascii?Q?Xd9MLhBS3zmG+PCFlt3ct/WrFyMFTcjEri3gLCCNt3smRZBO9r4K897WDafV?=
 =?us-ascii?Q?oTqeTmTAgdAqeJlbhFathVCl2QaSnK4wPybZC81WrxkGUyVpZQFdpBWFWPMZ?=
 =?us-ascii?Q?SYW7AUmCqbk8AKfgBo5q+8tMUHvDnGBaIt9pVzpVPNMaQnwd+5ThDmfytAOO?=
 =?us-ascii?Q?oI9tyHKdS0vfCid/CxZag9fg4vnXFcEK+s7wWfgV8mQ44UoHKBrHuvd4VqvL?=
 =?us-ascii?Q?mzzmCkE6LM5zPbmoxozxzKh6AKltsqaUIUevRn5gA92PoVCXZ1aiWDdgYvHK?=
 =?us-ascii?Q?WchLuXolS7PO3bY0VDEKcAkIcouBV7Lr9sYBVof/dzPSVsXE3NZ/uPnnacKq?=
 =?us-ascii?Q?FVtAnXw8QbH4YY70xcQkKGvEsNEiw+h6GWkTEIkUtD1Ot19jD5ZTNnDvURj/?=
 =?us-ascii?Q?BTGeqyte+nPHzK2xEwBV0onFtGK/T0f2wn+rPz9J949Bx+xMH9a/QsvnH+Rn?=
 =?us-ascii?Q?GuI8tltR+k4aIehJxJKts5OYVhy/2sFDK4TEPyt9G9izM9Gewpbifq3Bc7qE?=
 =?us-ascii?Q?G1Bq4LbxXZx7M6i9AkGVYL+dQag+HHq+KjGSZ5xZ5Wd/uzkw9AKqWWQVbiOu?=
 =?us-ascii?Q?ETDUNq63EPFblCF7LyLdCbjQuWg30jNCepJJWNQjkP7W3cwikeVfcGuMPxmZ?=
 =?us-ascii?Q?K54oh3so1ugXS6/fJFLXccny7l9lo8o3b0nPIfXVOIx7R0oJBEkdqtYBsQbh?=
 =?us-ascii?Q?YMF9wYd4CQCqJBy2re+EIvJBckp0z+C54q0rXkNByc9zahBA/U5/yCTjw81b?=
 =?us-ascii?Q?Jo910Pe8QvJbmL8T1Wc9EFx9KTwRhz3353/jUUKXKSysDG4qfEttWjbtXyIx?=
 =?us-ascii?Q?PfnNeA6n495w3UC94b9zAYuPEVgctDHt/TVVcHjXH0K+3QtxG8MkCtWnZKMi?=
 =?us-ascii?Q?5d8qOlP1riVVeUertpVxEkTVCDhfplZybQalqw3JmwROPmH2sCQnbUyuQp37?=
 =?us-ascii?Q?41o2tgm0auJHaeBEOzduJLDq8hv4wZIqbdf2d6kXTPvUA/lGal4ASGsYmQ2V?=
 =?us-ascii?Q?zux9Jzl4Bd2bd3fOoWLVPIrcd6zvNfM9mALfIl9tsEKuUEvgolIntRJIcJyF?=
 =?us-ascii?Q?CleEb7bjhBsxndI6REJEX7vucKR23t5JLSTU7xPVS/cAmGYqrcFK/Vm9Lc+e?=
 =?us-ascii?Q?RaV0WtwF/61EuUGAtXzeBrAxZ6lVMdMg9u1/qvdSatDWwBZIPfCGiur4RVCe?=
 =?us-ascii?Q?BP9bGxmXQ4G2T/98Gzt9W8vgsDkgHIn/3w/KD1CP/vXbeh7GlmzCWVToP9kQ?=
 =?us-ascii?Q?Ix70jPXNVw+gbZcr6LlG3XlHjqpM4idoBuVtGAye6FqrWrIgLqtn36tPZv3O?=
 =?us-ascii?Q?A5MEyVzfbwMCRHIJyrH9cPx6LNyZPrOKAzIrcuUrPKXMbEhK7Sc1yaowO5HQ?=
 =?us-ascii?Q?daUoI/r2WmUVnC7ADjB2eejpAz8f0xPnD9xvOHq4hvcMxAK8Ar+8J7tNfWum?=
 =?us-ascii?Q?7Ifv6oGvoYc6i4da8Bm0gtli0fjAQLA7HpGAn52q5h7TOLnkm77sDFeaPlVE?=
 =?us-ascii?Q?G3srxvHyOKZT1JwK51CwJR1M2MIBOe5f9Bv7Q+QR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 575e45b9-a717-4c77-1ed4-08dc634c1774
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 04:16:04.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJs9Idjw0wejZYxh7cKH/IBYqCsl3QCYqQw7JzROVeWQ83qE3GPDZD11LwmXCkxrWC9ctYQvOAxaBTIT8NMZ2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7255
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Ira Weiny wrote:
> 

[snip]

> > 
> > > +static cxl_cper_callback cper_callback;
> > > +static void cxl_cper_cb_fn(struct work_struct *work)
> > > +{
> > > +	struct cxl_cper_work_data wd;
> > > +
> > > +	while (kfifo_get(&cxl_cper_fifo, &wd))
> > > +		cper_callback(wd.event_type, &wd.rec);
> > > +}
> > > +static DECLARE_WORK(cxl_cb_work, cxl_cper_cb_fn);
> > > +struct work_struct *cxl_cper_work = NULL;
> > 
> > Initializing global data to NULL is redundant, however this feels like
> > one too many dynamic things registered.
> > 
> > cxl_cper_work and cper_callback are dynamic, but from the GHES
> > perspective all it cares about is checking if work is registered and if
> > so put the data in the kfifo and trigger that work func.
> > 
> > It need not care about what happens after the work is queued. So, lets
> > just have the CXL driver register its own cxl_cper_work instance and
> > skip defining one locally here. Export cxl_cper_fifo for the driver to
> > optionally reference.
> 
> Ok I thought we had decided not to do that.  If I recall exporting the
> fifo had some difficulties but it may have been my unfamiliarity with it.

Looking more closely I see that AER does something similar but it uses
constructs which I thought we should avoid.  For example all of
ghes_handle_aer is predicated on CONFIG_ACPI_APEI_PCIEAER.[0]

What I have is a bit complicated, with the extra pointer.  Keeping the
kfifo within the ghes module is much easier to follow IMO.

Let me know if you really want me to pursue this separation but my late
night gut feeling is this is going to be more trouble than it is worth to
keep the separation amongst the modules.

Ira

[0]
static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
{                                        
#ifdef CONFIG_ACPI_APEI_PCIEAER
	...
#endif
}

