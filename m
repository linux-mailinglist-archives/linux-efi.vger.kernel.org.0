Return-Path: <linux-efi+bounces-1183-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043989008CB
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2024 17:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91578284A3C
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2024 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872851953AA;
	Fri,  7 Jun 2024 15:26:30 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2831854660;
	Fri,  7 Jun 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773990; cv=none; b=pmWs+TqyGfDjgduMpkSEBy0/G0CTr2HL77iMQ6mbOtmTmxp0OYmO3tXMMc8L9jL+v6plJ6lFEeZUqJo+NIXXPNBv28Jtr7A19TF7gsmRb2J0UJcGUiIxpOs0skPMHWqHwUMzPdqnnh2YiaSRqq6832dsVLQ2zm55NtVMNK+9BSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773990; c=relaxed/simple;
	bh=lBO/t1yfjg2Yjj4AQQYnYMarQ3NUyTiqyq8jIAHT2YE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXhSPtL8fq9yac7T0wP28xxH6wPlzolf8tbqp0IsBmTJM+bBW0kbQvYszHAVuRmLlhYJfWyOz2QMvyelP7Z142t6yCLZ5RH0mlS0T4emSu2pqdRaV/driKCpcg2ZxZrUwq1kbvt3B3DbjgLFvt797OHA2O1SvJlTPSO4VYJ7m2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwlPf1hbLz6D95T;
	Fri,  7 Jun 2024 23:25:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4ACC91400CD;
	Fri,  7 Jun 2024 23:26:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 16:26:23 +0100
Date: Fri, 7 Jun 2024 16:26:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Bowman
 Terry" <terry.bowman@amd.com>
