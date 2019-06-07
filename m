Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2441B39765
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 23:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfFGVK7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 17:10:59 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37389 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbfFGVK7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 17:10:59 -0400
Received: by mail-it1-f196.google.com with SMTP id x22so4892836itl.2
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 14:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4a7+rGe39eGfULpW96XoMuPpB4xDYe154ZCg/ax41c=;
        b=Y0gY+Dm7TXd69LSMLXLZzTRJyi9kdGOTGxQ6kRro/DN0/Xa5MbIxVWKlc/oTwG2y66
         3X0wElKuXuY8KVPTBNmvCRCE2ujx1S0ZzwPeer5JRqo3AfbP85LT0WQ+ltSIrkkta+UN
         4HatcYPP36vSl15R1DEFyFYzjHzyCXs806bd4sytEP8/gU1hYtK48Ms8HlPmgzkUoxrv
         2GR9UICtdiupoE5Axr+OuDUAPsXEVKi2EkxOOsDn/M2jrmZpf52zwk33iEfbeWojzm59
         Fmjidf125R5nhP5QX0IvrS35eR89Ta8xj0TkB6twGN+ixGsVGFDxEdNcAzuRoVLxX/Te
         0Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4a7+rGe39eGfULpW96XoMuPpB4xDYe154ZCg/ax41c=;
        b=Le3T6tNRFdQmuTsV4DXVYOiiEh2/w+Zf3kLuDYsh48v/QiGTEykoXRYW8EnQe5DhHB
         MqfudLJG5vMDWrbcWAT8hVKlmLIksoUI74WADFaXuI/PiPfxGdi8DLGQt5sHGI9nag/X
         FnBMOAfIqbaCZlyVQ9MjaigNCiAhi3sy5qv92p5YeXeelc2XA9+Thknt461NCZi2E/5x
         3eVo2H1fJxO3R641QiCTYCU01qlDaCqdfIE45i8fTPx+E28jlUb+ZU86EEExrlc+9SP6
         pZWHK2hj1DM03SAm/Xm+BvRA4Ex4iFqdl1yRUrowBw0pRp3pLye0kFiWxsXx3Pc14zyn
         drww==
X-Gm-Message-State: APjAAAX7d7A3NXcYeTvT+np7IuzjiJxia+9R7tR+F/1Y+AMBXJ0Ad96w
        zgj2DU6EP2Dd7xIkQrymUjOdudbntBoiBi9qz7GrIA==
X-Google-Smtp-Source: APXvYqz9F1fMh+7cBaI49cBQfr1oz2O9gqHvl8iEgmDIjMnzJVGGDnXYZN3fyMkQ2bZcY/EJ0Jlq3Gmt6dUaGqblCOA=
X-Received: by 2002:a02:b01c:: with SMTP id p28mr37501466jah.130.1559941858294;
 Fri, 07 Jun 2019 14:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190607205147.102904-1-matthewgarrett@google.com>
In-Reply-To: <20190607205147.102904-1-matthewgarrett@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Jun 2019 23:10:46 +0200
Message-ID: <CAKv+Gu9AsK++7-UQGX0s_RFQiLEHP+d3rjR4pa2v5L0OX0AW3w@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] Abstract out support for locating an EFI config table
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 7 Jun 2019 at 22:52, Matthew Garrett <matthewgarrett@google.com> wrote:
>
> We want to grab a pointer to the TPM final events table, so abstract out
> the existing code for finding an FDT table and make it generic.
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  .../firmware/efi/libstub/efi-stub-helper.c    | 15 +++++++++++
>  drivers/firmware/efi/libstub/efistub.h        |  2 ++
>  drivers/firmware/efi/libstub/fdt.c            | 27 +++++++------------
>  3 files changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index e4610e72b78f..1db780c0f07b 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -926,3 +926,18 @@ efi_status_t efi_exit_boot_services(efi_system_table_t *sys_table_arg,
>  fail:
>         return status;
>  }
> +
> +void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
> +{
> +       efi_config_table_t *tables = (efi_config_table_t *)sys_table->tables;
> +       int i;
> +
> +       for (i = 0; i < sys_table->nr_tables; i++) {
> +               if (efi_guidcmp(tables[i].guid, guid) != 0)
> +                       continue;
> +
> +               return (void *)tables[i].table;
> +       }
> +
> +       return NULL;
> +}
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 1b1dfcaa6fb9..7f1556fd867d 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -65,6 +65,8 @@ efi_status_t check_platform_features(efi_system_table_t *sys_table_arg);
>
>  efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
>
> +void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid);
> +
>  /* Helper macros for the usual case of using simple C variables: */
>  #ifndef fdt_setprop_inplace_var
>  #define fdt_setprop_inplace_var(fdt, node_offset, name, var) \
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 5440ba17a1c5..0bf0190917e0 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -363,26 +363,17 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
>
>  void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
>  {
> -       efi_guid_t fdt_guid = DEVICE_TREE_GUID;
> -       efi_config_table_t *tables;
> -       int i;
> +       void *fdt;
>
> -       tables = (efi_config_table_t *)sys_table->tables;
> +       fdt = get_efi_config_table(sys_table, DEVICE_TREE_GUID);
>
> -       for (i = 0; i < sys_table->nr_tables; i++) {
> -               void *fdt;
> +       if (!fdt)
> +               return NULL;
>
> -               if (efi_guidcmp(tables[i].guid, fdt_guid) != 0)
> -                       continue;
> -
> -               fdt = (void *)tables[i].table;
> -               if (fdt_check_header(fdt) != 0) {
> -                       pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
> -                       return NULL;
> -               }
> -               *fdt_size = fdt_totalsize(fdt);
> -               return fdt;
> +       if (fdt_check_header(fdt) != 0) {
> +               pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
> +               return NULL;
>         }
> -
> -       return NULL;
> +       *fdt_size = fdt_totalsize(fdt);
> +       return fdt;
>  }

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
