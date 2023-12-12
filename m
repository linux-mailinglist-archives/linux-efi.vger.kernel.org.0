Return-Path: <linux-efi+bounces-190-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D2880E83C
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 10:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941B41F212F1
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E71359143;
	Tue, 12 Dec 2023 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxHmQ+4y"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77658ADA;
	Tue, 12 Dec 2023 09:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBBFC433CB;
	Tue, 12 Dec 2023 09:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702374782;
	bh=x5x2Vt28BNZ87A+YkQlGNkExkl+Op7LxWbonnGSkuOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mxHmQ+4y+8NlyN53vheUW3IUNyqKgtqsUPFN8tyNlZadW9rRHkUULTte7thnSgDOG
	 tyUvI9un9MjfFQr6SEwXNdMvzRQXrj1PuyEaBZcz1kB+EsnerTaSsX095Zj2nib096
	 jd5Jyp/5EK+RXWSS90eBP45XW+J7u4iLCUIDkcRERD7H4IdrUiKbgH2iIyfxhMiu6U
	 y1UV45PRyyiTHBVtVdVoksnRo2De8NRo1fnoIFEYsBuCnlR/9fJDiHgW/ZQ+16wwNE
	 cnpa599TB8SDYPaTJcgFzCRmibniGQjFP12JGCDkLEMy+TyuERAjmRW6GEuYr0fT7R
	 gKbpFtWIYlmgg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ca1e6a94a4so70571881fa.0;
        Tue, 12 Dec 2023 01:53:02 -0800 (PST)
X-Gm-Message-State: AOJu0Yzhids1hesGyOcEPsmMuXejaNVwE5BpRAHNWSX3Ks4mwthPGARH
	YSoSXnJ4yUa2LV22oLesB/XI7YHJB8BvzPHEVm8=
X-Google-Smtp-Source: AGHT+IFrQVmnOb7fDDBe24yV44ELYK4VOrlITkWMjSN/4x/YbEISe3Vo9O63r3t2vwCf1enEHPoe68o5AZgC/4ddJxc=
X-Received: by 2002:a2e:a22b:0:b0:2cc:207f:4783 with SMTP id
 i11-20020a2ea22b000000b002cc207f4783mr1292561ljm.18.1702374780611; Tue, 12
 Dec 2023 01:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211-cxl-cper-v2-0-c116900ba658@intel.com> <20231211-cxl-cper-v2-6-c116900ba658@intel.com>
In-Reply-To: <20231211-cxl-cper-v2-6-c116900ba658@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 12 Dec 2023 10:52:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGogr2hc9Ofv1WTSvh3uTjuY8rHFbcVpigfd6D19qdbvw@mail.gmail.com>
Message-ID: <CAMj1kXGogr2hc9Ofv1WTSvh3uTjuY8rHFbcVpigfd6D19qdbvw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] firmware/efi: Process CXL Component Events
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Dec 2023 at 23:57, Ira Weiny <ira.weiny@intel.com> wrote:
>
> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then send
> these events to the OS via UEFI.
>
> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The difference is a GUID is used in
> the Section Type to identify the event type.
>
> Add EFI support to detect CXL CPER records and call a notifier chain
> with the record data blobs to be processed by the CXL code.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

