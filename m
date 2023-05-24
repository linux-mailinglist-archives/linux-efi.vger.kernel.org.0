Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE8B70F8C8
	for <lists+linux-efi@lfdr.de>; Wed, 24 May 2023 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjEXOco convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Wed, 24 May 2023 10:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjEXOcn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 May 2023 10:32:43 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1826412E;
        Wed, 24 May 2023 07:32:41 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-94ea38c90ccso25719166b.1;
        Wed, 24 May 2023 07:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684938759; x=1687530759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31tbtpS/xtUTs4cItuML+a0DpTH2qwD/GhPYfwUQ6mU=;
        b=cEwDCsed1jhPe6e5xB+jEA0N4nkFxbOZIeQgWzJxg+WHlkwwASR9W6WsZ/Yw3/CULd
         3Pu56sA8CwVebi67inD0pLC1GHFEA3WcplR+KOpWB8AP8P5KU5110ks5nIa7pmZNJILl
         vbP+qNAyol9GUjrW/hdS6B1LchT1kpSxS5A13QTTQ9i+ILkg34bcxsjiZ4u00p/fBDBk
         kRSGPgIHpYL8sbGatkWjrkgYt3syO9pdoTdG0dOWTPgCr73jv6e8VtK3/j8Gdfsza04n
         0785qxKQFHkDcN4zIO/3cjOIFMhksNI0Q3Emm9C32K9UDgR41tFK863c71LWcbppF2MN
         qpcA==
X-Gm-Message-State: AC+VfDzDW+I6wGzvYFwQFqj8keKQWf3T9TCQJdNNGcgqHQm+42GK59h2
        s6vAjFvPNKJ6pB0Wni1XWBfJMjG6MxiH3tPdo/wyaOUU
X-Google-Smtp-Source: ACHHUZ4AJe2tQs2IpRiAPESgv85dqq908HA8Bz3yMGLrHTLQ7VAUWUG3mXG0j44lgX0oaltY05fmFB3cyMXNbd+C9zo=
X-Received: by 2002:a17:906:72d4:b0:96f:da08:d451 with SMTP id
 m20-20020a17090672d400b0096fda08d451mr9168213ejl.6.1684938759307; Wed, 24 May
 2023 07:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230523190226.3860727-1-arnd@kernel.org>
In-Reply-To: <20230523190226.3860727-1-arnd@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 16:32:27 +0200
Message-ID: <CAJZ5v0grS85Vk6MM9kgHaSp4ta5osdOLSSgc2OiFG0Gev=CynQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] efi: fix missing prototype warnings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 23, 2023 at 9:02 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The cper.c file needs to include an extra header, and efi_zboot_entry
> needs an extern declaration to avoid these 'make W=1' warnings:
>
> drivers/firmware/efi/libstub/zboot.c:65:1: error: no previous prototype for 'efi_zboot_entry' [-Werror=missing-prototypes]
> drivers/firmware/efi/efi.c:176:16: error: no previous prototype for 'efi_attr_is_visible' [-Werror=missing-prototypes]
> drivers/firmware/efi/cper.c:626:6: error: no previous prototype for 'cper_estatus_print' [-Werror=missing-prototypes]
> drivers/firmware/efi/cper.c:649:5: error: no previous prototype for 'cper_estatus_check_header' [-Werror=missing-prototypes]
> drivers/firmware/efi/cper.c:662:5: error: no previous prototype for 'cper_estatus_check' [-Werror=missing-prototypes]
>
> To make this easier, move the cper specific declarations to
> include/linux/cper.h.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For the APEI change:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v2: move the prototypes rather than including a file in a different
> subdir
> ---
>  drivers/acpi/apei/apei-internal.h      | 6 ------
>  drivers/acpi/apei/bert.c               | 1 +
>  drivers/firmware/efi/libstub/efistub.h | 3 +++
>  include/linux/cper.h                   | 6 ++++++
>  include/linux/efi.h                    | 2 ++
>  5 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index 1d6ef9654725..67c2c3b959e1 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -7,7 +7,6 @@
>  #ifndef APEI_INTERNAL_H
>  #define APEI_INTERNAL_H
>
> -#include <linux/cper.h>
>  #include <linux/acpi.h>
>
>  struct apei_exec_context;
> @@ -130,10 +129,5 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>                 return sizeof(*estatus) + estatus->data_length;
>  }
>
> -void cper_estatus_print(const char *pfx,
> -                       const struct acpi_hest_generic_status *estatus);
> -int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus);
> -int cper_estatus_check(const struct acpi_hest_generic_status *estatus);
> -
>  int apei_osc_setup(void);
>  #endif
> diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
> index c23eb75866d0..7514e38d5640 100644
> --- a/drivers/acpi/apei/bert.c
> +++ b/drivers/acpi/apei/bert.c
> @@ -23,6 +23,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/acpi.h>
> +#include <linux/cper.h>
>  #include <linux/io.h>
>
>  #include "apei-internal.h"
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 67d5a20802e0..54a2822cae77 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1133,4 +1133,7 @@ const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
>  void efi_remap_image(unsigned long image_base, unsigned alloc_size,
>                      unsigned long code_size);
>
> +asmlinkage efi_status_t __efiapi
> +efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab);
> +
>  #endif
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index eacb7dd7b3af..c1a7dc325121 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -572,4 +572,10 @@ void cper_print_proc_ia(const char *pfx,
>  int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
>  int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg);
>
> +struct acpi_hest_generic_status;
> +void cper_estatus_print(const char *pfx,
> +                       const struct acpi_hest_generic_status *estatus);
> +int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus);
> +int cper_estatus_check(const struct acpi_hest_generic_status *estatus);
> +
>  #endif
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index bed3c92cbc31..120af31a5136 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1349,4 +1349,6 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
>         return xen_efi_config_table_is_usable(guid, table);
>  }
>
> +umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
> +
>  #endif /* _LINUX_EFI_H */
> --
> 2.39.2
>
