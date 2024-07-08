Return-Path: <linux-efi+bounces-1382-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8578892A5C5
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 17:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A896C1C21272
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E61413AA2B;
	Mon,  8 Jul 2024 15:34:55 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAF1E898;
	Mon,  8 Jul 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452895; cv=none; b=XM8xMLeZUbn1DC6qAEAQNUaBopfXj0jthHi1lW+uiirlRayu8F52qLqet2H4V/7OJHwfz1zhp4LX6VlmG7h49UU94K9nmD+4kReW++oe0npce7pwvF+ongHXK8bOKt5Pgu0X5p0kwvECiglMq4OdfvjdckNUvnXAd6w9SBB9BHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452895; c=relaxed/simple;
	bh=LebzdJzhqdkNpzWYA4hxosalA/gbc8kD4iPdCi9ZICI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5YuT2nXwL7jEJHsyYJ4zzIvS1noEn2/UlCPl2lprq9p0aO71Is7Er4/OfhpVQLyi1S5hU3BSWdv4oYmjtvqysLNoJRRQkJvze4ZNPZ/GwGqjI6U5nIC/muAWEq8mdGWnsPkAe+y/L3FjWAmjiO3Lq3RE8Mr0BQei0vWCHVsKLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WHp6x5gcXz6K64W;
	Mon,  8 Jul 2024 23:33:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 68E25140736;
	Mon,  8 Jul 2024 23:34:49 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 16:34:48 +0100
Date: Mon, 8 Jul 2024 16:34:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Shengwei
 Luo <luoshengwei@huawei.com>, Ard Biesheuvel <ardb@kernel.org>, James Morse
	<james.morse@arm.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Shiju Jose <shiju.jose@huawei.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, "Dan
 Williams" <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Shuai Xue <xueshuai@linux.alibaba.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Tyler Baicar <tbaicar@codeaurora.org>, "Will
 Deacon" <will@kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>,
	<linux-acpi@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jason Tian
	<jason@os.amperecomputing.com>, Daniel Ferguson
	<danielf@os.amperecomputing.com>
Subject: Re: [PATCH 2/6] RAS: Report all ARM processor CPER information to
 userspace
Message-ID: <20240708163447.0000274f@Huawei.com>
In-Reply-To: <48ed5eb4448d85ccb5503335087a3e6a5159ca1e.1720436039.git.mchehab+huawei@kernel.org>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
	<48ed5eb4448d85ccb5503335087a3e6a5159ca1e.1720436039.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  8 Jul 2024 13:18:11 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Shengwei Luo <luoshengwei@huawei.com>
> 
> The ARM processor CPER record was added at UEFI 2.6, and hasn't
> any changes up to UEFI 2.10 on its struct.
> 
> Yet, the original arm_event trace code added on changeset
> e9279e83ad1f ("trace, ras: add ARM processor error trace event") is
> incomplete, as it only traces some fields of UAPI 2.6 table N.16,
> not exporting at all any information from tables N.17 to N.29 of
> the record.
> 
> This is not enough for user to take appropriate action or to log
> what exactly happened.
> 
> According to UEFI_2_9 specification chapter N2.4.4, the ARM processor
> error section includes:
> 
> - several (ERR_INFO_NUM) ARM processor error information structures
>   (Tables N.17 to N.20);
> - several (CONTEXT_INFO_NUM) ARM processor context information
>   structures (Tables N.21 to N.29);
> - several vendor specific error information structures. The
>   size is given by Section Length minus the size of the other
>   fields.
> 
> In addition to those data, it also exports two fields that are
> parsed by the GHES driver when firmware reports it, e. g.:
> 
> - error severity
> - cpu logical index
> 
> Report all of these information to userspace via trace uAPI, So that
> userspace can properly record the error and take decisions related
> to cpu core isolation according to error severity and other info.
> 
> After this patch, all the data from ARM Processor record from table
> N.16 are directly or indirectly visible on userspace:
> 
> ======================================	=============================
> UEFI field on table N.16		ARM Processor trace fields
> ======================================	=============================
> Validation				handled when filling data for
> 					affinity MPIDR and running
> 					state.
> ERR_INFO_NUM				pei_len
> CONTEXT_INFO_NUM			ctx_len
> Section Length				indirectly reported by
> 					pei_len, ctx_len and oem_len
> Error affinity level			affinity
> MPIDR_EL1				mpidr
> MIDR_EL1				midr
> Running State				running_state
> PSCI State				psci_state
> Processor Error Information Structure	pei_err - count at pei_len
> Processor Context			ctx_err- count at ctx_len
> Vendor Specific Error Info		oem - count at oem_len
> ======================================	=============================
> 
> It should be noticed that decoding of tables N.17 to N.29, if needed,
> will be handled on userspace. That gives more flexibility, as there
> won't be any need to flood the Kernel with micro-architecture specific
> error decoding).
> Also, decoding the other fields require a complex logic, and should
> be done for each of the several values inside the record field.
> So, let userspace daemons like rasdaemon decode them, parsing such
> tables and having vendor-specific micro-architecture-specific decoders.
> 
> [mchehab: modified patch description and fix coding style]
> Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
> Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
> Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
> Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section

