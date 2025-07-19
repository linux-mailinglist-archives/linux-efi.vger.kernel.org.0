Return-Path: <linux-efi+bounces-4423-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89788B0AFE9
	for <lists+linux-efi@lfdr.de>; Sat, 19 Jul 2025 14:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3CC3BEBB8
	for <lists+linux-efi@lfdr.de>; Sat, 19 Jul 2025 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F5A22A4E8;
	Sat, 19 Jul 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7Dn62pd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5527DF9E8;
	Sat, 19 Jul 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928619; cv=none; b=Jz5yf+86xbL7geaFNUsiG3jmezcU3nyur6ZnaHN7ObkEO9LGUh9P6Zb7jzNSD0YGcl8gQvKnFqqh7B0JqgQW5eIWc/sIgJJc3F9dzeX5W8YLPD67rCxPxAbmRSieSJPUOoOOmVoIrcoJcFf/bn+b5TChTS2Y2VamhbBOv51xn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928619; c=relaxed/simple;
	bh=4HhiSMitukMNzXvmlC75pkvI10Vu5ufv1kiOa2xNbaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXGfCMAfywMoAbiMNwMk57W87qs9cgPJuW6o3pBPAeL2LXdDBSVA+F9E4kyb1NgfkTJnteOU//I0hHS77TuIfVq3/ROJ7LNDdoOScB4VtQnw2ErrDqAAPaSSQUhOiRPHC7nkRMicYSj344yl0dwYBYSH2Px+NkZWnIpbVAn5i+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7Dn62pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972D4C4CEE3;
	Sat, 19 Jul 2025 12:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752928618;
	bh=4HhiSMitukMNzXvmlC75pkvI10Vu5ufv1kiOa2xNbaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7Dn62pdEltcSnW6ee2YGpZa5KVQoQnobyC/v9mBHOVtT+6jxWgAGaAq6kv5RDM0z
	 fjS+iJSOhRvSD/15QZZIC03MHTmgyXkPWBbqp1gno0xUWLSEo29/AmhylGuRYME9PB
	 DKGxZuHGRB1Skj0iPxeTZhBiK2qhEDMkapjUxyhCDcGFPnkRBxVoiUIfM7MQZQDWax
	 klmFYnc99UVBZrB6ULIKZ6s7FLB9ziCGSDFZQ7bhaNx6Nq1qUq2XhOsP6mzLZJrz14
	 L3i4p7UAQHocn5LLesQh5SR0oT9EptA5TmbIatyAM95EkMHqp9NVIUPG4jiHkUoWoG
	 byKH4SB33A2Xw==
Date: Sat, 19 Jul 2025 15:36:55 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: yangge1116@126.com
Cc: ardb@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org, jgg@ziepe.ca,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, liuzixing@hygon.cn
Subject: Re: [PATCH V2] efi/tpm: Fix the issue where the CC platforms event
 log header can't be correctly identified
Message-ID: <aHuRZ_4oKxelNPTa@kernel.org>
References: <1751710616-24464-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1751710616-24464-1-git-send-email-yangge1116@126.com>

