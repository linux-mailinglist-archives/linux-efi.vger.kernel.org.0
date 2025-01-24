Return-Path: <linux-efi+bounces-2726-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D017CA1BA99
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jan 2025 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB927A1617
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jan 2025 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05C61946CD;
	Fri, 24 Jan 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgaL4iln"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7C01925AE;
	Fri, 24 Jan 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736629; cv=fail; b=C8Msy7Eh+dLXZfT8qKaMwTrCd47RSjThtapQTFDaDKjCLEuoWICGsAzijlilvoiKC2YR6f8PW1AbnEmPzMvAchSQLuInIf+kLswLo5TKJYSIH/GTyqt8kf+pXjMAEowKiCCH+ZYh9GKw6r0a30TlMXK3lwkLLiBj5l3MIyr2eTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736629; c=relaxed/simple;
	bh=UQl9BEsW/bV6xF43DwZ6I//YbZAPjGGkoXYR4BrWRU4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KISraPvNvSajj2cQMybfE0gWOt9uSl47BZX3ninlxwQZdF+ge7ivbWj0BV91Zo1FDyKIHp3aQLkzfnzJeXdrq9wvNH99j6hHFdnZ4JZNnd5Szg/75aEglsJ1tB/fwKJWqo6itXoWdLOu7wRW1GW6gbLohGyoqzHz1QnxpG13Yzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgaL4iln; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737736628; x=1769272628;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UQl9BEsW/bV6xF43DwZ6I//YbZAPjGGkoXYR4BrWRU4=;
  b=kgaL4ilnh28ZEO878LdB8B82YUr+jtAiTuS4BsB7onbeYc6msIBcBxxl
   bDmMdue1U6NlAnZ8T+XzeeUmnMdkMp+O+VBQdS9fqAlApaevL8B4rYARG
   kMqMJrCSRZNxGy1pSB36YLJ8V0R7c6E+4U4w4JWe3vwB/W0Rb96sfl5UA
   lUHklipue1tHcHvB+SxCiz6UqLdvvYJCXD4O2bCouQTbSHASl+VrWQeM0
   8h0vxru2Gretie3v6OObaPjprDW9MYY38QMPYRmtfOmEoQqtson0iGv2r
   agHkP+2oqHRInNE6vV+IY87OIqROChG1EK7+s36vZNmNg9gSMMF698J4w
   g==;
