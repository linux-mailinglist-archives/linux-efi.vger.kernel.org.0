Return-Path: <linux-efi+bounces-4519-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C14FFB1EBCB
	for <lists+linux-efi@lfdr.de>; Fri,  8 Aug 2025 17:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9D71C80C9F
	for <lists+linux-efi@lfdr.de>; Fri,  8 Aug 2025 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A928469A;
	Fri,  8 Aug 2025 15:22:17 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3AC283FE9;
	Fri,  8 Aug 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666537; cv=none; b=ZOJQ9sNX5j0ulRzbCtJUyQLVW/7PVQMW21El0MMMBHqC1EMvWdwnZx4jqKuyS5uk6PTlWCmZriHOV4/4plecT0XsMCXU7mETu96thSBzt8oYB3mRBhkGhojWQhyka3gGmiostMEJUdwWvkoDsuYX9jrODiL58M5FZa45BbEipKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666537; c=relaxed/simple;
	bh=DkHkm43QbebMdGxyrXPLbcaF0/UO96vMSME/mk2C7KQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1ZJ91Bb8tQ03MtNCynEhHlpxgCQIO26cTLB8VHFMHeCPgHC0sEl+OIvbiTHawoP/WwlzwtlmXxxQkuyOfOO0+P+lAgWrVuEPzx1ZSJrTzYmcI4hKbj4ctqziPxCpHCbgSgeWYnNh5opakrOCS+WUriuf4gA3YPl5XCSdbIcalA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz7513HRFz6K9DZ;
	Fri,  8 Aug 2025 23:20:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A68FD140427;
	Fri,  8 Aug 2025 23:22:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 17:22:10 +0200
Date: Fri, 8 Aug 2025 16:22:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Daniel Ferguson <danielf@os.amperecomputing.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "James
 Morse" <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-edac@vger.kernel.org>, Jason Tian
	<jason@os.amperecomputing.com>, Shengwei Luo <luoshengwei@huawei.com>, Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 1/5] RAS: Report all ARM processor CPER information
 to userspace
Message-ID: <20250808162209.000068f5@huawei.com>
In-Reply-To: <20250805-mauro_v3-v6-16-rev2-v4-1-ea538759841c@os.amperecomputing.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
	<20250805-mauro_v3-v6-16-rev2-v4-1-ea538759841c@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 05 Aug 2025 11:35:38 -0700
Daniel Ferguson <danielf@os.amperecomputing.com> wrote:

> From: Jason Tian <jason@os.amperecomputing.com>
> 
> The ARM processor CPER record was added in UEFI v2.6 and remained
> unchanged up to v2.10.
> 
> Yet, the original arm_event trace code added by
> 
>   e9279e83ad1f ("trace, ras: add ARM processor error trace event")
> 
> is incomplete, as it only traces some fields of UAPI 2.6 table N.16, not
> exporting any information from tables N.17 to N.29 of the record.
> 
> This is not enough for the user to be able to figure out what has
> exactly happened or to take appropriate action.
> 
> According to the UEFI v2.9 specification chapter N2.4.4, the ARM
> processor error section includes:
> 
> - several (ERR_INFO_NUM) ARM processor error information structures
>   (Tables N.17 to N.20);
> - several (CONTEXT_INFO_NUM) ARM processor context information
>   structures (Tables N.21 to N.29);
> - several vendor specific error information structures. The
>   size is given by Section Length minus the size of the other
>   fields.
> 
> In addition, it also exports two fields that are parsed by the GHES
> driver when firmware reports it, e.g.:
> 
> - error severity
> - CPU logical index
> 
> Report all of these information to userspace via a the ARM tracepoint so
> that userspace can properly record the error and take decisions related
> to CPU core isolation according to error severity and other info.
> 
> The updated ARM trace event now contains the following fields:
> 
> ======================================  =============================
> UEFI field on table N.16                ARM Processor trace fields
> ======================================  =============================
> Validation                              handled when filling data for
>                                         affinity MPIDR and running
>                                         state.
> ERR_INFO_NUM                            pei_len
> CONTEXT_INFO_NUM                        ctx_len
> Section Length                          indirectly reported by
>                                         pei_len, ctx_len and oem_len
> Error affinity level                    affinity
> MPIDR_EL1                               mpidr
> MIDR_EL1                                midr
> Running State                           running_state
> PSCI State                              psci_state
> Processor Error Information Structure   pei_err - count at pei_len
> Processor Context                       ctx_err- count at ctx_len
> Vendor Specific Error Info              oem - count at oem_len
> ======================================  =============================
> 
> It should be noted that decoding of tables N.17 to N.29, if needed, will
> be handled in userspace. That gives more flexibility, as there won't be
> any need to flood the kernel with micro-architecture specific error
> decoding.
> 
> Also, decoding the other fields require a complex logic, and should be
> done for each of the several values inside the record field.  So, let
> userspace daemons like rasdaemon decode them, parsing such tables and
> having vendor-specific micro-architecture-specific decoders.
> 
>   [mchehab: modified description, solved merge conflicts and fixed coding style]
> 
> Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
> 

