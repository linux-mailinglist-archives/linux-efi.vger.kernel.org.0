Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFCD24B87
	for <lists+linux-efi@lfdr.de>; Tue, 21 May 2019 11:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfEUJaA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 May 2019 05:30:00 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36264 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfEUJ37 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 May 2019 05:29:59 -0400
Received: by mail-it1-f193.google.com with SMTP id e184so3633248ite.1
        for <linux-efi@vger.kernel.org>; Tue, 21 May 2019 02:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1X7RPyDDh/5LU3TKjTQyaNcPFI+lus2fRNzZlC+wAQ=;
        b=UTq/WQWRhNKLecTeiHcYuq5MEo+veMAQHD+tz7nj16YdLHQG8S/TaFf5PieSOHM/BZ
         d212GNVnR5VjOtWyEC05eLM+qr3llTerx1t7OQgnim3op76MlUIfTt0wBQdQdywAgRvx
         jeC0crRHgn0GsznDCPHN0tdaguqYXjBeNs8nLKWUzaZtrLeDpIM/A43SqokfJnAS1BYr
         +mO2mzbcH5gc8zF5wDN/XaCOpnDKxvTLAeV5w8NIFUD5wIJmi/SeP7maq9LGpXRAT1Kk
         ve9TeeJcGMkhIPz7Bsk/NQbL3+RCrgqrOck74IDzV22G5dQaib5FCBOolSxmAs9G/W6m
         iCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1X7RPyDDh/5LU3TKjTQyaNcPFI+lus2fRNzZlC+wAQ=;
        b=rk3X/s68vKnTe8nnA/Ki+RkrxY3nQqHnBZUj9sH/zlJlVC9xrTm50LajrrGd6t/h7d
         pinbwgythdAVGl7X/a5M5wMD4s1RastRhXwtq91x1JRGvBrNxKX0Rtr2Hrm09ZQs9HkS
         KgVaSEsndvBC8KoV77wCSNtInmLDdQ2SwQOPOz0zg/GnbsVUnQu0x67X1xg3Z2H7pMQ3
         VNPLJzOpXaltLiasVC51hIYV+O8NpWfCsB97JFuHeomviy18QvJUuCVSikyI/I/fA0ls
         HysHVR+ZFkSlQb6/xfopcjrc0D1qw41U0+vPyS5gFIyq2l6jI/mrpn+I57N7ur9sv6L5
         4xBQ==
X-Gm-Message-State: APjAAAV0PUmEFu1OOB5oG/ZkPmnQba0nqcyamJp6l9934MnmV/LwtoJn
        QzJxwsiQac2MGzwvvGVZbTcxL7IVqmpVq6vV+D4ozw==
X-Google-Smtp-Source: APXvYqxobjoRHd2DJzZU+eTKwPAU+2v8nden+IAXKosaOj3W1wy3uq2/SYh9+tlKJC6BYmNIlpoaXiBPIyIupu2Vxw8=
X-Received: by 2002:a24:ca84:: with SMTP id k126mr2801293itg.104.1558430998765;
 Tue, 21 May 2019 02:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190520205501.177637-1-matthewgarrett@google.com> <20190520205501.177637-3-matthewgarrett@google.com>
In-Reply-To: <20190520205501.177637-3-matthewgarrett@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 21 May 2019 10:29:47 +0100
Message-ID: <CAKv+Gu8Wpjq90xVkRxSd2JhJxwk7z+SaGhsX=-LvVvDNBWMdNg@mail.gmail.com>
Subject: Re: [PATCH V7 2/4] tpm: Reserve the TPM final events table
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

