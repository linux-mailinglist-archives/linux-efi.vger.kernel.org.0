Return-Path: <linux-efi+bounces-1890-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C94098E763
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 01:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA5B28961E
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 23:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C4199FC2;
	Wed,  2 Oct 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BP9IPdnT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD9914B972;
	Wed,  2 Oct 2024 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912889; cv=fail; b=pzl5wlkc+ZXIXqTUJ4QlD7gHGj6tJ95NVzqaiYZ9JDjU8HZh+8Q95Orr0s+wRBjxX6dvM62PprGBGlDv0m+T8k+ZM44RQsPHme+2x7zhbcxJ66pICi8mnNsJSN4Ntvbnzu5z9o8w+GfX0OQPCzdEKwG73YMsB5c/V8tpKtbSNr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912889; c=relaxed/simple;
	bh=y+QBD9GuE5DuXKERmnPSs4whnvjf3aYbMO/FAKUC4l0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ud6LsfyROpMoalhuFJH+vo7plL11LXYWT2GjwTiLiu6lO2nONYU3cyKmRFyzoM4+TTWm1F+REm7p0v5Yvv4XqYxISb+noxCb5u4nzKfYiOa07YclBN+F0u3gp43nmE+CV09YHS694eib6YLNtUt8T9lh3zZp2dE38kIhlXK/l34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BP9IPdnT; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727912886; x=1759448886;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y+QBD9GuE5DuXKERmnPSs4whnvjf3aYbMO/FAKUC4l0=;
  b=BP9IPdnTER32T+wGbjZSChLeEBRCRL1z1mjSkSZw7t821C/eSLrdJ0kp
   I9mHu9GLQMC0e+uOcot/bfscpN4/j8i3fSdwSrwghnRs1h0W8rTHTJQEW
   StzZ5RzYGO0ApqSkYsR8HsVMdnjjoeSy5SA6qaYfoZD9OvC3exylp5Hkd
   AwB7mk2re0KUfqoiguvkJG4jjb+cPPCP8WaaBZsmsi3XC1uD3lXjGCWtF
   iciML/UM8ZzxwuL7h+sjm9pFgazTCxjj6zCN4WkbMDMM4ksZ/WSyJbdmX
   utCpzdSurxd6rgYAqG39ZhOtLPw0RSylzEsemImwTPGnqyRGqwG8Pmg+g
   A==;
