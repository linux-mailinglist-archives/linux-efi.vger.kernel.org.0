Return-Path: <linux-efi+bounces-2890-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B694A4F322
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 01:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D037A719E
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 00:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2D215199B;
	Wed,  5 Mar 2025 00:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ll00dzQY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C82A14D28C;
	Wed,  5 Mar 2025 00:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136184; cv=fail; b=T2lQEWLpagnGe3/d0062B+KKk4/aMv4dsR/thzb4ajVMtZjSn+Ifw7MFOkkEycAJiB0pLdGiuzMaCwH2c9Xc1hyp4aFj2NX9WRL1iHEJVxnQ0ntQgduz3uKpp/oL1eK21Rqj+KOmTwNfeljkjqIPu68hG6KAWLC1bc5mztz6usw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136184; c=relaxed/simple;
	bh=J/91DmrTJCnflzDLeJx5vFQW0Y+1XBqtrMdEsIQnOMw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DLJpwWXa7b7LuBRe8Z/G5wZ7BmzPNRLb6O4jx08EMOKI4YtBO7+S49j+tw5kpBlb7Kahyrrv9N2eau/SGjz8YoK3t3ZetgA23KbGDbiJ31cMhXWaQgVNz/fgAmQwi0ExcJax2AnPyBz5vGhh4isgTG1C+TfVngvBN5A9H3Z6vOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ll00dzQY; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741136183; x=1772672183;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J/91DmrTJCnflzDLeJx5vFQW0Y+1XBqtrMdEsIQnOMw=;
  b=Ll00dzQYZq6Pg3ifKPVTJe2+gJ4Y+HYX5T8KVwNzr7FAFNKaBxDRROPa
   WYsj+0GDKsu5qYauOivaFIz8JFcnJrDF0tBerzbUENErQy0aoFL9yLmVA
   UoXd5FRJUI6Yca42Nc6nZ9Pi871DxFp5FX3L9R3phDifK/g5OTCpFe7YS
   Ak/q/lWspNOHeu5CykE4y4Qcri86bW3Bb87NVCWO5zJH1DwyUfDPSpdjf
   pHKijaHtZ+TGzkrVCicrgv42EVymcIq6qqPpzJ82OB3J4qgzhERDpp8Xd
   qF5yq2/S4PvFRYBIcngiBG1zXk0pvzBa9UUaoo5t9QiDvbfYNxY/Y690N
   w==;
X-CSE-ConnectionGUID: SvfRv0uSTwmiv3hLmGyD5w==
X-CSE-MsgGUID: BzeFtCEbTkeIyFsQbfXGSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53070895"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="53070895"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 16:56:22 -0800
X-CSE-ConnectionGUID: 5pNhLcgfSuOGAzippDTLJA==
X-CSE-MsgGUID: 8RYQPhVVQPW4NLN8WW6uAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="123468802"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 16:56:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 16:56:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Mar 2025 16:56:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 16:56:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbbtaqdsp7QqsDlkHQzKgEWz4zWsPzyxGlTLWiQKFUcx/3ofty3D0tz1RB5wfWF4HpsqtBzLl/7b1JtpyrVTczQwRxzgivAmDDE4cgQOYvhprfs6puUpHuMJ3t/Fd8ha1P42wO2dL1F8VGbcqN9i/xP7aIl1Z6jnom5I8L8Q45yykZX0HO8iocS9BoXjs5RFAAwNQxPS6XfJWJv6O0e3fVFReE4wdn7SqS74pQCth2MJT0lW8M1+u2AQ/5GfnrGduGzhwnKErcCE4zbv9EZTQdrRJgXmO6hDlDTGVi1mLNA2TDVkC96Oy3PAbyozdFoVizhoLKTRaVaWP1OM8MFn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gljKPQBGVrb2U5G+WQWOQy5KH27U4htGj1ycaAWXAE=;
 b=BgjbDcX2zzhdf1tGM5k+WR1L7snL82jEOVJ+L7zL6nsFnKMCdB/YIxP5hMlihDK+THpK8mVSXpWxv9SWlst/CgDgZ/NYmJTc14AMTHGL8YMWePY/7PBr1jTw8jtgE9/REgDeV20hM3wtDqHDxui/beRbRHG9hcQCgyego8HyX0+sJXMkpm3Zksk1eyMi1tCMiCifGUSiWg8aU6WjzCeLhh3AahMZA+YuiqFo00VoUc2N5jkr2tHN+hMwzEOd21N5JcHJxQ49aaZ1I4sEZRQqtIdC5T75vqgWPsIzM1Pjep8yJN2d+fv6dp5ybQ0zTT4OVMppx92fGLV6GE7n8xyMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 00:55:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 00:55:58 +0000
