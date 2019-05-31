Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A130A34
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2019 10:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfEaIY2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 May 2019 04:24:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34762 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaIY2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 May 2019 04:24:28 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so7506706iot.1
        for <linux-efi@vger.kernel.org>; Fri, 31 May 2019 01:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBe3bvl9MKcQgZxJza1ZuTOa5KHMCfYsCuRzXHbCq04=;
        b=iFA8RMq7lnSVWXCSumWGwGOMijPyYKxcbxfUBbdrd9HTG/AD/FM5Gr7BdFsoJc7UfY
         W8PjV81GNJnQ1BKZXFn90BDgqKM+wlADKtXIkijJ/+nTEmEsz2D/O2QxC8S7mq+AZWKl
         p0KqOQGBT7VQ/Ppy95XJ8d+iek+IY6o+QF88X+WeN7l1563UFR/kkVnQhmiL0EOrFiz0
         Cc3bSgL+ulCiiSOceNFGv6xZY3VZl/XjCBIsFIVvz1Uu6mJsyN8fd3KGurEvvRbqiBqp
         iz5X+uqBD7+zavDgMP8RWV+jGOESx8XEdOcrQZ+uaC3b5J1Ap+kvHX6lS1eFk32JKElh
         Qy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBe3bvl9MKcQgZxJza1ZuTOa5KHMCfYsCuRzXHbCq04=;
        b=c3zqCTKDLIVEfZc4ZkpE9u5fjZraVpGeotIaVGnpMJS/g9qQss5xLmYUZs97IcSnmb
         R/9cNguMFjxpsdxPXxwoEEzaf3V/K8GS74SOSJlqfRAHx1HAqoei2yQtBv3brzpLKv5A
         ELObBHsiXkC8ii0w+TlcG1smQzuoCJCTa8y1P77R4bigzVG54d+STD+wTZE0eFqT0PNI
         /Sf7dBz2U6QOTamHNEbcITOVqHQ9VgSe1gVXG3nCubPeIwOyoplzN00IkJ+i2xquYBTM
         q2GfDOgiFRUThgFVbQ1QaSz2fRsT+cpyRGbc2AaueDEjcbPUDYFSC5V2M0Hs7xINuLjZ
         BE9A==
X-Gm-Message-State: APjAAAW8iSbfVnRbA9b0KY0RHBIlpsM90L+Uhs+0qQs8yG52JcAyaJd0
        yuYDsZ/tZkechh5DIVdBV9Ex0DqHSz/uj4kK0wbwog==
X-Google-Smtp-Source: APXvYqwO5ElCRmp5GVYIDdRbg0irv0GEbx6GUGP+87EQPiP0ii6bC5/URMK3rB8LOr4h0Asd0OP056kW2xz8f4/p0kk=
X-Received: by 2002:a5e:c24b:: with SMTP id w11mr5784887iop.111.1559291066748;
 Fri, 31 May 2019 01:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190520205501.177637-1-matthewgarrett@google.com> <20190520205501.177637-3-matthewgarrett@google.com>
