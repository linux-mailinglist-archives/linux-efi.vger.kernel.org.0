Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2520C70B752
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 10:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjEVIKL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 04:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjEVIKL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 04:10:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D567DB3;
        Mon, 22 May 2023 01:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C4AE61EAE;
        Mon, 22 May 2023 08:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD320C4339C;
        Mon, 22 May 2023 08:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684743008;
        bh=EaTm1gdUesP4JYLh/QIwbO8g8A4zdbgsMTblmzL4DEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h6Y7O87X6kaQ1cygLgU9MJRSRu1FwXKs357KNy1/PVPZbny03bgBzRtNG2NceWrj5
         uwdr8eP3cEHhGgb2mu0O4DpbIQA6UuTrkOBAi+YOKMaP1oqvAnuO08RRFSeSCYNpqs
         FsLOfQVwJcpnDuKMk2b8ebZhfb9Ih3EaMY4fxnQThvrlwjeU+oAfy0krnbRTZ9t8ml
         XJIYRA5f9RBETvA/WfELqTp2U5mjdM9sr6Dt87mMKhVugb7IWeU/zbdSoW4B1tiFnT
         CwtFwoR+0hLaZCXEXWOFrBYV2EYtYLV8g8aIXoBP2KBC9ElZVrPqnh0iZ9/GYsF2ih
         4y8ojyHqEpNgQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2af278ca45eso33175741fa.1;
        Mon, 22 May 2023 01:10:08 -0700 (PDT)
X-Gm-Message-State: AC+VfDyO09Jr5sF8JTe2sSpp+gbh/UdrU+6NKpcaXvqT2aLi1vlArkFk
        Cpb+7sPMOl8x9JeWbnJGsdTlpy4BCLpotPMUmU0=
X-Google-Smtp-Source: ACHHUZ76fjHnNWcsBsf2aOxQuuYJa9gTpik6b3RqxaJOQXI+2zUP6cee//3chvzhfPIx0WLc0bZrx0DRzHC6XlGHqaE=
X-Received: by 2002:ac2:4352:0:b0:4f0:124:b56b with SMTP id
 o18-20020ac24352000000b004f00124b56bmr3058102lfl.7.1684743006832; Mon, 22 May
 2023 01:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230516201606.557548-1-arnd@kernel.org>
In-Reply-To: <20230516201606.557548-1-arnd@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 May 2023 10:09:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXELPjZ2XMebTf_pYnsba--H7PWSbLNPrcRU-tWu1r0P-w@mail.gmail.com>
Message-ID: <CAMj1kXELPjZ2XMebTf_pYnsba--H7PWSbLNPrcRU-tWu1r0P-w@mail.gmail.com>
Subject: Re: [PATCH] efi: fix missing prototype warnings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 May 2023 at 22:16, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The cper.c file needs to include an extra header, and
> efi_zboot_entry needs an extern declaration to avoid these
> 'make W=1' warnings:
>
> drivers/firmware/efi/libstub/zboot.c:65:1: error: no previous prototype for 'efi_zboot_entry' [-Werror=missing-prototypes]
> drivers/firmware/efi/efi.c:176:16: error: no previous prototype for 'efi_attr_is_visible' [-Werror=missing-prototypes]
> drivers/firmware/efi/cper.c:626:6: error: no previous prototype for 'cper_estatus_print' [-Werror=missing-prototypes]
> drivers/firmware/efi/cper.c:649:5: error: no previous prototype for 'cper_estatus_check_header' [-Werror=missing-prototypes]
> drivers/firmware/efi/cper.c:662:5: error: no previous prototype for 'cper_estatus_check' [-Werror=missing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/firmware/efi/cper.c            | 1 +
>  drivers/firmware/efi/libstub/efistub.h | 3 +++
>  include/linux/efi.h                    | 2 ++
>  3 files changed, 6 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 35c37f667781..75715c7be34a 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -25,6 +25,7 @@
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
>  #include "cper_cxl.h"
> +#include "../../acpi/apei/apei-internal.h"

Yuck. Could we move the missing definitions to linux/cper.h instead?

>
>  /*
>   * CPER record ID need to be unique even after reboot, because record
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
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7aa62c92185f..571d1a6e1b74 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1338,4 +1338,6 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
>         return xen_efi_config_table_is_usable(guid, table);
>  }
>
> +umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
> +
>  #endif /* _LINUX_EFI_H */
> --
> 2.39.2
>
