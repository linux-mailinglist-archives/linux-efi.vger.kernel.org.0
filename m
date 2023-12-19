Return-Path: <linux-efi+bounces-259-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BF1818A3C
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 15:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178F01C20A44
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B791805C;
	Tue, 19 Dec 2023 14:40:50 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C71BDCB;
	Tue, 19 Dec 2023 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SvfTn6Yx5z6JB74;
	Tue, 19 Dec 2023 22:39:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 95B01140D26;
	Tue, 19 Dec 2023 22:40:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 14:37:34 +0000
Date: Tue, 19 Dec 2023 14:37:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, "Davidlohr Bueso" <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ard
 Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH v4 7/7] cxl/memdev: Register for and process CPER events
Message-ID: <20231219143732.0000181e@Huawei.com>
In-Reply-To: <20231215-cxl-cper-v4-7-01b6dab44fcd@intel.com>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
	<20231215-cxl-cper-v4-7-01b6dab44fcd@intel.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 15 Dec 2023 15:26:33 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> If the firmware has configured CXL event support to be firmware first
> the OS can process those events through CPER records.  The CXL layer has
> unique DPA to HPA knowledge and standard event trace parsing in place.
> 
> CPER records contain Bus, Device, Function information which can be used
> to identify the PCI device which is sending the event.
> 
> Change pci driver registration to include registration for a CXL CPER
> notifier to process the events through the trace subsystem.
> 
> Define and use scoped based management to simplify the handling of the
> pci device object.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

I'd break out the pci guard stuff as a precursor patch.  That's likely
to be used elsewhere so it would help for backporting for other users
if it wasn't buried in a patch doing other stuff.

Not to mention that has a different set of likely reviewers to the rest
of this patch.

More generally maybe we should just hardcode the UUID in the tracepoint
definitions?  I think for everything other than the generic one we
only ever call trace_cxl_memory_module(... &mem_mod_event_uuid..)
etc.

It's a little ugly to match on the UUID to call a function where it
hard coded, but less so than inserting the UUID like this does.
Better I think to make it obvious that this isn't actually a variable
(for the ones we understand).

Jonathan

> 
> ---
> NOTE this patch depends on Dan's addition of a device guard[1].
> 
> [1] https://lore.kernel.org/all/170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com/
> 
> Changes for v3/v4:
> [djbw: define a __free(pci_dev_put) to release the device automatically]
> [djbw: use device guard from Vishal]
> [iweiny: delete old notifier block structure]
> [iweiny: adjust for new notifier interface]
> ---
>  drivers/cxl/core/mbox.c | 31 +++++++++++++++++++++++-----
>  drivers/cxl/cxlmem.h    |  4 ++++
>  drivers/cxl/pci.c       | 55 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pci.h     |  2 ++
>  4 files changed, 86 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b7efa058a100..c9aa723e3391 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -840,9 +840,30 @@ static const uuid_t gen_media_event_uuid = CXL_EVENT_GEN_MEDIA_UUID;
>  static const uuid_t dram_event_uuid = CXL_EVENT_DRAM_UUID;
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
> @@ -965,8 +986,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
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

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..638275569d63 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <asm-generic/unaligned.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/moduleparam.h>
>  #include <linux/module.h>
> @@ -969,6 +970,58 @@ static struct pci_driver cxl_pci_driver = {
>  	},
>  };
>  
> +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> +static void cxl_cper_event_call(enum cxl_event_type ev_type,
> +				struct cxl_cper_event_rec *rec)
> +{
> +	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> +	struct cxl_dev_state *cxlds = NULL;
> +	enum cxl_event_log_type log_type;
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
> +	if (pdev->driver == &cxl_pci_driver)
> +		cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;

This is handling two conditions. I'd find it more readable split like:

	if (pdev->driver != &cxl_pci_driver)
		return;

	cxlds = pci_get_drvdata(pdev);
	if (!cxlds)
		return;

and drop the = NULL above.

> +
> +	/* Fabricate a log type */
> +	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
> +	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
> +
> +	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type, &rec->event);
> +}
> +