X-CSE-ConnectionGUID: YIlWqcK9QCi9lrTGIXJ4Ag==
X-CSE-MsgGUID: y4Leb/VXSfOl2n2Bcm/D/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41110467"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="41110467"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 08:37:07 -0800
X-CSE-ConnectionGUID: qWvYuIxQRDuiLc2mhZgzPQ==
X-CSE-MsgGUID: DGvACtE3R7C499USCYNmxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112440829"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 08:37:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 08:37:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 08:37:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 08:37:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3CAwcIBrX2SkXrZhje/Wr0OJsteXOq6QTSzqHotWud5p93BwKUA6o2aZJncR0w1GuK8JAEhmcAvGJfRilU/gHzhha7Va/0BrFXpyRX4NzF3xzhum0DeIkg4HBJnGzvsd1iMEnwz1aEcwMILyC9OlD612591QzPKAmyKSC4NfyN3iN1A88YNXpDSZjiAh6kaNctb377+1UstZJ6fgpaPjg8cn/fnwCbT1tn6TqKXx48+ed2rVI43OcEx6+WXUGI+DOr3+6jJUj6MdZVNuEG+DTnz0mYH+j4PD3h5QG1zsPtZaK25rECB+XJe/eVznVuFZSEgn3XQXyVujdGrQTEiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfpQlC+D+h65cPqmus4AVcnK1R69HQpDyPkGvHFW7Zc=;
 b=h7uVlTq4zJATad1wfvgb4LOzbUYcFbB1BysZo7xt9xOn9VHXzu039V9fP8Tvht/3kq2SBBFOs8vy+hu01TEHKhg9ZZgrSiA2IqIKiKw1v7Ggjvt9kjDZmVq6qasgM2f0txB6MusgJYkOuzhUhqg4qZ1qM0Iw25oeGGDyA8Np0MlwEbqcIWnajfmvzAQWC5nETBJejSwfzMrwqpDUnEJwOGRaEEWDHfuaG4qCcNzTShfck5DDE+cAiZA/upFFeEqCXbw2Z0SOlSW72L+9uaTc05qVX2onilvXI+2iTRhcdTNIF4Jga52xkT9N4hzODj8o6NB6TXW8T7SiZMwwyBbeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7842.namprd11.prod.outlook.com (2603:10b6:610:128::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Fri, 24 Jan
 2025 16:37:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 16:37:02 +0000
Date: Fri, 24 Jan 2025 10:36:58 -0600
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
Subject: Re: [PATCH v6 6/6] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
Message-ID: <6793c1aa8d1ab_9882e29476@iweiny-mobl.notmuch>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-7-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-7-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 2990cb71-9af0-421c-909e-08dd3c9554b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FgbKF1p5Sz6N4ylTQLid0YNGrEMkMXtpKQCZpQ1pMVvrrGlQL8qDNi7ywEPk?=
 =?us-ascii?Q?LvSJmfxSd5wI9VwlB8PNb9ZJbCTYIJ7borrnSwWj4NobQOiRht+13g2H+yD4?=
 =?us-ascii?Q?Qdaeb6oXRglyafNv11P8tzJzFxh3+bdqpvRgmMbJQQQYJSBASCbS+tLH+TOl?=
 =?us-ascii?Q?hhmKqE5dbt+KNG18tCBV1baYoT0fGDZQYbvHHt4nFlan7DVxYe0P6hSs3zAW?=
 =?us-ascii?Q?47OJp2X5yiQAA5WAUl5kPMyeD9HPhfje329O9qo8A9LfdfXS/QjGAqu7lcaH?=
 =?us-ascii?Q?SH4JX4OJ6tMP1CUkm6MNYTlUl7POZRt9hvjElb2dG4NVdF7YE8pet9ye1OHq?=
 =?us-ascii?Q?RT6pCDqiZoTc+Gob+Y7eZZFN60W5zHXfG5SkxWwoIPoY4IugzcetUnhTEZf6?=
 =?us-ascii?Q?aCag2JZX/wSQlomCp9pp9hlkygaX/pg+Enhf/i9AKGPZt1c0qjSJ4cdg4Caj?=
 =?us-ascii?Q?KJQ6ychX9fRBEWXtpqhRuaAOFUg7A6IQOxpCYQ5V6xdVXHALclwGvHXHqoqW?=
 =?us-ascii?Q?DXMAJ74eD2QZgBE+0AKUXDs4SGKPSCl00aDfJqvcfPrAxShrfSQVctcHoPFO?=
 =?us-ascii?Q?DI3p7gWZlN2P766SljujHmj3Fq77LZB+ywku3O3tQtT84NfRsG9BK/I4y1bV?=
 =?us-ascii?Q?IfzZliM3gdMh9xVf7yV8k4Xu7HjYy9hXumh8c3UlekwfEceeQd6YjXJKP4nG?=
 =?us-ascii?Q?5CuvD7tTLxJdWJ1lU8I5gpYlw3GRZ2oyjnZk8EDNY6fkXm0tWOA4WFqkT16/?=
 =?us-ascii?Q?ijwl45G2XUwimsl3j3qzBeiW/7tjp19DE3c7LY9X0YvIlYBJSWEZCZ44FldL?=
 =?us-ascii?Q?4/swfxHcZ9tbM7O49Ax53nd9ilf2fJPzLC/I0bkktoTTpEJ9ARqRc94eHTba?=
 =?us-ascii?Q?E6JJjXk6Pfdnc5pivu3cMWitdzf/RMvg6tQnzy5flzDRtCLYaMzXcGc6Syi3?=
 =?us-ascii?Q?oeHSXMZh5UaAuDdpLve8QbAInA87I6Oyo2xYDss1VpAZhqO43cyF77CfMoQf?=
 =?us-ascii?Q?D6UrbEeAc4IKjhZylt+s7O0YTWEBXTYOeelhP4egkPKObMoy+xXPE57OKg0f?=
 =?us-ascii?Q?Vrv6VJ+Cbdby+nCKmr7dSmDfXOXOxveX0IXpfU6xk2HjK6jRqLYV3FTy7bB3?=
 =?us-ascii?Q?P1ADdzBE40vRR1DYnZkSF1jup70isiZ83b3r8ytOdEQb5ESEw6qBd3PL+RqW?=
 =?us-ascii?Q?856zgBC2MnGMuFDb5jDquXY8heST0c7lurZZd4g86ZU1KvRT5JjBEn1K43DS?=
 =?us-ascii?Q?sGbX+mm+4+HLgYfF4V5g6o7YlTbez4mfdQeEmnwJ78IMIILSIsS+y+2beaSD?=
 =?us-ascii?Q?JUq/fnJicD//CKeiH3ECOVsjWd0UBECBj3kMfazvpJlGJ9QlewH1bjHAoYd0?=
 =?us-ascii?Q?5Tr8h79QCcdGLI+mGGtGHQ0zWc3k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?utBNoKbc8jtx84AkJZw4tkhRPe9I9SngNchxJ3BSkAZe2aJsIP/rYWFNqw1m?=
 =?us-ascii?Q?bfCG9WbT3xzBboVEkM1hSIKfMZwzoc40jRHqnB3+uVi6Hu2BGJkf/ditYFi1?=
 =?us-ascii?Q?vc9YnfbtjdGbAnrCMjJVTPjnijWmuyuxaGcPIwKybxEBx42Ed6HA8FPUF9AD?=
 =?us-ascii?Q?J5/AsW5nIBkVrwXyk6Y7ZMXr3dOIB9DVKv+O7LYp7+uNwEgC5ck2TH+EgFi8?=
 =?us-ascii?Q?/QsigDqvydBtEBocLk8TTuuFvQxI8waNdPovz5hcYjKzefi3qmN+WEDZTT2O?=
 =?us-ascii?Q?+mZ1MPc8Hjt2O5aJ6YOy5f/Wd8HqsF08U9uKeeKJhGzBLcaLW9A5fy5Rdqzi?=
 =?us-ascii?Q?rx3lIi8WST9exjqLP45DzsH89y+xIdqu0gMqB4zk84KWjsUZyHV6BKDndGcL?=
 =?us-ascii?Q?amGWuWdUwLrlrz+tg6NoH9xuFNqMXCWP/7gjRyEWtsP9JK/x/5Iplqzup7q0?=
 =?us-ascii?Q?NN5ta3Z6MpzWPD3Jvf06hBu7Lwr/XQBVtmK0RbXqv0Rp1YcUZtvJ4rzo94xZ?=
 =?us-ascii?Q?Rn3VrByzCImO9j7XWtbSJEYJFd0pQNqDQGUAdi0kyGbnXPczjaMt50fZmHp7?=
 =?us-ascii?Q?WTruh0uXhlGE1jKRChR55NOmTNoxrac65esggtlrlkXfk4mmZs8Y08KAw7BU?=
 =?us-ascii?Q?BxDlpVNwISf3j49fhBMwwInyEScF8B9ykJ6jmrwviJhf4i7tkks4T1XK7kTo?=
 =?us-ascii?Q?D+TF0z243aY1cQxCUbLc13gZq7lYGtXI9bJPlU+udLb11ie/6hR3TMDNh335?=
 =?us-ascii?Q?+pPQHrvGRfJ5aFOyoNkz0DOwborE41amqQM0cM21tP4v7iQb7B4mIPsfdOh5?=
 =?us-ascii?Q?qSZ9PZ6AeAWU98a20MzfrD2eS1FNtOU6R960M00x9+Vv972YKMN4Wpe5fwMo?=
 =?us-ascii?Q?32d48Htl7m7cg6CiI5taN1jvaCUIGi6F1e4gW9NKpKI7boC3aV1kGsSmrSd8?=
 =?us-ascii?Q?ccb3MGxNEht0FRSWwVRfD21TIOHUroWcl0iZQCL9uEcIqMwC0dMTnp8CezI3?=
 =?us-ascii?Q?TwnXViKIm4Uv0JuV7vYXg/pz9kKdd3/vFuqkOiGMs0CTY7i8TyIHAdi+5bFw?=
 =?us-ascii?Q?5Ql7P6jo1+DnxAWnhy1fZDIoXE6FLL2L/xb74DMJtok+BroGFOHJAm/s76H/?=
 =?us-ascii?Q?htS0Cysq7tJwd1/o5apCAbWglDoGvfU7+3YGNu0FvnazNy54pc34U8e3YRyL?=
 =?us-ascii?Q?9YYlGd93+2A/4E1WD98rq5/CZqXg5CHnMUdv2AkgDOfezehrWnez4VyAgxB/?=
 =?us-ascii?Q?Jg2VV6Q0e4XPvF1HcxIAdU8Wm4BbyRzQwhQlgHWNQnIfClucTCqo/r5JR+7D?=
 =?us-ascii?Q?jMBhXjC1aEVuL/0Q/bgvoNKIgDU76y2ZPRXJr6Tq5KJSuI8iDIXG7nHHjqyP?=
 =?us-ascii?Q?PyawuIzf5cbZnd/b+9e8DIhN6NEzEr99H7wyIvB4JSlTu5d9cdzqa6VUaC+7?=
 =?us-ascii?Q?m+q/BIfjnBiMRZuldyN83VT4xWMkk+lk9+YsWj2tIoiZgBMamA3uKr7gz/1c?=
 =?us-ascii?Q?4TlAN42T8ngEPTYpCGTRA1OBuly3g5UjEuBVeJpmd6EzxZUyHRdkojCPd6f/?=
 =?us-ascii?Q?tNMONwpfSnySezMY4Hg0hs9oyi6hVFj1jqWxFe+x?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2990cb71-9af0-421c-909e-08dd3c9554b1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 16:37:02.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gvwg6PbDmUfB3JA1GTqXoxT5E5Bz4xd3DWizeMldygOP903HL0MZr/CweNKEqW0CbrI3Xzs2EBUDVWZ5rThRIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7842
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

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

