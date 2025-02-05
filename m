Return-Path: <linux-efi+bounces-2756-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657F6A29D26
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 00:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CF23A5D2F
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 23:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C0D215F42;
	Wed,  5 Feb 2025 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dx3fEz4Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF68215176;
	Wed,  5 Feb 2025 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796814; cv=fail; b=MDSSf4YjPTj9BtZLG5j+rkamd5Ler6Hnln33jAw9mQzK7lfC7TFNO5WHYttLYeVDZlBh3flBgzadXVDwdTqk52GPOkuQmur1GhgcZY58vAJIHRSMuD63GLyJzZ2jwRbiDqS9u3d0uDVEr/4bLySy9Vr4CL2CjNQ9xskcOOOSopc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796814; c=relaxed/simple;
	bh=lC91L1KmbOFsDm1nqjEpsdMeAPZ6rZJ/3zNASCGrL9Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZk4lsIdt5RBj2eUfVVVKVcts9X1MGpJ13RF9VQZs/buBnxY94xIAkUy7MOwu7QQ8Trx6uAC/PTwJZBg7mVaBYpy/pHkY0lBay6ULS4TeeF7bzClC92Mc7nuFfddrx6UjLLvuxeytcMyxZsxYkQq9tKgknCQdLZLz/mJhKfcthQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dx3fEz4Z; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738796812; x=1770332812;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lC91L1KmbOFsDm1nqjEpsdMeAPZ6rZJ/3zNASCGrL9Y=;
  b=Dx3fEz4Z61ZQkQHZ0HQJkqYA2RJcz1+vjbpnz/qjuZUtiTNSSSjN8SbE
   +eig4d6I/iDTIxDoyI9LsNbO1jLeWgi6M8/XNsUzpBEJenaJU4/thtSKM
   gm7/Tgg2u81ovXIf6D5v0uKwo5vOuLeEQvZvcngz9zYDEJcbo/FsUdoZy
   gBUvsnpueEKyZiaO5Jt2s/2yZ+Opsn9kj8IV3XWXAyRSSDzOponq2z/lT
   g+evmwHW2LraYCvGyEkpQwerOGdxngZRc4LZs39Nrp3kWNu9ICwdhzeWp
   iIe3GiSGszYLwC9SxEY3pNBohTiGFJPCv2wUqXni8h/bQ2EZvQ/vSpdfj
   Q==;
