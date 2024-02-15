Return-Path: <linux-efi+bounces-566-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E78562ED
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 13:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF6B1C20BD8
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA2E12BF17;
	Thu, 15 Feb 2024 12:18:05 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F302913FF5;
	Thu, 15 Feb 2024 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999485; cv=none; b=KqlLPpkjiEzmORS9GoE28ZhnPVixDDxf4eDswMnznz66qHI/0eVQrFlB2cfpLmLIqa6IsppZYU/ELWm5Yk0Fos6o/KiBu9mlbf/X4RJHr9/YhE5DjIoPoTRowUBRAz5pt0kdDBSya+0AEKs2nLmKrHL0tqfT89m50ENA+7liL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999485; c=relaxed/simple;
	bh=tzhtE5BnzSpYRfyiFDKGyPHBSmlkv7rCykm0IkMdLYw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLSITt2j2xWYDWfnec1HrJmjyEbtJrp/nsI7pGLjHdTPiNXPlDmSex5AW89VFB5Gr4juBztZuvqATEPXwCUTeu4QL8q067Ba1/ENlsYo8oOGcKeaWpDcaonfalqrxWU76VS5V+HEf43D6Sd1q4NnyiljeVoilzbpPMQfP5HGBFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbDWq4lQvz6K7LS;
	Thu, 15 Feb 2024 20:14:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 46D451400D4;
	Thu, 15 Feb 2024 20:17:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 12:17:58 +0000
Date: Thu, 15 Feb 2024 12:17:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 3/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
Message-ID: <20240215121757.00005e72@Huawei.com>
In-Reply-To: <20240109034755.100555-4-Smita.KoralahalliChannabasappa@amd.com>
References: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com>
	<20240109034755.100555-4-Smita.KoralahalliChannabasappa@amd.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 9 Jan 2024 03:47:54 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
> 
> Add GHES support to detect CXL CPER Protocol record and cache error
> severity, device_id, serial number and CXL RAS capability struct in
> struct cxl_cper_event_info.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	Change to sub-struct for protocol error specific elemenets.
> 	Set serial number unconditionally.
> 	Copy entire cxl_ras_capability_regs struct rather than pointer.
> 	Calculate error severity in efi/cper and change to enum.
> ---
>  drivers/acpi/apei/ghes.c        | 11 ++++++
>  drivers/firmware/efi/cper_cxl.c | 68 +++++++++++++++++++++++++++++++++
>  include/linux/cxl-event.h       | 13 +++++++
>  3 files changed, 92 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 60b615d361d3..1d4f3d68a0bc 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -714,6 +714,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  		cper_callback(event_type, &info);
>  }
>  
> +void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
> +{
> +	struct cxl_cper_event_info info;
> +
> +	if (cxl_cper_handle_prot_err_info(gdata, &info))
> +		return;
> +}
> +
>  int cxl_cper_register_callback(cxl_cper_callback callback)
>  {
>  	guard(rwsem_write)(&cxl_cper_rw_sem);
> @@ -768,6 +776,9 @@ static bool ghes_do_proc(struct ghes *ghes,
>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>  			queued = ghes_handle_arm_hw_error(gdata, sev);
>  		}
> +		else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> +			cxl_cper_handle_prot_err(gdata);
> +		}
>  		else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>  			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index 4fd8d783993e..9b9b8c8f1157 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/cper.h>
> +#include <acpi/ghes.h>
>  #include "cper_cxl.h"
>  
>  #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> @@ -44,6 +45,17 @@ enum {
>  	USP,	/* CXL Upstream Switch Port */
>  };
>  
> +static enum cxl_aer_err_type cper_severity_cxl_aer(int cper_severity)
> +{
> +	switch (cper_severity) {
> +	case CPER_SEV_RECOVERABLE:
> +	case CPER_SEV_FATAL:
> +		return CXL_AER_UNCORRECTABLE;
> +	default:
> +		return CXL_AER_CORRECTABLE;
> +	}
> +}
> +
>  void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
>  {
>  	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
> @@ -176,3 +188,59 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>  			       sizeof(cxl_ras->header_log), 0);
>  	}
>  }
> +
> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
> +				  struct cxl_cper_event_info *info)
> +{
> +	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> +	struct cper_cxl_event_devid *device_id = &info->rec.hdr.device_id;
> +	struct cper_cxl_event_sn *dev_serial_num =  &info->rec.hdr.dev_serial_num;
> +	size_t size = sizeof(*prot_err) + prot_err->dvsec_len;

Not obvious what this is size of.  I'd rename it to reflect that's only
the distance to the end of the dvsec copy.
Or just compute the pointer below directly by putting this maths inline.

> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> +		pr_err(FW_WARN "Not a valid protocol error log\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID)) {
> +		pr_err(FW_WARN "Not a valid Device ID\n");
"No device ID\n"
is more accurate description.

I'd move this down to next to where we check the data is valid.
So keep each validity check next to where it matters rather than
a bunch of checks up here.  (mostly because I started writing you
didn't check it was valid down there before remembering this
earlier code :)

> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Set device serial number unconditionally.
> +	 *
> +	 * Print a warning message if it is not valid. The device serial
> +	 * number is considered valid for CXL 1.1 device, CXL 2.0 device,
is required for
perhaps?  These all got renamed in the CXL spec.  We should use that naming
because it deliberately avoids limiting to particular spec versions.
	CXL RCD, CXL SLD, CXL LD, 
> +	 * CXL 2.0 Logical device, or CXL 2.0 Fabric Manager Managed
> +	 * Logical Device.

Not sure what this is now called.. :(


> +	 */
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
> +	      prot_err->agent_type > 0x4 || prot_err->agent_type == RCH_DP)
> +		pr_warn(FW_WARN "Not a valid serial number\n");
> +
> +	dev_serial_num->lower_dw = prot_err->dev_serial_num.lower_dw;
> +	dev_serial_num->upper_dw = prot_err->dev_serial_num.upper_dw;
> +
> +	/*
> +	 * The device ID or agent address is only valid for CXL 1.1 device,
> +	 * CXL 2.0 device, CXL 2.0 Logical device, CXL 2.0 Fabric Manager
> +	 * Managed Logical Device, CXL Root Port, CXL Downstream Switch
> +	 * Port, or CXL Upstream Switch Port.
> +	 */
> +	if (prot_err->agent_type <= 0x7 && prot_err->agent_type != RCH_DP) {

> +		device_id->segment_num = prot_err->agent_addr.segment;
> +		device_id->bus_num = prot_err->agent_addr.bus;
> +		device_id->device_num = prot_err->agent_addr.device;
> +		device_id->func_num = prot_err->agent_addr.function;
> +	} else {
> +		pr_err(FW_WARN "Not a valid agent type\n");
> +		return -EINVAL;
> +	}
> +
> +	info->p_err.cxl_ras = *(struct cxl_ras_capability_regs *)((long)prot_err + size);

Casting to a long isn't nice. Keep it as a pointer for this maths
a u8 * or void * would work.  Particularly if you did it as something
a bit more self documenting like

u8 *dvsec_start = (u8 *)(prot_err + 1);
u8 *cap_start = dvsec_start + prot_err->dvsec_length;

info->p_err.cxl_ras = *(struct cxl_ras_capability_regs *)cap_start;

> +
> +	info->p_err.severity = cper_severity_cxl_aer(gdata->error_severity);
> +
> +	return 0;
> +}


