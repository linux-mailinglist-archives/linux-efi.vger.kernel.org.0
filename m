Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D1E1FABE9
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jun 2020 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgFPJIv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Jun 2020 05:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgFPJIu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Jun 2020 05:08:50 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C272A207DD;
        Tue, 16 Jun 2020 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592298529;
        bh=mMcZbBKDIEf5QDbJvhcjb8NySIKsPG7Fhgc8LiSbKCo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QAbJhmj34S2Fh7X92lHNNV0g9TgINhpbE+Xi01XOpZGNnKr1JQOzc8zJFa/Q/IWIE
         KUXLzFRoNnTDPXxxfw5nMVDVRRo5OGfYUCr1Uu+PHiRMjg+ihC/RhWsE2s9n/dd3g0
         4HFqrjPh5o76I0Mk0irL6v+qQWIW1zQYLLpbow1A=
Received: by mail-oi1-f176.google.com with SMTP id a137so18611837oii.3;
        Tue, 16 Jun 2020 02:08:49 -0700 (PDT)
X-Gm-Message-State: AOAM532iBcwy8DQnU/c6AeEDsaRJC0okNSv1M7hOKPjTmTBuLeg5FPR0
        tulR5SBG+4hKCDmeyhe9hKWIAUAr0/AYstUiE8M=
X-Google-Smtp-Source: ABdhPJwa1K5xO9vLA3j1dAI/megl1vvVrIUpuNpiiEU3U5egWn6I8rCdX4OdQEugsG4Pg25O6pqrL++03BNz9mew+r8=
X-Received: by 2002:aca:ba03:: with SMTP id k3mr2525490oif.33.1592298529095;
 Tue, 16 Jun 2020 02:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200615232504.1848159-1-tyhicks@linux.microsoft.com>
In-Reply-To: <20200615232504.1848159-1-tyhicks@linux.microsoft.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Jun 2020 11:08:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
Message-ID: <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Petr Vandrovec <petr@vmware.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Matthew and Peter)

On Tue, 16 Jun 2020 at 01:28, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
>
> Require that the TCG_PCR_EVENT2.digests.count value strictly matches the
> value of TCG_EfiSpecIdEvent.numberOfAlgorithms in the event field of the
> TCG_PCClientPCREvent event log header. Also require that
> TCG_EfiSpecIdEvent.numberOfAlgorithms is non-zero.
>
> The TCG PC Client Platform Firmware Profile Specification section 9.1
> (Family "2.0", Level 00 Revision 1.04) states:
>
>  For each Hash algorithm enumerated in the TCG_PCClientPCREvent entry,
>  there SHALL be a corresponding digest in all TCG_PCR_EVENT2 structures.
>  Note: This includes EV_NO_ACTION events which do not extend the PCR.
>
> Section 9.4.5.1 provides this description of
> TCG_EfiSpecIdEvent.numberOfAlgorithms:
>
>  The number of Hash algorithms in the digestSizes field. This field MUST
>  be set to a value of 0x01 or greater.
>
> Enforce these restrictions, as required by the above specification, in
> order to better identify and ignore invalid sequences of bytes at the
> end of an otherwise valid TPM2 event log. Firmware doesn't always have
> the means necessary to inform the kernel of the actual event log size so
> the kernel's event log parsing code should be stringent when parsing the
> event log for resiliency against firmware bugs. This is true, for
> example, when firmware passes the event log to the kernel via a reserved
> memory region described in device tree.
>

When does this happen? Do we have code in mainline that does this?

> Prior to this patch, a single bit set in the offset corresponding to
> either the TCG_PCR_EVENT2.eventType or TCG_PCR_EVENT2.eventSize fields,
> after the last valid event log entry, could confuse the parser into
> thinking that an additional entry is present in the event log. This
> patch raises the bar on how difficult it is for stale memory to confuse
> the kernel's event log parser but there's still a reliance on firmware
> to properly initialize the remainder of the memory region reserved for
> the event log as the parser cannot be expected to detect a stale but
> otherwise properly formatted firmware event log entry.
>
> Fixes: fd5c78694f3f ("tpm: fix handling of the TPM 2.0 event logs")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---

I am all for stringent checks, but this could potentially break
measured boot on systems that are working fine today, right?

>  include/linux/tpm_eventlog.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 4f8c90c93c29..d83eb9fd5614 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -201,7 +201,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>         efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
>
>         /* Check if event is malformed. */
> -       if (count > efispecid->num_algs) {
> +       if (!efispecid->num_algs || count != efispecid->num_algs) {
>                 size = 0;
>                 goto out;
>         }
> --
> 2.25.1
>