X-CSE-ConnectionGUID: eJPq2h1GQMmVkZkkfrdhPA==
X-CSE-MsgGUID: y0y893UKRayZCbG9oyAylw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="37653152"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="37653152"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 16:48:05 -0700
X-CSE-ConnectionGUID: tMShdwrsTwGnliXjjDoFtg==
X-CSE-MsgGUID: 3oRyGWfPRZ6YyH7hpE0axQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="97500469"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 16:48:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 16:48:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 16:48:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 16:48:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 16:48:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDgmDqMy0/ZVDMjjhN+O28lSz5zluOG+z6lhKalsxBB+t/dukFPsGMBhAmw2lfkf+WRaFZu3oOnCZQiw88r6MxkX0ynLa5yPlVl6tljWzUCb71FWQkVKHdGVHFp9MDqjVYW1EwX5EXNXQdFMqPv5/f1Hv4K3rh7Y1VJY0EnEHOlDDres8nlOs8mYxPITybC5RoOQToLLfOnaY5RhCnPlPHDnspiWueb8DuMcmPsFl0X/4/k3v4BR9BqX3wWEpllMmXytsTfcZijnxHxY/wyuM2msxg+/KafuvlGjIjn42bDrru3eVIPh07MpFQXmHqthu9+Pe1DnqA+4nQvjgRSnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA/U9KQLubX6d3Myv89yg71Jz9vT4Zfm2lDH1K3Kc+E=;
 b=OBLv+POsTmTZtWguMi5WMnDD7YcoMo6U+WR3w3AqubXc8qdEaKyoo6bKFfoJy8/8p453LTRCovmRWYa5Rffp3EBYQL3bxGe2bpE7Fr5+NyDfSP8veATZL77I426trAGChWGOZSyWVdVPIfv+5Fm3TH4YSXnyoVlwpi4VusWsE03L3lVWRdLWleF9NS7jNK8TkMQFEpp693x/ZbJYCTEJvBr03Q2Gt43hHVWZF9hbOnijnVXO0CFteSCkHy8pOy5ZJrLuaPEGG7bJIAiEkHE8pwtZFnEtFm0k+sbrJk6LP8BN/CrnvKS2UwhElde49kZ+0PNcLqr7I5EzkC7w1QRpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7208.namprd11.prod.outlook.com (2603:10b6:8:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 23:48:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 23:48:02 +0000
Date: Wed, 2 Oct 2024 16:47:59 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH v2 3/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
Message-ID: <66fddbaf9acbc_964f22942e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001005234.61409-4-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:303:8f::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 24959a96-cf96-44f6-4ac5-08dce33ca71c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GG2OBJFyLIeW8FeY4NKdstDfZSNjohsBUhfrDzD9PNvGx0Bjz0PuP+yc7bOG?=
 =?us-ascii?Q?LHrYZYMtNENYqMtz1iCBQboOuvspmfFFf2KuLYgKDhtiFuLBECQoW72S0TUD?=
 =?us-ascii?Q?EcJpwT+H9RBXr6gI6wjIxL64ddhQ50NDYCuJHIvs4700minYFDPUCzRBkJ11?=
 =?us-ascii?Q?atyRSjyIaExzXaBXx2vcx2o39IDbHx4fXxA/g8nG1ijcveVrxzoYQ7OVkNrx?=
 =?us-ascii?Q?l4a4xixOjdR5uXSlwVB9Tt7uK12Fll246q80xEwAzRcXpamj/LXc/Oeg+LOX?=
 =?us-ascii?Q?QTv9HYt0EIP/fSANDN+O/Yde2zbwtHzgDYDFfiRb8UGHvSf4/96eFJdlUEQc?=
 =?us-ascii?Q?RyI2xK9WnOChO14SLYKFugV/3Ea5pOBwDDZ2WbAy0XFYNkVNP8Lwi8CNvogX?=
 =?us-ascii?Q?YLQ3ENTutbwRKgvS8Flm8xMBO2wojCZvXEs9U0PcUnV11Vzs237oHNfBCTrC?=
 =?us-ascii?Q?LZ7kNAidBo6mMcY7H7LESZfAHLGNFQrIjazE1nQKXa+VCKd/xBo1pdkGqkNv?=
 =?us-ascii?Q?2uOWFWhnDvqW54txOi91xYN2PFeOdBgcsYPtR9MecgI71ISUiWaUMwaDz3KS?=
 =?us-ascii?Q?rsT4eNRxgef66hloaq1cjGpu7sJxwbCNredlTN+7Dp+Vd39oQptn49ALE0aT?=
 =?us-ascii?Q?/BqgTq4GmCpnQFwM9ro46uoqazDSR5gessTO+CmpvsDQufoMPI1UCR4iuxC3?=
 =?us-ascii?Q?IXqL6YTYUva1aosWwoCV3rf57grN0sQ58REnsicBx2/pAe0TFpryrBY82xza?=
 =?us-ascii?Q?HAbB+VdZzqthj2ViSg/XlztsWKTTZAF4/oy430Ead54LehOLXMQvUIaI2gRO?=
 =?us-ascii?Q?Z/LplY1Pseh3d2SoOCSGib6Mn38BpnxKQT7r3XDMxCyDuewp3gDdI5JAGLRS?=
 =?us-ascii?Q?e7BSJphlH5i7MCCJUBUflmf0k1f9LO+C3SOULVxtu0YytzfBPlrnnixncgNw?=
 =?us-ascii?Q?ovGp05zZ00ajQPPGlueDi3J3TaXiN5kR/vgQkKGrW9OgJD9NQ/JYDUmQuJll?=
 =?us-ascii?Q?2qNcMsPJU3QxLqZZz9Ion60MBU9hqGcj/yKZ67eXDbKxR+70SuGvYcz7Knq0?=
 =?us-ascii?Q?FK4z6ntw75biFGXRfP1xnv82itl2Cv0Tva3/WXsEUdBa2RjIYMT3g5rvIpwm?=
 =?us-ascii?Q?MwjlUJ7OTA4Q9E5uXSDL5i6BRptYfgTBpL42FykAAYQm1odFgzBwGOWZe9Bp?=
 =?us-ascii?Q?jbUUOFlvoX0hBr6eP5y4MTVMa8znvVkpmUOlkPRMiRShvqNZ3BWcZkx4zfOz?=
 =?us-ascii?Q?jEGjvUXCsFVst8rro4/cQneolXzL7YpY/KJ+B2XyFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IRTSKvMdj7K8zNI+2CsGs57czdKIJomCB7FaR/HmhtQrc45wQr8Jbi1QgT4q?=
 =?us-ascii?Q?1VVJlId1v6Bg8cekO0sCqrL8/kirJ1Tpi8oNmbKsZSuTl0OxD9MH05g+Y76A?=
 =?us-ascii?Q?IlR8U0uUsqinUJQUd4WKsYKmEIV9dP31jbnFdmT8iMASiy+ix3hgw5N3RqsA?=
 =?us-ascii?Q?swLFElqfEnrFC9eJL3C4PIcEHYm19pimBOxpnD8GZnJk9+10hGF3SEC7TTQp?=
 =?us-ascii?Q?8Gj/gE+/hbFM02vuzikHFBXdZlHP06suDJLWVCXDUU4hDmEbEMZA8WRk/atT?=
 =?us-ascii?Q?iuDtYxRfPkGEYx6d99EMjN/7ZrJAXjh0cVikVQXQwwYouzCtKdSwLH7LI//7?=
 =?us-ascii?Q?aNmmoh+4OnWE5Hw+XJVrlSAMgskDjo784zM6xL390yFvlZxmB3M0UEFxAMks?=
 =?us-ascii?Q?cz/VOu0lVASFU6JT/1gXqo6/alC5UecfXtB+/nlax8cBlKGU2eMQ56jRukpc?=
 =?us-ascii?Q?VGrVPM4dectoCXcoVlRlzUJTErj/fLSTPw1XebfVmGlLIvho6hQNdK80n39k?=
 =?us-ascii?Q?fEDQyWgJ3ZpYXAXTCx9iHvlsKlYcHqcHM7BFW35pgLYJaT6BxYpFekCJ1oHX?=
 =?us-ascii?Q?djhkpYYkdaCsISkTmMqeMxSIPR+nC3cO965X8ded5LL7+j4uwIxuirPkNv59?=
 =?us-ascii?Q?5JPGjC636bLvWdawxsgJpemmuIVWxPNdzYI05eZx2Bvit6UBh1gT06nQqNUb?=
 =?us-ascii?Q?2Op2DN1MnN4rL0rxoKqLDPF0kl3RNq5JjX9+KRFMDHZs8o78Ex1fEFUX8YZO?=
 =?us-ascii?Q?DPbbqkoktTqu8PUJCAr/SvdFjU4Ctn07/5bZ/O712A+aqb+47baYfd8nzwO7?=
 =?us-ascii?Q?csfDcEwho8AYkhgzdajZmySir5bV9TZQR2UINADFdyTjqEJL8oTBYWccnaFI?=
 =?us-ascii?Q?o8SLIjIyRioFHX/107tq5hdBY1hdvYsoGcxzSmINR/K9j4BtyNUWhFoMbJe+?=
 =?us-ascii?Q?X7hdZAmUPZPdKidzCPQU+c1MoCY+30IzLs3jcj5Nqd6aLdJpGJ5E0OWnfwEl?=
 =?us-ascii?Q?GNPWUoWoQv81RyLzVNlvD15ykfaP0lYn95XYLvkC2Ho7wSW/x/Isn1TeGXGJ?=
 =?us-ascii?Q?Irwoy1i9KvLlnU67NQjegWNe6jDfkSxZDGITr0qvhNDb5cvSo4Rx4vvhBTuj?=
 =?us-ascii?Q?fpnDkGaNgFfp8929l+E5B6Qm9R1mw0gfSVJ62Asy3yOlBTqvmXxkMqMfte+A?=
 =?us-ascii?Q?O0S1Pn0NTQEtLAzjAX/d5H1FO5QJ0WNnXGdMrqOJ22mKl9SipdvHKyLQp0qo?=
 =?us-ascii?Q?rc6xwbGuOKcHt6mtl5Yd9c58o5PjWL3B3seWDgTzgzNGEEt2MKVCP5Hp7V6F?=
 =?us-ascii?Q?qzS07gyOUabw3E1PIcGl+aM+yqZe5xT3FNkbpdsXoNiGHjWhM4x68zHxvYJA?=
 =?us-ascii?Q?/aXWkaCvQGYlU2ASPxcIjwt3RzkC3Omtz34kwUPEiiVKtNw5T9HIHU+NZj9+?=
 =?us-ascii?Q?GDIkXiRtsNjgBnu5M5SiV+jVqB8bdhJt/eTi3iScBdC7XUVzIfLjddZedTvg?=
 =?us-ascii?Q?FdCUWHPDWyrVZaDwpnbUZeUI7wYD93P8z4SFH0Awnh6+MLIOKm3q02usTGvH?=
 =?us-ascii?Q?ihTWYyCznBK0BWIaGhUxbyc8Tme1cjqlYtxSEyhGmQ23luTEpjgVN32QbCWO?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24959a96-cf96-44f6-4ac5-08dce33ca71c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 23:48:02.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GQT4vvfHnJ+XWerfK6MxlZGVAoqjcNLTMvev4dfkQrgcFZ+tmscpQtRVbBYelaY9LSglyQdCTd11yRBftJUOrmz8tc0hzZpgRIbZQ1KqoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7208
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
> 
> Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
> Severity, Device ID, Device Serial number and CXL RAS capability struct in
> struct cxl_cper_prot_err. Include this struct as a member of struct
> cxl_cper_work_data.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	Defined array of structures for Device ID and Serial number
> 	comparison.
> 	p_err -> rec/p_rec.
> ---
>  drivers/acpi/apei/ghes.c        |  10 +++
>  drivers/firmware/efi/cper_cxl.c | 115 ++++++++++++++++++++++++++++++++
>  include/cxl/event.h             |  26 ++++++++
>  3 files changed, 151 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ada93cfde9ba..9dcf0f78458f 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -717,6 +717,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  	schedule_work(cxl_cper_work);
>  }
>  
> +static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
> +{
> +	struct cxl_cper_work_data wd;
> +
> +	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_rec))
> +		return;
> +}
> +
>  int cxl_cper_register_work(struct work_struct *work)
>  {
>  	if (cxl_cper_work)
> @@ -791,6 +799,8 @@ static bool ghes_do_proc(struct ghes *ghes,
>  			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>  
>  			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> +			cxl_cper_handle_prot_err(gdata);

I would prefer this follow the format of cxl_cper_post_event and pass a
'struct cxl_cper_sec_prot_err *' directly.

>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index 4fd8d783993e..08da7764c066 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/cper.h>
> +#include <acpi/ghes.h>
>  #include "cper_cxl.h"
>  
>  #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> @@ -44,6 +45,66 @@ enum {
>  	USP,	/* CXL Upstream Switch Port */
>  };
>  
> +struct agent_info {
> +	const char *string;
> +	bool req_sn;
> +	bool req_sbdf;
> +};
> +
> +static const struct agent_info agent_info[] = {
> +	[RCD] = {
> +		.string = "Restricted CXL Device",
> +		.req_sbdf = true,
> +		.req_sn = true,
> +	},
> +	[RCH_DP] = {
> +		.string = "Restricted CXL Host Downstream Port",
> +		.req_sbdf = false,
> +		.req_sn = false,
> +	},
> +	[DEVICE] = {
> +		.string = "CXL Device",
> +		.req_sbdf = true,
> +		.req_sn = true,
> +	},
> +	[LD] = {
> +		.string = "CXL Logical Device",
> +		.req_sbdf = true,
> +		.req_sn = true,
> +	},
> +	[FMLD] = {
> +		.string = "CXL Fabric Manager managed Logical Device",
> +		.req_sbdf = true,
> +		.req_sn = true,
> +	},
> +	[RP] = {
> +		.string = "CXL Root Port",
> +		.req_sbdf = true,
> +		.req_sn = false,
> +	},
> +	[DSP] = {
> +		.string = "CXL Downstream Switch Port",
> +		.req_sbdf = true,
> +		.req_sn = false,
> +	},
> +	[USP] = {
> +		.string = "CXL Upstream Switch Port",
> +		.req_sbdf = true,
> +		.req_sn = false,
> +	},
> +};
> +
> +static enum cxl_aer_err_type cper_severity_cxl_aer(int cper_severity)
> +{
> +	switch (cper_severity) {
> +	case CPER_SEV_RECOVERABLE:
> +	case CPER_SEV_FATAL:
> +		return CXL_AER_UNCORRECTABLE;
> +	default:
> +		return CXL_AER_CORRECTABLE;
> +	}

Why does the CPER severity need to be converted to a new CXL specific
enum value?

> +}
> +
>  void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
>  {
>  	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
> @@ -176,3 +237,57 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>  			       sizeof(cxl_ras->header_log), 0);
>  	}
>  }
> +
> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
> +				  struct cxl_cper_prot_err *rec)
> +{
> +	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);

