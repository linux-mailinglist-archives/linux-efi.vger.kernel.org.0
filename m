Return-Path: <linux-efi+bounces-6093-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIZBJOvXhGlo5gMAu9opvQ
	(envelope-from <linux-efi+bounces-6093-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 05 Feb 2026 18:48:27 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3921CF62BB
	for <lists+linux-efi@lfdr.de>; Thu, 05 Feb 2026 18:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AF19300DCFD
	for <lists+linux-efi@lfdr.de>; Thu,  5 Feb 2026 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C943002A6;
	Thu,  5 Feb 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knyBQRha"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99222173D;
	Thu,  5 Feb 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313667; cv=fail; b=rQNaaMrjwUlBaKMahkg8pK6tlkjVzfAT9Q/fdlSW+8mC/KO5CnqPKcxGx/rDOLHRyneABV286NPzKwKlk3XV6NLFHmwc7fqV41gqKHxpbB8R/QRrLXDpkaTv11D/twUl7IC4hUeyMYhDqZE2AY55HSeyCCnmK+BIaK8ypxtpg24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313667; c=relaxed/simple;
	bh=O1/uUe4B8XZZxkEg9Z/jZhRQO7iLmgfSCietPkW7Zb4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BQXGW8iU9b8iEUgh5ZFRp1x07sOV8LZKRfCKLu8W2hDlijjA/Bw4EBwZpFkNXWu2uyVjwND4VASJ9oYxwx9rzvVeuT/gZB8auhJyDofY8hneJkvv4oMycIS/TEBdztvHoyYx5v5vfcX/Chw+SXHrvUELaXX9SXqunGRIRoOYzSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knyBQRha; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770313667; x=1801849667;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O1/uUe4B8XZZxkEg9Z/jZhRQO7iLmgfSCietPkW7Zb4=;
  b=knyBQRhapJ+Lhgb+zu9Z1NM9iu0vp1RHD39JQNjHbi3vAJgjSaxQSs0P
   yfzZDpSaqSuJkcj+5lR8bv2rkLiXtzggN4ukb3DIUKql4PFI3DJWVXTv0
   c1I+6CMnQcWawhZV+TSbXcuEAAvqwzaaAUHSaFbHMmqHz3vZTTvbuhF3g
   RY/MiRgf8j152E8jO5bfcESPBy3a7ORnCCL+IOcli9ud0RA01C8axf7RQ
   47OaLaeE0PSf9on/4QZqcckoIGrt5vhWypY2/VpTU0WD6JmKtsVGFLFNE
   SBtcW2qoQw57p30eJ4SmxMjO7dWNlCXrXvDLOLzvoM7T7viW3gUlxp5qj
   g==;
X-CSE-ConnectionGUID: h4bu9Lk/QV2xkmGUIqmIww==
X-CSE-MsgGUID: 5i4V5XcKQ0eFyjE10SzVZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="74118144"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="74118144"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 09:47:46 -0800
X-CSE-ConnectionGUID: /dWlimUBTEeZyEV2oFZkfQ==
X-CSE-MsgGUID: OnEjKegdTqan0eUaSXmnlw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 09:47:46 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 09:47:45 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 09:47:45 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 09:47:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mtxv0PcfQiuRH0wzngkuyZpouW2JjaLIzeVyZbn3ilvNkoaals+JwOmEev4Q/XwZcamHjmn7KaQ6SZhkLKjEMdh1e6chtNaoakj6e+bUwjPi4YNmNC7EgVpVII1wqdpWvFAjtbsvimIw8Gi1WrvmaVvBRZbnbJdQ74/UdYQ+HGUaAbyEzFcc9TkSN/hi2eJeQjGb9xxDlraThyXtXjjJZOd5QewdgIi3+UDqkRAQqMsFM+VzjE5ZYSRu4oARmL0vnG8/ctjN9Xk7yyJcc0lXUQCz/Ho/apM0R6mW4JKot44KXO9I77LURnnwGBdsGROXaEiJ//kA0HX1DwmduArQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1/uUe4B8XZZxkEg9Z/jZhRQO7iLmgfSCietPkW7Zb4=;
 b=fiL2/LQmWO+jQFI1/QUc9GUwOjmtN1MdNbJC27KZUTJ6rYkWgrDtDOWAAcJziLMMBsS6E4C4jHxPJ+XbGyFTvtXIjfD1Y9SZqvqkYRPYvtUJzVbKr9s0h1Sq9XGTPGzzGbMbUm6bWdVeHbQPvTgogcDmeoNWirDjk/EcffKYkdVtXEY8fXDM11KQhdHf8oC7NVwP0UfpY4sM3kS4hl+ESW64oJ1uPdQzHj5GwdyY9QWpsOTDNbs+LuxLFHsbvAPiJnEi/7bbnkcHn/C4A2szux1Vmk4h/ue8NpQfOwQNGd9Cz/6hQbgZIf5MT5A97JoiCIzK7gGeJM7e/1r8+V2trg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB6786.namprd11.prod.outlook.com (2603:10b6:303:20b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 17:47:43 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 17:47:43 +0000
Date: Thu, 5 Feb 2026 09:47:41 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
CC: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, "Kirill A . Shutemov" <kas@kernel.org>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] x86: Extend LASS support to EFI configurations
Message-ID: <aYTXvX24FuBT49bd@agluck-desk3>
References: <20260120234730.2215498-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120234730.2215498-1-sohil.mehta@intel.com>
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|MW4PR11MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: fbdd8286-09dc-4281-7b0b-08de64deaa07
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V07y5XJbzGithwlvB3SSk1w/RHgFjlY2OIUoNkOCopmUx3MPL5vGw4HH0bko?=
 =?us-ascii?Q?rh1iRjPvygWHpNmroTHzusbqdwyGSi0yMffnaeOsX1IVqmPXqvWnSXsuo9eO?=
 =?us-ascii?Q?WepeCj0a+Hlfn6Jq0bEWiZbfUfHEP2nFXznNj5bMHtFTNl2KEJqWwCdM/nJT?=
 =?us-ascii?Q?9k85mmqFbSPcuToV1FLYb/pxwIybJRqab5cMvvK0AVVFh3UUuY3/MmvYzQtK?=
 =?us-ascii?Q?IhkAG7EV/e+PJTKPZrPEkMWKmW+JXzAemKBHvKXemOYeYUZiahUacCdSAl4R?=
 =?us-ascii?Q?Vj29w0SIQSuHea7z/Fn1Op11FNT9IY9XJD/M7540yI4+Dyx9cF9g/e2861Qi?=
 =?us-ascii?Q?jp1ncZNtF+XCk/D2awMZKCa044bMZ1UAHQt6I8SVGtSMaszNMkDP/1d/8cYl?=
 =?us-ascii?Q?WpHg8u/2Yyuup8Knv3D/L+lsMwTFs/CuLEFR1OSRAkFd2VtbpBwwJnnxtqdN?=
 =?us-ascii?Q?fN+t25irRkKMZj3fQ1gNCAopkoVmXU4WcDVWeC4vRsNX1YXrLpSRaXQcgfat?=
 =?us-ascii?Q?Gd4Jg2cLTNdgyIKuscAlu50JK4G1osyMVtrhJSzl29kHpJYi4LEPDcUmhFx2?=
 =?us-ascii?Q?yE6aAveXmoJ7KGlMi23cCxW2FLrZ0QEuKSZaVgtY/t9lJ0cb96CsB/gTxdDi?=
 =?us-ascii?Q?NAIDGsjb6uFj9+s00r7hap2QCvZHBYuEHV3WsRXxPtLVi2amKjsffny00HDF?=
 =?us-ascii?Q?yy1SDlgCRFJNc1mV4LihPtk5doKLsrckKCvOPWUrxXZsa7pGlfv9ErE8SExA?=
 =?us-ascii?Q?YI6Td0kN3qW5yOD49d3A5D6fVu/7/PYPWRTjbv7UvQHM9KMXLuYKj9/thPBC?=
 =?us-ascii?Q?+8u6FDvdtr6kzoLnQaIYtRw6jqT3PyOMOFWZjl/GOw4jV6qWiB2aKtJa+AsD?=
 =?us-ascii?Q?K/YSk9G6pmqriPiERFWzbqeiropxJjWgEViniJOhM2sMYAnbsrd2Cbc+UbGd?=
 =?us-ascii?Q?ZwJF7T9aBws5WSA2KbOhU/CC3DHVD0T+oTxQdfStaDn6CajrYXymPTev0ZbY?=
 =?us-ascii?Q?8lu7Ltey3uNP+k4ou4ZVu6JtSmjrYLET+oB6W0i4mrz9x7mi1gGb7UKL/EjQ?=
 =?us-ascii?Q?LTPX/kz5dfsJoJWQlit9YxK47ClZrmLKhVwvx9nbtUnwnoWBxMODgaN6h/6u?=
 =?us-ascii?Q?Za9/OQN2SOWuaoqUTALB7NKxcpsmWmFwce13irzlx9dx/8Ia3I4sRhrrfijg?=
 =?us-ascii?Q?eSaS5lYDqOzsn76Ih8xO+VKO+g7mW4B5odUlm+Q8eLHK9ImcuC/UVjRbY4M8?=
 =?us-ascii?Q?WZNlwkZ6VjnNT3zdXv0eOSKdiwzdOgdMqM/8zl8WOvItwnSsJu+ex1pH8TMk?=
 =?us-ascii?Q?m/pr1cX5eCD2O6aBnDWd72rdmdfHBC9EdajAVLZYhEbC/NeAn3haJQYBm3a6?=
 =?us-ascii?Q?5++Js5BwoKxqAPLH4auaZlaHWnGeH5ol3VPNkXoylw9BGHWmJVHD4bq6eTSZ?=
 =?us-ascii?Q?oDwjCWdDLR6mspe60r7g77dR4PlAZVtxH668ofX65ENHwHcStNLTOuD6gtpK?=
 =?us-ascii?Q?4yNd9YeFMzYSMtNQvmneyZR2xVsEe52rQ0aUJuk1IQuasgThhd/ETzGrlTb2?=
 =?us-ascii?Q?Aos5Qm/ioNsN+c6fjjI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6roSL5cU26qXcVn2KgAGCIculeFeOBdBLs+Kx7zt5kvFH/TWJGAJ/3xXpC9e?=
 =?us-ascii?Q?uDXG/OyY7vUN6ZTS/W7jZOcdKRD1EZs4wzsOyp4MS/oqOVzabpzZAfabDVDp?=
 =?us-ascii?Q?mAK+6RmPBXrWhfghMYFyV92SmcQV7+I/fdHLOmATlumY/AQ+jE16958/a1CL?=
 =?us-ascii?Q?c0i98NYi2WEyvUJF9Cu8h8L1Hv77lCWm2Brztm+8khoXfX8Z1e51wE/qDRcD?=
 =?us-ascii?Q?dlePyNVXJzPs82n4PQkFQknzkvi3flP+guHpACfZpHHOCJgn7vW9MX35WWX9?=
 =?us-ascii?Q?iB05wTO2DI8/AKuKTckFb29oCk9T3PB87LGS3qieKHtWVXygIenoYtbKvjCH?=
 =?us-ascii?Q?HzB8WOrtVYx3O7FJg1Te8/2okvywox9euHBjOzWe698AlDdmPQ1nQAaf+Ver?=
 =?us-ascii?Q?DkWdWjpnfRxc1rgmamawMAVwAB75ftUmGAQh7vnCogYVAGTwWKwW/HQdxzPB?=
 =?us-ascii?Q?wX7cUZEq+4TfIqU8AoxSdkvxf+VKqXkDBKsnR81Qy0s7rKWPfJplgEyRSoGz?=
 =?us-ascii?Q?I4XWsE0fyv+rYzZGJ8cx5lIzyk6tFNuQCRaZvgm1AIRpbB3jElPLs03kKghm?=
 =?us-ascii?Q?B2pacQ8xA/rV5jkqpKe67Pd7bEAvDGFKzIBBlDH9mbqXR+08tkP9zY03My2L?=
 =?us-ascii?Q?Q3JIcxID7AeD6wl+G94Sfp/cZWIndEXSGeEgVqTRz7I5ox8hRe35rCsh5BS/?=
 =?us-ascii?Q?choo7odZRF2sahYF0l2cPiFY2duERUQXb15rsgDH1MOfMRLGU5rPpGLIB+XU?=
 =?us-ascii?Q?8dSLO2OtbgGWi4Wv88cZHscoO++/seVKwa0jqETwWfc2Jh7fD9DurA+OcAa8?=
 =?us-ascii?Q?g6ZtxgtgTr7akexoyw3rgrRiBUxfjImTkGidC/s0U1MZvryh4AuvF5fOf/r9?=
 =?us-ascii?Q?Ism8+/HHHRlSlZ0ikwuGSGU6zGAGrQmLM03e6Hm7Z3CVtbj9TXnuwUVxCJ3Q?=
 =?us-ascii?Q?3Lwt/F4VyWMnsJ3TfFchwhpaYGYUID1N+svxNb4BmZGWCIunITXxsI/GB+MR?=
 =?us-ascii?Q?uP53uz4t3/+Y2QPS92w4zXfDi4kI+wHZI0Z9fYG3HkxdxlcYly2SxKWZC1aH?=
 =?us-ascii?Q?QjJjyYN+fIHRS/FLHyeLW9bzbeWJirZnrPUF62jXBiti6P8CN3IeC0ZoAXUj?=
 =?us-ascii?Q?aEsXnHlfu4JF+aHIkyPQcsAJSSM+GWSCYAe04KLTpux4LkG2n9gEyVwzVmFl?=
 =?us-ascii?Q?lvo8bIBqd5GmZMy0HoIZNCBrFFDqGrHkPuPuDcfRx98zasc2lIvbhwgqNOh1?=
 =?us-ascii?Q?sl16hO3pz01wTs2UVYc+ebnNLeozFWGh/rYFBGP6J/e6HeqPBhG2LHaDrEH4?=
 =?us-ascii?Q?Ol2v+1AnzHmoEN77Xflj/jDA0PHo50ZDEZybESc/PsUUioKBMWjPxIrUHZ7I?=
 =?us-ascii?Q?9z/d7YsmMd5I3VBAwlulyNyqkcOvVMl58L7f9plqtaR96Av9dAd63hrPNIEx?=
 =?us-ascii?Q?sRV+1KvJa/PajBxb0FJGCQv7/zc9dMsa9+/7CrMD+Fi0XOVH/b+q8d7fpp5q?=
 =?us-ascii?Q?HGLH/vECm+d51uMrlbbAjhs/jOfaYCB5rUVF/8rfAly9E6cljwaCPzwQK+qW?=
 =?us-ascii?Q?syQUa2itg8yPPYudYVwiVKapF5q2R0s1/lgJMuHlqcSbePuLrvd+zldwSByK?=
 =?us-ascii?Q?EHIjuiAkjVnSLflh+4MhmYmx2KaNXMsM939R04tjfzHsGHXTcDIjKfkgAnzk?=
 =?us-ascii?Q?2iFKj1VMUGHRvOMbeHUYB/QUY95V4rDKRHQmbNVmN2ToE3LajSlCNn3nap2K?=
 =?us-ascii?Q?UeiFFr7QPg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdd8286-09dc-4281-7b0b-08de64deaa07
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 17:47:43.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKTyeyDjLHwKnzDDvdMfDUGRT5UvzZI6WEmaYhGvkPrvd7mAtb5CpKWzjnre34eKg+wmaizTwr64K5T3+/BYtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6786
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6093-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tony.luck@intel.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3921CF62BB
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 03:47:27PM -0800, Sohil Mehta wrote:
> Linear Address Space Separation (LASS) is currently disabled [1] when
> support for vsyscall emulation or EFI is compiled in. This series
> extends LASS support to EFI-enabled configurations.

I tried these patches on a LASS-capable system with a kernel built with
CONFIG_X86_VSYSCALL_EMULATION disabled, and traces added to efi_disable_lass()
and efi_enable_lass().

System boots OK (with a bunch of my trace messages showing that CR4.LASS
was disabled/enabled around EFI calls from several CPUs).

Just for grins I commented out the CR4 changes from the efi_disable_lass()
and efi_enable_lass(). System still boots OK, so it seems the EFI runtime
calls during boot don't have any of the BIOS bugs that require LASS disable.

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony

