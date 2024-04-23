Return-Path: <linux-efi+bounces-962-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C4C8ADC6F
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 05:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5701C21B1B
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 03:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60C1C68C;
	Tue, 23 Apr 2024 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JP/7SsEG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8561C687;
	Tue, 23 Apr 2024 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844043; cv=fail; b=BIomDz9ItgteEo3Hu1DYEioV9cRIRElMH9+snCBC9rXoidZc5S/WI3Uf+3sthwNDCak3r6oFyyv0PRuyvxO7HbpkAVueKxIQaPeRLtraNTZh+ASh81mqAxyd3EqqoCXDu7gTYX8DifJIo6Tcc3rG7WFJz9L5Jn4p3E1dh14Zbt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844043; c=relaxed/simple;
	bh=4Q8OXQZrx5+BlmU/0ZEGrFaT2a+1iecE6pJqmeA3qQc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=si4dFm+ApZSa4IY8PhCckZDYe7Xaq35K+N3jeQf6p6jLgU1stHh0XBs/dOzvLyPlm1rTVOUZtOZ0HaSCJpWXmcNeqbZJqL8iJ8U4SN9/wuVzeVPFVJ1+IQKEcRfsu14KUbqai8hkl/YUoShvH7429TAPGRYkuqr3bw50thIv148=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JP/7SsEG; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713844041; x=1745380041;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4Q8OXQZrx5+BlmU/0ZEGrFaT2a+1iecE6pJqmeA3qQc=;
  b=JP/7SsEGn51s86ZuDRdTmKkTfuJIfLmvDGlNYKyx5tRv1+R5KX7ZypfY
   XW4QKU7G/yr8DRw6lEbHnprdYzNHyXrOwpcuDO3TMkGc91xDddgyWMNxo
   aQA6bmPwQAj629EsWaD8GSWcy33F47PGN2n2Yf7wJ4WRpFVq3Pu+OJxdi
   OFXLG9aVfJLhWWH8htLY1nBqFOC0Rfkfv4nutb2/AHQAkfK37nBokmJ0l
   pFw6cjvOhlZkMPiS9zSmyzx8gm+zHT9MM47pfxmUf5yJmCGX7HB/AgDAi
   4TP9DQynKWqsj6mPgpWFKb3JK6DAz1iX6Bg849lokfgGkTDTGyyDTYBKM
   g==;