Late feedback, but cper_sec_prot_err is too generic of a name. Lets make
if cxl_cper_sec_prot_err similar to cxl_cper_event_rec.


> +	u8 *dvsec_start, *cap_start;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID)) {
> +		pr_err(FW_WARN "No Device ID\n");

This should be pr_err_ratelimited().

This feedback likely also applies to the existing support, but I think
protocol errors are even more likely than component errors to be bursty
and persistent.

This error message and all the others should clarify that they are
coming from the CXL CPER code with something like:

    #define pr_fmt(fmt) "cxl/cper: " fmt

...at the top of the file.

> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The device ID or agent address is required for CXL RCD, CXL
> +	 * SLD, CXL LD, CXL Fabric Manager Managed LD, CXL Root Port,
> +	 * CXL Downstream Switch Port and CXL Upstream Switch Port.
> +	 */
> +	if (!(agent_info[prot_err->agent_type].req_sbdf)) {
> +		pr_err(FW_WARN "Invalid agent type\n");
> +		return -EINVAL;
> +	}

All CPER records without a device-id have already been dropped above, so
why reject agent-types that do not require a device-id here?

I think this agent_info[] scheme makes the code more difficult to read
especially since agent_info() is only consulted a couple times. Just put
a "switch (prot_err->agent_type)" in the code directly and skip the
indirection.

> +
> +	rec->segment = prot_err->agent_addr.segment;
> +	rec->bus = prot_err->agent_addr.bus;
> +	rec->device = prot_err->agent_addr.device;
> +	rec->function = prot_err->agent_addr.function;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> +		pr_err(FW_WARN "Invalid Protocol Error log\n");
> +		return -EINVAL;
> +	}
> +
> +	dvsec_start = (u8 *)(prot_err + 1);
> +	cap_start = dvsec_start + prot_err->dvsec_len;
> +	rec->cxl_ras = *(struct cxl_ras_capability_regs *)cap_start;

