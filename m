Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C011F3976C
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 23:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfFGVLf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 17:11:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:32878 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfFGVLe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 17:11:34 -0400
Received: by mail-it1-f196.google.com with SMTP id v193so5450067itc.0
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vz3v2cfJNJDIvZEsvbNPjIPnlqpxgDzyV60ZGJWzfhQ=;
        b=UEqDKuK3YV4RlCo0JnvLnVbGkIMtd0HzIHUsbBvNm2xTqDKMyWFbdR2Rl3hk4c323b
         BcYKSUeaQ428PkatGG/uFFh5Mx2pk556WowLcWnugppzTmpWtQG0mmXcR3Bbq138mrzM
         MT2HLbAUM+faba8gkNciABRm4uxDnbCM9rKaqT5iy5Gs/9Xh/u1q/nJlE62x+t+yblAj
         Ne3hZuhGBzmLdtMvD3FZzYZSztFkSidQXp4Y4/zERp2nYRFHTdSSWrpi0XEcKFHs7a6F
         a+VAdZmBr0d300qRzaneXpSZrYLSKZB73O3KWqgbqCUWfnrYw9uZN17N5BaLVMUKCFvB
         hqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vz3v2cfJNJDIvZEsvbNPjIPnlqpxgDzyV60ZGJWzfhQ=;
        b=p3A5PWKy8UQ/WB0F9NrAdceaWxMGh6viVDUSD3EAM5q6osbaAasOO9HN/0WBSnXoR4
         ifg1/IV+us5NQy6MfN+MzLczlFMWRujbvwPEavs3dr9DNAGveZO8FPjotGSAnxX4jxBJ
         vVZoxiZmbLYlo0K0jo8vmzFMUPUHrLpafALfLwzdbmqMzna5gvpagwxuXytqLb7OPm0M
         NAXcltgy5MJ+PtWsiXSsFPEUXZOWnWcu8/BRyRubTjp0/44NKeORgAaKbofYH31xWXYa
         i8TlL6uExYWHVAtUAzQ6MmaL5SGHoaTmmfjSU22vxPaGyV43agtavqojcB7SSzJwqUBp
         9CUA==
X-Gm-Message-State: APjAAAW0LH5y7heCbWiqJNpE31RDEqNqAMIPChSkJLYlwQFMl6i9ssKg
        zkSrtjUBw+MjVQ9ijwtoO1OYZg86rAn88nAOyZ89uA==
X-Google-Smtp-Source: APXvYqwZIbdfnW45HY5l6VgkLwXLgEisz7LjMwanxfS5rvIogJHlbwFmD0j7GpVuAFWc+YOV6XNZHjau4YRVy4+06YM=
X-Received: by 2002:a05:660c:44a:: with SMTP id d10mr5182000itl.153.1559941893361;
 Fri, 07 Jun 2019 14:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190607205147.102904-1-matthewgarrett@google.com> <20190607205147.102904-2-matthewgarrett@google.com>