X-CSE-ConnectionGUID: +FqQAW4ySGqmS5Dz5xd9iw==
X-CSE-MsgGUID: nP78eUcWQvyTshs5HVjboQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9241298"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9241298"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 20:47:20 -0700
X-CSE-ConnectionGUID: Iv+/JKBFT4qsjtGjFG8UNA==
X-CSE-MsgGUID: Df7L0K59SoSutCp+PiRczg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29025698"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 20:47:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 20:47:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 20:47:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 20:47:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 20:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccOIgmBwOE+XmY4MF3sXubMGzw+E/a8RH4L1nLg3Vd9tnTdjxMsqf/J65wbcLw6RPcCCUisyCVLM+Z5St0rmxiPO2H2AYKXjtbpUvO/JXn5k/oZHPcgnswr7Xvno+b1VVFStxmjLvtTum+M4hLa+8H63KWBdiNSxbbzWHkidqTwl1BK1PBeobyJLIvsXM9K02vy0GWBTbF4RAbvbGRww9BegGXeGMNAwvNJlX1zId6Fb4kM6gKHtq+aHLF6Pz9VcTf6L621qv2cLFB3G5XxpolxdSkvE/W+Raud4tOXl7e4cGv0cCsY0avajZ14zsBbVmi4D4Ly9/+fYIcBcnWAGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6iJAUg3V7OXmkxgYArMOXUrljr1axJRJGG+m6/u5OM=;
 b=m7ksgN/vYBOWX2bg7u6m6uPXy9+gYMZUdw+wLWuLGY/4MEsRXVrlE/tOXsimg/QWCWgZ2qzov1ZTxileCDpX+if472+ipJkeiyp/pb7iu1XXhnsmqPyJ8YNaOOVa7X+dOreVBUvf+Ajx8vv23SF35AUVJiXrV+D+TeD1uA8sBLDvUFeTeMT0VhlbykV26cNfcvWEfWZSnEbrgmXcVnlHR/u1p0u5w3XbT6ophSs2H7Np1Z6AwgJC/eb01gMgHX9haHY7MLJTt4MJtuQnnw05G0zllUKmKGjRbbwM/xkvo4u+6o3mGf5WpULZkKqZtVRka/KYY0ELVSTaZ7FMW6IkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB4889.namprd11.prod.outlook.com (2603:10b6:806:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 03:47:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 03:47:16 +0000
Date: Mon, 22 Apr 2024 20:47:12 -0700
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
Subject: RE: [PATCH v2 1/3] acpi/ghes: Process CXL Component Events
Message-ID: <66272f40420e6_bbee62945d@iweiny-mobl.notmuch>
References: <20240422-cxl-cper3-v2-0-5cdd378fcd0b@intel.com>
 <20240422-cxl-cper3-v2-1-5cdd378fcd0b@intel.com>
 <6626f8c9404f2_690a294d8@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6626f8c9404f2_690a294d8@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:a03:54::44) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: c77371bb-b86b-4c7c-ab5f-08dc63481162
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rZcV2pvCrMuyUbCHzRVRLPC8IpDKhdrM0yng1MxzhdNaXNds/0E8UDuccIW2?=
 =?us-ascii?Q?FdxPTZKeolLm58p5X2nf2CR3v87Sosaol/UnMDniceo87SGsE9tNlqrD48hM?=
 =?us-ascii?Q?bwO5WHfqW042ZtDJNzPzsQynNkPavAYLYSadzXTyjaBV6jfzHE2Hdu+gQzy0?=
 =?us-ascii?Q?1nSeiw0yW97VI7y+mUPSf28vCIRL/mvpFfC4L6O+dot59CDQkwb3WMDTKLr1?=
 =?us-ascii?Q?40wNiOu6VG2Vs3cqEIIPtVBX1sEMAocVBEF73tecLoTA+F0PHOH4aztuhy7X?=
 =?us-ascii?Q?7fH9d4airZp8+8gnHN9DfvMQ11qCk4BBz0lBbyJL0rBYEEw8wvOQC9MVG6dj?=
 =?us-ascii?Q?7U+ShcSROGj8DfcNChYFveutTgUpjtPzZJSVi1JLxwA0gd2cVbLvEsAevOTT?=
 =?us-ascii?Q?EExc9GgZvLzTeDW4OhQPeH1FFjOvbWY4om8Mu59afyCfF2+pPDY+MhfAa48I?=
 =?us-ascii?Q?TVCig2OejV0WFOUlPfZjpnrA3HlKN2Y0Qek/GkytSLZy39Xq8nY14KzCH/XR?=
 =?us-ascii?Q?qXac9JV8ES5Xgybwr98ioMeN5w4ne7fwQJePVp1/+V2b2fhqTPI8CFCA8XdO?=
 =?us-ascii?Q?4sOZGtEILKMuJ7zssYkcx3kAVTbbCj85bf9uvbnEEbzX3QhsiZxO/QPhjjSg?=
 =?us-ascii?Q?IbWurzng+Tbd+M9G6P5D95Qr/lsa5JhsXCYfA6oZS+XhExKgA2wqburfVscY?=
 =?us-ascii?Q?prgbkNqsjgLdoVla0kLprIt+q9mkTavWbeiEziwm4qphtRVdFG5UA2fo4OH7?=
 =?us-ascii?Q?k+JZTRpGpSi1RFAPrrFIPzJ/ayGb+DsbQJekYyXvkG040oMiznpZRaHWrHXj?=
 =?us-ascii?Q?wQ9kxsxyy4WV9N/q1aOZOJ1vA1sae8yQRCTjThC3ppO/lcXglUcNnLonKBJm?=
 =?us-ascii?Q?UgshCX86HbZgAgz3LITuDWYwiUu/ze+xKZQd8FTrl4Jzc/86LUBd9R+NUYmw?=
 =?us-ascii?Q?TUHbBrdK9VQ7O1npXbcODl7AhXNpiuPI9XHm21KG4zfznjWMyVbaHrZ7/NLx?=
 =?us-ascii?Q?FC3spXmxVlLZ4cEF7LJP/K8KBMZ5uRTcPnODiJvlOKNzVpQLmQJFxlhL3FEO?=
 =?us-ascii?Q?0NfpLuxuGWSFEYzYKXZCQNdbx1vDDnI/orp3mWrLojMoFVZB4wYAZcTwx9P/?=
 =?us-ascii?Q?TuC3pSwydiilDSR3JBsXKVm5hcsdrHx6lGJrPRw8Ej7h2krqO8m7cvWY3mhB?=
 =?us-ascii?Q?6ItPP4sQnK7tUYHkxH4yEkldXdcAa6eBGb1epvVRtmFgXHYuFpvEsc5udIbW?=
 =?us-ascii?Q?UuX5igMrGLP6zP6Zprpq2m8lZM823qmLIOLTltikhLlLfIZx5O6RQyRDElqe?=
 =?us-ascii?Q?KHo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w7ps7i9NEvUceqKpsyjBSp2tN9qxZq61F0EmQkKmvGMC2kJ290+pTNMib4Sm?=
 =?us-ascii?Q?8NigsCOQgknK484lH61Hv+goyGPnTea7qvcE2yXdqL9KGfBEMoNF2QtaSNdh?=
 =?us-ascii?Q?skC0p8vSSMDxepEru98VmYMHc6fiXpawxOFdaPb/kLSy+R+9N0di3MI5Y5Yp?=
 =?us-ascii?Q?q5vRu6+hr09DEaipg4Pk9Om2p5oD6hbgXR5lxdlQvhZxOVqRx86W2EoF8KlC?=
 =?us-ascii?Q?V2AnYMDvHd/mew3njdgoAIchtT6PdbS/ki0o15FnNScv/JaI5R64lSIbgQmh?=
 =?us-ascii?Q?MvOictNmYeoStG3ysL5nC1eXak6e0zOO7PRW0H+K2sPZwMRgFZGBZYfWbF0m?=
 =?us-ascii?Q?oftEppKcfaYWaCB15tES4GPTFJurkW/UOVSMs3KfC5UIavE4hsZImL2a/ncc?=
 =?us-ascii?Q?Tsdoh71XTEPAPRYnzSBfvcxhVEuc4FsGq1ol9v0xejEigBUM/6zGfGT1v1Pg?=
 =?us-ascii?Q?jlGdl3zBPCKB2AhVzdF5UoQpCJmKHy5aGLft5ytLUHU4uldvVp49n3h4kwna?=
 =?us-ascii?Q?pEjmLiD2q0Y4fbq0/O7jkrjGOucPetl2HKjO3ZjvRbc6vWC0FTSCbWoM+y6o?=
 =?us-ascii?Q?CvR/TqI9hBHuvELWAAUHiq953NkWvCBjGawTnIAkr4hODnDL2e6LCC2L1w2u?=
 =?us-ascii?Q?M8jgt/Yn8VXebDTSPSJN0EuAb+CwTDwwjxDA0bRc3h/8ZpJb+I0H1cpGMq2m?=
 =?us-ascii?Q?pv5v4BoQFg1VMaKRzM41GroNXhym9I6wZJ/z/c+j0o5a06OdCPLy+b+1A5kI?=
 =?us-ascii?Q?d6xlf12yOm6XRm6cOu7S0kGXDk/FGCJ/TbyOpoWKhPIedXLeMfpLUsG/5VzD?=
 =?us-ascii?Q?55y1gTGzxvzQdhMBYU2lkR9b6EOD80gyYSiAcEykfHepn8spNSHAeaPDoYIf?=
 =?us-ascii?Q?FSgoCHrxcmhrSZEIr3cahs/7eVaCfUS5Khc95+GVPYkVWZ4CPhDe5M1U8q4H?=
 =?us-ascii?Q?MgwRs469TaErBcDEusJSWzLfbYRSk2wbMxhkBc8wbJEBlJosS+gngqaHSObp?=
 =?us-ascii?Q?lJOaOwm/BVfyT3vpj2MC72Xvx/cPJSJ4epsBxUoZNumq6t7WjhB1/4MZdyaT?=
 =?us-ascii?Q?2rrzxzt5bp30lWThcUiRobtnqdGPqAuSHqrUVYK8nIrxk0tdrSiK9+Dq6MXn?=
 =?us-ascii?Q?zqGNkE4L0kc0Er8QmwlFZcK2qBzVGhD18HVB3p1pAtHeDTReikMmSIMOqUKk?=
 =?us-ascii?Q?gtW+lqvXXspUKyURXva2ear1vVpkq46LyqoGs3QF7LckIqkUho48DSHaDCpI?=
 =?us-ascii?Q?8RKTVI+xwAdcT/AmswdQIPv5vTEA9JGsfQUWnn5GSGYCHjCN0MkmLOPzG7xl?=
 =?us-ascii?Q?Og5fsgPXroiaZYUQ84KxSpc/n/xUMhWbiW/BQVsZqcRQISKxzt7ZEAhDOYPW?=
 =?us-ascii?Q?MPs0ZStbT7mWIhupIvnPjQ1+Wbrsc+bqktvjdgCJ7VqVikBEK4yA67khk8Ry?=
 =?us-ascii?Q?w8ZYgaePjksIU5g/acOJ+U+y160HaViCs0NO8Sem/oxyio5sjwVb2iJIODCS?=
 =?us-ascii?Q?iWdHKx/1yKIosF0YJRoB7tj5wOG2w9m7JcUYMjo+lneR22gd6U7YYz1iMo6C?=
 =?us-ascii?Q?I2SaopKQgul2SGJbGEg1R0Ic4iWor1AuqO1hWUmt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c77371bb-b86b-4c7c-ab5f-08dc63481162
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 03:47:16.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2GMv9iTZ3cjYoiCTZ46LBHyQtiHmTCdnZuMBo4iNKqSK78mLbqAZy8qLMIyH9gELPBzyWfhyaSiee7hZt4DvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4889
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
> Minor, but this can be reformatted a bit cleaner:
> 
> Link: http://lore.kernel.org/r/cover.1711598777.git.alison.schofield@intel.com [0]
> Link: http://lore.kernel.org/r/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch [1]
> Link: http://lore.kernel.org/r/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain [2]
> 

