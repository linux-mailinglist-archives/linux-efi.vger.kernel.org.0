Return-Path: <linux-efi+bounces-293-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED961821F68
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 17:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2D31C224AC
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 16:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCD114F6E;
	Tue,  2 Jan 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUxeijn1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122714F6B;
	Tue,  2 Jan 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704212600; x=1735748600;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nTj5BEcXpuVQut8n9uHupZr0JpAzXhHJg+74hWSY1iw=;
  b=PUxeijn1knk0I0utwsaYXCi8SXsd1De+60zCq+cVhKpKzXhvru81OWx0
   9KyAW7aSl2fSb77PKV21p9lmV//8XClc4VOkWSM5PyouafRVOpC5gol3I
   N9IdX75JPrDvrBHJzgkxr92z+WteVBTHpndh5BRPdf+jIIetesu1ZzqZH
   Ku4YEZWmKlEzVr7A5/rdti+PJoH4rcRCTdqAIrhtlwxoXhJpZXuHf9Yqr
   dYEe+lHq2+b6IfLSYoLttlc+i5ybQm3Zeco/nXOmN/NxmSwF+XszNQ9r7
   hVqPVj7kuQE0LMInuVG6Yidnv6a5DsrTXjz4IglIkLfBS2LnKqj8wWU4v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4231458"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="4231458"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 08:23:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="772879540"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="772879540"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 08:23:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 08:23:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 08:23:17 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 08:23:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFqtD2Ejc0p3/9TCmKmVGqH5di+nWHetPWqJEuKCiQoALG1bXRuLXFjz5TMuMkr9f1emqJ2v3np5bCNj4/XH6jeKESljvZIbva3weNAJEvFCa9IlTigMFtbYFqI206nqmiT5lNl76C4en6AyXnGkE4dX///06QH0yPWSwXB/lcilCla0Ea6nD1JJPFFOQuqXwAeoCSMwMGeu5RfdNXqNU8AqCdYvf32jqDBmvJVFC6esxYDt2kfOHIU1R3ZnTIuaJs2ots01ix1UGs1ECzVIuWSeR5vkqrXJaOSjcrW8juuhWyHtN9Qc2flliWTjjBOEJgu5Q41Z57b7tbYJfhYpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCATZMlhjzt0WZ3k34hJdQoByPkkIFRbfDbxzp3YkNM=;
 b=F6FdwWcTpOFuuOgHQ/gqNGizFwaUU/j9ARsb2Sf0/RA4Qk5AP8VW9K9y+RLcYywAebJh7o+m5+5IdYw5FZylP0Ca7xqM++C5pI4L6Qx3LXokckNTa2dHCCI5W0IQpDrH+lto/MGCorbjIEBKgI4BeLKI4JQIIS7sgx8XGoJZ59MIONo8i1kAFtf+X81JpWcpGgnN4Mx6BLoHHdWzwNGpOMFSRx9xVyEcDoP79JWiZ/N6J3gMRZSsgaRqOGUZ+feJeuOe7Z1q3I2pD1l5lfRhIeNX1l7NzPoFrI4OirmVvilfIcHCNSofojniMSgaVAcHHT6HS+V/sKK9oSskPkV0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 16:23:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 16:23:15 +0000
Date: Tue, 2 Jan 2024 08:23:12 -0800
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
Subject: Re: [PATCH 1/4] acpi/ghes, cxl: Create a common CXL struct to handle
 different CXL CPER records