A few comments inline but all of the 'I'd have done this slightly differently'
variety.  This is fine as it stands though.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/apei/ghes.c |  3 +--
>  drivers/ras/ras.c        | 45 +++++++++++++++++++++++++++++++++++--
>  include/linux/ras.h      | 16 ++++++++++----
>  include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++-----
>  4 files changed, 99 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 2589a3536d91..90efca025d27 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -538,9 +538,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>  	int sec_sev, i;
>  	char *p;
>  
> -	log_arm_hw_error(err);
> -
>  	sec_sev = ghes_severity(gdata->error_severity);
> +	log_arm_hw_error(err, sec_sev);
>  	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
>  		return false;
>  
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 5d94ab79c8c3..75acc09bc96a 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -52,10 +52,51 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
>  	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
>  }
>  
> -void log_arm_hw_error(struct cper_sec_proc_arm *err)
> +void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
>  {
>  #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
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
> +
> +	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
> +	pei_err = (u8 *)err + sizeof(struct cper_sec_proc_arm);
> +
> +	err_info = (struct cper_arm_err_info *)(err + 1);
> +	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
> +	ctx_err = (u8 *)ctx_info;
> +	for (n = 0; n < err->context_info_num; n++) {
> +		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
> +		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
> +		ctx_len += sz;
> +	}
> +
> +	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
> +					  pei_len + ctx_len);
> +	if (vsei_len < 0) {
> +		pr_warn(FW_BUG
> +			"section length: %d\n", err->section_length);
> +		pr_warn(FW_BUG
> +			"section length is too small\n");
> +		pr_warn(FW_BUG
> +			"firmware-generated error record is incorrect\n");
> +		vsei_len = 0;
> +	}
> +	ven_err_data = (u8 *)ctx_info;
> +
> +	cpu = GET_LOGICAL_INDEX(err->mpidr);
> +	/* when return value is invalid, set cpu index to -1 */
> +	if (cpu < 0)
> +		cpu = -1;
> +
> +	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
> +			ven_err_data, (u32)vsei_len, sev, cpu);
>  #endif
>  }
>  
> diff --git a/include/linux/ras.h b/include/linux/ras.h
> index a64182bc72ad..6025afe5736a 100644
> --- a/include/linux/ras.h
> +++ b/include/linux/ras.h
> @@ -24,8 +24,7 @@ int __init parse_cec_param(char *str);
>  void log_non_standard_event(const guid_t *sec_type,
>  			    const guid_t *fru_id, const char *fru_text,
>  			    const u8 sev, const u8 *err, const u32 len);
> -void log_arm_hw_error(struct cper_sec_proc_arm *err);
> -
> +void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev);
>  #else
>  static inline void
>  log_non_standard_event(const guid_t *sec_type,
> @@ -33,7 +32,7 @@ log_non_standard_event(const guid_t *sec_type,
>  		       const u8 sev, const u8 *err, const u32 len)
>  { return; }
>  static inline void
> -log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
> +log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev) { return; }
>  #endif
>  
>  struct atl_err {
> @@ -52,5 +51,14 @@ static inline void amd_retire_dram_row(struct atl_err *err) { }
>  static inline unsigned long
>  amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
>  #endif /* CONFIG_AMD_ATL */
> -

I'd keep a blank line here for readability.

> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> +#include <asm/smp_plat.h>
> +/*
> + * Include ARM specific SMP header which provides a function mapping mpidr to
> + * cpu logical index.
> + */
> +#define GET_LOGICAL_INDEX(mpidr) get_logical_index(mpidr & MPIDR_HWID_BITMASK)
> +#else
> +#define GET_LOGICAL_INDEX(mpidr) -EINVAL
> +#endif /* CONFIG_ARM || CONFIG_ARM64 */
>  #endif /* __RAS_H__ */
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 7c47151d5c72..ce5214f008eb 100644
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

I don't think I'd have bothered with these defines, but
it doesn't really matter.
traceprintk is strictly for debug convenience etc so not
vital how it is formatted however, maybe could have used a
shorter description as
"Vendor Specific Err Info (Length %d): %s"
However it would be inconsistent with existing entries.


>  TRACE_EVENT(arm_event,
>  
> -	TP_PROTO(const struct cper_sec_proc_arm *proc),
> +	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
> +			const u32 pei_len,
> +			const u8 *ctx_err,
> +			const u32 ctx_len,
> +			const u8 *oem,
> +			const u32 oem_len,
> +			u8 sev,
> +			int cpu),
>  
> -	TP_ARGS(proc),
> +	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len, sev, cpu),
>  
>  	TP_STRUCT__entry(
>  		__field(u64, mpidr)
> @@ -180,6 +193,14 @@ TRACE_EVENT(arm_event,
>  		__field(u32, running_state)
>  		__field(u32, psci_state)
>  		__field(u8, affinity)
> +		__field(u32, pei_len)
> +		__dynamic_array(u8, buf, pei_len)

Can we do better than naming buf, buf1, buf2?
Will make the code below easier to read if they are pei_buf, ctx_buf, oem_buf

> +		__field(u32, ctx_len)
> +		__dynamic_array(u8, buf1, ctx_len)
> +		__field(u32, oem_len)
> +		__dynamic_array(u8, buf2, oem_len)
> +		__field(u8, sev)
> +		__field(int, cpu)
>  	),
>  
>  	TP_fast_assign(
> @@ -199,12 +220,29 @@ TRACE_EVENT(arm_event,
>  			__entry->running_state = ~0;
>  			__entry->psci_state = ~0;
>  		}
> +		__entry->pei_len = pei_len;
> +		memcpy(__get_dynamic_array(buf), pei_err, pei_len);
> +		__entry->ctx_len = ctx_len;
> +		memcpy(__get_dynamic_array(buf1), ctx_err, ctx_len);
> +		__entry->oem_len = oem_len;
> +		memcpy(__get_dynamic_array(buf2), oem, oem_len);
> +		__entry->sev = sev;
> +		__entry->cpu = cpu;
>  	),
>  
> -	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
> -		  "running state: %d; PSCI state: %d",
> +	TP_printk("cpu: %d; error: %d; affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
> +		  "running state: %d; PSCI state: %d; "
> +		  "%s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
> +		  __entry->cpu,
> +		  __entry->sev,
>  		  __entry->affinity, __entry->mpidr, __entry->midr,
> -		  __entry->running_state, __entry->psci_state)
> +		  __entry->running_state, __entry->psci_state,
> +		  APEIL, __entry->pei_len, APEID,
> +		  __print_hex(__get_dynamic_array(buf), __entry->pei_len),
> +		  APECIL, __entry->ctx_len, APECID,
> +		  __print_hex(__get_dynamic_array(buf1), __entry->ctx_len),
> +		  VSEIL, __entry->oem_len, VSEID,
> +		  __print_hex(__get_dynamic_array(buf2), __entry->oem_len))
>  );
>  
>  /*