In-Reply-To: <20190607205147.102904-2-matthewgarrett@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Jun 2019 23:11:21 +0200
Message-ID: <CAKv+Gu-Vz8OSspw9RdEnVj3e7GFaNdA9PVVMWY2RKkEDfAbuRA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] tpm: Don't duplicate events from the final event
 log in the TCG2 log
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Joe Richey <joerichey@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 7 Jun 2019 at 22:52, Matthew Garrett <matthewgarrett@google.com> wrote:
>
> After the first call to GetEventLog() on UEFI systems using the TCG2
> crypto agile log format, any further log events (other than those
> triggered by ExitBootServices()) will be logged in both the main log and
> also in the Final Events Log. While the kernel only calls GetEventLog()
> immediately before ExitBootServices(), we can't control whether earlier
> parts of the boot process have done so. This will result in log entries
> that exist in both logs, and so the current approach of simply appending
> the Final Event Log to the main log will result in events being
> duplicated.
>
> We can avoid this problem by looking at the size of the Final Event Log
> just before we call ExitBootServices() and exporting this to the main
> kernel. The kernel can then skip over all events that occured before
> ExitBootServices() and only append events that were not also logged to
> the main log.
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reported-by: Joe Richey <joerichey@google.com>
> Suggested-by: Joe Richey <joerichey@google.com>
> ---
>  drivers/char/tpm/eventlog/efi.c    | 11 ++++++++++-
>  drivers/firmware/efi/libstub/tpm.c | 30 ++++++++++++++++++++++++++++++
>  drivers/firmware/efi/tpm.c         |  2 +-
>  include/linux/efi.h                |  1 +
>  4 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
> index 9179cf6bdee9..be6540f2cb3d 100644
> --- a/drivers/char/tpm/eventlog/efi.c
> +++ b/drivers/char/tpm/eventlog/efi.c
> @@ -80,6 +80,8 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>                 goto out;
>         }
>
> +       efi_tpm_final_log_size -= log_tbl->final_events_preboot_size;
> +
>         tmp = krealloc(log->bios_event_log,
>                        log_size + efi_tpm_final_log_size,
>                        GFP_KERNEL);
> @@ -90,8 +92,15 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>         }
>
>         log->bios_event_log = tmp;
> +
> +       /*
> +        * Copy any of the final events log that didn't also end up in the
> +        * main log. Events can be logged in both if events are generated
> +        * between GetEventLog() and ExitBootServices().
> +        */
>         memcpy((void *)log->bios_event_log + log_size,
> -              final_tbl->events, efi_tpm_final_log_size);
> +              final_tbl->events + log_tbl->final_events_preboot_size,
> +              efi_tpm_final_log_size);
>         log->bios_event_log_end = log->bios_event_log +
>                 log_size + efi_tpm_final_log_size;
>
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index 6b3b507a54eb..eb9af83e4d59 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -64,11 +64,13 @@ void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
>         efi_status_t status;
>         efi_physical_addr_t log_location = 0, log_last_entry = 0;
>         struct linux_efi_tpm_eventlog *log_tbl = NULL;
> +       struct efi_tcg2_final_events_table *final_events_table;
>         unsigned long first_entry_addr, last_entry_addr;
>         size_t log_size, last_entry_size;
>         efi_bool_t truncated;
>         int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
>         void *tcg2_protocol = NULL;
> +       int final_events_size = 0;
>
>         status = efi_call_early(locate_protocol, &tcg2_guid, NULL,
>                                 &tcg2_protocol);
> @@ -134,8 +136,36 @@ void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
>                 return;
>         }
>
> +       /*
> +        * Figure out whether any events have already been logged to the
> +        * final events structure, and if so how much space they take up
> +        */
> +       final_events_table = get_efi_config_table(sys_table_arg,
> +                                               LINUX_EFI_TPM_FINAL_LOG_GUID);
> +       if (final_events_table && final_events_table->nr_events) {
> +               struct tcg_pcr_event2_head *header;
> +               int offset;
> +               void *data;
> +               int event_size;
> +               int i = final_events_table->nr_events;
> +
> +               data = (void *)final_events_table;
> +               offset = sizeof(final_events_table->version) +
> +                       sizeof(final_events_table->nr_events);
> +
> +               while (i > 0) {
> +                       header = data + offset + final_events_size;
> +                       event_size = __calc_tpm2_event_size(header,
> +                                                  (void *)(long)log_location,
> +                                                  false);
> +                       final_events_size += event_size;
> +                       i--;
> +               }
> +       }
> +
>         memset(log_tbl, 0, sizeof(*log_tbl) + log_size);
>         log_tbl->size = log_size;
> +       log_tbl->final_events_preboot_size = final_events_size;
>         log_tbl->version = version;
>         memcpy(log_tbl->log, (void *) first_entry_addr, log_size);
>
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 2c912ea08166..0bdceb5913aa 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -76,7 +76,7 @@ int __init efi_tpm_eventlog_init(void)
>                 goto out;
>         }
>
> -       tbl_size = tpm2_calc_event_log_size(efi.tpm_final_log
> +       tbl_size = tpm2_calc_event_log_size((void *)efi.tpm_final_log
>                                             + sizeof(final_tbl->version)
>                                             + sizeof(final_tbl->nr_events),
>                                             final_tbl->nr_events,
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index e33c70a52a9d..2a26004a9bdb 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1703,6 +1703,7 @@ struct linux_efi_random_seed {
>
>  struct linux_efi_tpm_eventlog {
>         u32     size;
> +       u32     final_events_preboot_size;
>         u8      version;
>         u8      log[];
>  };

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