In-Reply-To: <20190520205501.177637-3-matthewgarrett@google.com>
From:   Joe Richey <joerichey@google.com>
Date:   Fri, 31 May 2019 01:24:15 -0700
Message-ID: <CAKpBdu0kMoZMMn4FqQSYJGMmk-_+Fd1JjhycRym9R4TfHiGSQw@mail.gmail.com>
Subject: Re: [PATCH V7 2/4] tpm: Reserve the TPM final events table
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        bsz@semihalf.com, Matthew Garrett <mjg59@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002f90cd058a2abe71"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--0000000000002f90cd058a2abe71
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2019 at 1:55 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
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
> ---
>  drivers/char/tpm/eventlog/tpm2.c |   2 +-
>  drivers/firmware/efi/efi.c       |   2 +
>  drivers/firmware/efi/tpm.c       |  62 ++++++++++++++++++-
>  include/linux/efi.h              |   9 +++
>  include/linux/tpm_eventlog.h     | 102 ++++++++++++++++++++++++++++---
>  5 files changed, 164 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog=
/tpm2.c
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
>  static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *po=
s)
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 55b77c576c42..6b11c41e0575 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -53,6 +53,7 @@ struct efi __read_mostly efi =3D {
>         .mem_attr_table         =3D EFI_INVALID_TABLE_ADDR,
>         .rng_seed               =3D EFI_INVALID_TABLE_ADDR,
>         .tpm_log                =3D EFI_INVALID_TABLE_ADDR,
> +       .tpm_final_log          =3D EFI_INVALID_TABLE_ADDR,
>         .mem_reserve            =3D EFI_INVALID_TABLE_ADDR,
>  };
>  EXPORT_SYMBOL(efi);
> @@ -485,6 +486,7 @@ static __initdata efi_config_table_type_t common_tabl=
es[] =3D {
>         {EFI_MEMORY_ATTRIBUTES_TABLE_GUID, "MEMATTR", &efi.mem_attr_table=
},
>         {LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &efi.rng_seed},
>         {LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
> +       {LINUX_EFI_TPM_FINAL_LOG_GUID, "TPMFinalLog", &efi.tpm_final_log}=
,
>         {LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &efi.mem_reserve}=
,
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
> +static int tpm2_calc_event_log_size(void *data, int count, void *size_in=
fo)
> +{
> +       struct tcg_pcr_event2_head *header;
> +       int event_size, size =3D 0;
> +
> +       while (count > 0) {
> +               header =3D data + size;
> +               event_size =3D __calc_tpm2_event_size(header, size_info, =
true);
> +               if (event_size =3D=3D 0)
> +                       return -1;
> +               size +=3D event_size;
> +               count--;
> +       }
> +
> +       return size;
> +}
> +
>  /*
>   * Reserve the memory associated with the TPM Event Log configuration ta=
ble.
>   */
>  int __init efi_tpm_eventlog_init(void)
>  {
>         struct linux_efi_tpm_eventlog *log_tbl;
> +       struct efi_tcg2_final_events_table *final_tbl;
>         unsigned int tbl_size;
> +       int ret =3D 0;
>
> -       if (efi.tpm_log =3D=3D EFI_INVALID_TABLE_ADDR)
> +       if (efi.tpm_log =3D=3D EFI_INVALID_TABLE_ADDR) {
> +               /*
> +                * We can't calculate the size of the final events withou=
t the
> +                * first entry in the TPM log, so bail here.
> +                */
>                 return 0;
> +       }
>
>         log_tbl =3D early_memremap(efi.tpm_log, sizeof(*log_tbl));
>         if (!log_tbl) {
>                 pr_err("Failed to map TPM Event Log table @ 0x%lx\n",
> -                       efi.tpm_log);
> +                      efi.tpm_log);
>                 efi.tpm_log =3D EFI_INVALID_TABLE_ADDR;
>                 return -ENOMEM;
>         }
>
>         tbl_size =3D sizeof(*log_tbl) + log_tbl->size;
>         memblock_reserve(efi.tpm_log, tbl_size);
> +
> +       if (efi.tpm_final_log =3D=3D EFI_INVALID_TABLE_ADDR)
> +               goto out;
> +
> +       final_tbl =3D early_memremap(efi.tpm_final_log, sizeof(*final_tbl=
));
> +
> +       if (!final_tbl) {
> +               pr_err("Failed to map TPM Final Event Log table @ 0x%lx\n=
",
> +                      efi.tpm_final_log);
> +               efi.tpm_final_log =3D EFI_INVALID_TABLE_ADDR;
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       tbl_size =3D tpm2_calc_event_log_size(efi.tpm_final_log
> +                                           + sizeof(final_tbl->version)
> +                                           + sizeof(final_tbl->nr_events=
),
This line causes:
warning: passing argument 1 of =E2=80=98tpm2_calc_event_log_size=E2=80=99 m=
akes
pointer from integer without a cast

> +                                           final_tbl->nr_events,
> +                                           log_tbl->log);
> +       memblock_reserve((unsigned long)final_tbl,
> +                        tbl_size + sizeof(*final_tbl));
> +       early_memunmap(final_tbl, sizeof(*final_tbl));
> +       efi_tpm_final_log_size =3D tbl_size;
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
>  #define LINUX_EFI_LOADER_ENTRY_GUID            EFI_GUID(0x4a67b082, 0x0a=
4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
>  #define LINUX_EFI_RANDOM_SEED_TABLE_GUID       EFI_GUID(0x1ce1e5bc, 0x7c=
eb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
>  #define LINUX_EFI_TPM_EVENT_LOG_GUID           EFI_GUID(0xb7799cb0, 0xec=
a2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
> +#define LINUX_EFI_TPM_FINAL_LOG_GUID           EFI_GUID(0x1e2ed096, 0x30=
e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
>  #define LINUX_EFI_MEMRESERVE_TABLE_GUID                EFI_GUID(0x888eb0=
c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
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
>   * @event_header: Pointer to the initial event containing the digest len=
gths
> + * @do_mapping:   Whether or not the event needs to be mapped
>   *
>   * The TPM2 event log format can contain multiple digests corresponding =
to
>   * separate PCR banks, and also contains a variable length of the data t=
hat
> @@ -131,10 +156,13 @@ struct tcg_pcr_event2_head {
>   */
>
>  static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *eve=
nt,
> -                                        struct tcg_pcr_event *event_head=
er)
> +                                        struct tcg_pcr_event *event_head=
er,
> +                                        bool do_mapping)
>  {
>         struct tcg_efi_specid_event_head *efispecid;
>         struct tcg_event_field *event_field;
> +       void *mapping =3D NULL;
> +       int mapping_size;
>         void *marker;
>         void *marker_start;
>         u32 halg_size;
> @@ -148,16 +176,49 @@ static inline int __calc_tpm2_event_size(struct tcg=
_pcr_event2_head *event,
>         marker =3D marker + sizeof(event->pcr_idx) + sizeof(event->event_=
type)
>                 + sizeof(event->count);
>
> +       /* Map the event header */
> +       if (do_mapping) {
> +               mapping_size =3D marker - marker_start;
> +               mapping =3D TPM_MEMREMAP((unsigned long)marker_start,
> +                                      mapping_size);
> +               if (!mapping) {
> +                       size =3D 0;
> +                       goto out;
> +               }
> +       } else {
> +               mapping =3D marker_start;
> +       }
> +
> +       event =3D (struct tcg_pcr_event2_head *)mapping;
> +
>         efispecid =3D (struct tcg_efi_specid_event_head *)event_header->e=
vent;
>
>         /* Check if event is malformed. */
> -       if (event->count > efispecid->num_algs)
> -               return 0;
> +       if (event->count > efispecid->num_algs) {
> +               size =3D 0;
> +               goto out;
> +       }
>
>         for (i =3D 0; i < event->count; i++) {
>                 halg_size =3D sizeof(event->digests[i].alg_id);
> -               memcpy(&halg, marker, halg_size);
> +
> +               /* Map the digest's algorithm identifier */
> +               if (do_mapping) {
> +                       TPM_MEMUNMAP(mapping, mapping_size);
> +                       mapping_size =3D halg_size;
> +                       mapping =3D TPM_MEMREMAP((unsigned long)marker,
> +                                            mapping_size);
> +                       if (!mapping) {
> +                               size =3D 0;
> +                               goto out;
> +                       }
> +               } else {
> +                       mapping =3D marker;
> +               }
> +
> +               memcpy(&halg, mapping, halg_size);
>                 marker =3D marker + halg_size;
> +
>                 for (j =3D 0; j < efispecid->num_algs; j++) {
>                         if (halg =3D=3D efispecid->digest_sizes[j].alg_id=
) {
>                                 marker +=3D
> @@ -166,18 +227,41 @@ static inline int __calc_tpm2_event_size(struct tcg=
_pcr_event2_head *event,
>                         }
>                 }
>                 /* Algorithm without known length. Such event is unparsea=
ble. */
> -               if (j =3D=3D efispecid->num_algs)
> -                       return 0;
> +               if (j =3D=3D efispecid->num_algs) {
> +                       size =3D 0;
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
> +               mapping_size +=3D sizeof(event_field->event_size);
> +               mapping =3D TPM_MEMREMAP((unsigned long)marker,
> +                                      mapping_size);
> +               if (!mapping) {
> +                       size =3D 0;
> +                       goto out;
> +               }
> +       } else {
> +               mapping =3D marker;
>         }
>
> -       event_field =3D (struct tcg_event_field *)marker;
> +       event_field =3D (struct tcg_event_field *)mapping;
> +
>         marker =3D marker + sizeof(event_field->event_size)
>                 + event_field->event_size;
>         size =3D marker - marker_start;
>
>         if ((event->event_type =3D=3D 0) && (event_field->event_size =3D=
=3D 0))
> -               return 0;
> -
> +               size =3D 0;
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

--0000000000002f90cd058a2abe71
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS7QYJKoZIhvcNAQcCoIIS3jCCEtoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBTMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
QAYIKwYBBQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWlt
ZWNhMS5jcnQwHQYDVR0OBBYEFG6/jgVXjk39iBARYUuHmZCsTrTrMB8GA1UdIwQYMBaAFMs4ErDH
mcB4koyzIZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0
dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQBtJ4NaR/zX
2J1ZDXrnIxYq0ncG1ChsKj1V6wae7E6B4hbWl0aBAcmKc+yuwrQpcaBsD0UnW5r6OBTRVigQrCe9
wuPrZSf0m+W2YtEaIalAY5z4lRk8Ejs9x7ao9IQefPMnlBAu4J3P2yPr2Z/H6kR7IAeoqRh74hRt
R0A3/jv+yqtVggpgW+GcSVII3+i6d1UWyZ36pyz/XDPj9U9sxyv0SP/nmVQ/fa84EU3K2waJe3JK
8Ouzzz+TKaX8Z+L0b3BirVkYIWbNig6VTzh75FQwVSOqRSJeSNypbshDB2Hui+ptRyhQxRDKfdWX
ravwoP1khGyAfyNl91xqxNPlfqmWMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIM
XsN7dVzFxfwQ99yiMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA6YYz4Uf0xk8dm
C2OtIx4+gd2r8ku+ToHUxTX+bo6U3jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0xOTA1MzEwODI0MjdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAKWIodnlpaVIdN+YwzbEbLfOzGXeUIavO
aNKrjgEBS504+vR/nruG/jIy1X0B3hXwZgZDQx3/n8BUvb3R/Nv/rY2tBZSJ9HllkgBtsfQUS8OB
mAKdVFkSHOq1upTLDEKaY1Otrkjbk29JF1JeOwqVdkeGZSP/1/MPt6c9t1FXNRMH+8CSLdwlNdjb
NwcTGMKp96xbnDYfCC5EJ+KUw5jW5IIYa5TR5R9M8J7425PQEKvylMzkuzzwp4LN9nQLCUInfX9N
gdt4WOn87N1q+1KF6MwSoIpVy+BsOZveLjd4Wi4YUmtJfUSzh9J31te5Gm4/ND1bpWEJN2+RWE9Y
6y466g==
--0000000000002f90cd058a2abe71--