Sure.


[snip]

> > +/*
> > + * Memory Module Event Record
> > + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> > + */
> > +#define CPER_SEC_CXL_MEM_MODULE_GUID					\
> > +	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
> > +		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
> > +
> > +struct cxl_cper_work_data {
> > +	enum cxl_event_type event_type;
> > +	struct cxl_cper_event_rec rec;
> > +};
> > +
> > +DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, 32);
> 
> Any comment on where that "32" comes from?

If anyone has any better queue depth I'm open.  It is just a guess.

> 
> > +static DEFINE_SPINLOCK(cxl_cper_work_lock);
> 
> Needs a comment on what it is specifically protecting.

Ok.

> 
> > +static cxl_cper_callback cper_callback;
> > +static void cxl_cper_cb_fn(struct work_struct *work)
> > +{
> > +	struct cxl_cper_work_data wd;
> > +
> > +	while (kfifo_get(&cxl_cper_fifo, &wd))
> > +		cper_callback(wd.event_type, &wd.rec);
> > +}
> > +static DECLARE_WORK(cxl_cb_work, cxl_cper_cb_fn);
> > +struct work_struct *cxl_cper_work = NULL;
> 
> Initializing global data to NULL is redundant, however this feels like
> one too many dynamic things registered.
> 
> cxl_cper_work and cper_callback are dynamic, but from the GHES
> perspective all it cares about is checking if work is registered and if
> so put the data in the kfifo and trigger that work func.
> 
> It need not care about what happens after the work is queued. So, lets
> just have the CXL driver register its own cxl_cper_work instance and
> skip defining one locally here. Export cxl_cper_fifo for the driver to
> optionally reference.

Ok I thought we had decided not to do that.  If I recall exporting the
fifo had some difficulties but it may have been my unfamiliarity with it.

Ira

[snip]

