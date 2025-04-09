Return-Path: <linux-efi+bounces-3249-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519BEA81F7F
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 10:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CEA3BAE7C
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 08:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B741E260A;
	Wed,  9 Apr 2025 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQzoYHLT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50171D61AA;
	Wed,  9 Apr 2025 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186548; cv=fail; b=RsWSkshCJfzUPLBib/xSRfIu/4mf9jhV3nPkN29XIQ8GXPEg28q/rwEmMVaqdFbaGvy84tK+IU0T9J4u8htKOW9wK87AKOJC0femeLEu0yTEwJd38kFa4VykFftauGu+rCYMmjtib2wMYotX4vRse36rJDft0QR2pleKOpjkpe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186548; c=relaxed/simple;
	bh=hYpul9LikSI058lJ2hhRonvrUsp1ePcVjk0/kE4xu3o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T8S/hyJ5IEcc8djiK6NVqyEZUGxR23aBChBc4jD9+gHpwl6HdhChYcssuPimecCUtXYI9zRmweI700QQ622xRDxbkGvnF/Ws89CmT+HRbfmXsub2wBaLYFkd3LrNYmp+I2Jva18bBDjEMLdl8QIwQBU1o1JI7LSULAQzFhW5Rbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQzoYHLT; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744186546; x=1775722546;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hYpul9LikSI058lJ2hhRonvrUsp1ePcVjk0/kE4xu3o=;
  b=kQzoYHLTNzNsI67gyS3KZD8e6W7HFHrAFI3QfZrflQ8/OtJWCZQqgNgs
   zmbwOKw4vKySZk/m7bXmiOOSfouDgC+XdfS3Wko3qSULK5Bb45gks7wyH
   e0CQB622uL6JH5xeF9q4fRYjeNKDYWwE3krvyZWHKM9/MXeZN7MMxf89S
   CUefDNkBD1hH6qt+daMBM0sIse8tFe+unUzwBYA5rFTKEaEV2n55uiX39
   KHJq5S5Nt0PIwrxMT/mPxgjUNUQqGOHrZ9joqOf8v+wS9NhVunwQJRe8c
   mrWxIPBMNhxQf+zLJ8wZk044u2NAp3U9aca0iLrT8ssgthwdHyJJGvKC5
   g==;
X-CSE-ConnectionGUID: wQYn77fITkCP7d6MRAZ4PQ==
X-CSE-MsgGUID: Ye1hB1b1QviADdeeH8aUkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45540649"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45540649"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:15:45 -0700
X-CSE-ConnectionGUID: upo98PsoQB+/thNzJEsXLg==
X-CSE-MsgGUID: +O66hio+Q9KTd7ez7+jOJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="128500386"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:15:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 01:15:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 01:15:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 01:15:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlynwxVk+mkjWl8TDfDqRh+ByOlApmDYM3Hc8DvmkWy/Xzi574uAIKV3DgBwk+RKgNIhT2CVwXPOYUsSB2iMokvp/8LoU5jNXub5RnTRJGzBjcv3keLmqRDBNUZGBYS9lkbjxm/B2ukqC1V3xGGDwjBmnx2DFt2h889MJMFHBsLI4LZnauvLYr10cpJs9FmDNM4UXlmpTAw2KF5wB/Z/alPUTX7p0acKeqhuGUVi28c5HWPaT/Kvl4UY1q7p2F2+YjKRqwdeLJwGwodiV+u1+eTFzukRd90xrLG3OcFdf/adPA8Mw46aeFEc/1vZ5JUczmUo1C/mcf1GzVOo6rtICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPJR8jT5wzRKs+hmyTAwdFhqYvKBVs9/haBc4DEqaKA=;
 b=TPJfTN7U3MDj3VtPV9/iJnnUDH9GLqtaLWhXwHlt4g6RhbOFdsMmHlfbwoCYkGu+w5APlHeyRtLDPFJKxSF9fMHopaA3yLn/Xd9mL/iBqloxppQNzItgHQaT3q7jHd/SusjOIVhORqpq4iEK7gjuHBMaNfagvhPUF4kaCKr2Ek2M3WMUOo10/JUda8SqwniSLF/FIHBEfNLK33d4zOZdA/p+HlNtwJe2kswFpNbJPUxAoSirWM9/PbprmotDDtwzofCsKlBM65wo/DPS+Pd4i0d9g3t6rFo/X81h9XYEbeiyltnfLiyFLtG4KhP4IfDpuG5U5/F8HuGniFEy689G0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6141.namprd11.prod.outlook.com (2603:10b6:8:b3::13) by
 SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 08:15:16 +0000
