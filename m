Return-Path: <linux-efi+bounces-333-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A691824836
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 19:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADAB287F98
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9F28DDE;
	Thu,  4 Jan 2024 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWtX1zI6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7B52C18E;
	Thu,  4 Jan 2024 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704393124; x=1735929124;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wm4BI8rp8tzpkYnHWiHzMLQVsOBbyPH/KTa/NL/WUlQ=;
  b=hWtX1zI6awZ8e87jhdWOv3JHMKSBiZTw5OGllT1nKhtdVKW1vnLCS1c8
   TJGeLv/qXQ2jEvCzzxLaUdIeyXZy7Xd3Nd81i8m1esG98yTkvqxe6ICSZ
   r7L/gVGgtvnky5Zlc43ZqduIgCsGCL8+dUA8RAWPg1XmKxXbvfBItXhmB
   ae2x7BWtwj7pcMggmjFKZEuZkqpL2+5b8KzK7W3lvGfT+d1vBWkuuVNEt
   E2HDN960YGUWzwi/xZJpMQ63b+Iiy8BSmrEhc9cAG9aXHLj6EWK4KyIGP
   uaQZk1I8t1nQHxODfQwy2Y+HhZ7ZdTVk/kKTk4h4SlTR74sFJ30Obeo8V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4437222"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4437222"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:31:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="814730783"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="814730783"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 10:31:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 10:31:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 10:31:30 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 10:31:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdOYj2HCBQZbRj4IksWIDP4l/pCaSmG5/zOvn+5TFAmImAvLEG6ZpP1Pmy8njo+Mnk1MTVPp0lNqpF3Ynq1WSNrlklmyl/fJouoa3jm9+6RiIdPAzKbsGSVk0ABwIzqSgWCPDHToQp/I94yQGCbQHISdvE6+h4UCW8VfKONgKakeyZpfMonvBhxxt7MCgslZpIRqaYiO/IjzCS+I832GgH+bcUTXO/f2hfHFWP4pVly/GvcW/SSf2fE2xFB5Gn62hrZlPod3JflW30vTDoE8j9dLXQt2hu97Hr9fIf/vrsqpSdhz8B1LxOkQS9j9OjMQE1ey6mareQgNHDrCm83e4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOwv20fXbRzqvoppBAOkFXO9W+9axnkREej6KaCyvsg=;
 b=PJuBp2M6aSYWaCsLuN9IACZsJTonWHKRjd0DXvHLd7k75hKajbwZRzUe2oPb+9f4vdHWJ8MtsVtLBJXJpI3T91ez1od0eGdaV2cDVodkY/kuUkpDiReumotA6Vn7fGV+fNRZQ1sWB3RgL5uVv3Y7HD37+rCBVAti/OKmKHcjWJINV6hwfipE1IrQ5qf9lFjvnqPumU3wQQhtlIP8Ny0r+v0d00MbRRxMTE+BmhNDJvObSITQN4dIIlbJjRQUat97PY4NQN3UEpsbOClAvFRzq7/nCuJsGqi9iF4fNqIh0rRpjTVXONIb9yo2kTTlpy5iypcEKOab2p3fRLf/YOXdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 18:31:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 18:31:26 +0000