On Mon, 20 May 2019 at 21:55, Matthew Garrett <matthewgarrett@google.com> wrote:
>
> From: Matthew Garrett <mjg59@google.com>
>
> UEFI systems provide a boot services protocol for obtaining the TPM
> event log, but this is unusable after ExitBootServices() is called.
> Unfortunately ExitBootServices() itself triggers additional TPM events
> that then can't be obtained using this protocol. The platform provides a
> mechanism for the OS to obtain these events by recording them to a
> separate UEFI configuration table which the OS can then map.
>
> Unfortunately this table isn't self describing in terms of providing its
> length, so we need to parse the events inside it to figure out how long
> it is. Since the table isn't mapped at this point, we need to extend the
> length calculation function to be able to map the event as it goes
> along.
>
> (Fixes by Bartosz Szczepanek <bsz@semihalf.com>)
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/char/tpm/eventlog/tpm2.c |   2 +-
>  drivers/firmware/efi/efi.c       |   2 +
>  drivers/firmware/efi/tpm.c       |  62 ++++++++++++++++++-
>  include/linux/efi.h              |   9 +++
>  include/linux/tpm_eventlog.h     | 102 ++++++++++++++++++++++++++++---
>  5 files changed, 164 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
> index 1a977bdd3bd2..de1d9f7e5a92 100644
> --- a/drivers/char/tpm/eventlog/tpm2.c
> +++ b/drivers/char/tpm/eventlog/tpm2.c
> @@ -40,7 +40,7 @@
>  static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>                                    struct tcg_pcr_event *event_header)
>  {
> -       return __calc_tpm2_event_size(event, event_header);
> +       return __calc_tpm2_event_size(event, event_header, false);
>  }
>
>  static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 55b77c576c42..6b11c41e0575 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -53,6 +53,7 @@ struct efi __read_mostly efi = {
>         .mem_attr_table         = EFI_INVALID_TABLE_ADDR,
>         .rng_seed               = EFI_INVALID_TABLE_ADDR,
>         .tpm_log                = EFI_INVALID_TABLE_ADDR,
> +       .tpm_final_log          = EFI_INVALID_TABLE_ADDR,
>         .mem_reserve            = EFI_INVALID_TABLE_ADDR,
>  };
>  EXPORT_SYMBOL(efi);
> @@ -485,6 +486,7 @@ static __initdata efi_config_table_type_t common_tables[] = {
>         {EFI_MEMORY_ATTRIBUTES_TABLE_GUID, "MEMATTR", &efi.mem_attr_table},
>         {LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &efi.rng_seed},
>         {LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
> +       {LINUX_EFI_TPM_FINAL_LOG_GUID, "TPMFinalLog", &efi.tpm_final_log},
>         {LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &efi.mem_reserve},
>         {NULL_GUID, NULL, NULL},
>  };
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 3a689b40ccc0..2c912ea08166 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -4,34 +4,90 @@
>   *     Thiebaud Weksteen <tweek@google.com>
>   */
>
> +#define TPM_MEMREMAP(start, size) early_memremap(start, size)
> +#define TPM_MEMUNMAP(start, size) early_memunmap(start, size)
> +
>  #include <linux/efi.h>
>  #include <linux/init.h>
>  #include <linux/memblock.h>
> +#include <linux/tpm_eventlog.h>
>
>  #include <asm/early_ioremap.h>
>
> +int efi_tpm_final_log_size;
> +EXPORT_SYMBOL(efi_tpm_final_log_size);
> +
> +static int tpm2_calc_event_log_size(void *data, int count, void *size_info)
> +{
> +       struct tcg_pcr_event2_head *header;
> +       int event_size, size = 0;
> +
> +       while (count > 0) {
> +               header = data + size;
> +               event_size = __calc_tpm2_event_size(header, size_info, true);
> +               if (event_size == 0)
> +                       return -1;
> +               size += event_size;
> +               count--;
> +       }
> +
> +       return size;
> +}
> +
>  /*
>   * Reserve the memory associated with the TPM Event Log configuration table.
>   */
>  int __init efi_tpm_eventlog_init(void)
>  {
>         struct linux_efi_tpm_eventlog *log_tbl;
> +       struct efi_tcg2_final_events_table *final_tbl;
>         unsigned int tbl_size;
> +       int ret = 0;
>
> -       if (efi.tpm_log == EFI_INVALID_TABLE_ADDR)
> +       if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {
> +               /*
> +                * We can't calculate the size of the final events without the
> +                * first entry in the TPM log, so bail here.
> +                */
>                 return 0;
> +       }
>
>         log_tbl = early_memremap(efi.tpm_log, sizeof(*log_tbl));
>         if (!log_tbl) {
>                 pr_err("Failed to map TPM Event Log table @ 0x%lx\n",
> -                       efi.tpm_log);
> +                      efi.tpm_log);
>                 efi.tpm_log = EFI_INVALID_TABLE_ADDR;
>                 return -ENOMEM;
>         }
>
>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
>         memblock_reserve(efi.tpm_log, tbl_size);
> +
> +       if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR)
> +               goto out;
> +
> +       final_tbl = early_memremap(efi.tpm_final_log, sizeof(*final_tbl));
> +
> +       if (!final_tbl) {
> +               pr_err("Failed to map TPM Final Event Log table @ 0x%lx\n",
> +                      efi.tpm_final_log);
> +               efi.tpm_final_log = EFI_INVALID_TABLE_ADDR;
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       tbl_size = tpm2_calc_event_log_size(efi.tpm_final_log
> +                                           + sizeof(final_tbl->version)
> +                                           + sizeof(final_tbl->nr_events),
> +                                           final_tbl->nr_events,
> +                                           log_tbl->log);
> +       memblock_reserve((unsigned long)final_tbl,
> +                        tbl_size + sizeof(*final_tbl));
> +       early_memunmap(final_tbl, sizeof(*final_tbl));
> +       efi_tpm_final_log_size = tbl_size;
> +
> +out:
>         early_memunmap(log_tbl, sizeof(*log_tbl));
> -       return 0;
> +       return ret;
>  }
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 54357a258b35..e33c70a52a9d 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -689,6 +689,7 @@ void efi_native_runtime_setup(void);
>  #define LINUX_EFI_LOADER_ENTRY_GUID            EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
>  #define LINUX_EFI_RANDOM_SEED_TABLE_GUID       EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
>  #define LINUX_EFI_TPM_EVENT_LOG_GUID           EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
> +#define LINUX_EFI_TPM_FINAL_LOG_GUID           EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
>  #define LINUX_EFI_MEMRESERVE_TABLE_GUID                EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
>
>  typedef struct {
> @@ -996,6 +997,7 @@ extern struct efi {
>         unsigned long mem_attr_table;   /* memory attributes table */
>         unsigned long rng_seed;         /* UEFI firmware random seed */
>         unsigned long tpm_log;          /* TPM2 Event Log table */
> +       unsigned long tpm_final_log;    /* TPM2 Final Events Log table */
>         unsigned long mem_reserve;      /* Linux EFI memreserve table */
>         efi_get_time_t *get_time;
>         efi_set_time_t *set_time;
> @@ -1707,6 +1709,13 @@ struct linux_efi_tpm_eventlog {
>
>  extern int efi_tpm_eventlog_init(void);
>
> +struct efi_tcg2_final_events_table {
> +       u64 version;
> +       u64 nr_events;
> +       u8 events[];
> +};
> +extern int efi_tpm_final_log_size;
> +
>  /*
>   * efi_runtime_service() function identifiers.
>   * "NONE" is used by efi_recover_from_page_fault() to check if the page
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 6a86144e13f1..63238c84dc0b 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -112,10 +112,35 @@ struct tcg_pcr_event2_head {
>         struct tpm_digest digests[];
>  } __packed;
>
> +struct tcg_algorithm_size {
> +       u16 algorithm_id;
> +       u16 algorithm_size;
> +};
> +
> +struct tcg_algorithm_info {
> +       u8 signature[16];
> +       u32 platform_class;
> +       u8 spec_version_minor;
> +       u8 spec_version_major;
> +       u8 spec_errata;
> +       u8 uintn_size;
> +       u32 number_of_algorithms;
> +       struct tcg_algorithm_size digest_sizes[];
> +};
> +
> +#ifndef TPM_MEMREMAP
> +#define TPM_MEMREMAP(start, size) NULL
> +#endif
> +
> +#ifndef TPM_MEMUNMAP
> +#define TPM_MEMUNMAP(start, size) do{} while(0)
> +#endif
> +
>  /**
>   * __calc_tpm2_event_size - calculate the size of a TPM2 event log entry
>   * @event:        Pointer to the event whose size should be calculated
>   * @event_header: Pointer to the initial event containing the digest lengths
> + * @do_mapping:   Whether or not the event needs to be mapped
>   *
>   * The TPM2 event log format can contain multiple digests corresponding to
>   * separate PCR banks, and also contains a variable length of the data that
> @@ -131,10 +156,13 @@ struct tcg_pcr_event2_head {
>   */
>
>  static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> -                                        struct tcg_pcr_event *event_header)
> +                                        struct tcg_pcr_event *event_header,
> +                                        bool do_mapping)
>  {
>         struct tcg_efi_specid_event_head *efispecid;
>         struct tcg_event_field *event_field;
> +       void *mapping = NULL;
> +       int mapping_size;
>         void *marker;
>         void *marker_start;
>         u32 halg_size;
> @@ -148,16 +176,49 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>         marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
>                 + sizeof(event->count);
>
> +       /* Map the event header */
> +       if (do_mapping) {
> +               mapping_size = marker - marker_start;
> +               mapping = TPM_MEMREMAP((unsigned long)marker_start,
> +                                      mapping_size);
> +               if (!mapping) {
> +                       size = 0;
> +                       goto out;
> +               }
> +       } else {
> +               mapping = marker_start;
> +       }
> +
> +       event = (struct tcg_pcr_event2_head *)mapping;
> +
>         efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
>
>         /* Check if event is malformed. */
> -       if (event->count > efispecid->num_algs)
> -               return 0;
> +       if (event->count > efispecid->num_algs) {
> +               size = 0;
> +               goto out;
> +       }
>
>         for (i = 0; i < event->count; i++) {
>                 halg_size = sizeof(event->digests[i].alg_id);
> -               memcpy(&halg, marker, halg_size);
> +
> +               /* Map the digest's algorithm identifier */
> +               if (do_mapping) {
> +                       TPM_MEMUNMAP(mapping, mapping_size);
> +                       mapping_size = halg_size;
> +                       mapping = TPM_MEMREMAP((unsigned long)marker,
> +                                            mapping_size);
> +                       if (!mapping) {
> +                               size = 0;
> +                               goto out;
> +                       }
> +               } else {
> +                       mapping = marker;
> +               }
> +
> +               memcpy(&halg, mapping, halg_size);
>                 marker = marker + halg_size;
> +
>                 for (j = 0; j < efispecid->num_algs; j++) {
>                         if (halg == efispecid->digest_sizes[j].alg_id) {
>                                 marker +=
> @@ -166,18 +227,41 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>                         }
>                 }
>                 /* Algorithm without known length. Such event is unparseable. */
> -               if (j == efispecid->num_algs)
> -                       return 0;
> +               if (j == efispecid->num_algs) {
> +                       size = 0;
> +                       goto out;
> +               }
> +       }
> +
> +       /*
> +        * Map the event size - we don't read from the event itself, so
> +        * we don't need to map it
> +        */
> +       if (do_mapping) {
> +               TPM_MEMUNMAP(mapping, mapping_size);
> +               mapping_size += sizeof(event_field->event_size);
> +               mapping = TPM_MEMREMAP((unsigned long)marker,
> +                                      mapping_size);
> +               if (!mapping) {
> +                       size = 0;
> +                       goto out;
> +               }
> +       } else {
> +               mapping = marker;
>         }
>
> -       event_field = (struct tcg_event_field *)marker;
> +       event_field = (struct tcg_event_field *)mapping;
> +
>         marker = marker + sizeof(event_field->event_size)
>                 + event_field->event_size;
>         size = marker - marker_start;
>
>         if ((event->event_type == 0) && (event_field->event_size == 0))
> -               return 0;
> -
> +               size = 0;
> +out:
> +       if (do_mapping)
> +               TPM_MEMUNMAP(mapping, mapping_size);
>         return size;
>  }
> +
>  #endif
> --
> 2.21.0.1020.gf2820cf01a-goog
>
