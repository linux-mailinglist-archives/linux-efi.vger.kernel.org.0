Return-Path: <linux-efi+bounces-296-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 038F4821F88
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 17:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893CA283BCD
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2714F83;
	Tue,  2 Jan 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDsfIsLC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149414F69;
	Tue,  2 Jan 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704213037; x=1735749037;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wR0d+nlXzEncbosFd6oH3TbORK4CKKUCm3YhfTjm8Qg=;
  b=dDsfIsLCLMDGq1lFaqM6bR49XMDgG6PV06U/pfrjYd0MinmakcVtv4yy
   O3Y8kuaWTBeZUlxmaqPmLcZ7D4lQS3wpuV1F3RpKNC+4xhqqn1VVo42Ox
   99UddTczKfiKlEQyXGAkDVd6Erw/02yHJIad8nC4yijJJo1blS+JuL3cG
   Hb4GPxKNrhx34TnU8D3S672g91/6OsmTxeJlkxy1fQlaHJ0gUttNuS4FY
   D4udi4cuDaksjngpY+R0OUgaEPz4VMraqmswgTx7jpEOGlADtMXCSthJt
   BGj+8QlYohUHhZ1QRL3v8e729QB87gehQx/Yoq1B0pijnx15DxrODA8xG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3667401"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="3667401"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 08:30:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="729536284"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="729536284"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 08:30:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 08:30:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 08:30:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 08:30:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at0E3QtQniBkQ5P4hY10WKWIDrws0JsPveGC+2IoHiViYVa901ck5vQG294vRz9moO/D8xSKgvSgZkwAPuBSlbHCyJY+0f3jqgfZqPtTL5yti1J6WJoOkPKwSHRcecxLJWHkMWlwsfN2jCIAd9W6qaT7W51rZZrup6EN/E/4gFazOJuNewd5YIeFij/wg4iJuc6mkt3ICpOvlBvhZBAbFE+eb4+0/kcSbthgz6Odyt9v19h+QjfzENrjhastfIg+7IJIQjXq+qP5EV4FDEGE0nX7Wcjnhh1saue+S/QTMZ6OBIHCPavUadMoyab6NM8MRqEa75fn4T/njS/MXJcTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4bRk07J1tnce0nIFaH+SvzUD3qiln2kPBR1rqrVO90=;
 b=Sc2dbV/z5D9cb7nGaWFZadIdrxj8g8cTFOJ7j6VUKg6wqSnzx7HW72MDersSzvFwOJ7j7Va1W/AXS9rl6w8sdimw6RK9ZISo3bp7zgJ9txuHY/vun5twzbLbUjNZVocrsnbyZh7p3SxdF6bPqqM9DBGO9aeOYNMviWv8Ey6vN5+wFc+SgOfOGG2bXxDnZbd055CPzulUVIu/nZ4r+FLT7JW9FaVTWyzXWz/KgMWi8RFEjdnIeCRjpmbMhpFhexWumzfkmZiPqqa5mGLdHIVp0C3x/NxYZNAEVJFi+H7yQxIN1PrSg4ke4N6+/QJoLxeDQDYG65aGo5oWrwueay7hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB8142.namprd11.prod.outlook.com (2603:10b6:610:18c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 16:30:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 16:30:25 +0000
Date: Tue, 2 Jan 2024 08:30:21 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH 2/4] efi/cper, cxl: Make definitions and structures global
Message-ID: <65943a1da3368_151dc1294c2@iweiny-mobl.notmuch>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240102150933.161009-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240102150933.161009-3-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 465936ef-7ee1-490f-6a50-08dc0bb01f74
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqU1b1jRoelZTkCNVTFec6OKAysmT6U7ODaRb3DjQRi8+UPcxJkPHusABXwfqTFTtkyohV9n/+LLylF4XOrGasbUQkv3/Tb1AjqiuEH7sm0BFJC6RCpGljFWwdYP0u1uc5Ayd8wM+4ETCsKA7Hi+zZ0t6wyNyjG+JQ19UhgUjXk57z8wcoaXyk0vnc7Sd85Ql+cC5VNwaE0y5kaQkyZrgPnVe+dWae7rlXBX7pERqlcNlOaVieDcHVg3jAxTNXPpnUItTf15FTtq/LCn5SrNp5SEPRpF/iWgHaCgKCjMqBxf43MJ/QvC/COSbLuuJWExtWxzPgtZC7Ksz/AIfQT9M2Ke/Vl7V8E0hhrjP6NptusQFpsmCWJliLy+URzYeEcim2txPKrzkHF95mzis26EGw/lS4AxajQlwRAiw2ZjQBZdTTHilzffVz+GFB1AUXCs0WVNgLCazWBRp1P3sxHY9vUvQWatV0tciM3nd/gxpVQ1ZZfkcabm0C14YXq9uODa30t2v1K06M+wzLq+AHBDMYdaw1iNadVUKA5Z40RgecUKxV7Wzf/WpbJaioQap70c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(9686003)(6512007)(66556008)(66946007)(66476007)(6506007)(6486002)(86362001)(38100700002)(41300700001)(82960400001)(26005)(2906002)(6666004)(4326008)(478600001)(44832011)(8936002)(5660300002)(316002)(54906003)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6SuKvZvbER0z0Vg8Sy+bwNUqiz5eKicb97m49xmoK5xGiOak0s0XP8Rksdlj?=
 =?us-ascii?Q?/SNjHV57cn5DvCsULWJu/8JTLQbEpncrAjWPlRPv0bUQYRK2Rpi/3zwLLxgi?=
 =?us-ascii?Q?p1ZxI0B+/+7PjLUm46s1ZB79CvTcDzYaj0Y5qlqJyr6E+MEJH5s1BepTNm/S?=
 =?us-ascii?Q?yXZN2ryVdfFskGLq8EcRVQ1LWqjtN24GLpo22r3YFPtD1IMQ5L3TxjtfhY8I?=
 =?us-ascii?Q?3ZYvRdk+DC5B6oBnOc+bM+8F7ANAtj3drGGG0PY9oXo1MezrWKCltzYwzagF?=
 =?us-ascii?Q?qbH95/PdyUvBZVBoH1Xz8CMS+DuH2Vh6eDnIqEqxoUoBivFWvNzjPJo5LaR4?=
 =?us-ascii?Q?qgCO/gT78k27fLAYczQs+FNk1smjhuQIgygJ9ZFq2hTuMxA6GARd/AW7CfgS?=
 =?us-ascii?Q?wmqOK13wieWNu68AebhI+JSGt4u/j9yXsehwnQ/Kvr+kGno/dZB7lptW820i?=
 =?us-ascii?Q?msw+FpH6j0ujXk90c9oO9OgnbciI15ID0QyDciaNl1+bU1IeruOYR/EkJRL3?=
 =?us-ascii?Q?8n+4HldxmzFFs9HKLR04Cc6pDLX6nL1bt8fTjUh/a2NMo0QueXRhUF5OY455?=
 =?us-ascii?Q?K+F+BbHihXmDv1ot5A6MUrtnmxSc3n2F/BlIRPLFhR9UmTyI5EQ+5d0klJyn?=
 =?us-ascii?Q?K+fO+u9gNS///W9wQ/KNpmJesnMlq75k3EPs8okcJya3Dj6YR+ijxVSZHO7D?=
 =?us-ascii?Q?uvgSA5HcyBb54kUVp/eITLbgrUYjkL9uhNp81fhcWIPn1ydvqkg3MbqTLjtQ?=
 =?us-ascii?Q?9egtDGiIi/ojQWh882UTSNv2KnZmPmZE7dCc1fnMGJJf+sTr9/ZGkw/QP9EF?=
 =?us-ascii?Q?QmbcSzuqqryWFYA5zAEnDLl9ZkytQWKhGmobzj4gopcMyOk1x6zGnmmvQvgX?=
 =?us-ascii?Q?fLlYoZufpEU2d+7wE6xf64UjEUP1HGjULqonCKSAVH1KoEPP9sISE6lpg+dU?=
 =?us-ascii?Q?+UXzv3SxeljZDfJATB+co8TACv5Sqxh2YVTzTfDxB8xDRMOosdtMm20LARnI?=
 =?us-ascii?Q?xylC0Sj2a+fZv/8iXPsOWDc4ZHVLmMygvonQgXUJv61uzA6cjJQFB0DcxIPA?=
 =?us-ascii?Q?XNiqKR/uct4Bpuo+Kc7WP5UMgIpQoGfhrCCEGzYLB6ojv6Fbh4+FL/Bje+aD?=
 =?us-ascii?Q?dsQFMB/ppkj/inkzYb9cJC+ytKo1YT0IN9GBMDcGHE4xZx+3AQg9jtmYl7yI?=
 =?us-ascii?Q?/5+n5vJw5d3tDn2pZjl3/XidAyPoWRQH4RddKhZArl1I/ll9fbS56gFlvXtH?=
 =?us-ascii?Q?EE6oBTXlXF/3ASkPB2dcxmJF/3guIIISxeoWXf6Yd421M0Hf31kr+bWtCYsv?=
 =?us-ascii?Q?KZQrHHbl6hTrXy99jGMwzUj+3/Zn0FfIz/rSgIll0wB3Djs1+F5eBIwDlbC6?=
 =?us-ascii?Q?e6y42XW8fzC04JE+nyDQRgOWLAUlsGoOWWTl63OgvxNUKb9operNbMt+CK4t?=
 =?us-ascii?Q?dgY8t6wn/xVo7KIevJMDjh83sxjH8yBzahcNjDQXiRRPJcNLh9a/G6CCmD3P?=
 =?us-ascii?Q?S14UbdGM9t6Z/Q/o2m69j9ohJKdNxetmQuZucyQCLzNTjFZ4xINWhrK7Bkt/?=
 =?us-ascii?Q?31GRBi/RrpQ3uKoRWTFdDZKbzrqtRW8YGlgoW6Rx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 465936ef-7ee1-490f-6a50-08dc0bb01f74
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 16:30:25.2279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMNMn3gqlj9Ig4ZdNKtnZ6fB+l3F0GncwLNMXxTf1d470NeEFc6foKxERcP6Y0ibxEq5UIGiQSqKoOIdcLivxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8142
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> In preparation to add tracepoint support, move protocol error UUID
> definition to a common location and make CXL RAS capability struct
> global for use across different modules.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

[snip]

> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> index 86bfcf7909ec..6f8c00495708 100644
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -7,14 +7,11 @@
>   * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>   */
>  
> +#include <linux/cxl-event.h>
> +
>  #ifndef LINUX_CPER_CXL_H
>  #define LINUX_CPER_CXL_H
>  
> -/* CXL Protocol Error Section */
> -#define CPER_SEC_CXL_PROT_ERR						\
> -	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> -		  0x4B, 0x77, 0x10, 0x48)
> -
>  #pragma pack(1)
>  
>  /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index c1a7dc325121..2cbf0a93785a 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -89,6 +89,10 @@ enum {
>  #define CPER_NOTIFY_DMAR						\
>  	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
>  		  0x72, 0x2D, 0xEB, 0x41)
> +/* CXL Protocol Error Section */
> +#define CPER_SEC_CXL_PROT_ERR						\
> +	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> +		  0x4B, 0x77, 0x10, 0x48)

Is this shared with code outside of GHES?  I did not need my GUID defines
outside of ghes.c and further becuase the events are defined as UUID's I
chose to keep the GUID definition as local as possible to ghes.c.

Can you do the same with this define?

The rest looks good,
Ira

[snip]

