Return-Path: <linux-efi+bounces-194-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F87280F47C
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 18:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C621C20A77
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A29A7D88A;
	Tue, 12 Dec 2023 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+zuyEI/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCC495;
	Tue, 12 Dec 2023 09:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702401874; x=1733937874;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iqLIqczhp/JN4Jj6MXHcIBZDTvC0Z/OyoiKDCJm4JU0=;
  b=P+zuyEI/0oawwOQndMkb02pHqxLUge7zdvQ2DNKinQP7Nx0aRzaSELwu
   GqirENrAXM22VgNmHqMOWNDzX71nZF9litGuhekiAdmy7P332R36pveJR
   6+AUI477TgkR6EAFig4hpWJuaXI4pOwa/NwZWm15LrqVTxSfGQIUuEWi3
   owMci8tqtG3LXmvJ60ftErBxImCZJItuMZzUUzKLUUoaHiBmyN27BKHo0
   xtq9Cn1OBt9Mq2jz/EtMhuj42nixrAKD0NM49L+rBhl57lPpVj7jB0znl
   ZhvF5AOX93XY9BwMRlEE88GPWY8cMXDKh5bPbtxJqpgCARG7ZnynEdruH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="398686365"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="398686365"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 09:24:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="773637362"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="773637362"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 09:24:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 09:24:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 09:24:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 09:24:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNENsUBCijzvX3xaDonX4I13Z70lhWZOGing4RkeWyBUQw/hkDWEm9kfLdm0/fAv1cGsc5O2y2+g+8uUi+vSSz/fMKXyEenMy3wJf4b5ZUlQRM6dR33EI8zjlzni9GcvTYS0giM+QzeeYGYUm4QRn/V53l/6Xf3qw11FEpKcz2d3zH4cWb0o72X52QtTZQ65FRFyYZCcgb6cy0Q6ARG7LLLLtuTTN5ITVmQBNFFhzRdLGQSCFyOkc7fSKOIzBPlxPKz7y/FsA4KYSGaIFvr/eMR7/cLGvfNfjg9epjDNjgPscEQofrRwpyRi1C482ylUCDGis/WXvakPqm/G83OirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anTA5DfHBSn5ocTTYj1KNUqSFQEXcXrIIoY82QWF/ic=;
 b=gFhgrto/FFukKOhKydU/MScJeh5fT+aEXneP2J1L3skvooXrCsQJtDr5VxOySYiTvmVbOUwzbKZ3/CmJHOSXWLIuxcV1b9CxQLVxfGFkR1khHb7RT9mamcuAkq8mHqzd/iuofHEyK8F9rpPekP+XWPSP+hCWBXMwmneFXcA71d2auumydkxZkNpOzfyB5O5TK2ZxEzb65pcMMa5FAhwvnbfS4Oyw5/o5UdfbbS58BIxxYM1OAjkjBnC66Gp0/5yMK1fR0dlGG7KFuH9i4hyGJ+ca/LZg6l6SpJAW4XsRjsRpZ69qU+Aj9Afko4R+nenwUBCX1VdL5YSnVeWgWcu2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5220.namprd11.prod.outlook.com (2603:10b6:610:e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 17:24:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 17:24:29 +0000
Date: Tue, 12 Dec 2023 09:24:21 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2 7/7] cxl/memdev: Register for and process CPER events
Message-ID: <657897453dda8_269bd29492@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231211-cxl-cper-v2-0-c116900ba658@intel.com>
 <20231211-cxl-cper-v2-7-c116900ba658@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231211-cxl-cper-v2-7-c116900ba658@intel.com>
