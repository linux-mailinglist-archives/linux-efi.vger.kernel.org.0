Return-Path: <linux-efi+bounces-1903-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE85598FA64
	for <lists+linux-efi@lfdr.de>; Fri,  4 Oct 2024 01:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9205C282908
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 23:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C576C1D0170;
	Thu,  3 Oct 2024 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3hDZHaj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607D1CC171;
	Thu,  3 Oct 2024 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727997687; cv=fail; b=CqNdOGNrXUYHuOki09rsYBqu+Gs0sEZG5rWRwapdQieWvw3Kb/MiD4mvrTNmhWxgUBVdqzOUjFP/CIZAY7H6HF9k0Vj+f9TCutdTZNikniOV+BizhBnhPO6CFNigULkRu7oxjAa3RetPotXw3L2vOLvZ+dKBBQ0hAw96Pac2aWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727997687; c=relaxed/simple;
	bh=PcJwZQXKhCgLE9UyGZb3sDfPy4kdujTs4rnB0O5APXA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jcvQoGb2u4mUTbaA4Ysry2czi3dbcnmxrrVxfZclIa0qXXTanqcGSnsyLiWnLDa+v8xWj7O7nlk/E2l5ccG+es6wL4heJVvVuAeiqUtNMyeiQun72mz+0fGY4Wcxc/Dmt32QsLyZ0seKikOauDew3xgas+yBBX3OrVdTOPHahRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3hDZHaj; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727997686; x=1759533686;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PcJwZQXKhCgLE9UyGZb3sDfPy4kdujTs4rnB0O5APXA=;
  b=Y3hDZHajH3747CWR+W+PLsZih+lPXVHX9KOMnXpL3l2xN5+miiLTdNg3
   6di/5aE9d1QOTHtiJhvx9MUFKIniOz9Eh9b9tpfIWJjf+rsntTaRo+sRB
   btx7/5psoS3WAzyLjV5ROvVIYtPjdBNMmPi/5dT3FdzgH7KdOKVUc5KrS
   mVYIRr1ELBTVLHT+i098gDD07lxdV3LOxTIhThfass0gQRlrZL9+JocFl
   RyvSWtUp2ty82NI286kniSX/YeOHg+TVEXCPpbLK119J65w/GDB+64Dty
   2TvPK8s+Nj36L+DvcbxqeK1BUqG2AObjLy1oJX7RHRxsbsJuocquDUZX0
   A==;
X-CSE-ConnectionGUID: owCdjySaTfOi7vTKVdHtsQ==
X-CSE-MsgGUID: Ck/8h53yRK+awuqgpFu+CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27100892"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="27100892"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 16:21:25 -0700
X-CSE-ConnectionGUID: q6in/5dgSYKcCIk81dqFXw==
X-CSE-MsgGUID: zvtD7vQ/QhS33Xk8VUXfzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="97829409"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 16:21:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 16:21:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 16:21:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 16:21:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 16:21:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRkToLDnxvOyLW/8KIEE9qwK7Zq9dwl2zcxdQmbMuMJ7IoyvIHeiIG+8fyrmXzyGgB8TpZbIXfM0nTHaONEvFpVTjE1oPRAlgmQMbehaW2tTfGHsqNyuw3yZCFxGCpz/jw6g4qly/H/y1rYrtyDsI7z78ZIHi98/oLMVhHNzrtlFIgUXzdkGmHgx0Z20vTAM1kEwEoE+WlZuBBjMc64EdF2I6xwUTvECMNWMLF5TmyryWvJA00xKKXT24xmPVu2ys0ijgQDyhZBgERd53jsrPnn+BbH/fZVKAHk+huIlpwVQIevkq22zCpjvSjs2uiPj8Qz1gT/OyYiad5leEn/FBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7HhbZoQ3cZY2cckhrKrGvPYK8n/PRFRRiGu80e3Mmg=;
 b=Qi1DK3xk8113YImDC65XUUBpmRtaIzg8mXiPuj6eH30vzDcNAUVFaf1KtMMU1WEdzH47NJnTbBGFFk1EFgeqz03QOJRHete7x3v259Svy0zhjpNtut2cDA5Zup2aBjR6edVtrM7mNzpvzSAIhQl47Wd/pzK6mrq+xgJBS6HTyCFIRJHdBWkXErSqYV2VW9g4XL+CShV83VJDUpbm0KQcWRYSxWznc4mjGAQCm8jzk6O2iVCZTmS2bdi/fXjxgX4Rs2tHDZj2pqsQcV43zauswhvq3bmwZkEFHo3NO194aI9Q94/1GSkZMu6lCUrTNbyfbszteB5rnghHWuHeBVR2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7268.namprd11.prod.outlook.com (2603:10b6:930:9b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 23:21:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 23:21:22 +0000
Date: Thu, 3 Oct 2024 16:21:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH v2 3/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
Message-ID: <66ff26ef619e9_964f229411@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-4-Smita.KoralahalliChannabasappa@amd.com>
 <66fddbaf9acbc_964f22942e@dwillia2-xfh.jf.intel.com.notmuch>
 <082e7c7e-9306-2f99-3693-696350cfc43f@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <082e7c7e-9306-2f99-3693-696350cfc43f@amd.com>
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a88bb8c-fcda-490c-6b15-08dce40217bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ilq9h2Rq0NHLntVVs+MWdYD20xrMFbPehPP48GrIxLEUBjLU3M+t8ZSf1dgb?=
 =?us-ascii?Q?+QuEYADUJqSmffH/YfEjqulTV8t0RCE07aOeRFaNvGvwalp3TLMvBQegv+hs?=
 =?us-ascii?Q?mn5/+gSuO6BCl2XEO293VIvgpp29gmIonyB54hlN80ppDDGdTZVHnK1vfoQm?=
 =?us-ascii?Q?CdXBE9I6w/g8he0wkQWynbqt5hjleG6AeFQJGmo+ZUYtxEo7oxBHiyfcaFaP?=
 =?us-ascii?Q?Vo1sGQMQaKue+xtH50yc/FIXA4GP1EfC07nDky9OTmqSsYB0F+NT79J3/YQU?=
 =?us-ascii?Q?dY6ojDdnJf1CZg1rvEat9zfzWDDrzel8bwienCfGw5/YnRagdrb2DLtKVBAO?=
 =?us-ascii?Q?C039ga08+QYw7xR61jiw2rZdUT/1lCrc7r5WUrwcMHpD0NSd6PaRhkdTGaRf?=
 =?us-ascii?Q?ULgL/Q7HxA1I5ai68mv/nYnJ1xwTFFHAoHpapNtQXKkXA4oelt/k3SzfEftq?=
 =?us-ascii?Q?e/uiY+RLDTTMj45Pe+UC/dBNTsYMLtBw8qjQl3E22BHAED+SgjEYwQ0gOLJv?=
 =?us-ascii?Q?17jYh8GVjblPfLNlPwmslapzSx9NgQX0xlpYnw+/1xbwJazZBR0OZCjk2wWN?=
 =?us-ascii?Q?6zNk8A879PisaCRo3YQe+J1J84/UkDVYIaPek3FlV21uAAAOxG1h7R8nzaRR?=
 =?us-ascii?Q?hy3bo61e4ZYZGF46YCJia978PjTs6kyLcVlV95j8ERXLPmas4dkQvVteMyRO?=
 =?us-ascii?Q?2PE4enEbbeHaWZK8BrUqlAAGMMAphITjCjnT3tGEOx9aIaQLVR13+kcFfxyy?=
 =?us-ascii?Q?qq2pjYiu1UVP8Ys9rIYI2MrgisVKcozXmM0qoW/PH8jXFUbFuEL9GghIe603?=
 =?us-ascii?Q?T8m6TN4r9WwzpcQe22wrlZpZw7WdbS6MlACk6eYwCGCy2aGYc8wynEYDWps5?=
 =?us-ascii?Q?V9U4fAixe4o5VN91vTmAalIZPz4ijo6TtugJ2oo+CicF+Be4iUF298jUD40U?=
 =?us-ascii?Q?ej9KUrYYuDhIwQi3bdcOj0kO+xZUogwpKWEgIsTtxAdIcAo6cKV+varQObZt?=
 =?us-ascii?Q?awG2ZiRwVGsghaGws6DyY1c9vHzn9uTE+1HnsBkX5T66aFL58ytJlqOXQ7Mo?=
 =?us-ascii?Q?DlaAofXFeFiX/rPcGB/5CkZdoBH9eAa2Ur/ZCs4yk2qrZuTo5MU0bQhGQh0/?=
 =?us-ascii?Q?S3jWm7AWYHO1H50D0abUnojjaP2B032EYwYtzWzteRvf7POIpBKFg9U9XmJV?=
 =?us-ascii?Q?B/xs0OY3TpRvjb1D6R5tbeW7uThr99VLLJWC2nLdEqSdnOG23o1yrHA9Wpmw?=
 =?us-ascii?Q?CyLunlGGZYPruqYVQLZeaiZG5b1/QuAky+6DUkPlXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?afnmjScOM/XAjl5z/AcZSvSD9k+RuMdle9fmPRz+bbGUy4ItPHeBEVMBNd2i?=
 =?us-ascii?Q?x4sdIjuAlbJm8PZ2Xa3qBd/uw3QpL92i9NUQFVqa2Qh0hB2bX0B3C52tgUea?=
 =?us-ascii?Q?+0PDD3ErLCVNJw/4spsiIAwoB8AjP4cX2qTh6+YMOWWL4pwV2ae+M0MnqlGd?=
 =?us-ascii?Q?eATmshUR1TkgjwXBCjhxerF6JqfC/8FLjLetaQFSB1qyJS6jtZAKESH32keH?=
 =?us-ascii?Q?XRJRCLt3SRoqMUgvgIvxFwAZWHZk4+2N46aG9lMFCp3GtAMWEnP7Zh8CZyu3?=
 =?us-ascii?Q?tB45aEKjHPvNNrZd4aIEbT5j3o8Twez2STgQkcul54OSZIfcWwT17XF+7cnA?=
 =?us-ascii?Q?KLChft1vD0nYdAUzlP17NTVP19F6tPX5CqMoOl/s2vOVDfrc11S81V4xcqv3?=
 =?us-ascii?Q?7A0bN/z3u5Cv+Yd6vxLu8Q7xNwOqWJI3Sk6pbJzPTnqVlP7GbadxT4DBp90l?=
 =?us-ascii?Q?C5KovqBfJDLI76sxh36Ry1Kr79qflq1IcsgUsxjnq2ZjUVzTgADyIINTwISq?=
 =?us-ascii?Q?ZkeYObYMjrvE+Vp8FiT3bNfX85cjxlly95kQk/JNVmS0qZpoBzGKxHnVoPD5?=
 =?us-ascii?Q?f8Z1SH1Ld0le4OyjUjPWmf55F3PyQMmPj4zaxvnhgBVjzJydKKZwhO0vi+Uk?=
 =?us-ascii?Q?htwcgHGRPB6ctw81HWHr+TDhLwS7m8lioI6+mCcHpeB1D1tP36ur8mh2lQ8u?=
 =?us-ascii?Q?JVRNL/emfX/w/LvD+vjegAI9JcxZwf1EG9SpJSSs9iaMmsYi6HxpCqWTXNJb?=
 =?us-ascii?Q?KV+970pgeJS9M2b1M7HfAiFwzr3D7oToiH4enNHgyb74YBRYjh31OOv3hpPH?=
 =?us-ascii?Q?y0HK/73kwv4hR2jH7JUV6YpAhOWkR9C3C7PmKiPay9buGC4cvUrQ5xj8RA3j?=
 =?us-ascii?Q?w4jA9motcg4kEXfoYFJHKj9DFTxZthtP/j5/PWN06+MfgAhwxbwVtEKqzgLA?=
 =?us-ascii?Q?J6gUeAVwK5VynYP4DHGG1rNObq6EVsm1pVSAA98OGHX2WrFoAEAqC4pT/zQe?=
 =?us-ascii?Q?MZAuMvSbDEFNWJWgiZwIQehzsDAY4zRwHL+s0whrJXJAsz5hZCn+sOgBx1bC?=
 =?us-ascii?Q?RDSzyaQCWHlpHZLlnwhfiiU/bXepmq0GnNpyAb+u98wXglTm9vtKc7o5fhA1?=
 =?us-ascii?Q?0IVvNWCeG4mjM6d0DcMcBtL3spoNTuNA+a/nA2URNVFM53fJ9G+8bcGRgTPZ?=
 =?us-ascii?Q?MP75azP+qg3kkF9hiZSTz1UJSYVen3Gs2ZGzhgK+ag7q7xEb+7R6d6Uquw4j?=
 =?us-ascii?Q?qKr8Mwm1VDKHCdYypMKelJ40PNUtkDQVmBrMCrhHReeqFr9UkOYbCozX9PS3?=
 =?us-ascii?Q?U5ph0iCD9FPb3fvCF2MPLKHiSmjftFV3IDjqFI6DASihqjQEoLGQYRRDMd0b?=
 =?us-ascii?Q?AAv/VT0VZtCY1nRXounGUGgJzHilDX/4eUzQoBdkJbFFT1Fo4f02x1yMWQfd?=
 =?us-ascii?Q?xbsgB/qE1/pCMV4hQIGhOFI7yroXYyq4lzoPUXuiOG0ZthP6M1chc8IabYbb?=
 =?us-ascii?Q?RzRtzgxGex1UiJ1CFR3fVTMlXpiA/x12vbMy3YLSMWUayEs1WkF69lA1jRnB?=
 =?us-ascii?Q?Fpbb7tBf/sE3Aie82j++0aZE+5tlhs0il1G8U33AjPBgnCQGqrJHRXAeoRfz?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a88bb8c-fcda-490c-6b15-08dce40217bc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:21:22.0908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThJCWXGmPs7poqHkka10J+KT//nHUSGZaCGXzWk30Qg8cbh6ZPB/E8dq1KUE7zKf6FF8MzMR8xgZFjEoB2IAg+a0qAkweZ5Hs8fw9YResnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7268
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> On 10/2/2024 4:47 PM, Dan Williams wrote:
> > Smita Koralahalli wrote:
> >> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
> >>
> >> Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
> >> Severity, Device ID, Device Serial number and CXL RAS capability struct in
> >> struct cxl_cper_prot_err. Include this struct as a member of struct
> >> cxl_cper_work_data.
> >>
> >> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> >> ---
> >> v2:
> >> 	Defined array of structures for Device ID and Serial number
> >> 	comparison.
> >> 	p_err -> rec/p_rec.
> >> ---
> >>   drivers/acpi/apei/ghes.c        |  10 +++
> >>   drivers/firmware/efi/cper_cxl.c | 115 ++++++++++++++++++++++++++++++++
> >>   include/cxl/event.h             |  26 ++++++++
> >>   3 files changed, 151 insertions(+)
> >>
[..]
> >> +static enum cxl_aer_err_type cper_severity_cxl_aer(int cper_severity)
> >> +{
> >> +	switch (cper_severity) {
> >> +	case CPER_SEV_RECOVERABLE:
> >> +	case CPER_SEV_FATAL:
> >> +		return CXL_AER_UNCORRECTABLE;
> >> +	default:
> >> +		return CXL_AER_CORRECTABLE;
> >> +	}
> > 
> > Why does the CPER severity need to be converted to a new CXL specific
> > enum value?
> 
> I was just following up the same convention here as done for AER..
> cper_severity_to_aer(). I can change if there is no value in doing it.

I think because PCIe and CXL are both using AER as the transport they
can both use cper_severity_to_aer(), or at a minimum do not introduce
'enum cxl_aer_err_type' and instead use the existing AER_ values.

[..]
> > All CPER records without a device-id have already been dropped above, so
> > why reject agent-types that do not require a device-id here?
> > 
> > I think this agent_info[] scheme makes the code more difficult to read
> > especially since agent_info() is only consulted a couple times. Just put
> > a "switch (prot_err->agent_type)" in the code directly and skip the
> > indirection.
> 
> Hmm, I initially thought I would do switch case and then changed it to 
> if-else thinking that would look cleaner.
> 
> What would you suggest? Just incorporate switch case similar to 
> cper_print_prot_err() here as well or clean up switch case in 
> cper_print_prot_err() and reuse the agent_info[] there?

Even though it is more lines, I find cper_print_prot_err() easier to
read because I do not need to switch back and forth to the agent_info
definition.

> This agent_info[] would include 3 fields then, two as above and another 
> for valid_cap. Maybe unify sbdf with valid_cap..

agent_info[] ends up being code-logic masquerading as a data-structure.
Keep the logic all in one coherent readable block.

[..]
> > Hmm, 'struct cxl_cper_event_rec' follows the raw format of the record
> > from the specification, and 'struct cxl_cper_sec_prot_err' (formerly
> > cper_sec_prot_err) already exists, so why is this new intermediate data
> > structure needed?
> 
> Yeah, the intention was to extract only necessary info to be consumed by 
> cxl_pci driver and to be passed to cxl_cper_fifo.
> 
> Going forward, while handling protocol errors separately, I can send the 
> entire cxl_cper_sec_prot_err.

I think it defensible to send all of it. Recall that the real consumer
is not cxl_pci it is rasdaemon in userspace. The kernel is not in a good
position to filter what rasdaemon expects to find in the record based on
the EFI specification.

