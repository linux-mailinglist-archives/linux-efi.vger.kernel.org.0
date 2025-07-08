Return-Path: <linux-efi+bounces-4181-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4D9AFBFCE
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 03:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC101AA501D
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 01:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31A1E2838;
	Tue,  8 Jul 2025 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDmvco2X"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE167464;
	Tue,  8 Jul 2025 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937594; cv=none; b=nI/mk3Y4NCuqOs0C5yvkLdW06gvzYAnVm1VK7Tik7cxSyw5h4AFr53PEw2qNwr0DPSXnnuUm9aGpqf2aj+7mVo5pOFB/SJhdLzlHWS+aopCXf3PttlIyTEfC7Qd1L8wWRdJO33MRhWqZpNB4UoZJZCGA7nLMklu98+eII5vFclQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937594; c=relaxed/simple;
	bh=xXLBp1dzSbZ0T1gdudVULGsOqBwn9w3PKTIA1vQOwKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQ7FuedNF9I3YVI3nrcBh6jck1L3/jO++qQTHxTVdPsOi7DpIrww62hZqznKa4P4P2MJh80aHiUMsdrZhceV0ymghxID2oZs/bSJ3in4HL9hAvVHU1FmRl/W+enE2cRCqc7D7sVNfN7S6FQjsZN/ZqkVKV3GqAoXAGhZJRZebtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDmvco2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431ADC4CEF6;
	Tue,  8 Jul 2025 01:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937594;
	bh=xXLBp1dzSbZ0T1gdudVULGsOqBwn9w3PKTIA1vQOwKk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bDmvco2Xj2rwGzzewW/jE0ahM6jRz6w9Z4AoGKf6cfaPwOz8T5VSo1Nza+Hu+xfnW
	 4inOPwBGa8utcjg1MRxzt2y0F4WHjCE2BX9WJnu6t9YN0Cbn8av0/o9OIjEkkphKhK
	 BF1bLr9uF9/M8GmfABzA0u613wqTA8I/9+SOHTG4UoXk2BM//dUSoz1PaNaiJPxeUd
	 4jVeKV3Uq5iGRaOBAV1FrLwuMP1yLO2yYqTlFFzbA0coBhU+YWhRvObZkmfrj/3EOl
	 HdNSPUGwu0fd3cS3Vcg1iDscpM2GrgSDuvGxzC939KHklyAjJgOwC95452ZtFf8qor
	 hRzpWFHLliStg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54d98aa5981so4980981e87.0;
        Mon, 07 Jul 2025 18:19:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuQob8rtuBZ0RzyJGeTnd2rn2WIs26tC2gC8fgi5sTx7tUgPbQbqd9lL/KrDAGJpqz4uWWYMBB@vger.kernel.org, AJvYcCVHWofEEFBSbgUguQwLOmr9EA+Vcd+Gkhbpe2Vf8aN+33+kf0Fc7ZemDlQSfvVbTk2EmTfO85Mi6bs=@vger.kernel.org, AJvYcCVaf98rfxKV7ck0lScuhUwUOD0nRs8ajUJtI4ELERJSRfVOstMMWcDxhSffTGZuABPAY4m4P1Zpet0OIW4E@vger.kernel.org
X-Gm-Message-State: AOJu0YwoUAeUfEwtfmhFN3tCNgiIUjmnmm4usMg9/+r2atYqurYg2cKL
	VB+yJG8SgQ4uNcgcR+AEWqacFg3NNFy4dM9oaR0yAYoe9wpiJIAm3Wfa14IQYJMeQ95O62SRQE3
	BDAaX9DvbsfYs6Y92j1xU4UVx1A0NtfU=
X-Google-Smtp-Source: AGHT+IFfDR3gsWOC7fygq7gdQV7NxSbjnvvkjwzS3D37iAnoO/LpDRJJzkFsSpXf4HJI1nXqR88gJI74GgGpjSsKLIg=
X-Received: by 2002:a05:6512:3d88:b0:553:34b7:5731 with SMTP id
 2adb3069b0e04-557a1235debmr4075223e87.3.1751937592543; Mon, 07 Jul 2025
 18:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1751858087-10366-1-git-send-email-yangge1116@126.com>
In-Reply-To: <1751858087-10366-1-git-send-email-yangge1116@126.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 8 Jul 2025 11:19:41 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEbTH3T_hYQnvPy_cAnBJi6z7VoZxh3KseW91D1o=R_4g@mail.gmail.com>
X-Gm-Features: Ac12FXwcaEQw3NFCpAjmJAO1x6LBq3l8Z4iOHLKENljTRVEbOzMbumq--aR4dhE
Message-ID: <CAMj1kXEbTH3T_hYQnvPy_cAnBJi6z7VoZxh3KseW91D1o=R_4g@mail.gmail.com>
Subject: Re: [PATCH V3] efi/tpm: Fix the issue where the CC platforms event
 log header can't be correctly identified
To: yangge1116@126.com
Cc: jarkko@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com, 
	ilias.apalodimas@linaro.org, jgg@ziepe.ca, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 13:15, <yangge1116@126.com> wrote:
>
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
> V3:
> - fix build error
>
> V2:
> - limit the fix for CC only suggested by Jarkko and Sathyanarayanan
>
>  drivers/char/tpm/eventlog/tpm2.c   |  4 +++-
>  drivers/firmware/efi/libstub/tpm.c | 13 +++++++++----
>  drivers/firmware/efi/tpm.c         |  4 +++-
>  include/linux/tpm_eventlog.h       | 14 +++++++++++---
>  4 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
> index 37a0580..30ef47c 100644
> --- a/drivers/char/tpm/eventlog/tpm2.c
> +++ b/drivers/char/tpm/eventlog/tpm2.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/tpm_eventlog.h>
> +#include <linux/cc_platform.h>
>
>  #include "../tpm.h"
>  #include "common.h"
> @@ -36,7 +37,8 @@
>  static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>                                    struct tcg_pcr_event *event_header)
>  {
> -       return __calc_tpm2_event_size(event, event_header, false);
> +       return __calc_tpm2_event_size(event, event_header, false,
> +                       cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT));


This conflates TDX attestation with guest state encryption.

I think there could be meaningful ways for a confidential guest to use
[emulated] TPM attestation rather than CC specific attestation, so I
don't think it is a good idea to assume that the fact that we are
running on a CoCo guest always implies that all the TCG data
structures are of the CC variety.


>  }
>
>  static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index a5c6c4f..9728060 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -50,7 +50,8 @@ void efi_enable_reset_attack_mitigation(void)
>  static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_location,
>                                        efi_physical_addr_t log_last_entry,
>                                        efi_bool_t truncated,
> -                                      struct efi_tcg2_final_events_table *final_events_table)
> +                                      struct efi_tcg2_final_events_table *final_events_table,
> +                                      bool is_cc_event)
>  {
>         efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
>         efi_status_t status;
> @@ -87,7 +88,8 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
>                         last_entry_size =
>                                 __calc_tpm2_event_size((void *)last_entry_addr,
>                                                     (void *)(long)log_location,
> -                                                   false);
> +                                                   false,
> +                                                   is_cc_event);
>                 } else {
>                         last_entry_size = sizeof(struct tcpa_event) +
>                            ((struct tcpa_event *) last_entry_addr)->event_size;
> @@ -123,7 +125,8 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
>                         header = data + offset + final_events_size;
>                         event_size = __calc_tpm2_event_size(header,
>                                                    (void *)(long)log_location,
> -                                                  false);
> +                                                  false,
> +                                                  is_cc_event);
>                         /* If calc fails this is a malformed log */
>                         if (!event_size)
>                                 break;
> @@ -157,6 +160,7 @@ void efi_retrieve_eventlog(void)
>         efi_tcg2_protocol_t *tpm2 = NULL;
>         efi_bool_t truncated;
>         efi_status_t status;
> +       bool is_cc_event = false;
>
>         status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
>         if (status == EFI_SUCCESS) {
> @@ -186,11 +190,12 @@ void efi_retrieve_eventlog(void)
>
>                 final_events_table =
>                         get_efi_config_table(EFI_CC_FINAL_EVENTS_TABLE_GUID);
> +               is_cc_event = true;
>         }
>
>         if (status != EFI_SUCCESS || !log_location)
>                 return;
>
>         efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> -                                  truncated, final_events_table);
> +                                  truncated, final_events_table, is_cc_event);
>  }
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index cdd4310..ca8535d 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/memblock.h>
>  #include <linux/tpm_eventlog.h>
> +#include <linux/cc_platform.h>
>
>  int efi_tpm_final_log_size;
>  EXPORT_SYMBOL(efi_tpm_final_log_size);
> @@ -23,7 +24,8 @@ static int __init tpm2_calc_event_log_size(void *data, int count, void *size_inf
>
>         while (count > 0) {
>                 header = data + size;
> -               event_size = __calc_tpm2_event_size(header, size_info, true);
> +               event_size = __calc_tpm2_event_size(header, size_info, true,
> +                                    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT));
>                 if (event_size == 0)
>                         return -1;
>                 size += event_size;
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
>                                          struct tcg_pcr_event *event_header,
> -                                        bool do_mapping)
> +                                        bool do_mapping,
> +                                        bool is_cc_event)
>  {
>         struct tcg_efi_specid_event_head *efispecid;
>         struct tcg_event_field *event_field;
> @@ -201,8 +203,14 @@ static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
>         count = event->count;
>         event_type = event->event_type;
>
> -       /* Verify that it's the log header */
> -       if (event_header->pcr_idx != 0 ||
> +       /*
> +        * Verify that it's the log header. According to the TCG PC Client
> +        * Specification, when identifying a log header, the check for a
> +        * pcr_idx value of 0 is not required. For CC platforms, skipping
> +        * this check during log header is necessary; otherwise, the CC
> +        * platform's log header may fail to be recognized.
> +        */
> +       if ((!is_cc_event && event_header->pcr_idx != 0) ||
>             event_header->event_type != NO_ACTION ||
>             memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
>                 size = 0;
> --
> 2.7.4
>