X-ClientProxiedBy: MW4PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:303:83::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e193a1-5b3f-4d06-62a1-08dbfb3732af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7gG1XX/3xZQBUMpgkBUtj2oDKZ3EpMrpydYHQp7bWOSiWPPxp+HvNMeuNEVzv/BOEXZ2gsEclsM4hdchjlw/XhMwZmtJ0PFLp1bD/O+1iftEDgwXQeI+XQqasaPkNGpm2GEnPfSUuhvyMSuOMzWP4XIizglI5D4iykQ/32s7yZpjHyYB3NfIc52VYN58QmmWV380FPJCWN3VGmG6AMVRTKsBpan36tFI9Dr0TR73+aBRTdj+Wv/eqq7c/jnTSPeeNiQnIMOvw23TPvKd/CWLv/OZFHuHG7RpjF2TOsQ/0VKuq37PGmu/3TYc0v+/pTcZd1+/3EVYUBMHVFWWLJNvlETkUtmIZknFyMhMwxTDR79K/BQA73TRBOIkksryMDxLs16IQIcgFRKxeIaEh6/qN4bthjyrH5xWXw4ONVJzgTHXbTDXBbOJBRY7l6j5LAeVAdbA+Lar9vMmB5psuaFGB6KevedLD0gN2LMHOgDECwS9cV7Z3DHr3jQ6tx99Pl4CLzU2ggXk7Vjx4XdgsSxnMcpY45RcEPa8pIpV/k9Us9i1RJ5i76CLZmUQTcqeFKM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66556008)(66476007)(54906003)(82960400001)(66946007)(86362001)(83380400001)(6506007)(107886003)(6512007)(9686003)(8676002)(6486002)(2906002)(316002)(38100700002)(110136005)(6666004)(26005)(478600001)(5660300002)(4326008)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AoR2U4u2DMQAz1zATLNkgZ+7UibuNK+2E8uqzaSwCXQd7QArvxHxKt0ZuafG?=
 =?us-ascii?Q?Yp14o+iIZ0I/Wc1geNMKMyV+y//zosx7facSKhhN+Q4kr6Z80sl6wxKvK8d9?=
 =?us-ascii?Q?VNJcWYhawfdEE9QxPTAoQlgCfpeg1r1jmJ8u7GTd4JnhKgsSO3JnQY0WXUIb?=
 =?us-ascii?Q?OqWkciphG3uzMF5FIAnyjoQ6qBY0AhT9wU6dVXu/VVhvFXz3rPgCvlayMRrf?=
 =?us-ascii?Q?8HuMAcrmA//4EwDWENlFqLE/MMNBqXO3TqoAw6pfWQOoZ17WanhT6spOyPNa?=
 =?us-ascii?Q?/JFiXbJTHTrNii4115T0svnxcH4J/eCmCGj+vDDglNlSTQ9nJwMykxTTTAjo?=
 =?us-ascii?Q?nhmjt1X6/nL2NZ8GEVGJy30pL2XskuP1mrG2WJFqyGA2wt1Yt64nJ5CaN+Va?=
 =?us-ascii?Q?Q3rUOWLJwtWgZcaHtoijXpp7tOfxPcz/BneQdhQPgnBLsB0rIRYfjcMXKnIs?=
 =?us-ascii?Q?JvXsa2k5eMDHZ98gWPo8stOkb3JtJSVuLTrcVtAibAR9tAiKSP3Gqa0hqgVT?=
 =?us-ascii?Q?D678DvtKtajidW2hu4XLJiakLegaMMF2xWaVM2Na/KRc9pFFz5/AmRXmN9gE?=
 =?us-ascii?Q?ob4FEyX8mfQZA9YBneI8GbIer8h06qIdSkGF/tpLfw/zdVQ7OARrL3PvtWkV?=
 =?us-ascii?Q?8Kl9sbvfUP2sBTUPLzPlorXCdLTRrsg/09iXcI2fRefXLGwnvkpds8SRMhTs?=
 =?us-ascii?Q?rcbIErS2GKOkirfXAQVuGS/carhERpbbaR85+LQHBINSMKaiSbzAG2BThDDu?=
 =?us-ascii?Q?kiSjCrSQToMC+Ody4ViXj0VSYMqmt2nSYM97ajZ7yCINTeAJiRiiIfSIgSm+?=
 =?us-ascii?Q?WLsNgSetn4cdsyrsSeXymetEKnfve6K/2wI4OyHCYd1VjmISfZZwtxsLNi7F?=
 =?us-ascii?Q?bKJXU6L9U4bo1ty0qq+MkW/dKgTvPqNqLHDC7+MVPNavc7MaOOH2fCyqi50/?=
 =?us-ascii?Q?SoAFyCAr8S4j+rqyLjQzMrrHApWrqjJU5AT54NtlBrM3wXzkUSGXQxStQs8f?=
 =?us-ascii?Q?lfGYFH5gpGFJ5spcDc/V090JKxwzpqv0fc/EQjQhpIyn5rxIFljhDx7atAhs?=
 =?us-ascii?Q?zGjRvjSvfgoVfJWANL0AR4tf4gOKHevAWmtgRipG65Mr7X/FSJBm/WFsPK4r?=
 =?us-ascii?Q?QP4jIDEvfxs3lDy2RSSMv7w9MWWN+AnussEpdQhv/98RIHzlt4CsuXjZW0tp?=
 =?us-ascii?Q?yHm1pujqDBL+NolzkP1sNiq53zE0Q0+tLPR/9tUjvCAdrRC3uGuvdrbGmeZB?=
 =?us-ascii?Q?r1CaQAdX3H+olfN/kLZkTb7bE8XDrzS/wb1G2/83cmiGjmqcNqTzIzu9q0eh?=
 =?us-ascii?Q?oYqI4yZFLn2l98Pw9nMejxGqjP3oEFbFN4JrlkTaqdwYiW8HaVA6C4l89TY3?=
 =?us-ascii?Q?aHWeEvWrSJZoiMRp3JdrwiGrZiFmPQMCHVJ0NA9ShmworEHN0/tQ3KQjVzmB?=
 =?us-ascii?Q?3W4P1Dr6X2uKuqwi1fbzLVRxcNeGQZlrBj2FKnjrc619n8sYhAo+/quzcaru?=
 =?us-ascii?Q?gxzDEoygICmQ0qX8awx2R3N4GsVJ0QgO7vGKFMdYZDM94PRKDcNQhIQ+LoqQ?=
 =?us-ascii?Q?HN0+Y2UckkRSgCc5LYOZq5tWxdshm8Jzlju18qG4yZBY74eD3178vdygackz?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e193a1-5b3f-4d06-62a1-08dbfb3732af
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 17:24:29.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zpmh6IC/RvSlVCnYGo649EYkoO/C4ZokSXR1d/f8QPzMyowO23FnV7Uyg5tDRMbVNsxlTcY8Tj5qyAD/T3254bTBPPiyTyDTM/+OFgGYPIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5220
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> If the firmware has configured CXL event support to be firmware first
> the OS can process those events through CPER records.  The CXL layer has
> unique DPA to HPA knowledge and standard event trace parsing in place.
> 
> CPER records contain Bus, Device, Function information which can be used
> to identify the PCI device which is sending the event.
> 
> Change pci driver registration to include registration for a CXL CPER
> callback to process the events through the trace subsystem.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v1:
> [djbw: use single registration function]
> ---
>  drivers/cxl/core/mbox.c | 31 ++++++++++++++++++++++++-----
>  drivers/cxl/cxlmem.h    |  6 ++++++
>  drivers/cxl/pci.c       | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 83 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a67161f8764a..da262bbc3519 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -854,9 +854,30 @@ static const uuid_t dram_event_uuid = CXL_EVENT_DRAM_UUID;
>   */
>  static const uuid_t mem_mod_event_uuid = CXL_EVENT_MEM_MODULE_UUID;
>  
> -static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -				   enum cxl_event_log_type type,
> -				   struct cxl_event_record_raw *record)
> +void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +			    enum cxl_event_log_type type,
> +			    enum cxl_event_type event_type,
> +			    union cxl_event *event)
> +{
> +	switch (event_type) {
> +	case CXL_CPER_EVENT_GEN_MEDIA:
> +		trace_cxl_general_media(cxlmd, type, &gen_media_event_uuid,
> +					&event->gen_media);
> +		break;
> +	case CXL_CPER_EVENT_DRAM:
> +		trace_cxl_dram(cxlmd, type, &dram_event_uuid, &event->dram);
> +		break;
> +	case CXL_CPER_EVENT_MEM_MODULE:
> +		trace_cxl_memory_module(cxlmd, type, &mem_mod_event_uuid,
> +					&event->mem_module);
> +		break;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> +
> +static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +				     enum cxl_event_log_type type,
> +				     struct cxl_event_record_raw *record)
>  {
>  	union cxl_event *evt = &record->event;
>  	uuid_t *id = &record->id;
> @@ -979,8 +1000,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
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
> index e5d770e26e02..7a891b4641cc 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -481,6 +481,8 @@ struct cxl_memdev_state {
>  	struct cxl_security_state security;
>  	struct cxl_fw_state fw;
>  
> +	struct notifier_block cxl_cper_nb;
> +
>  	struct rcuwait mbox_wait;
>  	int (*mbox_send)(struct cxl_memdev_state *mds,
>  			 struct cxl_mbox_cmd *cmd);
> @@ -802,6 +804,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				  unsigned long *cmds);
>  void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> +void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +			    enum cxl_event_log_type type,
> +			    enum cxl_event_type event_type,
> +			    union cxl_event *event);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..30a98399d013 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <asm-generic/unaligned.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/moduleparam.h>
>  #include <linux/module.h>
> @@ -969,6 +970,55 @@ static struct pci_driver cxl_pci_driver = {
>  	},
>  };
>  
> +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> +static void cxl_cper_event_call(struct cxl_cper_event_data *ev_data)
> +{
> +	struct cper_cxl_event_devid *device_id = &ev_data->rec->hdr.device_id;
> +	struct cxl_dev_state *cxlds = NULL;
> +	enum cxl_event_log_type log_type;
> +	struct pci_dev *pdev;
> +	unsigned int devfn;
> +	u32 hdr_flags;
> +
> +	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> +					   device_id->bus_num, devfn);

