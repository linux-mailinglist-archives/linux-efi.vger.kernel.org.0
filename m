Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E279A4536
	for <lists+linux-efi@lfdr.de>; Sat, 31 Aug 2019 18:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfHaQLk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 31 Aug 2019 12:11:40 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41654 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHaQLk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 31 Aug 2019 12:11:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id g17so8896900qkk.8
        for <linux-efi@vger.kernel.org>; Sat, 31 Aug 2019 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pe83f1owssXbd1TvMfyX2xKZ3JkailJMx6JMRxathC4=;
        b=TIU+H/yOMnpGn4f4v+24auU9sX4hy0gWjCT/iynH+zgD+GPtnT6SE9ny570T0gLRMk
         0ml9pEKDRRo2eZ2kG+5HTT0fV9htzXIkkiRbR6w1A7ugt2+AjdkWnYGC7gWrJKJXdGI4
         fz0BWSH9c49yRtsw1IRL3kLXAOKsTxfSVLmDXdOPHw84f2BwHfkO+p1mshuc4QDhQ8W6
         vngdXu21W6T5lFm5g4qWua78SIU1rki4+Yyirrw42M1zT6sO0WTJM5wjkRLSfKddnzK8
         W72g3waK569Vj28dNoaKGxZhB0RbN8FFOr2fyS5OV2krkeyT41M8aotUi+vzA3pBVugm
         I08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pe83f1owssXbd1TvMfyX2xKZ3JkailJMx6JMRxathC4=;
        b=mMWTMzP1tBB/Z1KVullAWPz7DESIdX/cR/6L5gLXGXsaBW5Z9O2cLAtMNiUNsgMYhh
         Av9waiyGnQxtITCk9TVDH0vpt/P/cU0zZzwzJh9Y4FfwMYpXNCVhe0tew2cjhUI5+zzc
         iTHo9BXn6kOx+F6PpFUVH+EkYKqC4TjocclHqCxwTiv3FPgX2rKCsJp8UkQ4sfOuUKlg
         f6QFfarx+7FWa+QcQY4+O0Z7WFA70gd8loRiPW/a/EsHXeahWzlprDIwpQN7yG6u6SYL
         6OJxVK3vBcVpMZjzVXPSS+TDWLZ4JvFeaG3kE0j7mpwOyNAzmz5A9CMn+uFICQD2Ye+f
         6ICQ==
X-Gm-Message-State: APjAAAWS6pNDcapr+gRZzOZ5Szd7hMyNo2OPcyZ1330YiNwozjuStHi6
        QIKdWdC/prhanHfsKY0OErXiKKeUWcICnXbTEjwajg==
X-Google-Smtp-Source: APXvYqxAQuJTy3tPDbVD0p9WMAUf9PV2yWyEY08GGHsce85dO2Y5kZoWOCzQdEqZySjprOclYCKijLT1bxvXd0aDnhg=
X-Received: by 2002:a37:c403:: with SMTP id d3mr14148483qki.212.1567267899073;
 Sat, 31 Aug 2019 09:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190826153028.32639-1-pjones@redhat.com>
In-Reply-To: <20190826153028.32639-1-pjones@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 31 Aug 2019 19:11:27 +0300
Message-ID: <CAKv+Gu-JQMaFdfSAVzqskC143roHvw2OrMvuUMikYHoReNiDoA@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi+tpm: Don't access event->count when it isn't mapped.
To:     Peter Jones <pjones@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <mjg59@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Lyude Paul <lyude@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 26 Aug 2019 at 18:30, Peter Jones <pjones@redhat.com> wrote:
>
> Some machines generate a lot of event log entries.  When we're
> iterating over them, the code removes the old mapping and adds a
> new one, so once we cross the page boundary we're unmapping the page
> with the count on it.  Hilarity ensues.
>
> This patch keeps the info from the header in local variables so we don't
> need to access that page again or keep track of if it's mapped.
>
> Signed-off-by: Peter Jones <pjones@redhat.com>
> Tested-by: Lyude Paul <lyude@redhat.com>
> ---
>  include/linux/tpm_eventlog.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 63238c84dc0..549dab0b56b 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -170,6 +170,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>         u16 halg;
>         int i;
>         int j;
> +       u32 count, event_type;
>
>         marker = event;
>         marker_start = marker;
> @@ -190,16 +191,22 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>         }
>
>         event = (struct tcg_pcr_event2_head *)mapping;
> +       /*
> +        * the loop below will unmap these fields if the log is larger than
> +        * one page, so save them here for reference.
> +        */
> +       count = event->count;
> +       event_type = event->event_type;
>

These assignments should be using READ_ONCE(), since otherwise, the
compiler may reload these quantities from memory anyway.

With that fixed,

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

>         efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
>
>         /* Check if event is malformed. */
> -       if (event->count > efispecid->num_algs) {
> +       if (count > efispecid->num_algs) {
>                 size = 0;
>                 goto out;
>         }
>
> -       for (i = 0; i < event->count; i++) {
> +       for (i = 0; i < count; i++) {
>                 halg_size = sizeof(event->digests[i].alg_id);
>
>                 /* Map the digest's algorithm identifier */
> @@ -256,8 +263,9 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>                 + event_field->event_size;
>         size = marker - marker_start;
>
> -       if ((event->event_type == 0) && (event_field->event_size == 0))
> +       if (event_type == 0 && event_field->event_size == 0)
>                 size = 0;
> +
>  out:
>         if (do_mapping)
>                 TPM_MEMUNMAP(mapping, mapping_size);
> --
> 2.23.0.rc2
>