Where is the validation that the size of the RAS field matches
expectations? I.e. what if the BIOS builds a bad error record?

> +
> +	/*
> +	 * Set device serial number unconditionally.
> +	 *
> +	 * Print a warning message if it is not valid. The device serial
> +	 * number is required for CXL RCD, CXL SLD, CXL LD and CXL Fabric
> +	 * Manager Managed LD.
> +	 */
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
> +	    !(agent_info[prot_err->agent_type].req_sn))
> +		pr_warn(FW_WARN "No Device Serial number\n");
> +
> +	rec->lower_dw = prot_err->dev_serial_num.lower_dw;
> +	rec->upper_dw = prot_err->dev_serial_num.upper_dw;

Serial numbers are u64s, so if any conversion is to be done here it
should be from upper+lower to a u64, but then again see below on my
question about why a new cxl_cper_prot_err is being added.

> +
> +	rec->severity = cper_severity_cxl_aer(gdata->error_severity);
> +
> +	return 0;
> +}
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 57b4630568f6..5b316150556a 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -158,11 +158,37 @@ struct cxl_ras_capability_regs {
>  	u32 header_log[16];
>  };
>  
> +enum cxl_aer_err_type {
> +	CXL_AER_UNCORRECTABLE,
> +	CXL_AER_CORRECTABLE,
> +};
> +
> +struct cxl_cper_prot_err {
> +	struct cxl_ras_capability_regs cxl_ras;
> +
> +	/* Device ID */
> +	u8 function;
> +	u8 device;
> +	u8 bus;
> +	u16 segment;
> +
> +	/* Device Serial Number */
> +	u32 lower_dw;
> +	u32 upper_dw;
> +
> +	int severity;
> +};

Hmm, 'struct cxl_cper_event_rec' follows the raw format of the record
from the specification, and 'struct cxl_cper_sec_prot_err' (formerly
cper_sec_prot_err) already exists, so why is this new intermediate data
structure needed?

> +
>  struct cxl_cper_work_data {
>  	enum cxl_event_type event_type;
>  	struct cxl_cper_event_rec rec;
> +	struct cxl_cper_prot_err p_rec;

>  };
>  
> +struct acpi_hest_generic_data;
> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
> +				  struct cxl_cper_prot_err *rec);
> +
>  #ifdef CONFIG_ACPI_APEI_GHES
>  int cxl_cper_register_work(struct work_struct *work);
>  int cxl_cper_unregister_work(struct work_struct *work);
> -- 
> 2.17.1
> 




