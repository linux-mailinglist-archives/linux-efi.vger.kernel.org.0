Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4E14192F5B
	for <lists+linux-efi@lfdr.de>; Wed, 25 Mar 2020 18:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgCYRe2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Mar 2020 13:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbgCYRe2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Mar 2020 13:34:28 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1326C20740
        for <linux-efi@vger.kernel.org>; Wed, 25 Mar 2020 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585157667;
        bh=94llP6pxjUCSz+E2JwEvEnVMsGf+o3HmJYs0SY1dkEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vyXdMn6LTB/ZBJzJhU2OkW9K764yEb3/kcpYsk4VE8oguctYxcN1JMCLn2eToI9Mi
         L3LteaIGqZWzFgcFJ111bgVS12QXLFrq4JRSIXSO4YfczFADBC+lkJqsA3VywPSYaA
         IGT7gQMHQDjQ0YXx/X+4kxrXEwsfRQYQEOWD5aoU=
Received: by mail-wm1-f50.google.com with SMTP id m3so3747581wmi.0
        for <linux-efi@vger.kernel.org>; Wed, 25 Mar 2020 10:34:27 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0WbDOVX70XCpnyPv7qLv6sIRautu70++OTctcWN/fGijqasDZI
        +ehZwKIyx9rtTj8Z+3RLhP3qi0N8j0R5bj2YRXNg6A==
X-Google-Smtp-Source: ADFU+vtGlUbKLQBPPKXRCRMI0idw94HVW4lJVSi/Z2iQoS/wuuAPgA48VyGt0m52Nx33CoeTFmfRRRtUqhUwE/hc5Lo=
X-Received: by 2002:a1c:de87:: with SMTP id v129mr4344376wmg.40.1585157665490;
 Wed, 25 Mar 2020 10:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200312011324.70701-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20200312011324.70701-1-qiuxu.zhuo@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 Mar 2020 18:34:14 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_p56925-Grfk0GAtju8BTsShGx0wDMWe4MeqkVQg1QZQ@mail.gmail.com>
Message-ID: <CAKv+Gu_p56925-Grfk0GAtju8BTsShGx0wDMWe4MeqkVQg1QZQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] efi: Add 'nr_config_table' variable in efi structure
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Gao, Liming" <liming.gao@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Mar 2020 at 02:12, Qiuxu Zhuo <qiuxu.zhuo@intel.com> wrote:
>
> The 'nr_config_table' and 'config_table' (already in efi structure)
> in efi structure provide a way for some driver(e.g. capsule-pstore
> goes through the configuration table to extract crash capsules to
> aid in debugging) to iterate over the EFI configuration table array.
>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

As indicated in my reply to your cover letter, I don't think we need
this patch. Please drop it.

> ---
>  arch/x86/platform/efi/efi.c     | 1 +
>  drivers/firmware/efi/arm-init.c | 4 +++-
>  drivers/firmware/efi/efi.c      | 1 +
>  include/linux/efi.h             | 1 +
>  4 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index ae923ee8e2b4..2f3065905e8a 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -456,6 +456,7 @@ void __init efi_init(void)
>                 return;
>
>         efi.config_table = (unsigned long)efi.systab->tables;
> +       efi.nr_config_table = (unsigned long)efi.systab->nr_tables;
>         efi.fw_vendor    = (unsigned long)efi.systab->fw_vendor;
>         efi.runtime      = (unsigned long)efi.systab->runtime;
>
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index d99f5b0c8a09..f2e2e1c1624b 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -143,8 +143,10 @@ static int __init uefi_init(void)
>                                          sizeof(efi_config_table_t),
>                                          arch_tables);
>
> -       if (!retval)
> +       if (!retval) {
>                 efi.config_table = (unsigned long)efi.systab->tables;
> +               efi.nr_config_table = (unsigned long)efi.systab->nr_tables;
> +       }
>
>         early_memunmap(config_tables, table_size);
>  out:
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 621220ab3d0e..1b599941bad3 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -46,6 +46,7 @@ struct efi __read_mostly efi = {
>         .fw_vendor              = EFI_INVALID_TABLE_ADDR,
>         .runtime                = EFI_INVALID_TABLE_ADDR,
>         .config_table           = EFI_INVALID_TABLE_ADDR,
> +       .nr_config_table        = 0,
>         .esrt                   = EFI_INVALID_TABLE_ADDR,
>         .properties_table       = EFI_INVALID_TABLE_ADDR,
>         .mem_attr_table         = EFI_INVALID_TABLE_ADDR,
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7efd7072cca5..13b3fe069f1f 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -913,6 +913,7 @@ extern struct efi {
>         unsigned long fw_vendor;        /* fw_vendor */
>         unsigned long runtime;          /* runtime table */
>         unsigned long config_table;     /* config tables */
> +       unsigned long nr_config_table; /* the number of config tables */
>         unsigned long esrt;             /* ESRT table */
>         unsigned long properties_table; /* properties table */
>         unsigned long mem_attr_table;   /* memory attributes table */
> --
> 2.17.1
>
