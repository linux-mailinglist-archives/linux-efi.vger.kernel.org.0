Return-Path: <linux-efi+bounces-1888-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710EC98E68E
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 01:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD9A1C220DF
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 23:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D6A199929;
	Wed,  2 Oct 2024 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nh+TltQc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B098286A;
	Wed,  2 Oct 2024 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727910150; cv=fail; b=d3rCLNbIsUDWFKngEf6oMdxt/aVfAcjpSbgzvdv14l/qmEf/bDnCWrM/RDrQO2fIY6JOyQ7HNZ1IU014ph3H9i6OZ2xMsxQih1/b9ovokSXRnEk/2FL8WuiyHteXh+1UKpNUkOrRcJar8f4IB8tVeymFclMhgBCE1Eld7mtciuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727910150; c=relaxed/simple;
	bh=3NAhTXHzfxJ2BU2mIRsYG7dteOzNI/nRuOPCXNCrAtc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mXw492zbv8QsLxz/yK0xXSGUClDa1yYTDzqYHvFCyr3e1IR8Uc8ZpV8PZQEfpyWo2tErl/jRNWFLuDXpuFkm58W7SCQYiW+Z1q3jxO/kQyP7zdYybAx3wJARR1PfRTfDIx6DfMPyEvjJjs5HSBhBSuA54dBYPDBrwc+i2HliE9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nh+TltQc; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727910147; x=1759446147;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3NAhTXHzfxJ2BU2mIRsYG7dteOzNI/nRuOPCXNCrAtc=;
  b=nh+TltQc838H+zywbrzVIWPYyMhyK9hkMsL+hMVevemvqDHCLoa9NTQh
   GW/G2/4IY3zSyglUzUDIOb8R5Brvix1N+/MmqoGUeyTAd5Hj/czh+t7HQ
   cmzN3mzjsLlrI6hSLsYsplTf0AlE6cwoBtDZJv8Qz7jNo6bQDIkW1hm7p
   vx36gILM8MwyEavE26NkaEwNuySCttpVMdu/knbrFnf3Eapkm6rlHFHFj
   sUpBr/m4tWwaohWecjmQU936lnmdFzCAoMOUXHAdoHRz+sn6/y/+OfGP/
   2014UpfhWYu2rrMXki1LCkhok8IsXISam17pZkCet8G/tsaCFwtXu9PgL
   Q==;
X-CSE-ConnectionGUID: Ixl6NksnTfOrjdYEiUGX1A==
X-CSE-MsgGUID: 4Nwj81MoSlOnCkbLg6oa0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30800447"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="30800447"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 16:02:26 -0700
X-CSE-ConnectionGUID: TlZKp/MgS6GqPRKejzHhFA==
X-CSE-MsgGUID: QvqlyAbpQOqBNNzsv6y8aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74268424"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 16:02:26 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 16:02:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 16:02:25 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 16:02:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 16:02:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 16:02:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+I6NpzPEFYRJTnrAZWq5EdqqK87n0f2Kk0glDIzl/i+W616rqgRc/jObqksVCS0MPuTK1GDomYiUSxguPzctOd/WgP+u8yLTv1hEgJ9sUrF3hOQfECOrmZcLj5lEyJEV5eI+C6tgQi1S1R+P8K2TiTDBtgxKzTgEQonIeMJfyLSxmKC+ktrgpfWU1F7DszUY9j3wPVdqZRXtMmmDyC6rS5kbVXqdLkUqdET+Xf/LEzMcdhaC8CbYOEj3k9JQH1/spgHwA5WmwCFY6Ey0Au13NnGHFuaymKVnc1H+70SzWCpDXLFFB7YjczIccMuxkpqTCzds7dvGAXvPwWeUO60tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6GQrewqZg2Ap5t8EOc+RcH86yPXZHnn8erMAuo1nyU=;
 b=WyF6LjLzZ2jZmhwwYvqMmySsVYH7SXuh4TGUocSSIqzTuTdqLv+qNomRYWpBVds3DQC4setuJjPNiSL7qFPlvqr1pRrOOY9SFLnkd1y4+XqnQkmlvBNpgtcP/mscsduwXN4vT0ncrgN2a9JlERK+YCXU5q4vjuaaomMaW4McPPOvKj3Y2jM3oMPCEeaeezokjEiU4admfd9Ll4tn/83UkKWgt9Z4jf7m73g8Af54ak5/RLp2YtFbzkV1U7Zdr0EkFoF93pmBDCopPVQjjvhSzE+YYh6fkxrKT1YwqhqAdgDKUutuDHt4pHWnIlTBkP2rNmMKGMk079Ejx4N3r1o1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 23:02:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 23:02:17 +0000