Date: Thu, 4 Jan 2024 10:31:17 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH v5 9/9] cxl/pci: Register for and process CPER events
Message-ID: <6596f975a413_1587c2945b@iweiny-mobl.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20231220-cxl-cper-v5-9-1bb8a4ca2c7a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231220-cxl-cper-v5-9-1bb8a4ca2c7a@intel.com>
X-ClientProxiedBy: BYAPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:a03:80::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: b65578d6-ac98-4e56-73b0-08dc0d535c87
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41hDugRwuk2K+FUCrM5iJt5vxG2NYucvqaTDO8tI0pVH4fDSbE5Ysv6SvaRbs4WvYE65x6gBBFRRCsyCcoLQAkfWqfV9FT9s8pK5Jwp+gbLZx2ws3Uxrh8ik+BqMpM8gCH/Bn3GUXeHoC8rhchP/Sr9C3dO43R5vTAzElBlpZCIRAYB56BJ0zghZRTXJ384SOMu0EQGwntDaBSwjC1yMHcsQVAHrHVtglmXLclB7RFi8Y3q+Uio8lYqo8YXblCxWpWsKzgOalFClHs0z+xXM2wD5FmRLkkKOb/g16bOBYJgK/F8ZJf8gZTvbff9MTsT/kq6Gw/TdXsw4SPSxmK6pwdGbrgG8TJRIllyblrr5Ild19KBb3VSAPvgt1IysPb9O5hdhYC9SMmkTYBq7GpG6AnS47T5F1SkRncglzMTUpRyn2Kz/DQqM4XuUczC59Z4BZewIOX23djMqcxY24n1vhJTFTdunM3azZLYZ6fT1xjf4khou1LSlXGjAkFYg1gkqZGT8deIg6atNnFyDXBtoCtoMNZwpmk/czmgG7XlrpSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6506007)(41300700001)(66556008)(6512007)(9686003)(66476007)(66946007)(86362001)(966005)(6486002)(38100700002)(82960400001)(107886003)(83380400001)(26005)(2906002)(478600001)(5660300002)(4326008)(44832011)(110136005)(8676002)(54906003)(6666004)(316002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p1AlVu+oRzu1atjJ//4HLbPD4lmXGwAk1H9sA2zxvbkoY9ex/PpikhW96NPo?=
 =?us-ascii?Q?quw/POj772RdSNXAwiFaKp0RiJ7NHP0OLvD4NJYKTzyCNSPpqsKfOr39UuFU?=
 =?us-ascii?Q?SItAwSNcKmNlj7hUKHo6bLIcOc2fb/ycP/UZOTzVf2iuu1KtVrK6oGQhGcuH?=
 =?us-ascii?Q?u7tiJQwB8syGr6zcuc7gRq4OTAkQxADOHjTbAepcIBgGykkXlZF9gA8wyScY?=
 =?us-ascii?Q?r5KCw0eYuA0sK3E+Jk2iQrRo6m+wKURb4wogOh67iMAWyjZ0npciPqvwdnoC?=
 =?us-ascii?Q?APil714Vlwg27At5A/7S6KIphDq13cG+rBepzk9ZxSzd1JJin0w5Ym936kIH?=
 =?us-ascii?Q?sE2juA0/wmf9keVRb4Aqfgr61XZTmg5M+5Js3/T7flh45vgr23JlT3yewqqU?=
 =?us-ascii?Q?Mgk24+n7t+dlDP4eS4caxfo310LeyGMlSdlopIqyUl/iL9L/DKO+jM+u4/1I?=
 =?us-ascii?Q?lPcMMFg6x1uJ4LQG+gueAYRvZvWQG0xOxUHRMHRSD5diHWu8wT5++YOP8kHg?=
 =?us-ascii?Q?nQwxrG/tFULrDj0z4sgLSE7qj7hNFy8U+paJ+qZAQYwmf6eIUf2zCTyNkctq?=
 =?us-ascii?Q?6Y2jSFJ7NLyQj6FxotQqCN4vHqRG6zjie19zcC+KR1Ho8k3KCMHw2qby8EyR?=
 =?us-ascii?Q?sXUfigN+U1StNc7SvKSt6Y5bXKhFujtLZ5pDbx7tPWnDgvLUgo9Z/3riTmKq?=
 =?us-ascii?Q?UxtXvmasODDk9K3lgdb9pwL9o8lvzv4SuiNcXIPTaH1e1dwD77dr/EpTItXc?=
 =?us-ascii?Q?TlAFKf0RS6oeq9hUq9u8ZWc4oe3KvlJIsZdWoV7uI3WKDU3IGKc+5ni8W0F7?=
 =?us-ascii?Q?Mdkr9T+oeq4Djl0aZKdbrcXpmb2Lf43L2PM9wZaDgmg+bs86lhMSrvgGRb4Z?=
 =?us-ascii?Q?z70owkyjpjqJorE7bOsudgZqmgVfRRzqdo1zj7DUexHbpthkn4H7bF6Q8TP5?=
 =?us-ascii?Q?P2Mnc/CyixVQdgoS6C0txFjR8mQCYevnHJAutHXFrOfLohCJrkGgdQyRFUhG?=
 =?us-ascii?Q?3UnbxrmOknHAP/1uexdPLkmD9W5tyJBPTX8n08Za0R2FwhTYV25sp7tjnIgY?=
 =?us-ascii?Q?oF7lTfKndePwYKcrWc4xSDFLDCZImp9T7//xh/KnOt4U4KyyAx4y2F36MjDR?=
 =?us-ascii?Q?oqyI+bzx9sjZHmBBjMILf+fzPfw40SaxT9I01uRLMFGLKcDZMujAhC01+sEj?=
 =?us-ascii?Q?+qv4Q9GW128hx/Ao0lDZNZqfsKzEkmEXjivZgsxnJmlKVPTM2cv0MFsWXW6Y?=
 =?us-ascii?Q?fXTKjN/6xJq1fawbcUwlBZ4r/8CUvqnT3O0HrjNazDhtkla97MSoidMrSQqy?=
 =?us-ascii?Q?tgf/IWZy0BikRKcgD2bIoBXPEwJ5TmlanhbbyHYJ9kgdj/Yt13zPH+wa8q7K?=
 =?us-ascii?Q?XzCusEmpBzFk8xO7X8H4NcssNRnKQjY/Q6XeBKzWgoligD9AYQWQR7B5sBne?=
 =?us-ascii?Q?MVnmBYuqmH26YAtQEJbInFg43sRzunaM711f6Ey428gpTBbrVjWr7Ag1Ot7t?=
 =?us-ascii?Q?P0Tl6rIxfSdI8rI6T6J/+dglj88P+UUsl3G+XkQ69GMjz7eHhuHWqcP8ozrp?=
 =?us-ascii?Q?+wFx0yfb1pKS8xcbqWz7cR7yk5vxd15dRwYzL8zX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b65578d6-ac98-4e56-73b0-08dc0d535c87
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 18:31:26.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+qFTEM65TwEekJyP6m15mz8VFE49svek8iqmivnImT5crri7eRmK0eiZkEYeGt7qk7x3RMJCre3955mySzKbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> If the firmware has configured CXL event support to be firmware first
> the OS can process those events through CPER records.  The CXL layer has
> unique DPA to HPA knowledge and standard event trace parsing in place.
> 
> CPER records contain Bus, Device, Function information which can be used
> to identify the PCI device which is sending the event.
> 
> Change the PCI driver registration to include registration of a CXL
> CPER callback to process events through the trace subsystem.
> 
> Use new scoped based management to simplify the handling of the PCI
> device object.
> 
> NOTE this patch depends on Dan's addition of a device guard[1].
> 
> [1] https://lore.kernel.org/all/170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com/

Somehow this patch lost my signed off by line from V4.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

> 
> ---
> Changes for v5:
> [Smita/djbw: trace a generic UUID if the type is unknown]
> [Jonathan: clean up pci and device state error handling]
> [iweiny: consolidate the trace function]
> ---
>  drivers/cxl/core/mbox.c   | 49 ++++++++++++++++++++++++++++-----------
>  drivers/cxl/cxlmem.h      |  4 ++++
>  drivers/cxl/pci.c         | 58 ++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/cxl-event.h |  1 +
>  4 files changed, 98 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 06957696247b..b801faaccd45 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -836,21 +836,44 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> -static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -				   enum cxl_event_log_type type,
> -				   struct cxl_event_record_raw *record)
> +void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +			    enum cxl_event_log_type type,
> +			    enum cxl_event_type event_type,
> +			    const uuid_t *uuid, union cxl_event *evt)
>  {
> -	union cxl_event *evt = &record->event;
> -	uuid_t *id = &record->id;
> -
> -	if (uuid_equal(id, &CXL_EVENT_GEN_MEDIA_UUID))
> +	switch (event_type) {
> +	case CXL_CPER_EVENT_GEN_MEDIA:
>  		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> -	else if (uuid_equal(id, &CXL_EVENT_DRAM_UUID))
> +		break;
> +	case CXL_CPER_EVENT_DRAM:
>  		trace_cxl_dram(cxlmd, type, &evt->dram);
> -	else if (uuid_equal(id, &CXL_EVENT_MEM_MODULE_UUID))
> +		break;
> +	case CXL_CPER_EVENT_MEM_MODULE:
>  		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
> -	else
> -		trace_cxl_generic_event(cxlmd, type, id, &evt->generic);
> +		break;
> +	case CXL_CPER_EVENT_GENERIC:
> +	default:
> +		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
> +		break;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> +
> +static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +				     enum cxl_event_log_type type,
> +				     struct cxl_event_record_raw *record)
> +{
> +	enum cxl_event_type ev_type = CXL_CPER_EVENT_GENERIC;
> +	const uuid_t *uuid = &record->id;
> +
> +	if (uuid_equal(uuid, &CXL_EVENT_GEN_MEDIA_UUID))
> +		ev_type = CXL_CPER_EVENT_GEN_MEDIA;
> +	else if (uuid_equal(uuid, &CXL_EVENT_DRAM_UUID))
> +		ev_type = CXL_CPER_EVENT_DRAM;
> +	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
> +		ev_type = CXL_CPER_EVENT_MEM_MODULE;
> +
> +	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
>  }
>  
>  static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> @@ -961,8 +984,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  			break;
>  
>  		for (i = 0; i < nr_rec; i++)
> -			cxl_event_trace_record(cxlmd, type,
> -					       &payload->records[i]);
> +			__cxl_event_trace_record(cxlmd, type,
> +						 &payload->records[i]);
>  
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e5d770e26e02..80076c235073 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -802,6 +802,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				  unsigned long *cmds);
>  void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> +void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +			    enum cxl_event_log_type type,
> +			    enum cxl_event_type event_type,
> +			    const uuid_t *uuid, union cxl_event *evt);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..b14237f824cf 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <asm-generic/unaligned.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/moduleparam.h>
>  #include <linux/module.h>
> @@ -969,6 +970,61 @@ static struct pci_driver cxl_pci_driver = {
>  	},
>  };
>  
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
> +	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> +					   device_id->bus_num, devfn);
> +	if (!pdev)
> +		return;
> +
> +	guard(device)(&pdev->dev);
> +	if (pdev->driver != &cxl_pci_driver)
> +		return;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;
> +
> +	/* Fabricate a log type */
> +	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
> +	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
> +
> +	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
> +			       &uuid_null, &rec->event);
> +}
> +
> +static int __init cxl_pci_driver_init(void)
> +{
> +	int rc;
> +
> +	rc = pci_register_driver(&cxl_pci_driver);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_cper_register_callback(cxl_cper_event_call);
> +	if (rc)
> +		pci_unregister_driver(&cxl_pci_driver);
> +
> +	return rc;
> +}
> +
> +static void __exit cxl_pci_driver_exit(void)
> +{
> +	cxl_cper_unregister_callback(cxl_cper_event_call);
> +	pci_unregister_driver(&cxl_pci_driver);
> +}
> +
> +module_init(cxl_pci_driver_init);
> +module_exit(cxl_pci_driver_exit);
>  MODULE_LICENSE("GPL v2");
> -module_pci_driver(cxl_pci_driver);
>  MODULE_IMPORT_NS(CXL);
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 71e3646f7569..17eadee819b6 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -109,6 +109,7 @@ struct cxl_event_record_raw {
>  } __packed;
>  
>  enum cxl_event_type {
> +	CXL_CPER_EVENT_GENERIC,
>  	CXL_CPER_EVENT_GEN_MEDIA,
>  	CXL_CPER_EVENT_DRAM,
>  	CXL_CPER_EVENT_MEM_MODULE,
> 
> -- 
> 2.43.0
> 