X-CSE-ConnectionGUID: +0+GhwQ0RMeJrkKuIWDUDQ==
X-CSE-MsgGUID: OM16RjW0RnC0bImvfMjk7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="26985415"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="26985415"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 15:06:51 -0800
X-CSE-ConnectionGUID: xf+rXrxvT4GrEBtp/ZXwcQ==
X-CSE-MsgGUID: /AebpmXqSgu2sGmNIiJf5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134274058"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 15:06:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 15:06:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 15:06:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 15:06:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKXh1R8Qo7+dRDgdccBzvmwuxEzC005aq+/rZ4dGixs0/gS0k9LmID3s1FN2M91xcagp1v36qWIbQs6MLpOo5pEMtBzzVm6G7gBloMOejw/TjuAoczC856c0+afhWE8UMJh3FrG4/JBn2n/RFuxHWEbC+oSCq33hNO/UU1jEIVLJvEVsoSWKkwZ4aIvv5qCYtnvMvk0p2OIrmxcxRsAZ3vnTF/6bmueI//06ymbvxRLOr8D/X9Yz97o1hebkLpkZdynq+qCp+gs00U0yHfmTAuE5V835mgJDOCWX9k+iGlbyV84jBUXEK5yCdA22Nl8d2RDZ5u+0z8qkqKPDbgnhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWm3YPWM7jvT8trwKQrQ7+Fj/LMPgIz+2nQ0CTbUKI0=;
 b=tY0JO2Z26OQKUi44XV31U8k8w2oR2XqpvQT2h+MEYz3N6YvlAiFxYnH6jRV48ZVca6s7gpKcAt+hD44EcKLn0/9IGseW9n/QGWx9CsXya9dltm5JOSsYUvmcLpsuRF/+eTvPi6Jz4NFAxL98pCq12njn8nzdhsBCet6YfBv2y7OUG98PYgzlMHlRC553sSMS5EVEOhoM/dGEg3VtqiJ4N7cc3lKX/5ye2MsfEgQfJpX/wu2/ho+qRcxrMTXx5tR8H0JVC+MrM/M/l4nTD5ugUpoKQ63chbgs74k/HGkSrfuATV5EEPC9ZPI2MbSP2Oer/lGUwhaKkMzhTQhnYc4Z0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8348.namprd11.prod.outlook.com (2603:10b6:a03:53a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 23:06:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 23:06:48 +0000
Date: Wed, 5 Feb 2025 15:06:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v6 6/6] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
Message-ID: <67a3ef05520fc_2d2c29451@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-7-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-7-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR04CA0320.namprd04.prod.outlook.com
 (2603:10b6:303:82::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 36daeb95-8299-4e2a-1561-08dd4639c455
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yqv6LwWwtNBpUdMbB2/i8NohHdUKr1Frs9Q4pAIAEma0Njt3VbLuA5UAUbtJ?=
 =?us-ascii?Q?ojPe42xWiyaWfOn5DCvp9rr7kF56Mqc0edr0sgvmKYEF5vfaA5m81YqZFXcI?=
 =?us-ascii?Q?dKIKDdavHjY9/jzCjJ20ENYRuhedJOt/h75Rth0z/cVmqOUOeEvhgz+UoNQA?=
 =?us-ascii?Q?2nDo1m+kszjA3ht8haBwzXBHE/AKrL4WJbhhrneePODjPPt28ivAHmVPcr+6?=
 =?us-ascii?Q?t+WVZgkuZwtVs8tWcsKQHUvXWioKM5SwAlF7PkVNW0ysEzS17m4PxFrndlod?=
 =?us-ascii?Q?v08+9a/EZsaA8x2r49QQDyaxD5iXWg1U3irnykQlsnOM9/5jeNczNPWZh9uB?=
 =?us-ascii?Q?7z5Y7p87TJFz2MuxautccmOK4wiPLxcIMhahVeKxULtXwVeTPH4mljaWGv5s?=
 =?us-ascii?Q?WLjQTawkjfgtaX6Q7WpsYd+Zx9esHEVJ4IFwoBUioLmi6J24qC53EgArd/no?=
 =?us-ascii?Q?hAy8znPh31wGCV9sg1ZASySoyfAYPHKspvr/hXKPOuFjUQsmXrt1oumTMjfU?=
 =?us-ascii?Q?EJ8jDqFiLadLxZOWqc4vsImsHdIBK6nNVRfN8aSLUCFnsGoE6VbU+g3PV4zu?=
 =?us-ascii?Q?RFbllwBwwbrTasb7BsunkCumFm4MoSncPFuXikegoNLgZA/r8CppK3TkEU6j?=
 =?us-ascii?Q?3WnprMi92RlR8juPPFLA2l+YcOingHp5kDyyq4f5LqZ1BlPNPLRMfw6drhTA?=
 =?us-ascii?Q?d5RtFnDH8Mb01ZMknm7udiqTpba1/MFnv/Kk+Eo2z0qUASRQN8tgwKpvLQv8?=
 =?us-ascii?Q?YOxgS5aS+GuLj3u9UbJb0TnJaaHePaJGFcyVV5vnToBFwGU6UVGd7vE4VsZZ?=
 =?us-ascii?Q?QWoRHRQX25siyfq0QUMHShMZc9OsmnVKsUFTsARHJWu9kqnYFCOI4+dpsV1Q?=
 =?us-ascii?Q?iNp4aAc4WZvOKCH24/OFzI1yceO5v8Btz9eRMyQrD5KyZLE7nxuFzv6kncfs?=
 =?us-ascii?Q?CIbemY85GhyNGLXlz03Qa2XjNCiG/7LehkzFz1wgAA0thCs4jRFP1u/QiGVU?=
 =?us-ascii?Q?UBsTuEeVFVoWTBGSRqW4OHcJpRwIdwKQ8zU8DR6TtBnSLhoOelu/I2Iu12f2?=
 =?us-ascii?Q?bkB4QTe894cKqsIVhUINIPo/hDm1rGRGx7FIODzjBnuCW+7+/BCa+LeIo2qw?=
 =?us-ascii?Q?XXzaV79KZ+yaZSYW+iyw8jgASP9PSoP2VXcHKCIRmzW9bonn/Sngud3Y5wr7?=
 =?us-ascii?Q?+AL9P+4PqmRKMTCQZCpSCvTmJl/e7PooYi4PLnp/Iddl9fI142GDxJHquMDE?=
 =?us-ascii?Q?UHoyEkCxO7Ig2H804rWW+49DNWC3KkTBFWO8TMKKGHd0a3+wDe4/Fa0s4sQE?=
 =?us-ascii?Q?KrNLB9AISRjB5c98GIxUflSrw1Ix00zZEIH57DnM23lVYrP4ZSLzjYGLFTdC?=
 =?us-ascii?Q?h1x1Z7lXkax8AscZ4OaUyJhFlQ6Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8lAbZ28nf7Iq/v5oBNNynmS64r/QctfDMcyNLjR47YflP1VRHaTB2p1q8usy?=
 =?us-ascii?Q?wRlHfiUXUW0XjqlQ0E77qKOXrucLBk/Ni8yZWrJWJf1BwXAPBa60GmgyNnyr?=
 =?us-ascii?Q?ts9y15Ar1uu1PL7rpX1EtZMmWDkbzIMSzA+l/DCZkEiRITGDRH73dHJw3Pbr?=
 =?us-ascii?Q?KvpWfeg2zka1d3tuzHu/af2jAkyAo/ULqqwwd2BtIzHPuTReBC2OS5r7943m?=
 =?us-ascii?Q?dxBuqdURslU6RiBQ/oMqSG3B3JQFR3lgJlPVLwgPYTGBwm0ejZoKDMjA8ZDT?=
 =?us-ascii?Q?PyjLychSwVZpPcRVBvEWZgEtdA6p5ScCKHmWf1+5f2aya9RgF1IfsKXPy8Wr?=
 =?us-ascii?Q?Tg7iKJvdtYrQNAlCm1xRnC2AVk8jbhC8bc5bZfVdrnBXy5LRNmL7mwlDgJGv?=
 =?us-ascii?Q?P7Ul6JgnZY+7wPFAlAza86TT6tYzx2CixDOnFYrMnjh+Q0NNMbwOmAwininF?=
 =?us-ascii?Q?qSmhH6vzzYmLjsXvmJlDldy+u3CglLrcpi4u89WW3q5w1jlf4ytzRdRzBy1l?=
 =?us-ascii?Q?n1si3+gZhnZGWioJp2c8O03Cu8Ks9uoZm8Pm8lB9ng0dY0pJQ+UBlKQZ+Ymq?=
 =?us-ascii?Q?gfDN3KXnBuntTC7rOOvufH6gqniz+Kw84PcyaxT+xFWKHzVVSQYX7XlXfrg9?=
 =?us-ascii?Q?xhuNZowAwuvR0pbnAu9EHoURJBl2/fzID5NVvsU6HGI0neoWSiEZ6mQW3mTY?=
 =?us-ascii?Q?i9DKKnTe5pnLCqA/hcMIIfqSdO8TwXLD1kOIC/V5caxC74+FKhUG+Mw/mnq7?=
 =?us-ascii?Q?STQhOf6CryIFzo21oI14uaI+GMaQ2hu8GYTuN2T+k6UHaJ1u7R7gvNGlb5iS?=
 =?us-ascii?Q?95nk4EK/9P6OVh1Ye0WolyOaG7eqdLoo24uwhkGrY3JPloficSImY4CfnIjO?=
 =?us-ascii?Q?BwluTSbe0y1BfZquIV6DfMeHW6jAwzCAgNnA6SPrVg87dSkm0mtKn7CyK4Ei?=
 =?us-ascii?Q?QpFyXElH7o9bsHeBHVQnXSte61RIauvYcO3VwL13tkui8lV5O5Uw+t0vM85g?=
 =?us-ascii?Q?gMCMZbrH7PBQ4zTxHcqiDVm14fjDmLg5lTNU7bEY7e8d6WvbNa+1ydaN+RLr?=
 =?us-ascii?Q?z+QWaghtKTxpa2kGFwVQSdVqjaxB1wHrWDj8IIi+XTlJY8yYLt2lTOA9qqru?=
 =?us-ascii?Q?7T4pLjUdyK0UgusVT0X29VoQ8xw2i0f1C6Tt8N5rAuQ9S3DZslRKZJGLA/G8?=
 =?us-ascii?Q?xOONA4cuoZYu0mlhKhKtgkjdKvnoOfDXNtduEAWM2ZBFHPAPZRE1MN1ZHsDK?=
 =?us-ascii?Q?tN/t1s2UUuxE0RFUHhsVQBDx6I5OJCuBS5xMo9OeL4AzHuf8IdJ1mzqmp427?=
 =?us-ascii?Q?7/fNFMBxvZlN+gOZ32/NB1cOC54DI0LJHLyfAH0UvxCeAumvNFjzV4xqwPtu?=
 =?us-ascii?Q?98LiJc7QtzLwSwcu/X3VptXTGVgF3HY8hMh7NpYSXcejPq3AFoIghTvHhd3x?=
 =?us-ascii?Q?kSLcAQHTYvbWAqGQAzTrWAweeMFpM3yhiAhkUflCagbXco7fG/DDfNJqBR4w?=
 =?us-ascii?Q?769BlCVMioaZyeDICm/9g8SehDeQQqkcjT9oaFl3AE5Bd6/gY+YwGLC48ehm?=
 =?us-ascii?Q?Wb30lg9IbrMFmdzPM+HmxZSjPNuIPgAqG1tqNljG/ekZ2royE6OVmcrmWB/8?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36daeb95-8299-4e2a-1561-08dd4639c455
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 23:06:47.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5ZHye7fdNEHPXa4uJcdsAS3bLDusZENEUvu+twebrny/R1evaJr9bsPcUucsmAASQvBZzeEmH6dmQ5aUSJm8Zv4q8Toaf84Uyl9H0Rymog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8348
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> The CXL drivers use kernel trace functions for logging endpoint and
> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> Upstream Switch Ports.
> 
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Use them to trace
> FW-First Protocol errors.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

I think this functionality moves to a central / non-cxl_pci location
once we have a formal CXL AER path established.

So, for this series you can add my Reviewed-by: to patches 1-4, but I am
not yet convinced cxl_pci should play a role in emitting protocol errors
compared to a centralized place in the core.