Date: Wed, 2 Oct 2024 16:02:14 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH v2 1/4] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <66fdd0f6314c2_964f229426@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001005234.61409-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:303:83::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 878444f1-93bd-4a76-eabf-08dce33642ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5WYlwjXzoyCsL7hCEniHub8nNMcQ7tJWlm4WKW4C1dCtpnXpUJjFC/1Mux80?=
 =?us-ascii?Q?vW6DMLQAR3gcSqyQoKZue50KemtPMVY3kusWvlJHy7+GYkt+4YTDMeII5zkl?=
 =?us-ascii?Q?4sD2B+S0xn0f9qgjDKnH7lDclrgViKu2SbLTwzE6/lczKWolR0aMtCkPwUj8?=
 =?us-ascii?Q?K+BGbifpPaDsYi5vxOOKnv2HG9yqtoaeVxh3PTuzyDSFnmm5//AfF/rWKDwk?=
 =?us-ascii?Q?hFThSqLtJZCkXw0uAZ9c8Qeb7ZtYXQTYDAZmxudd6QOcDFe5V5gRNh3HHN+r?=
 =?us-ascii?Q?md32CeI7UXrfEhNpvh6t/jBLz2seSsxFxq5qptRUi//NpwXmsbhB2Wx7vjVG?=
 =?us-ascii?Q?URZAgGKBl0qCnvgXHSXhJApBH6jRFku54t7nVVi9LckatZ7ssyO+O0pgKdX+?=
 =?us-ascii?Q?fagIMGBqWE4Vn9O0CubbfQB0TQYrokkAkMeurXmSt4BBIrG0+3+2aUVhhQEk?=
 =?us-ascii?Q?slAahqvrm/PdjrjPBF6cEGTkXFHCjys24tu1OmPePkSz4RnS/nrdkXNq4Ypi?=
 =?us-ascii?Q?STuGaJY/Bj5UDgOjTD87wOKwvAt3cHIYvat8F5+rM1ERBKd08wv19Mp+iVLP?=
 =?us-ascii?Q?WJdoA+n3BgHQVaQrZ7oFShcRaXeiLqOc4YvaTrmb4eZooF8Sr2DXc03Edz7w?=
 =?us-ascii?Q?8CZ97+1515geHwqw6ZGY7TpWXU2Zsg3YlKFfs8gblyk2AW+gSR2dx0RwYOmB?=
 =?us-ascii?Q?0Ai81gMK+iBOkojiu4/DNSbOdYvwi6rlU6E3lwySMbzKniKVwSjmprXbK2hA?=
 =?us-ascii?Q?yzXLXwk+VJ11hQnZqklz9dDKfnXsYC9E7pf73GcfmouEgIw7rxjkSDP2UVJH?=
 =?us-ascii?Q?UnXy+bdmEMvLZe4C0bALntLUuvkN3a//3RLhUfaUEXr9y10h7bTkVyuoQw0e?=
 =?us-ascii?Q?HA4AoYWLc92aZDkxqtEmp0fgJpoHy7RhszsHXkjlY/9bid7iWDiCC6d2B9vX?=
 =?us-ascii?Q?kjv4z2YdSdJd5KSsHHSsxDlJdHf8ZG4sUJO+sFVBE/Jm6DL3qFvbp2Ks34Tg?=
 =?us-ascii?Q?dTcHsS4w4kbClH/D/wRquO0JrRN0ZLpLOHyJYuzZ6r4K76k+SV/nbxJswVIA?=
 =?us-ascii?Q?VLIrGQiX69GwO3Uttg/vOml+etuYruy33p287DwV2BJb13Wm8y3T/WS/F7PA?=
 =?us-ascii?Q?AcGhQhEfJq4AZaT2iFNvu8nv8rYlFy9iZNqEboDhqVKUYkqFjopUXlMSuJDA?=
 =?us-ascii?Q?b4G2gaRz0y1zMxgMd5cQtqhyEcv9vPlQScHYbSMkMmy6cNG/UQhgViNWd+yX?=
 =?us-ascii?Q?Gns7rJ/5ZlpuecFjWLevuO1mHWkdpFdcFbiiU5WxlA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?121lsIn96i/sPsA76XTYt2wba13LHge6bWHrYzqNPmpwcULUoo/RUF+OxdPk?=
 =?us-ascii?Q?pU2+RwRNaKdLVGmxCQfrDbnnGyfM9AXWdDxn5I4ag88i6KBrrRFzO6bwyZHp?=
 =?us-ascii?Q?GjTVJOXBlnf1S8llVWJAJ2WzHDPmc14FZAjll62SLJ2Lm1cOhyBgtNFv81Ot?=
 =?us-ascii?Q?JlvGPls7Kr9IbAbENxCSLMjZuqGSihYucMgi4IBISqmHUv9BDTqNDC5so3Bm?=
 =?us-ascii?Q?dq7bAEmjWI9lu2d5V4qF9SUw+MgkvrBjZzDLCaEz4eAjcRua9aU2LDKBF4hp?=
 =?us-ascii?Q?x4/AhBFL5JiDVP8u8n74Mmn2p5P7p35ThYShNy1XXG3oRk7Kn7xC0Y/QVbyY?=
 =?us-ascii?Q?P04Zb9iP0Kr5ajFWZTV34t4STpXsvH3pWlLywU593nPkDdZcxli7K3tJb8N7?=
 =?us-ascii?Q?GH5jJyaVfn8n99N2ZgZfcAEqaNut3FB4n/BRWdetj8RhLXtO5ZYwYKiH/KVc?=
 =?us-ascii?Q?7B297bj3x1R1lAX/7c523YT3qbrg75HEG8vfmHsgPjaU8+80alN0KK+2Nlo4?=
 =?us-ascii?Q?BCXtaoU4qK4JIXHKSXhwudPmPwAAAW+zPc5o+6jKeMaJ3ZhZlXJsb1Y4VXkK?=
 =?us-ascii?Q?PSqvHf1eUpadrx6Wn4kILW6wVIFDrm6jzPnSTbV8tA/aPevq9T2FChkEzX7t?=
 =?us-ascii?Q?68m1HMupLZJwZkQenNV/x+k7MVWqD6NDpOHk5lJUXKZnEDPcPHndS7NDZo0A?=
 =?us-ascii?Q?OAwCJlogCDzX9U6/fPgcOmjIBgFgIuLe4c0wg9Hp5OcMGV4XXkaqXV1DvsXo?=
 =?us-ascii?Q?u3GZ1wqRsthnTw2dF9Gik9Fb76o2KUyh+QWs1JDpGZkE+u9rYYY3L1tFyC6S?=
 =?us-ascii?Q?qF1R8xICLUylm5ydI4Tc5+S3Q8bgh+5TdEEMgK0xhgULWLrNomjA9r1BhI5b?=
 =?us-ascii?Q?4Ycq7Ipo+orZzBJscwEPji2Ie57LBOLgSUpFlNvd3b/VuhmS6Ry24KCkOVVE?=
 =?us-ascii?Q?KsflP+B8JcEY5CAkeuwbfm5yPXcVHS68vvt+8LOO0oQmG/QHnh6aGnUJx65v?=
 =?us-ascii?Q?jkcFO8cFn/eJlZKJ3EJ7g1WPaUvsTtQhY45OMlAKok72D+StxiVzwpu1Wc1O?=
 =?us-ascii?Q?GBaTFrbhnAzgwcE4XEKr/a9TJeVFcDGP9Y2dgdpfJJ/WKfrA0CxsCpsya5Bt?=
 =?us-ascii?Q?Kh2/Y+cEYpOtdZIz0I6fcSk+a7lqJs30B+RnKOx9l5o2oXmjU8xsGZUMrF4l?=
 =?us-ascii?Q?dUn3ryOsBdAyotdsgMcrCTpmb7YQE36Fq9kTLsnQx59JD6BnTnrsNdHpJPvN?=
 =?us-ascii?Q?btmp8Js/fvVPgwcNN0mYeHVs/liW3tni7M3J80ykBGHMEaKtbPbKPRb8lqRf?=
 =?us-ascii?Q?sppuzVab8vWt3NVLzMDndLNYxQDJaDpRg97NmV934DZ5MTu5DwatRmKzxZba?=
 =?us-ascii?Q?IoKRcUIzqfDevICMRIL4apC5TYsklDa0SsPa8wgCwbMXHRqgDoAPkr3Pp1/W?=
 =?us-ascii?Q?14TfBFsfv0Xg1Mcyh8q24QkjO2A/okRepeN1PpeitB60W5n3ubKf6l+XH8df?=
 =?us-ascii?Q?YjCJqs9WtQ+lPIO7t/r4kUyAgxxgqfbC/af+Sckirj5As1TTp37fge3RsM7R?=
 =?us-ascii?Q?Ky1TeGn1NlOGcmeMOEkolBt0VS9Y0C3Src3uZlGyrrwu9W4p3T6CL1gxq2tB?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 878444f1-93bd-4a76-eabf-08dce33642ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 23:02:16.9581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYXNwHOUzKngBcBYKmGAcnbpibQpC5Zzz/Q+QseYN3RICAEBA3PQrzNoxYsorw4Bybom4DKbXAoMrHb8hBAsrE3oJWusSbc9HImQFu+PKdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> In preparation to add tracepoint support, move protocol error UUID
> definition to a common location and make CXL RAS capability struct
> global for use across different modules.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

