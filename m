Return-Path: <linux-efi+bounces-680-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D70D086EB65
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 22:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E241C21498
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 21:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0065658AA5;
	Fri,  1 Mar 2024 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqIGCsgC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27B5823F;
	Fri,  1 Mar 2024 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329799; cv=fail; b=RkLBV++CBR8yefugcg4Hq95L4jaW3x66BjMcDQqDT7/Xb86FKzTgMid/0CksFZrRrsctWHq53TGOWMk05ofEgh4hivFNi+m8m6GyvbQgZTjRObIctOq8dMgrVtvXkS/cFL05NVGmi4FMSNW1EGdNApl/suMA5VJJCSl8L9R9e18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329799; c=relaxed/simple;
	bh=S3fJbQkzPkHfx+DS2P4pNwxY1Rcdj2LTOPg4VAdcYh8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UpxKUW1lp+HwK9D4u+Ev0eTnVMW1hOc7zXy1+z6Lg8b3riBDUT68HvcH0qxtv8wG85ijQgO2/SSGSywdBnJGsXmMZnA3vBKGVO7rwlkqpTu0QLQDOhhdJPF1GAWiU+Ap14yELvkXF0tyU0T1Et3U22wgosTWGhhmtkro3IcuWss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqIGCsgC; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709329798; x=1740865798;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S3fJbQkzPkHfx+DS2P4pNwxY1Rcdj2LTOPg4VAdcYh8=;
  b=nqIGCsgCrQ8RAi/lNoEiif7s92FJMItDC23aY1icVP9J/bQtYGSmkX89
   KOeeohKip+RlbxlujijY8JdTiWssKfu60YNpjJ/LUfuPGLUN2iTMUzVZf
   O5g+fihjavsIewDt+1hif839bo6pQnLhr+mYfOibFn8rgWTQQNiFGVnPH
   JKGJx16tDxD24VITuqwOWgkVUan3ePo1QidxkdmxCwPGseX5K35/XXKeo
   PMH7jQmnTCROCyAE4ioCO0KTItwVFSP0i9yO81llmX4UU3ODVB5/IQDKD
   3nBjmmJsvD7nzAw1zwrQH/uSTOAkoORPPPVi2xAEvVYFHvaaHC06hHKD0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3812477"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="3812477"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 13:49:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8223183"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 13:49:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 13:49:56 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 13:49:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 13:49:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duf5rsZT3YRrjol7PK5uAlksfgoc3HX9jAw+6K7QV2G/bh0IylcX2XrxEbkHGQubGmlTdj9DnZh4MYI9riJnb+DwcjP0njTz69ODu1qcVyKx/fC1jwCvyEn/3l6V1P13zOMeS/ZZi7rI4NEnCJHyLc/28Dq3XkwBFUciTprmeuyrQAKSIs1I41QQdkgN66O/LZ1trzHIaWYF7OP1uIuo0FLMbEhrGdngw1SRha7thc4I4DXNLNjfeX6j2WiwcUHjqxLDmFoheOESvziB83PCAWpUGC34NAWVoPX8sLfgxswXJfqKWdWj8Xh22ruR2Rl6RCyP7qiuGTUkvIBVGdFbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR5anyj9CFATM+fFqggF2nsj1YNlLb3pwrTU9dNtc0s=;
 b=dgbtaq8ohC5J0F0UX/sIfIghGnzIZAoMgm3wH7/mB5Eb+A7CsIrj7XEkyxkChfWTlHpgMDyonb3t1/q9bz+nIkyYapPP/oAC4Tv0UH3fAUSuAJjJ2xvRfZu4ZoqpB4Z8QAKpOgyNJwaL9KfJpFM7EOaihY2n705Z7/ACRRDgyPV1JIhsec1F4ZmvpmTgUFnBIw4mwsAyKUsAusJNqATWwa1PovKjOkdiuWrYawUfbiPc6j7Vo0+N+HmbhF/EwzDiBRGFPTJyY2bAq6zu0UUvrPzR6v4QrrYM1Xy1Ps796vwkxzlcKcrIkif70PDnFI0p8XzTejvnZXrVyRR+e6sv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5775.namprd11.prod.outlook.com (2603:10b6:303:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.16; Fri, 1 Mar
 2024 21:49:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Fri, 1 Mar 2024
 21:49:53 +0000
Date: Fri, 1 Mar 2024 13:49:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl/pci: Register for and process CPER events
Message-ID: <65e24d7df3521_3651e29492@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
 <20240228-cxl-cper3-v1-3-6aa3f1343c6c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240228-cxl-cper3-v1-3-6aa3f1343c6c@intel.com>
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: af7f0b0b-1dcd-48da-a1a0-08dc3a398703
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEoWdsQ6vW7q7tIylDNyUrVTBof5o7ClC1AmKP1DtMBOs5UvhZSH71rJ2dprNkM+Nh5+HTlOB/D7y8mGJPuxIBqwJfSgZyTzrrRazoUXOtmULFXBlgbKRRkd8YJtTPhy0/ab9UDpm4fxAeGFt/ggNYtbPj1HW20TS/FAe4wg4J/9r9wTO73u9p8akUQ4eJPPcx3JP5vOezBEWahEDui3/2sFTaQJAnhb2OMLPhRHE4wbDVI0fO6Eaj4/MJ1+2BBbyrhl5c5y3by5533ibMcAY08grwVwucPjcP6BbeMtSmurz0e2j9cy+jdIv8vKLxaaVm6VeRqJeEzsfwJeGwkA9LViMNpWB/sE75/8XmCp5Cy6bb2aYAH2afg02UtjDT6midNcXO53JNQiGJYHzSR+z8miPE+6LgtO7EyCB6nwYoQ4HyWheOCwkUMZdNGpV5x+t17F3/fsaW9YTSssbmqi/Sn38vj/aK0zYwlPaUSZS4ym8t2RU7H29SckbQeJi0E9zAfyj1pxL6X2vKKsRgqMAbnfbZqVLH6JayqSHN51e2cSkKmFjTZo8IFqTJ8mcMDO0E6qzlewAmO0qafUoJ3+Jpy8sRqIYlKo1w4SL8Bi5p3g9JiUsjNJ3q/TGEwUCjNPY46tFgtJjIrUzq27uXToKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E3nYE/mL61bX4DHX5a5FYBNmQSvsMW5FY5MCPEkgSKpVrWGdLxTFL1CGEFOg?=
 =?us-ascii?Q?i6HUPc6zkagOZ9uaQCS4ymdvShGUxedXBLqSslD+s/VdMGGmrvrS35D8/lSv?=
 =?us-ascii?Q?NcbWFb1eI22I8sqNah2tLDsk41znpBja6iwj/SqUovwI+0Z/2W7R0PagfDOF?=
 =?us-ascii?Q?ND8wbB6F1k4dGEyNavePBF5qMPxwcT85SLJHXOOvBcr41VN557719S6SfDOd?=
 =?us-ascii?Q?qTFTYtia/TRvuQtkuA89sYZFFmrhBSv8CjpFjlNmJLBrfUMZLZM4KHs1Vdo0?=
 =?us-ascii?Q?S4q/tHFNg4zC+KF72ebXQldJ3LQx3YJPwa0srM3YF+BQArf/iZy30Tn+Ntwx?=
 =?us-ascii?Q?Wl58mYAydkMdpRId4TqpoOIxbkjsflolbAkodOmfUbigiHoX/cApZ7w8dgca?=
 =?us-ascii?Q?QKWuW/T/qY+PcyvpCYyT96JqQ7DR8afc9btyL/He1ID1+MLYesvtas2EyM0C?=
 =?us-ascii?Q?K7XXQwsUJeMDCS7Lrp9CyyraOnJ1dPlxwMCTYrBjdx2aXlfBV8R5ZdZrv02q?=
 =?us-ascii?Q?rUTEah6CmYQT+EvdDnqFj8sECGYRW1WfEqWvhwmIEA7z11CQsaSz7AJGLjrh?=
 =?us-ascii?Q?VoDD1zf4IirzaV4R0ibPWj3Ygfv6ndMU/xdFnifo94IyyYp+yzG0R0+Z/f4n?=
 =?us-ascii?Q?NQkXuDD0dKUKE1nOIXHxGoSDJofDX2QgObpCeQAGdqg5/0R+8H+rjB+BZ/bk?=
 =?us-ascii?Q?3pGKe9meXNQnHBXGcJ5INJe4wDKOkX9bqOuaITq6dkvgeI6pXqNapswWFZvR?=
 =?us-ascii?Q?/+aH1KFMTcrtpyCR75r5ZWEFi5+oNgxeQC27zXGgQfBWj4KUGnBs+5qt7S8l?=
 =?us-ascii?Q?J679jZmYe+xiSBqz3nn5c4HRd0XtK22+fh0Jc05+MQzQBA8C5z42vNSN6XWF?=
 =?us-ascii?Q?8e6ajYRRxFHvrrO5T7w/sIM9zyEGPnCCONu1THPSBWkcwHLFJwBVr7hZyRlP?=
 =?us-ascii?Q?mbQEpuLobZOinkdG4QXT4UQF0y+m5G9GkbuygMDgEMzT3jK/A8c+swbJljte?=
 =?us-ascii?Q?6V0wSadqptd+gfDJu7c2leR4sW05hWpJ3AE3VxhZ2nK9CMygvrEuDMUnrfKV?=
 =?us-ascii?Q?y37hv+AxHs5YYzSv7gOQaIyVG/LAaZd1yBj7GmvynXasPW7oXnvFyX5EqBIr?=
 =?us-ascii?Q?qT7sSveb6GTNNf/8NDmTBph1n5BPMo5/cbFUvmbXcz0E5TMIM4INg3XKC1qf?=
 =?us-ascii?Q?6wQvluaq5vDR5alBPTOASHAUvTvGikeuKdZyG8CqF2kXubcgpFPKIX29PbJ4?=
 =?us-ascii?Q?bH8maWtDc570tTIOACLth6Y8P2ZvihrrHgNeNQqpFTewCKnNAQ9cTQU+Hcyw?=
 =?us-ascii?Q?6lZBjjEZ33Ide6w66/F42F9OazWUsMJfjr2GkIDgFse+kUMa3Q2H+ECJOnxA?=
 =?us-ascii?Q?Wii/Nu1TBbuON+bwnVKRq/6ivXDNlo9RohlDJ3k1BK0diCyzTzxXve6HhwUa?=
 =?us-ascii?Q?XuKZMWOm1Z/qgC0+hatiVWg6cxe44ITNhIvzvx5CrUYQAuajZDUsdPnjDBIB?=
 =?us-ascii?Q?1LH/20coLJMIX9HeLNFAxO0s98I6CMixe7mRID0Wwj5vRG76ZuUsElp1Y6ZI?=
 =?us-ascii?Q?tGhIkqIbPgHut0+WMVQ/Rk2uU7Q66yrSmUz2ETokpyJTD2nGdcST/29ryPUw?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af7f0b0b-1dcd-48da-a1a0-08dc3a398703
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 21:49:53.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uLio9K/BnWyKEUQ8mrZ+9BgM4GxW9/wefv5/KyhI0Gzkl908l/ZWSFaeo+v86j8LtlehOWMKzljjqwuOhe722JPTU9KiHHzzVk1fzhA08U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5775
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> If the firmware has configured CXL event support to be firmware first
> the OS can process those events through CPER records.  The CXL layer has
> unique DPA to HPA knowledge and standard event trace parsing in place.
> 
> CPER records contain Bus, Device, Function information which can be used
> to identify the PCI device which is sending the event.
> 
> Add a CXL CPER callback to process events through the CXL trace
> subsystem.
> 
> Future patches will provide additional region information such as HPA.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes:
> [iweiny: Add back in after the revert in 6.8]
> ---
>  drivers/cxl/pci.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..6cf8336d1b33 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -974,6 +974,73 @@ static struct pci_driver cxl_pci_driver = {
>  	},
>  };
>  
> -module_pci_driver(cxl_pci_driver);
> +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> +static void cxl_cper_event_call(enum cxl_event_type ev_type,
> +				struct cxl_cper_event_rec *rec)
> +{
> +	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> +	enum cxl_event_log_type log_type;
> +	struct cxl_dev_state *cxlds;
> +	unsigned int devfn;
> +	u32 hdr_flags;
> +
> +	pr_debug("CPER event for device %u:%u:%u.%u\n",
> +		 device_id->segment_num, device_id->bus_num,
> +		 device_id->device_num, device_id->func_num);
> +
> +	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> +					   device_id->bus_num, devfn);
> +	if (!pdev) {
> +		pr_err("CPER event device %u:%u:%u.%u not found\n",
> +			device_id->segment_num, device_id->bus_num,
> +			device_id->device_num, device_id->func_num);
> +		return;
> +	}
> +
> +	dev_dbg(&pdev->dev, "Found device %u:%u.%u\n", device_id->bus_num,
> +		device_id->device_num, device_id->func_num);

These print statements are excessive. The dev_dbg() already encodes the
device BDF into the device name. The pr_err() is not actionable and
somewhat redundant with the default cper_estatus_print_section() print.

I would just delete all of them.