Date: Tue, 4 Mar 2025 18:56:04 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Alejandro
 Lucero Palau" <alucerop@amd.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v7 1/2] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <67c7a124e2790_364d129453@iweiny-mobl.notmuch>
References: <20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250226221157.149406-2-Smita.KoralahalliChannabasappa@amd.com>
 <67c73bff37ef7_f1e0294a@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67c73bff37ef7_f1e0294a@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:303:8f::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV3PR11MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 9276993c-fd31-44f0-697b-08dd5b807de4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pag2da3z4sznJ43MVoTtVZr2J8L+iM7KnlmqYtlgqMNn13KYoRgFfuf8cjj6?=
 =?us-ascii?Q?LJm/I34p3hB2nMLSBsI2li9qmYwAZ0hoDrhZznEtdCcio7uCFZGEa/qfM72I?=
 =?us-ascii?Q?efWC7yvO8KL+gkFwl0RXosr4jDF5WNiBm1q+8Je/q4Vd6eDPx3dM9YJ7/C04?=
 =?us-ascii?Q?PgAii0UHN6OQtpJU8PTvqOOQzi5gLa8mfFmcPkjy/rszoQjbKr0huCA8nZRv?=
 =?us-ascii?Q?Y6AXOmYFm85keH/SQJWnddCBCVJxqUReX9tqyKc8Jcfz1aUPJonKceK/+W5m?=
 =?us-ascii?Q?DOwkm5IynBx6eH/Z3ekwbSwtA8EN4th7EfkT0PcZizFQ4CslOwlw/+IWJyCg?=
 =?us-ascii?Q?TK8LiUgugHtRN0gl/Ka5PPtQilbdCVpUbSgYcu+7lR1/FURPUZY9hzE5cEym?=
 =?us-ascii?Q?agtOaYXUUW8d8tVxt/92hHCAH7p1rU+QFn6vNyfGfQjXcesdE1vGE8hHaOxG?=
 =?us-ascii?Q?cvAm/sH23F2VVC0y+GQ/qjA3pAyVnbb8LWD0sVUCSjyfyEetKTnPEe+LPPDv?=
 =?us-ascii?Q?8Dq+fuCuyOKw2KAFWH83rgtgYgZLOJUUjFfY1DzfR7J0maOqLOj/Bv7Lw5f3?=
 =?us-ascii?Q?/5MsIkmuowUuJtrQKiX1bt+Pv42dNypRXpUxfwLj8fdYIYKGzJjq5lYYEqmJ?=
 =?us-ascii?Q?gjBDvkL5iW7Xecqa0VdQXYQt4K4JWqkb3wc7WQd5BP5qRAYntz8Y8Cio7Hb/?=
 =?us-ascii?Q?TwrsraxJg+QVsPAJG36PP/7AjdRxtiirLSvfqZXpi880laU/5Mrar9/7Xf9R?=
 =?us-ascii?Q?oHBiEcgyxdVQ7tvvq0BXpULxfdzVAPitfMAD9ql35LQlf6nYk+kVDE4G38dT?=
 =?us-ascii?Q?SujOox5bFTIKTV2VVvmQfM05RAWNgEyD4ucNT/cLgCYguRqYkhR74VcBNddn?=
 =?us-ascii?Q?fNQnRs05N4sfLetUTuF4JYUoTWd2NuKaI1se9ADSvkNUSLZ2OnFHT7reC/BS?=
 =?us-ascii?Q?RaEvkU4K1kwXI1/34i8y6vnFM9jnGoX6c+jhKpt/AgX/64ZymNEM4IQW0sQi?=
 =?us-ascii?Q?DCj/nu0rcYNPVG7cerqkFp4vtNRqzLKsTs/onosc9RrBCGYrvaCRX9pohTKI?=
 =?us-ascii?Q?Qr1einWLa4vLB2TPZnb8lR5V+3GHN1sZhy74hrQhMJeTvLsHtgHCaxgntRd8?=
 =?us-ascii?Q?kL4svW4cR7k4qlvRH7wYE0eI7HFikfTPLbrkf8DFi4KR8f9E8Eu2SO3mM3LP?=
 =?us-ascii?Q?QpgdRP9X3hZfMw8vHifnC45JOytDa3tl8t1QHzE/vU0u8GFD646YmkT70UGV?=
 =?us-ascii?Q?LJSJ+3OMq9M6Dph7a/9kd/RkcrXOZZs07F5AY/LJ95ioaif34379JyQvcAy9?=
 =?us-ascii?Q?C0pXaNEKZhfZ08qv1dPVSOV0YqPHIXma+PM2aonkSJkD/90KwbfEr4+XwF5O?=
 =?us-ascii?Q?NnVak258+KaBcDzmQ1IUImsvCnYj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C08TKPBJyfrG4+TLQxn35A4eBeXznV3Mqd/wwHfBoYtFwLMObIxgOc5xlMlF?=
 =?us-ascii?Q?Drvb36pg2LaaAMYU12fhzvuYwBA222ZoIwN2VthT07dnck5+3jQMexYoj5IS?=
 =?us-ascii?Q?+mkPa3QUvypp+wsHfuPmCzqMkmGfHv/yMm2ydeDLp3+SA6Z52NCvWgDtzMDs?=
 =?us-ascii?Q?c6ho6xbO2FhnYPr0LujUXBJjsX5tzFlggbwarvxhTkT2DWrZlNJR10OSDeiz?=
 =?us-ascii?Q?hG/1Owk0d4KaymTGKVB4NmYOJdgl/CrHPrfbNAmfplYdbL/FUtXpBWyfBSKv?=
 =?us-ascii?Q?BsPoSmniOx0qqD7jR/2XFupjvjVPdm7hGm1xmQHA/0iMBgpNL81OP0NWolj4?=
 =?us-ascii?Q?xhyVSjg/3WpZbKZzTVEn7JUSFPSnMgZgK1rG7us3mp0iBnyzuaCC3tme6JAv?=
 =?us-ascii?Q?Empn7s32R8Jg1nwPFgfktEMuOtdUMm3F5TPckyEQYq+9+HvjoxLL5jc/Nqvf?=
 =?us-ascii?Q?SRusOfdXAE0j0nhIn1f9SBx+xWlDAqX+mRjB2kuc3ygg4m/ZVGhBD5JEpTxe?=
 =?us-ascii?Q?nHq3m8u2gknzRy0tKxPnvltVFY3d8rgPNmcqnR9Kso4lD1dCOv5VKdXComtv?=
 =?us-ascii?Q?cYWFsY2AJxQkFCLKXOWSYvfEg8s6+h1iLDlDdfhd7Wv3WErxT18wXFwejVsM?=
 =?us-ascii?Q?aoW8r++KX99oTQcs40cya+zfGO2sjMksxMYnuKvBS8M3A9qaRzEXMLaTyC24?=
 =?us-ascii?Q?MryNL4esFmmxWIvEuEiJ0E1zDWxmXM1xiHA4U05Edwt0V54IjPPFfdo5Bhs5?=
 =?us-ascii?Q?NoK1VezC86tMB68DEKvrBmjJH2JZQEJudb++E0bgLjcXxDXVEMlPQzudg7An?=
 =?us-ascii?Q?PijGv7+GCLDOqkIN+HDzTPHwYtR3eGH4KR1B8jyHD2R++xOOU+E+YLntcBRz?=
 =?us-ascii?Q?1ddCqtsiCru0rBR7FCOoCcblB1diK3DEZV1fg3SJZc6SMB2MW/nCzor/0KJM?=
 =?us-ascii?Q?wXFvgX+XCuoEG912z/sngFr3OQHCoYCzLzKiEIZVn0VY1hF5XfjbeEIK+rnk?=
 =?us-ascii?Q?Y6RKaFsVDLqq2BEegY1gwNzB9pHUDheZ7hGdxzN/FoNlgDpIMgqxd3hm5Gsm?=
 =?us-ascii?Q?TGPaJulyq7SVvtwLy7V4o/qiG1AwNa+px+s1xjZRgM1OQIeT8yQ3mzz/VEff?=
 =?us-ascii?Q?0DtuxaOBBtpn8fqsiRpjDPSr7T/7JBLSrylWz5ABbH1TVeJXswkmvtUDff5r?=
 =?us-ascii?Q?kJBfRWbFZ6XRBDRMomUGNZP9mPD+ggUCsBh+KCmVfGIedP9k7Pxf6mKvhBdW?=
 =?us-ascii?Q?fKpqCdQ46XPdYowMNHeFG78RI0jNV/3I2bBGsWQ5Ox0ny/4cxt2Q3rBlqzb1?=
 =?us-ascii?Q?QfriTThHxmyFMXJEk5RABBRkI48Rqm1euMzuaTcZGX0f4wElg1om3jPTD24X?=
 =?us-ascii?Q?bJM/8X8fzdlP6Uuf0kCikIlpjRTe8VzKzDlf3ToNvr99NJu2X3mgsKcebDMU?=
 =?us-ascii?Q?cM2GXVcsOq0e06/qW1vQTe3ltgYvQV7hrKUf2kBjAF8EzeUU+BYPWTMzHUXj?=
 =?us-ascii?Q?bRg9AlCTf4aOv/XxWonO/8h3Wad8NjqiZAe2UoWtpEsfVWisQBtb+zgmTvyN?=
 =?us-ascii?Q?Dd1SU0cyp2Zzc5q/pb4bIOkVsHd+UkYogWuDinEc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9276993c-fd31-44f0-697b-08dd5b807de4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 00:55:58.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cu2n2UGfibxjS+BNURK4vodnLW70LPno5BbxfyKRTpHXCGmX2spgS4VFqVQVKZuQCyP60IJqmIss1sUoIEJOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8601
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Smita Koralahalli wrote:
> > When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> > CPER records. Introduce support for handling and logging CXL Protocol
> > errors.
> > 
> > The defined trace events cxl_aer_uncorrectable_error and
> > cxl_aer_correctable_error trace native CXL AER endpoint errors. Reuse them
> > to trace FW-First Protocol errors.
> > 
> > Since the CXL code is required to be called from process context and
> > GHES is in interrupt context, use workqueues for processing.
> > 
> > Similar to CXL CPER event handling, use kfifo to handle errors as it
> > simplifies queue processing by providing lock free fifo operations.
> > 
> > Add the ability for the CXL sub-system to register a workqueue to
> > process CXL CPER protocol errors.
> > 
> > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > ---
> > Comments: There is a potential failure case, and I am seeking feedback.
> > 
> > If a CXL Protocol Error occurs during boot: Both acpi_ghes_init() and
> > cxl_core_init() are subsys_initcall. GHES might detect the error and
> > trigger cxl_cper_post_prot_err() even before CXL device is completely
> > enumerated. (i.e pdev might return NULL OR pdev might succeed and cxlds
> > might be NULL as cxl_pci driver is not loaded.)
> > 
> 
> I don't think this is something we should be overly concerned about.
> If protocol errors are occurring that early then they are very likely to
> be bad hardware which is going to happen once the subsystems are brought
> up and start working with the devices.  So new errors will alert the user.
> 
> > Usage of delayed_workqueue(): Would delaying the handling/logging of
> > errors, particularly uncorrectable errors, be acceptable?
> > Any alternative suggestions for addressing this issue would be greatly
> > appreciated.
> > 
> > Tony questioned choosing value 8 for FIFO_DEPTH in v6. That was just a
> > random value that I picked. I would appreciate any suggestions in
> > considering the appropriate value for number of entries.
> 
> FWIW I think this is fine until someone sees a reason to increase it.
> 
> [snip]
> 
> > +
> > +static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> > +				  struct cxl_ras_capability_regs ras_cap)
> > +{
> > +	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> > +	struct cxl_dev_state *cxlds;
> > +
> > +	cxlds = pci_get_drvdata(pdev);
> > +	if (!cxlds)
> > +		return;
> > +
> > +	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> 
> I dug into this just a bit wondering if passing cxl_memdev is the best way
> for this tracepoint to work given the type 2 work...
> 
> 	+ Alejandro
> 
> For now I think this patch is fine.  So.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Unfortunately I missed the fact that this breaks the test build.  ras.o
needs to be in the test build files as well.

Ira

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index ef10a896a384..4efcc0606bd6 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -62,6 +62,7 @@ cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-y += $(CXL_CORE_SRC)/acpi.o
+cxl_core-y += $(CXL_CORE_SRC)/ras.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o