Received: from DM4PR11MB6141.namprd11.prod.outlook.com
 ([fe80::31fd:4de2:2775:396f]) by DM4PR11MB6141.namprd11.prod.outlook.com
 ([fe80::31fd:4de2:2775:396f%7]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 08:15:16 +0000
Message-ID: <f4ac5bf3-d380-45c3-a48c-2969cd49b32c@intel.com>
Date: Wed, 9 Apr 2025 13:45:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] x86/boot/startup: Disable objtool validation for
 library code
Content-Language: en-GB
To: Ard Biesheuvel <ardb+git@google.com>, <linux-efi@vger.kernel.org>
CC: <x86@kernel.org>, <mingo@kernel.org>, <linux-kernel@vger.kernel.org>, "Ard
 Biesheuvel" <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
	"Dionna Amalie Glaze" <dionnaglaze@google.com>, Kevin Loughlin
	<kevinloughlin@google.com>, <chaitanya.kumar.borah@intel.com>
References: <20250408085254.836788-9-ardb+git@google.com>
 <20250408085254.836788-10-ardb+git@google.com>
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20250408085254.836788-10-ardb+git@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::7) To DM4PR11MB6141.namprd11.prod.outlook.com
 (2603:10b6:8:b3::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6141:EE_|SA1PR11MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ff6054-b63a-48ab-b920-08dd773ea8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGVnbWxIVW4xR2ozKzA1NVJNTDdxTWNHa2hnemVWb2hXd3JYSENBdUFVYWZ4?=
 =?utf-8?B?Ym5iY1BDdTJYaWZiZWgwekI5UEVOaFRlUUJXOWZrZWdNckhXbG1LRlRuUVFC?=
 =?utf-8?B?dXlJU0xTWEh4dXo4V01WbDlKL3ZQRkNONklRd1Z4V3o4WFE1WXlnK01UWjd3?=
 =?utf-8?B?cDBaelIrcUc4QXg0Z2x0RGpPZzlvNTlVdkg5WUJ5ejJMb3FPeHJ4Y1doT0Nt?=
 =?utf-8?B?d1FBY29HeDJLQUJYSHNhRzhrSjloRXJTeW9GaSt0djJvT2dqOHV1bVRJZ3JN?=
 =?utf-8?B?TjNzU2NwdmEyOCtKODNObHRiWFpUY1ZFZFZyUUEzNndLQnh3Rmo2a09pdDl5?=
 =?utf-8?B?aEIrRmkyTGdFMkcxNDZsbHpqd1Q2RUtHS25oSmpqU1lPVng4VTIwRVFqNDZa?=
 =?utf-8?B?bWMyc3dFM0pucmNzbHZEMEY3M3ZycC9LTGxmeC9sR01Wc01lRXVaK3Z6Nnc5?=
 =?utf-8?B?V0I5SldCdmxQQzVmUzdVU2drTFkwN3k2ME9SckUzMXFzVkh2eE5PQndLWGRM?=
 =?utf-8?B?WXdMVjNjTXlnRDlFODBIU2Z1R2k1Qktadml2Z3MvS2ZOWkRFS243bzlVSHZI?=
 =?utf-8?B?QktrRTFBODFKaW1abndycVhoaGF2MUoxV2FxNkxKR2Q2djFORDV1aS9GM1dF?=
 =?utf-8?B?cS9UNXBmOGtFQmYyeEI5L2JCbzhadGZGVGhLOStaYkwyelpDRFJnaWk4anBX?=
 =?utf-8?B?KzVYT3VKUXdiN1FSM2JOYmNmVHovQURXSTBnYXZrbUNJRjB6YXRLSTVhQ1pJ?=
 =?utf-8?B?Rjd6TVFEMTMvL2hQM2pidm5HaFlFdnhOTzZ5ekhLK1J2N3JmVWgxREZBR2Fx?=
 =?utf-8?B?UEpBZnUyUDEwNUdNazQxRGx2YTd3OHpRM05YQlUra0dwZ0Vpc2dvUi9CaUJX?=
 =?utf-8?B?NE5LYjhHMm13RlRUZk5yWWJHRXV0ZExST0dsUHhDUXpWUXBNQ0ZHdmVDdG9s?=
 =?utf-8?B?V3JoVlUwekJRdWYvakJXTlBla05wV3FFQjZRSDhMKzFabUpNU0IrSlphQTRw?=
 =?utf-8?B?ZFg4WVFVVjJHcHAwMkJCUzdwSHJKYnMyUC9JRHV0enpKaHVBV0l6MjFaNFZr?=
 =?utf-8?B?MjROWlp1alhMNGRYSnh2dVBEWHkxa0NVRGNJYnFoRlZlNzdPa0xNNm11R1Vp?=
 =?utf-8?B?TDVFU2FaY1NOcjhMNWNLalJoUWg1eHFjOFp1QmNBcW1aVUpnMWQ5ZWtnZ1RI?=
 =?utf-8?B?bEtZeDlOdGdaQjdEazFjdEhjVzhnbXVtNXFCMHhGSVRrM2wrUWI0WU9ESk9q?=
 =?utf-8?B?UkdXV3NYUzhwRDAvZ3pjaExhdXFGMG8rM2hXR1Urd2JvVncwL2U5ME93U1FD?=
 =?utf-8?B?bmlZSjhqUTlBL0hNWUQxODgwZkxHbzVvcGRvQWROUldLRzZCNk8yWEhycnZp?=
 =?utf-8?B?OUpxOGhBT0FDMFNBMVE1U0Urb3lvc1JlNW8rdkdPM2JtVlZPVURUT1dwQzQx?=
 =?utf-8?B?a2dWa3I2QXlsSkt3ZzE0MlFtQUJCY0tDODJudTlNTHZVZlI2QnFWMjZISWJQ?=
 =?utf-8?B?SXh5Z2FRZXJFSTRuNS94eXlmYkg5ODhOZTRRSFIvUkhYQTJDMlEzdXBTK1ZX?=
 =?utf-8?B?ZkNNNHEza2N1YlBQVWlzQU1kV21HUWVnelBlbVZYNDEyOHRjSXpBcTU1SkZU?=
 =?utf-8?B?Mkl0dnlRUHBXT3BhalNWVVR3NHFYUU5wTlZSQ3JxdW8wMGlRVmRNT0g0WHg2?=
 =?utf-8?B?WkJWdElibHhJallKalg3bkxJM1JMMFdFYWMrM21LNlY2Zzk0b3NuQ253OE9r?=
 =?utf-8?B?TnZvVm1GY0x3WkJOU05HUFYxb0N3M0F3S21SNS9OcXowbzdqbHFwZWFOVStQ?=
 =?utf-8?B?Vm81VXdEblFKYWRLSTZWZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEJ0TktzU1lMTFc1K1gwZXZlRkdmY2ZobzUwSzVwTmFyd3IwOG1nWExlQkJh?=
 =?utf-8?B?Q1NETVZxaGMzNFpUTmx0bmVsbzJLSzZCQlZYaE5yVVpQOUtOTXF0cDBaUzUv?=
 =?utf-8?B?OHBVMUIxbGZxWmVjSE1WMFducTR4UkpmQ0UwMmVpL2h2TWhLd0ZuaDBWQ3Rv?=
 =?utf-8?B?aDdubDVjM0tmblFKb0dyVUU0RnNIZFVaUEhiWFQ5bnhDR2JpRGxOeXpqcG1l?=
 =?utf-8?B?WGNHRDBudzZHUjRTNVE4NW1XTHVXUWM0clcwVXJHUUo4Ym0ydnBtdlB1WGR0?=
 =?utf-8?B?RTVCZDlyR09WbFFhUnBxZWVYTDRTamdyZXpGOVdsNkpnOU5xbVBSSVdtaFpF?=
 =?utf-8?B?bC9SQWFVdHVUZTFmYUNpU0V4b1Y2Nzh4RGFTWnVudDlDUWFhZkVUZlZPc29n?=
 =?utf-8?B?VkhyYnhVbFpsbkVEMTF2cFhRQ2ZrZ0FqR0JVd0hSYmluZURlMTl1aW82U1ps?=
 =?utf-8?B?cFhVYjBvWmgrRDR1czE4US9DdUFpSnVOREIwVFJkbURicnZTNGNoS1JSZVV0?=
 =?utf-8?B?akwzTkNvbVlEcnhyMVVXRWxOWERYSFhvMXdYaklyZ0tnRjdDMzc2T1oxVEJ4?=
 =?utf-8?B?djdSbWpHNUFic2plSk5UN1hqK3cveklNQi9yKysyS2R1ekgrTDZLTUw1Znc5?=
 =?utf-8?B?RlNTNklCRkUvald3cnNPUXZyTElmSTZlWWxGWW1WZ0xiQk45MXM5V0tUb2dv?=
 =?utf-8?B?QTdHUlhuTFNXQjlhTUhKYU1XaEpvOW9XQkRtSGtUYlk3aVUvZnkvNzVJQWRT?=
 =?utf-8?B?WWVOVlhzRmpIZkF5Zk9JTm9vS2VBdUVGRFlCcEprVG1MY0trNWdoZjBGQm1o?=
 =?utf-8?B?TXhzQ2d2dkk1ekNXVi9JZDVYS25lN01Ncmlvc1Rib0s3YmlNS3hWZnQrYWVH?=
 =?utf-8?B?RUlvRVREY0ZnN2dqVjljMEorNkJqRHNRcWVuN1BlcnlqM3FXNnhtNEVzdnI0?=
 =?utf-8?B?UVA0Q292MmU3U3FtZDFOdDd2TEltenJ3NFBKWlZ1NThZZlo3OVJFeTV1L3RG?=
 =?utf-8?B?alRFa1h6VDQ0K3A5VkY1dkw3Y0dpMmZkSjdQU1NNV1ZCMDNVV2tiSzloZjRB?=
 =?utf-8?B?VHgvZ09QbTNZaHZzUUc0WDdPa2ZSUVFTQ3dZMmNxS3orakdmUS9SUnh3b2RD?=
 =?utf-8?B?VVQ2aDE5WFc5N2xteS9IY1R6UGdWSktIUncyZzhleGFkZk5ySERmOGxBUG9X?=
 =?utf-8?B?VXJqSTZHQVVHQ01TZHErN3hpRmVKZVZHY1Jlc2lHa2RXYVI5YitNeFN2OHUx?=
 =?utf-8?B?VExoK2tlYzNIMy9SR0FQY0NjLyswM1dWOXJrY2krbHAwVEc1eWdyenVVa0hm?=
 =?utf-8?B?VFdjcjluemx1YndQZlZjaG1QaTBVTFF6Ymc4MUNlTFMyZnJtRDhwdVNMNGJY?=
 =?utf-8?B?Y3RpdzllVkJVRHlMNGhTM1pOUWtQd0NvMk1HL3ZGbzUyaXpTVlJ4RisvQUhD?=
 =?utf-8?B?L252akhPRENQUzVRMVlSdjJnQldtL2hqVzJMK2U3ZFB2cyt2SUxaem5nbUVK?=
 =?utf-8?B?dWd2QkVBUXZ3YnN6a1pkL21RbGFOckJPM29iNTA1QW51VnhZUXJSeUxUUlVU?=
 =?utf-8?B?L2tlUzRjdVI5NGV6TW9DWEIxLzc0d2VnTjdzVlNWSzZ6RU41UkRwcXlIbXRp?=
 =?utf-8?B?RytwWnpydEJqWityQUxYWVEyaXI2TkM1WEpoYzdudGxwZlRwR1d6S0RTVHlN?=
 =?utf-8?B?eEIyOCtmVDUwZitrclNBRXp4WmM2d3JiTDUrQ2ppWUlCWEdOa1RGTEZQdjVW?=
 =?utf-8?B?dlNTUk0wL1BESjJlbkZkc1FoVWQ2K1VTV3o2eGZyUCtPbmtrOWFRTXZSQml6?=
 =?utf-8?B?b2VKVDQ3cVlseHJocnZDM0lwRXExUXJBcktuR083RkRMRlJRRFRWTW85cmR3?=
 =?utf-8?B?Mmhad1dFVzJGZjRrNmpxVGswa25FN2kwNE84NG1YYlJpU21lRnBoZEdDaTcy?=
 =?utf-8?B?U05aTUM2ZmhmVnBYb0NxOHNDc3ozY1hiNjJiVXpjNVV4ZmY4VEdXaHFjTnlZ?=
 =?utf-8?B?THU0c3A5NjBocURoY0RIOElMV2NsckJpbW5JK3duQk81UnBQQThHY2xEcTNG?=
 =?utf-8?B?SjV4Tzlpc1lYdzNhWnQ3eFJzKzZXSVNyYnFXVDZDeHJDSlBzRmRSc1g0Mk45?=
 =?utf-8?B?YlNVTzdwSFdZSy9WVTJsU2puOUJOUEFLY2lHaXoyS3hJZ3RxaFJnQmU2WmZq?=
 =?utf-8?Q?XwFQ22pM0q4+Y6PLhOlgMZs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ff6054-b63a-48ab-b920-08dd773ea8b4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 08:15:15.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcrRGgluZepOPyzT6A5PQbQCJEhG0D4WiiDXlfpt/iXTT9de/sjsBW6jfnmW/mgQIpLLKhrKq8vLcYzuoszgbM4y9puDAuje7TerQIML/Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6733
X-OriginatorOrg: intel.com


On 4/8/2025 2:22 PM, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The library code built under arch/x86/boot/startup is not intended to be
> linked into vmlinux but only into the decompressor and/or the EFI stub.
>
> This means objtool validation is not needed here, and may result in
> false positive errors for things like missing retpolines.
>
> So disable it for all objects added to lib-y
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Solves 
https://lore.kernel.org/intel-gfx/CAMj1kXEfBMczOmA2+dMMubuD-qE59GTAiV2E_9m8KNG4-rgP6Q@mail.gmail.com/T/#mbf2913e778475b70617390d4a5d0244295b9cb8c

Tested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

> ---
>   arch/x86/boot/startup/Makefile | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
> index 73946a3f6b3b..8919a1cbcb5a 100644
> --- a/arch/x86/boot/startup/Makefile
> +++ b/arch/x86/boot/startup/Makefile
> @@ -4,3 +4,9 @@ KBUILD_AFLAGS		+= -D__DISABLE_EXPORTS
>   
>   lib-$(CONFIG_X86_64)		+= la57toggle.o
>   lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
> +
> +#
> +# Disable objtool validation for all library code, which is intended
> +# to be linked into the decompressor or the EFI stub but not vmlinux
> +#
> +$(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y