Fixes tag is part of the main tag block so no blank line here.
There are at least some scripts running on the kernel tree that trip
up on this (and one that moans at the submitter ;)

I'd also add something to explain the SoB sequence for the curious.

> Co-developed-by: Jason Tian <jason@os.amperecomputing.com>

Jason's the Author, so shouldn't have a Co-dev tag.
There is some info on this in
https://docs.kernel.org/process/submitting-patches.html

> Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
> Co-developed-by: Shengwei Luo <luoshengwei@huawei.com>
> Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
> Co-developed-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>

As person submitting I'd normally expect your SoB last.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I guess this is because Mauro posted an earlier version in which
case this is arguably correct, but likely to confuse.
For cases like this I add comments.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section

A couple of trivial things inline.

> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index a6e4792a1b2e9239f44f29102a7cc058d64b93ef..179b1744df71ee1eac28718628d550075c480cd5 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -52,9 +52,46 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
>  	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
>  }
>  
> -void log_arm_hw_error(struct cper_sec_proc_arm *err)
> +void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
>  {
> -	trace_arm_event(err);
> +	struct cper_arm_err_info *err_info;
> +	struct cper_arm_ctx_info *ctx_info;
> +	u8 *ven_err_data;
> +	u32 ctx_len = 0;
> +	int n, sz, cpu;
> +	s32 vsei_len;
> +	u32 pei_len;
> +	u8 *pei_err;
> +	u8 *ctx_err;

Maybe combine the two u8 *

> +
> +	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
> +	pei_err = (u8 *)err + sizeof(struct cper_sec_proc_arm);
	pei_err = (u8 *)(err + 1);

Which is the same as err_info. Setting one to the other will make that
relationship more obvious if we do need to keep them both around.
(Similar to the ctx_err = (u8 *)ctx_info; below)

> +
> +	err_info = (struct cper_arm_err_info *)(err + 1);
> +	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
> +	ctx_err = (u8 *)ctx_info;
> +
> +	for (n = 0; n < err->context_info_num; n++) {
> +		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
> +		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
> +		ctx_len += sz;
> +	}
> +
> +	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) + pei_len + ctx_len);
> +	if (vsei_len < 0) {
> +		pr_warn(FW_BUG "section length: %d\n", err->section_length);
> +		pr_warn(FW_BUG "section length is too small\n");
> +		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
> +		vsei_len = 0;
> +	}
> +	ven_err_data = (u8 *)ctx_info;
> +
> +	cpu = GET_LOGICAL_INDEX(err->mpidr);
> +	if (cpu < 0)
> +		cpu = -1;
> +
> +	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
> +			ven_err_data, (u32)vsei_len, sev, cpu);
>  }

> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 14c9f943d53fb6cbadeef3f4b13e61470f0b5dee..a6b7ac0adaff9dfeab05a0c75ed359930ae04479 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -168,11 +168,24 @@ TRACE_EVENT(mc_event,
>   * This event is generated when hardware detects an ARM processor error
>   * has occurred. UEFI 2.6 spec section N.2.4.4.
>   */
> +#define APEIL "ARM Processor Err Info data len"
> +#define APEID "ARM Processor Err Info raw data"
> +#define APECIL "ARM Processor Err Context Info data len"
> +#define APECID "ARM Processor Err Context Info raw data"
> +#define VSEIL "Vendor Specific Err Info data len"
> +#define VSEID "Vendor Specific Err Info raw data"
>  TRACE_EVENT(arm_event,
>  
> -	TP_PROTO(const struct cper_sec_proc_arm *proc),
> +	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
> +			const u32 pei_len,
Trivial but this is an odd bit of wrapping to have two items
on first line, but then only one on later lines.  Also additional
indent seems unusual and isn't matched by the first few things I looked
at in this file.  So should be under the c of const (one space I think
rather than a tab).

> +			const u8 *ctx_err,
> +			const u32 ctx_len,
> +			const u8 *oem,
> +			const u32 oem_len,
> +			u8 sev,
> +			int cpu),
>  