Message-ID: <6594387015431_151dc12949a@iweiny-mobl.notmuch>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240102150933.161009-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240102150933.161009-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 4038b4fc-3248-4abb-a6df-08dc0baf1f7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgjicEmoGcNUuJvACoX4ost+pCUBhaI2eeK6rvSMEs4yX0dryDJZKD3cWFt1dpPdrNmNDk9sYfVtiksSukrDkSWFEqaDWtL/Vcu4ZhWV+DBMAzYu5gvLxAbYuuiS3DTCclNq4MRtgjuw9TipRgmZADKWDk8BITqpyF75+6FKwk1VmZ1oHXFGMUv1HEAmYr+XBcJxM2We7jYvxb7rK+trQh7iBwM7RqOjbfudbR1Gi44Qg8H2GVQYOd8R06ivTOCZQwnEB4yObtkxXZxFnDclD1kuNrMlJ7Jc1v6Bcq//t7KVl0LSulJq9m/UzYUeXN30dCr+ep50+Tmumb1R0gq/W6EMPvDvn2pzkSyrscxZHmr5QnwIkVJ4eePdKFOP+s/y+FeJSsoNj03g+t4TUbCeTa4svB1GdWjMVJS0Y6VFNMYurBxognPJDFjk+YjKvM8fmTvoyA0ZcoD4gcGH7veKIJD6zwEnoedTx1DLOt5C4lOnd/biTMPyzjvRb6Url/wcnao4ygC7Nf5GSYnggEe1XkQZd1uP8BhPVIlZq257UPDFZdp/NLslDdvEYUQ+IhQJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(82960400001)(38100700002)(66946007)(66556008)(66476007)(316002)(54906003)(6486002)(478600001)(86362001)(5660300002)(2906002)(44832011)(8936002)(8676002)(4326008)(6666004)(6506007)(9686003)(41300700001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iZ/RNu5p2Rl8eXkXx1QZy0/SIAo3q1VTqHGx0od45DNSuFnLTFV7opH2bRol?=
 =?us-ascii?Q?jHRRtkn0TiEcPn/DCz7rS1E/QPMTUUAW74FUWFwm68rX1B81ByRldCcBGl+T?=
 =?us-ascii?Q?UR9j5MKDwC3zCN2pRbXSsyuOUA5Zfhd0MLfcJxbzG8pSUH1s/GJPvCI8kJ+5?=
 =?us-ascii?Q?m9xduQegi38E5Zl5Qps2u1cFeZRWx4FIe6D47wRMJ4T17owM6GdI6OCsBkOK?=
 =?us-ascii?Q?zAU2OR2C6P+CEXpNhGE1EIGZZedPRXh6fdY6wu6gdV5nXsHDX//XjxCUHzyj?=
 =?us-ascii?Q?oGQ7u/LQBa//wZk6O7+GZYRmMakwVqW1reZ6AMMCw20Rwx15Z5E1bPLIG2z9?=
 =?us-ascii?Q?le032jpHJVuzsJCQULOdVo08g0aoC3n403LdAclLjkr1BbTKCvVBKW0lN31i?=
 =?us-ascii?Q?PS9c1HG5nPT0vGGjhTRQJAv7VF1nbZbp3a5SbaPvUxBTP+vbIFYw/d+7n6p+?=
 =?us-ascii?Q?JIcKuYkWXBrFebUV6+oMz3/UaO/spce3uH5IG7F/6FCfemb6ntpSK+OStdwr?=
 =?us-ascii?Q?s3bh6HL46W/85OOBLWxXztZv7lFpiU8vyhvjwQKOUG7Z2ZWMzQXjEDiOK17a?=
 =?us-ascii?Q?SRvKA60JKyCKn2q7U7OGWACVkw879Mcxjd8el8PKffIghcyIjx304qA3Sa/F?=
 =?us-ascii?Q?NxlmBuC+OMNI66irNEmO2GNnL2Z1a25rWzJMGEOzXrugUt8v7qjb41Pzez4B?=
 =?us-ascii?Q?D7w2J6/4TLBqmeN36wnbBVTE0GYiM+XdjIafy3oGdtD3p+GVJSr6mtMUxwah?=
 =?us-ascii?Q?Vf1CE+4+YlLd01RhHCLyyKhAbtNu57b4ulVaqJcgXkfhNpNk1wrdKVRHOHbG?=
 =?us-ascii?Q?38sYvgwmAl9OKCywFt/N5z1RP69BTu2BtRveZfwurWgsZBBWKuUzyzWb6WjH?=
 =?us-ascii?Q?ifC/Q16lVpqoTuYs00visiP0wAS84dvnB/fcFw32p60+3fzLvsAX+APghRi3?=
 =?us-ascii?Q?k742ATN+lBRmeh5zInv70GLNwFRP6E8C0OJIOptJiZ8dfKmOOOl4pOzFuHA1?=
 =?us-ascii?Q?oXNBQgzubxPlzwL6vwxEsIntYc9PJzGWtYTevjpoPNu0pqvkvkfvHdhjpqRi?=
 =?us-ascii?Q?rC37sFZ8Iz1PUF06yotDSjap06AzWXVjzpTGyCp8eg404ghiKH4On8OPBV1H?=
 =?us-ascii?Q?BN/uvWolHqtBAXICtexoMBtf3+Go35iSlVBeBg+oZMOabS2G1GXDvRnMskj/?=
 =?us-ascii?Q?cF1XbMrejq9WbecNeu1mvekms1CghZdZfzkG88RJX9MgnAXQu4XJUPEB/B7l?=
 =?us-ascii?Q?RxgNkNyF043AgnM/w6cCbP/mmG4MunQnF10I4GYBbRV0401bIpUsSa1mH5yB?=
 =?us-ascii?Q?8hlLjYcmvRXAv/6rnEOGEhzAKaZk6HaOoEYn9G2U/g9bx9lSvsLS8jcN/JK/?=
 =?us-ascii?Q?ymXDk6pXeerGm+cx1zvonKlHlTLmtklGIlxqVWCaSytAbep2kEOtvcSr25qk?=
 =?us-ascii?Q?B+Xi95VcaMIb9u9+fkPIrXPQrN5Qo6hHutj/wGslPiIyG6KnZwqbd84R0ucY?=
 =?us-ascii?Q?+F0+VnCCeo3vNu4+70YN6M8wUPdlxg5Zht6caZ7RCft1FH5TFuT3jvKu7fK1?=
 =?us-ascii?Q?zfs9QTHW0gmPNeyio8MZLEJMA+0RcyyIvhDhmanB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4038b4fc-3248-4abb-a6df-08dc0baf1f7e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 16:23:15.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42DMYIz/R+UYOOZX2nn7Oe2tzISSlUwCy0dCUrvKGGm4J56y3Yuqd5Vu1pgX/QoyWx5JVeRP5xMH5XsznyiROQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Currently defined cxl_cper_callback interface between CXL subsystem and
> GHES module is just confined to handling CXL Component errors only.
> 
> Extend this callback to process CXL Protocol errors as well. Achieve
> by defining a new struct cxl_cper_rec_data to include cxl_cper_event_rec
> and other fields of CXL protocol errors which will be defined in future
> patches.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

[snip]

>  
>  static int __init cxl_pci_driver_init(void)
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 17eadee819b6..afa71ee0437c 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -141,8 +141,12 @@ struct cxl_cper_event_rec {
>  	union cxl_event event;
>  } __packed;
>  
> +struct cxl_cper_rec_data {
> +	struct cxl_cper_event_rec rec;

NIT: I would call this something like event to distinguish it from other
record data.

Other than that this seems reasonable to me.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

