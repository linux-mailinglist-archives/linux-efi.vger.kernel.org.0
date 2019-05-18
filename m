Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB92E2240A
	for <lists+linux-efi@lfdr.de>; Sat, 18 May 2019 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfERQMn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 May 2019 12:12:43 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52424 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbfERQMn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 May 2019 12:12:43 -0400
Received: by mail-it1-f195.google.com with SMTP id q65so16665358itg.2
        for <linux-efi@vger.kernel.org>; Sat, 18 May 2019 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUYaBpI7HtM+jFnabamgjA4IxjSWFzxdWp6kmm3cyvc=;
        b=mIEuqgFsXiDW3fTmdpRG+x6vjSNL10IgQt/XYQCA3tvAVqhB7QGkBxHPCI8wxwDhNd
         LKhT/cUnMNci9N1bDfqzL1yn8/f8bRZj27gZzeRWqddEubo6SN4yvRpclKXOZMz5xKUq
         5Jy0L71fygPiUrbWvc/eNo4ajwTAUj4ROThEKRkR+Wv3qIFs2Yax6JCqkAcALdbSrrhk
         WixeukZ6A7rXQIIZ9adTcNBIRr66Pun66C+sC6rAy6XWix2BA/oWWbHiorYXcrJmzbUr
         5C07cBiMW18gR75dHA5Mn8Jww09N2/+p29DRtnNsM/qqTrha/L3WWKTRqa3+fK63gTJd
         qIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUYaBpI7HtM+jFnabamgjA4IxjSWFzxdWp6kmm3cyvc=;
        b=aU0Rjj8SpCN/NYFvbKKda8wMaff+vmWM+jzkVyEq7ntsykYvomPC0Dm7a0otnVDVZc
         MO6Ak3gqfrGd0c7uSAhnabygoOOlPyn2DXQj+2EDXg9n0VWBu1AnHVISArq6s2A90fGh
         BnznjmIExGalWel7nqH+0xli8315UUIHVEfyU1fpX/maBuViiWi1NeJDGjNaVa2M2Ry2
         W7Osu1y9RATTG8GCnnXum+xGDx2IMRJHgS0k8fLnn0AhlJ4fL3B3nzUvSFxHE+KuqAYE
         EeNfthW9bs4iVigwPExpH7zclD2QQmvWtQwBjiA930KEz+oT9j00M6w4Tyc07VoGtk8G
         4SSg==
X-Gm-Message-State: APjAAAXj6JBUMf9Ux5If686gJ36PNshNExuPtTAGpsB2A+0Wgv1VWZp0
        4qLvv7xo6oMdPIBSPQzF4HJ4GEJqdqj5uQxriQBIZA==
X-Google-Smtp-Source: APXvYqwUL20YHqglcJVp2NUVYSoE87eqr/iSK2JugWCY2czDEEDb0iLbCV5bCK7vWFO/qjW7HnckzFSJVyUOyW4coOE=
X-Received: by 2002:a24:ca84:: with SMTP id k126mr4027300itg.104.1558195961792;
 Sat, 18 May 2019 09:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190517213918.26045-1-matthewgarrett@google.com> <20190517213918.26045-5-matthewgarrett@google.com>
In-Reply-To: <20190517213918.26045-5-matthewgarrett@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 18 May 2019 18:12:29 +0200
Message-ID: <CAKv+Gu935UN8D5pkD8S9G-7=06JmsN66RdXVOCMaJfcLz=37ew@mail.gmail.com>
Subject: Re: [PATCH V6 4/4] efi: Attempt to get the TCG2 event log in the boot stub
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thiebaud Weksteen <tweek@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 17 May 2019 at 23:39, Matthew Garrett <matthewgarrett@google.com> wrote:
>
> From: Matthew Garrett <mjg59@google.com>
>
> Right now we only attempt to obtain the SHA1-only event log. The
> protocol also supports a crypto agile log format, which contains digests
> for all algorithms in use. Attempt to obtain this first, and fall back
> to obtaining the older format if the system doesn't support it. This is
> lightly complicated by the event sizes being variable (as we don't know
> in advance which algorithms are in use), and the interface giving us
> back a pointer to the start of the final entry rather than a pointer to
> the end of the log - as a result, we need to parse the final entry to
> figure out its length in order to know how much data to copy up to the
> OS.
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

