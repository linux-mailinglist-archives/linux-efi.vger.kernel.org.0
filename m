Return-Path: <linux-efi+bounces-1867-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B822698C130
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 17:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401CA1F20FB9
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242EA1C9EB3;
	Tue,  1 Oct 2024 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jfluk/Z4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D831C9DCB;
	Tue,  1 Oct 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795200; cv=fail; b=kxR1530IXbBfwi8L27kqu6XUl81ORVIcgfCGIJIVFX5wmiPU9VV2ecWP8E3RtTna2a/e2WyC3ilPy7TwnYwbGkr72+2dEPr8Adui0Kjwlfu6JU2asaG8N3EsGj4QM8xm4JoIWSXW2iNGLDfk0MGo8vnon/kFXgE9HvhjDc2WTu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795200; c=relaxed/simple;
	bh=w44kr5LEO4cb0PmtY0VB0l3I32iWZlcAlEibbvHpoPg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IaIfUQ+lxS00JYZiHxX7ksokrYsQH88iY4WR69IFsLJKSxXB6JWUu8EITc3dGeXtoqoCRHo4C0/0jtEfotpLAoEWqFXZw/UfP8xr/SbUs+yga9kUGn+lRtqoziR2ItuhHHpZ7SRDv5BQSJAmGYz+YYbOAdMWyMMXG4v5N8dwcUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jfluk/Z4; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727795198; x=1759331198;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w44kr5LEO4cb0PmtY0VB0l3I32iWZlcAlEibbvHpoPg=;
  b=Jfluk/Z403VyMbYRVcWhmJ8s9vmbCYOQCYtTpqBAO52X0LWzMbwrvXM1
   8y6kDxXeJB4iXNoAKbFa1z2BIyvyZP5nVXPHmpD/g3M6WQUFJfJYp+Y5n
   Lo/QZKIpj0A3wkHJT8RHdMYfm0hiM20K6PWGgpU/EJnIhEX6t39KJZROc
   zZhDnoip0rX468pC14x6S/WpiFUeAY3lckhdgQ4QH93oACXeA1372pSb8
   bVjQpDHnoEQaS4Zl9WIuhU1DOwI5QT6Wpjq7ViSWO1JdDqdQDxnyEOUe8
   703C3TJtKx4QpoYVJVNYRNvv/dbz3acDbuWtWXMCihnbfVBBB6Fp5u47K
   g==;
X-CSE-ConnectionGUID: EtIW8KIeRiq1oKUt9EYwtA==
X-CSE-MsgGUID: dl8zGZ1XR6Wa70EqusfjTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="30642521"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="30642521"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 08:06:38 -0700
X-CSE-ConnectionGUID: Xd8QE1Q5Q52pGXh2OHI7Ig==
X-CSE-MsgGUID: y3GKIDEJSve7thBSG7NuFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78564706"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 08:06:38 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 08:06:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 08:06:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 08:06:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 08:06:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfmFpmacOk47+38xVXoD9YeoiHuwU11V9l10N3Dw6p1N30e8FrSo6kk8g7XQCcaNYpUSERTDRSyJA3pXA6gkEYzg17710dDcD9O/2Qce7ovkip1uIu+1XAtK3fxFPP6G/0yXVT5M2+KMt6QzlExtU7vQ+FB0ByTetvtsy+1nkyv1dBgJqP3KU+W0V7lo379y1/nr9aGCp1GAbFqnphF5v28smLOP6kLMKMNpTj7Zbr2x+SvEW29zwcc1TWn7rgbEWDPFgpyqeJURW+vyP7I9SzKlhJHMwv2Oyeddl9914nV8IIn3J6vpspc7gvt4lf/MZB9yPgoKV9LBLBgBjdjBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UoxnQghvRFrQGmVDg/1rWmwf3Wi+m0UeZq/amoRZaQ=;
 b=y9r4n5uJOiNPB6FXOw1SgAKGg9DrT3f3eXzPwp/RUaW6aZHFlLlx56jCZYMVSLcPeAEcZBKIgdiX6GL0FG0mJAVU3RD3HxqDinzcKMfyPOHDAvk376VqmxwExZS65G6PnqRvKaCfiwCIauD+/Rsw1GnJusBYr2/d+b/uJXBImpF140KpTShpmRmRXvG+uTXnZy9fJ2KGsfEVtAQcl7zjOwnyb28eztUpzWKgK7Z/muk4jwRsBgMaF9Nq5x7sjAC2niMN5jTnVYKbHfMQ6x+oUASACYLDxpuZffDwVtkLe8ucEVhlyLnFR7T2CrV1gj0pkAEatBhknfEO2aQQ7FlGmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 1 Oct
 2024 15:06:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 15:06:33 +0000