>
> ---
> Changes from v1:
> [djbw: convert to single notifier callback]
> [djbw: append _GUID to guid defines]
> [iweiny: clean up function names]
> ---
>  drivers/firmware/efi/cper.c     | 15 ++++++++++++
>  drivers/firmware/efi/cper_cxl.c | 45 ++++++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper_cxl.h | 29 +++++++++++++++++++++++
>  include/linux/cxl-event.h       | 51 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 140 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 35c37f667781..39c65733ae9b 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -22,6 +22,7 @@
>  #include <linux/aer.h>
>  #include <linux/printk.h>
>  #include <linux/bcd.h>
> +#include <linux/cxl-event.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
>  #include "cper_cxl.h"
> @@ -607,6 +608,20 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>                         cper_print_prot_err(newpfx, prot_err);
>                 else
>                         goto err_section_too_small;
> +       } else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID) ||
> +                  guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID) ||
> +                  guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
> +               struct cper_cxl_event_rec *rec = acpi_hest_get_payload(gdata);
> +
> +               if (rec->hdr.length <= sizeof(rec->hdr))
> +                       goto err_section_too_small;
> +
> +               if (rec->hdr.length > sizeof(*rec)) {
> +                       pr_err(FW_WARN "error section length is too big\n");
> +                       return;
> +               }
> +
> +               cxl_cper_post_event(newpfx, sec_type, rec);
>         } else {
>                 const void *err = acpi_hest_get_payload(gdata);
>
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index a55771b99a97..669983f7956f 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/cper.h>
> +#include <linux/cxl-event.h>
>  #include "cper_cxl.h"
>
>  #define PROT_ERR_VALID_AGENT_TYPE              BIT_ULL(0)
> @@ -187,3 +188,47 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>                                sizeof(cxl_ras->header_log), 0);
>         }
>  }
> +
> +DECLARE_RWSEM(cxl_cper_rw_sem);
> +static cxl_cper_notifier cper_notifier;
> +
> +void cxl_cper_post_event(const char *pfx, guid_t *sec_type,
> +                        struct cper_cxl_event_rec *rec)
> +{
> +       struct cxl_cper_event_data data = {
> +               .rec = rec,
> +       };
> +
> +       if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> +               pr_err(FW_WARN "cxl event no Component Event Log present\n");
> +               return;
> +       }
> +
> +       if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID))
> +               data.event_type = CXL_CPER_EVENT_GEN_MEDIA;
> +       else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID))
> +               data.event_type = CXL_CPER_EVENT_DRAM;
> +       else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID))
> +               data.event_type = CXL_CPER_EVENT_MEM_MODULE;
> +
> +       down_read(&cxl_cper_rw_sem);
> +       if (cper_notifier)
> +               cper_notifier(&data);
> +       up_read(&cxl_cper_rw_sem);
> +}
> +
> +void cxl_cper_register_notifier(cxl_cper_notifier notifier)
> +{
> +       down_write(&cxl_cper_rw_sem);
> +       cper_notifier = notifier;
> +       up_write(&cxl_cper_rw_sem);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_register_notifier, CXL);
> +
> +void cxl_cper_unregister_notifier(void)
> +{
> +       down_write(&cxl_cper_rw_sem);
> +       cper_notifier = NULL;
> +       up_write(&cxl_cper_rw_sem);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_notifier, CXL);
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> index 86bfcf7909ec..b1b1b0514f6b 100644
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -10,11 +10,38 @@
>  #ifndef LINUX_CPER_CXL_H
>  #define LINUX_CPER_CXL_H
>
> +#include <linux/cxl-event.h>
> +
>  /* CXL Protocol Error Section */
>  #define CPER_SEC_CXL_PROT_ERR                                          \
>         GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,   \
>                   0x4B, 0x77, 0x10, 0x48)
>
> +/* CXL Event record UUIDs are formated at GUIDs and reported in section type */
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CPER_SEC_CXL_GEN_MEDIA_GUID                                    \
> +       GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,                           \
> +                 0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> +
> +/*
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +#define CPER_SEC_CXL_DRAM_GUID                                         \
> +       GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,                           \
> +                 0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
> +
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CPER_SEC_CXL_MEM_MODULE_GUID                                   \
> +       GUID_INIT(0xfe927475, 0xdd59, 0x4339,                           \
> +                 0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
> +
>  #pragma pack(1)
>
>  /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> @@ -62,5 +89,7 @@ struct cper_sec_prot_err {
>  #pragma pack()
>
>  void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
> +void cxl_cper_post_event(const char *pfx, guid_t *sec_type,
> +                        struct cper_cxl_event_rec *rec);
>
>  #endif //__CPER_CXL_
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 18dab4d90dc8..c764ff877a6d 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -108,4 +108,55 @@ struct cxl_event_record_raw {
>         union cxl_event event;
>  } __packed;
>
> +enum cxl_event_type {
> +       CXL_CPER_EVENT_GEN_MEDIA,
> +       CXL_CPER_EVENT_DRAM,
> +       CXL_CPER_EVENT_MEM_MODULE,
> +};
> +
> +#pragma pack(1)
> +
> +#define CPER_CXL_DEVICE_ID_VALID               BIT(0)
> +#define CPER_CXL_DEVICE_SN_VALID               BIT(1)
> +#define CPER_CXL_COMP_EVENT_LOG_VALID          BIT(2)
> +struct cper_cxl_event_rec {
> +       struct {
> +               u32 length;
> +               u64 validation_bits;
> +               struct cper_cxl_event_devid {
> +                       u16 vendor_id;
> +                       u16 device_id;
> +                       u8 func_num;
> +                       u8 device_num;
> +                       u8 bus_num;
> +                       u16 segment_num;
> +                       u16 slot_num; /* bits 2:0 reserved */
> +                       u8 reserved;
> +               } device_id;
> +               struct cper_cxl_event_sn {
> +                       u32 lower_dw;
> +                       u32 upper_dw;
> +               } dev_serial_num;
> +       } hdr;
> +
> +       union cxl_event event;
> +};
> +
> +struct cxl_cper_event_data {
> +       enum cxl_event_type event_type;
> +       struct cper_cxl_event_rec *rec;
> +};
> +
> +#pragma pack()
> +
> +typedef void (*cxl_cper_notifier)(struct cxl_cper_event_data *ev_data);
> +
> +#ifdef CONFIG_UEFI_CPER
> +void cxl_cper_register_notifier(cxl_cper_notifier notifier);
> +void cxl_cper_unregister_notifier(void);
> +#else
> +static inline void cxl_cper_register_notifier(cxl_cper_notifier notifier) { }
> +static inline void cxl_cper_unregister_notifier(void) { }
> +#endif
> +
>  #endif /* _LINUX_CXL_EVENT_H */
>
> --
> 2.43.0
>

