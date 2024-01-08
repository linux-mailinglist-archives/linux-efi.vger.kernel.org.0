Return-Path: <linux-efi+bounces-356-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9BA827052
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jan 2024 14:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC481F22AF0
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jan 2024 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D8045944;
	Mon,  8 Jan 2024 13:50:12 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6086C45BE1;
	Mon,  8 Jan 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7wNj6VDyz67NNV;
	Mon,  8 Jan 2024 21:47:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E4007140A86;
	Mon,  8 Jan 2024 21:50:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 13:50:06 +0000
Date: Mon, 8 Jan 2024 13:50:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, "Davidlohr Bueso" <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ard
 Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] cxl/pci: Register for and process CPER events
Message-ID: <20240108135005.0000288f@Huawei.com>
In-Reply-To: <20231220-cxl-cper-v5-9-1bb8a4ca2c7a@intel.com>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
	<20231220-cxl-cper-v5-9-1bb8a4ca2c7a@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 20 Dec 2023 16:17:36 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

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
> 
One trivial comment inline.
The guard change Dan suggests makes sense.  Otherwise I'm fine with this.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'll bolt in the other stuff I need to test it from QEMU this week.
Did the protocol error first, but these are easy to add now I have
that working,

Jonathan
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

Might as well return directly and save a reviewer having to check if anything else happens
after the switch

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