On Sat, Jul 05, 2025 at 06:16:56PM +0800, yangge1116@126.com wrote:
> From: Ge Yang <yangge1116@126.com>
> 
> Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
> for CC platforms") reuses TPM2 support code for the CC platforms, when
> launching a TDX virtual machine with coco measurement enabled, the
> following error log is generated:
> 
> [Firmware Bug]: Failed to parse event in TPM Final Events Log
> 
> Call Trace:
> efi_config_parse_tables()
>   efi_tpm_eventlog_init()
>     tpm2_calc_event_log_size()
>       __calc_tpm2_event_size()
> 
> The pcr_idx value in the Intel TDX log header is 1, causing the function
> __calc_tpm2_event_size() to fail to recognize the log header, ultimately
> leading to the "Failed to parse event in TPM Final Events Log" error.
> 
> According to UEFI Specification 2.10, Section 38.4.1: For TDX, TPM PCR
> 0 maps to MRTD, so the log header uses TPM PCR 1 instead. To successfully
> parse the TDX event log header, the check for a pcr_idx value of 0
> must be skipped.
> 
> According to Table 6 in Section 10.2.1 of the TCG PC Client
> Specification, the index field does not require the PCR index to be
> fixed at zero. Therefore, skipping the check for a pcr_idx value of
> 0 for CC platforms is safe.
> 
> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension
> Link: https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClient_PFP_r1p05_v23_pub.pdf
> Fixes: d228814b1913 ("efi/libstub: Add get_event_log() support for CC platforms")
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Cc: stable@vger.kernel.org
> ---
> 
> V2:
> - limit the fix for CC only suggested by Jarkko and Sathyanarayanan
> 
>  drivers/char/tpm/eventlog/tpm2.c   |  3 ++-
>  drivers/firmware/efi/libstub/tpm.c | 13 +++++++++----
>  drivers/firmware/efi/tpm.c         |  3 ++-
>  include/linux/tpm_eventlog.h       | 14 +++++++++++---
>  4 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
> index 37a0580..87a8b7f 100644
> --- a/drivers/char/tpm/eventlog/tpm2.c
> +++ b/drivers/char/tpm/eventlog/tpm2.c
> @@ -36,7 +36,8 @@
>  static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>  				   struct tcg_pcr_event *event_header)
>  {
> -	return __calc_tpm2_event_size(event, event_header, false);
> +	return __calc_tpm2_event_size(event, event_header, false,
> +			cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT));
>  }
>  
>  static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index a5c6c4f..9728060 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -50,7 +50,8 @@ void efi_enable_reset_attack_mitigation(void)
>  static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_location,
>  				       efi_physical_addr_t log_last_entry,
>  				       efi_bool_t truncated,
> -				       struct efi_tcg2_final_events_table *final_events_table)
> +				       struct efi_tcg2_final_events_table *final_events_table,
> +				       bool is_cc_event)
>  {
>  	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
>  	efi_status_t status;
> @@ -87,7 +88,8 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
>  			last_entry_size =
>  				__calc_tpm2_event_size((void *)last_entry_addr,
>  						    (void *)(long)log_location,
> -						    false);
> +						    false,
> +						    is_cc_event);
>  		} else {
>  			last_entry_size = sizeof(struct tcpa_event) +
>  			   ((struct tcpa_event *) last_entry_addr)->event_size;
> @@ -123,7 +125,8 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
>  			header = data + offset + final_events_size;
>  			event_size = __calc_tpm2_event_size(header,
>  						   (void *)(long)log_location,
> -						   false);
> +						   false,
> +						   is_cc_event);
>  			/* If calc fails this is a malformed log */
>  			if (!event_size)
>  				break;
> @@ -157,6 +160,7 @@ void efi_retrieve_eventlog(void)
>  	efi_tcg2_protocol_t *tpm2 = NULL;
>  	efi_bool_t truncated;
>  	efi_status_t status;
> +	bool is_cc_event = false;
>  
>  	status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
>  	if (status == EFI_SUCCESS) {
> @@ -186,11 +190,12 @@ void efi_retrieve_eventlog(void)
>  
>  		final_events_table =
>  			get_efi_config_table(EFI_CC_FINAL_EVENTS_TABLE_GUID);
> +		is_cc_event = true;
>  	}
>  
>  	if (status != EFI_SUCCESS || !log_location)
>  		return;
>  
>  	efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> -				   truncated, final_events_table);
> +				   truncated, final_events_table, is_cc_event);
>  }
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index cdd4310..a94816d 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -23,7 +23,8 @@ static int __init tpm2_calc_event_log_size(void *data, int count, void *size_inf
>  
>  	while (count > 0) {
>  		header = data + size;
> -		event_size = __calc_tpm2_event_size(header, size_info, true);
> +		event_size = __calc_tpm2_event_size(header, size_info, true,
> +				     cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT));
>  		if (event_size == 0)
>  			return -1;
>  		size += event_size;
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 891368e..b3380c9 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -143,6 +143,7 @@ struct tcg_algorithm_info {
>   * @event:        Pointer to the event whose size should be calculated
>   * @event_header: Pointer to the initial event containing the digest lengths
>   * @do_mapping:   Whether or not the event needs to be mapped
> + * @is_cc_event:  Whether or not the event is from a CC platform
>   *
>   * The TPM2 event log format can contain multiple digests corresponding to
>   * separate PCR banks, and also contains a variable length of the data that
> @@ -159,7 +160,8 @@ struct tcg_algorithm_info {
>  
>  static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>  					 struct tcg_pcr_event *event_header,
> -					 bool do_mapping)
> +					 bool do_mapping,
> +					 bool is_cc_event)

So it might be a good idea to put a small enum together:

enum tpm2_event_type {
	TPM2_EVENT_TPM2 = 0,
	TPM2_EVENT_CC = 1,
}

Then stamp *all* call sites with either. Then the usage of
__calc_tpm2_event_size() is so much easier to track later
when everything is stamped :-)

And if there's something that is not TPM2 or CC platform,
we have something that scales in place, and we can slice
that in place with much less friction.

BR, Jarkko