Subject: Re: [PATCH 2/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
Message-ID: <20240607162622.00000819@Huawei.com>
In-Reply-To: <09e0d961-e19f-30d6-5306-1b35609b7d79@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
	<20240522150839.27578-3-Smita.KoralahalliChannabasappa@amd.com>
	<Zk6H5jTdVfN4aFhF@aschofie-mobl2>
	<09e0d961-e19f-30d6-5306-1b35609b7d79@amd.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 23 May 2024 14:21:40 -0700
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Hi Alison,
> 
> On 5/22/2024 5:03 PM, Alison Schofield wrote:
> > On Wed, May 22, 2024 at 03:08:37PM +0000, Smita Koralahalli wrote:  
> >> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
> >>
> >> Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
> >> Severity, Device ID, Device Serial number and CXL RAS capability struct in
> >> struct cxl_cper_prot_err. Include this struct as a member of struct
> >> cxl_cper_work_data.
> >>
> >> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> >> ---
> >>   drivers/acpi/apei/ghes.c        | 10 +++++
> >>   drivers/firmware/efi/cper_cxl.c | 66 +++++++++++++++++++++++++++++++++
> >>   include/linux/cxl-event.h       | 26 +++++++++++++
> >>   3 files changed, 102 insertions(+)
> >>
> >> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> >> index 623cc0cb4a65..1a58032770ee 100644
> >> --- a/drivers/acpi/apei/ghes.c
> >> +++ b/drivers/acpi/apei/ghes.c
> >> @@ -717,6 +717,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
> >>   	schedule_work(cxl_cper_work);
> >>   }
> >>   
> >> +static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
> >> +{
> >> +	struct cxl_cper_work_data wd;
> >> +
> >> +	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_err))
> >> +		return;
> >> +}
> >> +
> >>   int cxl_cper_register_work(struct work_struct *work)
> >>   {
> >>   	if (cxl_cper_work)
> >> @@ -791,6 +799,8 @@ static bool ghes_do_proc(struct ghes *ghes,
> >>   			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> >>   
> >>   			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
> >> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> >> +			cxl_cper_handle_prot_err(gdata);
> >>   		} else {
> >>   			void *err = acpi_hest_get_payload(gdata);
> >>   
> >> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> >> index 4fd8d783993e..03b9839f3b73 100644
> >> --- a/drivers/firmware/efi/cper_cxl.c
> >> +++ b/drivers/firmware/efi/cper_cxl.c
> >> @@ -8,6 +8,7 @@
> >>    */
> >>   
> >>   #include <linux/cper.h>
> >> +#include <acpi/ghes.h>
> >>   #include "cper_cxl.h"
> >>   
> >>   #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> >> @@ -44,6 +45,17 @@ enum {
> >>   	USP,	/* CXL Upstream Switch Port */
> >>   };
> >>   
> >> +static enum cxl_aer_err_type cper_severity_cxl_aer(int cper_severity)
> >> +{
> >> +	switch (cper_severity) {
> >> +	case CPER_SEV_RECOVERABLE:
> >> +	case CPER_SEV_FATAL:
> >> +		return CXL_AER_UNCORRECTABLE;
> >> +	default:
> >> +		return CXL_AER_CORRECTABLE;
> >> +	}
> >> +}
> >> +
> >>   void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
> >>   {
> >>   	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
> >> @@ -176,3 +188,57 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
> >>   			       sizeof(cxl_ras->header_log), 0);
> >>   	}
> >>   }
> >> +
> >> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
> >> +				  struct cxl_cper_prot_err *p_err)
> >> +{
> >> +	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> >> +	u8 *dvsec_start, *cap_start;
> >> +
> >> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID)) {
> >> +		pr_err(FW_WARN "No Device ID\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	/*
> >> +	 * The device ID or agent address is required for CXL RCD, CXL
> >> +	 * SLD, CXL LD, CXL Fabric Manager Managed LD, CXL Root Port,
> >> +	 * CXL Downstream Switch Port and CXL Upstream Switch Port.
> >> +	 */
> >> +	if (prot_err->agent_type <= 0x7 && prot_err->agent_type != RCH_DP) {  
> > 
> > For this check against agent_type, and the similar one below, would a boolean
> > array indexed by the agent type work? That would avoid the <= 0x7 and > 0x4
> > below. It seems one array would suffice for this case, but naming it isn't obvious
> > to me. Maybe it'll be to you.
> > 
> > Something similar to what is done for prot_err_agent_type_strs[]
> > 
> > static const bool agent_requires_id_address_serial[] = {
> > 	true,	/* RDC */ 	
> > 	false,	/* RCH_DP */
	[RCD] = false,

etc rather than comments would be neater.
Given two similar things already. Maybe time for a little structure.

//with better name than this
struct agent_reqs {
	bool sn;
	bool sbdf;
};

static const agent_reqs agent_reqs[] = {
	[RCD] = { .sn = false, .sbdf = true, },
};

etc.

Maybe just bring the the string in as well

struct agent_info {
	const char *string;
	bool req_sn;
	bool req_sbdf;
};

static const agent_info agent_info[] = {
	[RD] = {
		.string = "Restricted CXL Device",
		.req_sn = false,
		.req_sbdf = true,
	},
};

Values made up, but hopefully conveys that moving to having
all the data in one place makes it harder to forget stuff
for new entries etc.

> > 	.
> > 	.
> > 	.
> > };
> > 
> >   
> 
> Noted. Will implement it this way!
> 
> Thanks
> Smita
> 
> >> +		p_err->segment = prot_err->agent_addr.segment;
> >> +		p_err->bus = prot_err->agent_addr.bus;
> >> +		p_err->device = prot_err->agent_addr.device;
> >> +		p_err->function = prot_err->agent_addr.function;
> >> +	} else {
> >> +		pr_err(FW_WARN "Invalid agent type\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> >> +		pr_err(FW_WARN "Invalid Protocol Error log\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	dvsec_start = (u8 *)(prot_err + 1);
> >> +	cap_start = dvsec_start + prot_err->dvsec_len;
> >> +	p_err->cxl_ras = *(struct cxl_ras_capability_regs *)cap_start;
> >> +
> >> +	/*
> >> +	 * Set device serial number unconditionally.
> >> +	 *
> >> +	 * Print a warning message if it is not valid. The device serial
> >> +	 * number is required for CXL RCD, CXL SLD, CXL LD and CXL Fabric
> >> +	 * Manager Managed LD.
> >> +	 */
> >> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
> >> +	      prot_err->agent_type > 0x4 || prot_err->agent_type == RCH_DP)  
> > 
> > then this also can be replaced with
> > 		agent_requires_id_address_serial[prot_err->agent_type]
> > 
> > 
> > -- Alison
> > 
> >   
> >> +		pr_warn(FW_WARN "No Device Serial number\n");
> >> +
> >> +	p_err->lower_dw = prot_err->dev_serial_num.lower_dw;
> >> +	p_err->upper_dw = prot_err->dev_serial_num.upper_dw;
> >> +
> >> +	p_err->severity = cper_severity_cxl_aer(gdata->error_severity);
> >> +
> >> +	return 0;
> >> +}  
> > 
> > snip
> >   