Date: Tue, 1 Oct 2024 10:06:25 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH v2 2/4] cxl/pci: Define a common function
 get_cxl_devstate()
Message-ID: <66fc0ff16eecf_b5d94294b7@iweiny-mobl.notmuch>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001005234.61409-3-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:303:b9::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: f311bcdd-00f4-44b1-b9ba-08dce22aa30b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nRgAkZ3DHfdYaMi0j2VJDdfpWIhoBDfrbEi3TZiNgZAUImCnv/TDErm4kdcF?=
 =?us-ascii?Q?sokbgnWBWSXSm4vRGkEHpp0skfDLZmEIh6+Vj4Gp70S64Gxk4a15aJ8Y2/C9?=
 =?us-ascii?Q?kOUHGgP+Fb3yHQJflfsLd0vvFI0awJpmgEfGfvWQ0Pp83s+JTE54npVJKbsA?=
 =?us-ascii?Q?CzPW2R+hFL+xzB1ajH92RRzlFhRz3u1/w5Iuu7BVNi13+C1XhiHdyaCPrV8U?=
 =?us-ascii?Q?5pHS5/Dkj45c4eUtvLYSUNoY1glIV/PW5hG0KJZ1wldVEMWBdnII9JHmLjWt?=
 =?us-ascii?Q?8VYr3suM+N+Go/ECe/3JlGNbgUvzBAVWvVHif1irhw7ZXE8Hl+imtUFx9TZd?=
 =?us-ascii?Q?5nZCTwVZDWaMRfeoAKr7HdNDLshWY/99WgPvzXAgtK4BIRQYlN8ribfQMc32?=
 =?us-ascii?Q?FmbqJGZmXR2zAP8XV8NF9KQquXM6yv+AZt0y5av+lCi52mkk52SrMW3V/wd0?=
 =?us-ascii?Q?Ji9EpISfD5jLpb31fiHNl0trp1Mtn+D12u9r7QNww59R5V8k0WdlkOoDdvrq?=
 =?us-ascii?Q?rJnMFcRAj46AVP2BRSKKRdyLDiD4BBKhm8idAt78Q6JBXeqq0l7GUFRrfm9h?=
 =?us-ascii?Q?EF5u3xxz8IFpwHMQrIdto3nMeQ9v5v58s67n4JsngNcRrWsmmUSXbtOUDgzF?=
 =?us-ascii?Q?3cpw5GqFpLZyWAdWqYMvkjAX/LVKFRGoxRQAf3kotE3+8vxHpsRtlOzIPWg/?=
 =?us-ascii?Q?5Bpsy3dY+DcpEj1Q1IrcZoMwRulG1oOydIFdP/TtWa5Y1u0nyZKo7s5erz6W?=
 =?us-ascii?Q?mDyC0i5Gfm55mTp0vYw5eAIz6jVj1sfkn1wixh0YSdITXPYo+Aei3hlJfqix?=
 =?us-ascii?Q?9oGhtr3Cql9CLHlRXjFgwv4sYyPfhWB37sQVP0/0V5FNl52P9p+LXZdaixFm?=
 =?us-ascii?Q?+Km8EmZz89od7PVpgop6JxWssEBHlJ4g+Sthiqt7cUTK507sQiRiWPuns/Eu?=
 =?us-ascii?Q?paN8rebd7w/Wj3I6C0rk49mJHUWwR+nAoEKkTzqoeGT7lCFZqn0RBaikBKr9?=
 =?us-ascii?Q?GBj9C5hlwMbmmjWQElG9+gxoau+9sd1/dkkgGtGtzT6gD2ThvN1AEpkFAXpw?=
 =?us-ascii?Q?19OC2m5fh2ymhN/Z+MTQo1PnmUUJHcmIkn3pivM5qEyh1Ew/VHiPm/Hn/TpS?=
 =?us-ascii?Q?7vJbZOGQfgBmtSh6qRTtja9lVLhcpHZas+mdzO1UVthFf/zrtW1bEW24blAy?=
 =?us-ascii?Q?eoF1NWpXEH7WtQVLIjxntUsiFMSEzO3NfGPY33eom1xsYvRhM8knuvG1I9o/?=
 =?us-ascii?Q?9Gie8Isbm7g/kvRahMmRRzYHbFypU71wcTZgQ+yYPr/QNdIEmgfQ34Ltqopp?=
 =?us-ascii?Q?2+AEpFrUY9wRG5g7SIzOu4qbEho1HY6sUChNZsZJ+h7dDw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wr8urXUvw8zW5qayK74vg6M2aQu9dTbPCJdwGL46A28Xv+4yucOFujBUhjst?=
 =?us-ascii?Q?3A2+kjAR7khoaT47CrbEdaVPUowHrdNVUBd8kY15NyG2GX94Gx5zTRV9fbHR?=
 =?us-ascii?Q?80hlTHbkhEE6f0QVxH6ony7x+gTgEztXWOjW5Sp7MfjjcR1eL8F4+MRzlYru?=
 =?us-ascii?Q?WdzJKLqkO66lUD15hiP+56nhBVEDITE7ROhuw2Lh6IiyuxojNt2788mtI0ZK?=
 =?us-ascii?Q?WTVCIpTbaBSusuzqxCR7mMtEn2/efEgEx7jl2ta8vVAse4wYs4RTdKjZXkWF?=
 =?us-ascii?Q?VJQsZ1v/H9xqFkuho4aUxLQ9Z64VBGy7NK22f0ATG0VW3Pgfn8F/XmUieHsI?=
 =?us-ascii?Q?9vyGN2aBrP+6FcC78pwnTeorGpo2cFoAyTSiqr+3a3TtSoxlp4LdhpJxpqwp?=
 =?us-ascii?Q?QgIVXdwe+O6g/tO0Zb+7F3nlc12vWzhnXIT3PXSiABP0Me/UolTYjZ1vJDCi?=
 =?us-ascii?Q?tCT60HYiCe32PwOc9bs4r7guYHglmTNAW1SYiGxWUrp1kxWWO5XMwX20JfyW?=
 =?us-ascii?Q?AUMTWOhyGMuM2J3PnJ70TrZ2IMooAQruV0TdoelxjqqUbwZZz4vYipEU5f5s?=
 =?us-ascii?Q?iFsQDEiz/KPDPk4QvUQjdb77exG5NaVhavT5y2k7MtuPAkFtR1iiZBFnGiAf?=
 =?us-ascii?Q?NbvYwNgcnX/SD61j2bTzL1upoCwKUlWJ7AWvL//cq6dcpozcSjEb3FcakjR2?=
 =?us-ascii?Q?xEzgZzmhP2XWxamIFOXzqTNhzf0dF6xyqAcCmBlqcvcvcvphEe6A8xO+/zt3?=
 =?us-ascii?Q?1mHoDuqWSAkvsnxV2x34WKTz5GdGsdwOFt9CGjll5daxxMgIk3rCKlegH4i8?=
 =?us-ascii?Q?vL1RWlswQVKJovRsI4WyCpTRcSzl22T9ZOLpu3/1/dHFevoVZBJaqmUKMn8O?=
 =?us-ascii?Q?lVYZw0K/HZ0G5zExZp+26uuC5pfB9JUyvJOh0ZLUR361scFsQ/mmDdIrR4ns?=
 =?us-ascii?Q?ISpKysRMCze78ql/PkccpEqwY0HYJXZBvLSAw7/nmIj3swVg1UYXPc61A0df?=
 =?us-ascii?Q?viA9f+DTQRz28jquDvuL7AFre4dvkyIvgr8rabYryD0c6cmIwWWIXgxGhHBR?=
 =?us-ascii?Q?sCa4K3aMlJrhFe6GNqHNM9dwhBAoT4HXNd8GBy63Orz5I5SbUSJquw+x9Jat?=
 =?us-ascii?Q?yo/z6BURO94RVDZHv3WnBRNEvwyFQSS2NQlkgUw7JjFTW6wZ6ZreyDoNVSnW?=
 =?us-ascii?Q?o7rTOeMOaVAJpA2t4vvsLpcV6MH7mU9uKDpXj2/xIeorKOTWnXmVdFvPZdz0?=
 =?us-ascii?Q?d7PhIMXwgt5DodS86jfsE2zAJmchyuECMEfqba1+4FJldU31dl+PzO4cwZzq?=
 =?us-ascii?Q?HKvcGkK+evPk182JcSckX2wEdqqqTLxdsMnYQUJ9F8iXYyU2jd7eXv2gPpbB?=
 =?us-ascii?Q?QpltShSIB7KGCjERE5oJjOZL9iHNd8ldAkQxqR48+jAucPA6YTJJFt4jxLJI?=
 =?us-ascii?Q?wIGqaZldJt8ZbwZopcv6/saIYk4rcx0Bm04+jj2Rx93QqPXEkrvYk7NeQL0k?=
 =?us-ascii?Q?Fi7LKbIcfuwfJA1lfY4hT6VFWV1VCXHJ5V3V+WS4/5oRbmilezpFwD7JJ0r0?=
 =?us-ascii?Q?akQkP/QaEZM75+LKrpxY+AQgVyoyBICY0MU3XCDm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f311bcdd-00f4-44b1-b9ba-08dce22aa30b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 15:06:33.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJrzN9ON4TiEvnHTgOq/uXkqHiY/3O1LqlIUCkwXxXZAllMtrq+3pxfEGggvd0/mGXY/T5cK6hZMKf5tLQ2Ptg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Refactor computation of cxlds to a common function get_cxl_devstate().
> 
> The above function could then be reused in both FW-First Component and
> Protocol error reporting and handling.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	Refactor before adding trace support.
> 	get_cxl_dev() -> get_cxl_devstate().
> 	Cleaned up get_cxl_devstate().
> ---
>  drivers/cxl/pci.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 37164174b5fb..915102f5113f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1021,32 +1021,38 @@ static struct pci_driver cxl_pci_driver = {
>  	},
>  };
>  
> +static struct cxl_dev_state *get_cxl_devstate(u16 segment, u8 bus,
> +					      u8 device, u8 function)
> +{
> +	unsigned int devfn = PCI_DEVFN(device, function);
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_get_domain_bus_and_slot(segment, bus, devfn);

This is a good cleanup.  The previous code should not have declared pdev
NULL.  However...

> +
> +	if (!pdev)
> +		return NULL;
> +
> +	guard(device)(&pdev->dev);
> +	if (pdev->driver != &cxl_pci_driver)
> +		return NULL;
> +
> +	return pci_get_drvdata(pdev);

The device lock is now dropped before the tracing is completed.  For this
simple code I'm not keen on having the lock be taken in the helper and
released later.  It seems best to just open code this in each caller.

Ira

