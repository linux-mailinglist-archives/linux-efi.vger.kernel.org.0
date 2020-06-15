Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938781F93C3
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 11:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgFOJnW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 05:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbgFOJnW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Jun 2020 05:43:22 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3395820714
        for <linux-efi@vger.kernel.org>; Mon, 15 Jun 2020 09:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592214202;
        bh=Azg3oiewv302f97xP0/pOqiRNaECSGIkg+e8EopwAE0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f4lWBNHofaN3fLQxWR1FMOnl9D0RYzHT5v+yjJ74geyxNbOAER8W3ARIuGb3/bG01
         LTLnyZNrUSsPO3JM+8dL2kUr1cSgRmLPo/BjK5Kpq8ZlEIoGGI9l3uYAW6ikx9w3tk
         U94hbn4thTKywnQEucBDCUXnBxIpwSamng/WMXOA=
Received: by mail-oi1-f171.google.com with SMTP id 25so15274051oiy.13
        for <linux-efi@vger.kernel.org>; Mon, 15 Jun 2020 02:43:22 -0700 (PDT)
X-Gm-Message-State: AOAM530rAx0dzRE0r2FmvF/0riTdAY0qZlKQpZ+0N8z0sVcRgBW8cwek
        QdIL404N2u/qzUiFXWeRnTuFPe91/4ZqdBfHqYI=
X-Google-Smtp-Source: ABdhPJznYbHPuQQ957bMWS7T1Xo/Qec6OwOuR8kripK4cgo5oPjXD6Wqaui76mZgLDo5xBSLRbF7G/BBz5K/dJQ3unQ=
X-Received: by 2002:aca:b241:: with SMTP id b62mr7794624oif.47.1592214201548;
 Mon, 15 Jun 2020 02:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <1927248.evlx2EsYKh@linux-e202.suse.de>
In-Reply-To: <1927248.evlx2EsYKh@linux-e202.suse.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Jun 2020 11:43:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHs6rUUjqJcq+1iSmRfkowSpLJnscdfSrRaf5iTCj3_sQ@mail.gmail.com>
Message-ID: <CAMj1kXHs6rUUjqJcq+1iSmRfkowSpLJnscdfSrRaf5iTCj3_sQ@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: verify that it's actually an event log header
 before parsing
To:     Fabian Vogt <fvogt@suse.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 15 Jun 2020 at 09:16, Fabian Vogt <fvogt@suse.de> wrote:
>
> It's possible that the first event in the log is not actually a log
> header at all, but rather a normal event. This leads to the cast in
> __calc_tpm2_event_size being an invalid conversion, which means that
> the values read are effectively garbage. Depending on the first event's
> contents, this leads either to apparently normal behaviour, a crash or
> a freeze.
>
> While this behaviour of the firmware is not in accordance with the
> TCG Client EFI Specification, this happens on a Dell Precision 5510
> with the TPM enabled but hidden from the OS ("TPM On" disabled, state
> otherwise untouched). The EFI claims that the TPM is present and active
> and supports the TCG 2.0 event log format.
>
> Fortunately, this can be worked around by simply checking the header
> of the first event and the event log header signature itself.
>
> Commit b4f1874c6216 ("tpm: check event log version before reading final
> events") addressed a similar issue also found on Dell models.
>
> Fixes: 6b0326190205 ("efi: Attempt to get the TCG2 event log in the boot stub")
> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1165773
> Signed-off-by: Fabian Vogt <fvogt@suse.de>

Queued in efi/urgent, thanks.

> ---
> v2: Drop unneeded READ_ONCE around event_header derefs.
>
>  include/linux/tpm_eventlog.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 4f8c90c93c29..64356b199e94 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -81,6 +81,8 @@ struct tcg_efi_specid_event_algs {
>         u16 digest_size;
>  } __packed;
>
> +#define TCG_SPECID_SIG "Spec ID Event03"
> +
>  struct tcg_efi_specid_event_head {
>         u8 signature[16];
>         u32 platform_class;
> @@ -171,6 +173,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>         int i;
>         int j;
>         u32 count, event_type;
> +       const u8 zero_digest[sizeof(event_header->digest)] = {0};
>
>         marker = event;
>         marker_start = marker;
> @@ -198,10 +201,19 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>         count = READ_ONCE(event->count);
>         event_type = READ_ONCE(event->event_type);
>
> +       /* Verify that it's the log header */
> +       if (event_header->pcr_idx != 0 ||
> +           event_header->event_type != NO_ACTION ||
> +           memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
> +               size = 0;
> +               goto out;
> +       }
> +
>         efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
>
>         /* Check if event is malformed. */
> -       if (count > efispecid->num_algs) {
> +       if (memcmp(efispecid->signature, TCG_SPECID_SIG,
> +                  sizeof(TCG_SPECID_SIG)) || count > efispecid->num_algs) {
>                 size = 0;
>                 goto out;
>         }
> --
> 2.25.1
>
>
>
>
