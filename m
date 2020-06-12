Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16A61F7708
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jun 2020 13:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFLLBs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 Jun 2020 07:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgFLLBr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 12 Jun 2020 07:01:47 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5CA620835
        for <linux-efi@vger.kernel.org>; Fri, 12 Jun 2020 11:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591959705;
        bh=gTdOxYltRa2orZ59B53iuFiFWv6ZFKm8Cc04YTtf9os=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EoXaZ+DZ4qFhrjWptLpjRldsioAom0BGyAiuX0rsfOqtOYgcwS3Ehvb4CuApDgEvj
         AxrTKFguFoom7lFwECKGh6Khjoi+iQ8VD9pSQXvGuODz/pNZt+dw1K91034cguilkJ
         4qMQx35VOraoUErHNbXGjMllaV6feYP3b4t4So9g=
Received: by mail-ot1-f54.google.com with SMTP id s13so7007886otd.7
        for <linux-efi@vger.kernel.org>; Fri, 12 Jun 2020 04:01:45 -0700 (PDT)
X-Gm-Message-State: AOAM532IFuWglteKi2ymrMm3VH/Urz9CK53BDPnO6RwzNR4JgMV7w5+p
        mWJlhftQ/OvJeepkrNu3Xf4jVYKe5MI3o9HhhB4=
X-Google-Smtp-Source: ABdhPJx4GIIYBXsYzIAVVQWTJro3FZxv1CO0MxRg7hPWHE0Lu38QDPVyzRB10ce38RrnYsGr29f96OtFhmg3Bwv/ghE=
X-Received: by 2002:a9d:42e:: with SMTP id 43mr10314456otc.108.1591959705081;
 Fri, 12 Jun 2020 04:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <1894249.ujS34B1uSo@linux-e202.suse.de>
In-Reply-To: <1894249.ujS34B1uSo@linux-e202.suse.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 12 Jun 2020 13:01:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHErV-tx+8GvvLmb-L0wXq1cVwzY+OEr4PEHDZWrB7Dpg@mail.gmail.com>
Message-ID: <CAMj1kXHErV-tx+8GvvLmb-L0wXq1cVwzY+OEr4PEHDZWrB7Dpg@mail.gmail.com>
Subject: Re: [PATCH] tpm: verify that it's actually an event log header before parsing
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

On Fri, 5 Jun 2020 at 16:22, Fabian Vogt <fvogt@suse.de> wrote:
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
>  and supports the TCG 2.0 event log format.
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
> ---
>  include/linux/tpm_eventlog.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 4f8c90c93c29..b913faeedcb5 100644
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
> +       if (READ_ONCE(event_header->pcr_idx) != 0 ||
> +           READ_ONCE(event_header->event_type) != NO_ACTION ||

Is the READ_ONCE() necessary here?

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

So is it guaranteed that every well formed event starts with TCG_SPECID_SIG?


>                 size = 0;
>                 goto out;
>         }
> --
> 2.25.1
>
>
>
>