This signoff doesn't belong here I think?

> ---
>  drivers/firmware/efi/libstub/tpm.c | 57 ++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index 5bd04f75d8d6..b3f30448e454 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -8,8 +8,13 @@
>   *     Thiebaud Weksteen <tweek@google.com>
>   */
>  #include <linux/efi.h>
> -#include <linux/tpm_eventlog.h>
>  #include <asm/efi.h>
> +/*
> + * KASAN redefines memcpy() in a way that isn't available in the EFI stub.
> + * We need to include asm/efi.h before linux/tpm_eventlog.h in order to avoid
> + * the wrong memcpy() being referenced.
> + */
> +#include <linux/tpm_eventlog.h>
>

Please drop this hunk. I just sent out a patch to fix this properly.

>  #include "efistub.h"
>
> @@ -57,7 +62,7 @@ void efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg)
>
>  #endif
>
> -static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
> +void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
>  {
>         efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
>         efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
> @@ -67,6 +72,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
>         unsigned long first_entry_addr, last_entry_addr;
>         size_t log_size, last_entry_size;
>         efi_bool_t truncated;
> +       int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
>         void *tcg2_protocol = NULL;
>
>         status = efi_call_early(locate_protocol, &tcg2_guid, NULL,
> @@ -74,14 +80,20 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
>         if (status != EFI_SUCCESS)
>                 return;
>
> -       status = efi_call_proto(efi_tcg2_protocol, get_event_log, tcg2_protocol,
> -                               EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2,
> -                               &log_location, &log_last_entry, &truncated);
> -       if (status != EFI_SUCCESS)
> -               return;
> +       status = efi_call_proto(efi_tcg2_protocol, get_event_log,
> +                               tcg2_protocol, version, &log_location,
> +                               &log_last_entry, &truncated);
> +
> +       if (status != EFI_SUCCESS || !log_location) {
> +               version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +               status = efi_call_proto(efi_tcg2_protocol, get_event_log,
> +                                       tcg2_protocol, version, &log_location,
> +                                       &log_last_entry, &truncated);
> +               if (status != EFI_SUCCESS || !log_location)
> +                       return;
> +
> +       }
>
> -       if (!log_location)
> -               return;
>         first_entry_addr = (unsigned long) log_location;
>
>         /*
> @@ -96,8 +108,23 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
>                  * We need to calculate its size to deduce the full size of
>                  * the logs.
>                  */
> -               last_entry_size = sizeof(struct tcpa_event) +
> -                       ((struct tcpa_event *) last_entry_addr)->event_size;
> +               if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> +                       /*
> +                        * The TCG2 log format has variable length entries,
> +                        * and the information to decode the hash algorithms
> +                        * back into a size is contained in the first entry -
> +                        * pass a pointer to the final entry (to calculate its
> +                        * size) and the first entry (so we know how long each
> +                        * digest is)
> +                        */
> +                       last_entry_size =
> +                               __calc_tpm2_event_size((void *)last_entry_addr,
> +                                                   (void *)(long)log_location,
> +                                                   false);
> +               } else {
> +                       last_entry_size = sizeof(struct tcpa_event) +
> +                          ((struct tcpa_event *) last_entry_addr)->event_size;
> +               }
>                 log_size = log_last_entry - log_location + last_entry_size;
>         }
>
> @@ -114,7 +141,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
>
>         memset(log_tbl, 0, sizeof(*log_tbl) + log_size);
>         log_tbl->size = log_size;
> -       log_tbl->version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +       log_tbl->version = version;
>         memcpy(log_tbl->log, (void *) first_entry_addr, log_size);
>
>         status = efi_call_early(install_configuration_table,
> @@ -126,9 +153,3 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
>  err_free:
>         efi_call_early(free_pool, log_tbl);
>  }
> -
> -void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
> -{
> -       /* Only try to retrieve the logs in 1.2 format. */
> -       efi_retrieve_tpm2_eventlog_1_2(sys_table_arg);
> -}
> --
> 2.21.0.1020.gf2820cf01a-goog
>