What if pci_get_domain_bus_and_slot() returned NULL?

> +
> +	guard(mutex)(&pdev->dev.mutex);

Lets not open code this since device_lock() is so prevalent it deserves
its own guard() type:

DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))

> +	if (pdev->driver == &cxl_pci_driver)
> +		cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		goto out;

Lets not mix usage of cleanup.h helpers with usage of goto. The helpers
are there to eliminate goto errors. Just add a new helper:

DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))

...and declare @pdev as:

struct pci_dev *pdev __free(pci_dev_put) = NULL;

> +
> +	/* Fabricate a log type */
> +	hdr_flags = get_unaligned_le24(ev_data->rec->event.generic.hdr.flags);
> +	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
> +
> +	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_data->event_type,
> +			       &ev_data->rec->event);
> +out:
> +	pci_dev_put(pdev);
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
> +	cxl_cper_register_notifier(cxl_cper_event_call);
> +	return 0;
> +}
> +
> +static void __exit cxl_pci_driver_exit(void)
> +{
> +	cxl_cper_unregister_notifier();
> +	pci_unregister_driver(&cxl_pci_driver);
> +}
> +
> +module_init(cxl_pci_driver_init);
> +module_exit(cxl_pci_driver_exit);
>  MODULE_LICENSE("GPL v2");
> -module_pci_driver(cxl_pci_driver);
>  MODULE_IMPORT_NS(CXL);
> 
> -- 
> 2.43.0
> 



