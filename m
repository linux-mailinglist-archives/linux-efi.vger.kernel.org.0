Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB024C85DF
	for <lists+linux-efi@lfdr.de>; Tue,  1 Mar 2022 09:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiCAIEK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Mar 2022 03:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiCAIEJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Mar 2022 03:04:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A70124BD8;
        Tue,  1 Mar 2022 00:03:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C529C6144E;
        Tue,  1 Mar 2022 08:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34651C340F3;
        Tue,  1 Mar 2022 08:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646121806;
        bh=ITNwfYn9yCwXS904JZzxIn6PFJtXdmjz1gwvlBHef/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XOzD6a9R4OGNSEJX1LYkmKjNE7qqjiEpEWS9hIDBX++8OPoA66Iw3Sef14Oe/BSyZ
         MyZayIkr8cPqpEh8Ebwpqic3iVE6Fy+4foJrDMTF5BunjSGGWe2bIuQQzzmXrymcYp
         X9a4wuB24gF/Z2PraBPYH/W8GARrvnYGDzCjrBQZv0G4UfaeNOzWR2BsH+JJlJ6iXN
         taf/300eWOY6qWJK5XdGuFIJpMRakfhLmgAqELEZPCDhbJ28NNoCY3PXGWdFAZfzul
         Ra9eXcdy15Q7kv2N+afg183cAQ+8Ejh47NhI9MZtq3FCEFu4xyeuCnsRlhUnS0F/CL
         IDtfh3gviFkPg==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2db2add4516so102940897b3.1;
        Tue, 01 Mar 2022 00:03:26 -0800 (PST)
X-Gm-Message-State: AOAM533S207QGlAmUoPHhNp6ujvC1BfjJmIYvxTeoNIXEsc+TzhX/Zu6
        sUxWU0QS28YppdcjAtGOEKmGiOaJsNxlkPS5ylE=
X-Google-Smtp-Source: ABdhPJyce8csgpoqsqMHhg4cLB2sjjn6KplAkAfElJEiSb2+Z5kmju7LF8JrCq5cAMKZiVIjvrzh4eQa+WHA+gHyCk0=
X-Received: by 2002:a0d:dfd5:0:b0:2cf:924b:105d with SMTP id
 i204-20020a0ddfd5000000b002cf924b105dmr24880414ywe.342.1646121805226; Tue, 01
 Mar 2022 00:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20220301041851.12459-1-rdunlap@infradead.org>
In-Reply-To: <20220301041851.12459-1-rdunlap@infradead.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Mar 2022 09:03:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEzxX9vOCaCgdqeQ1n-vwBdJemJgEEMJbSp+R+Jzpx6BA@mail.gmail.com>
Message-ID: <CAMj1kXEzxX9vOCaCgdqeQ1n-vwBdJemJgEEMJbSp+R+Jzpx6BA@mail.gmail.com>
Subject: Re: [PATCH] efi: fix return value of __setup handlers
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Igor Zhbanov <i.zhbanov@omprussia.ru>,
        linux-efi <linux-efi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Octavian Purdila <octavian.purdila@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 1 Mar 2022 at 05:19, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> When "dump_apple_properties" is used on the kernel boot command line,
> it causes an Unknown parameter message and the string is added to init's
> argument strings:
>
>   Unknown kernel command line parameters "dump_apple_properties
>     BOOT_IMAGE=/boot/bzImage-517rc6 efivar_ssdt=newcpu_ssdt", will be
>     passed to user space.
>
>  Run /sbin/init as init process
>    with arguments:
>      /sbin/init
>      dump_apple_properties
>    with environment:
>      HOME=/
>      TERM=linux
>      BOOT_IMAGE=/boot/bzImage-517rc6
>      efivar_ssdt=newcpu_ssdt
>
> Similarly when "efivar_ssdt=somestring" is used, it is added to the
> Unknown parameter message and to init's environment strings, polluting
> them (see examples above).
>
> Change the return value of the __setup functions to 1 to indicate
> that the __setup options have been handled.
>
> Fixes: 58c5475aba67 ("x86/efi: Retrieve and assign Apple device properties")
> Fixes: 475fb4e8b2f4 ("efi / ACPI: load SSTDs from EFI variables")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Octavian Purdila <octavian.purdila@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>

Queued as a fix,

Thanks,
Ard.

> ---
>  drivers/firmware/efi/apple-properties.c |    2 +-
>  drivers/firmware/efi/efi.c              |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20220228.orig/drivers/firmware/efi/apple-properties.c
> +++ linux-next-20220228/drivers/firmware/efi/apple-properties.c
> @@ -24,7 +24,7 @@ static bool dump_properties __initdata;
>  static int __init dump_properties_enable(char *arg)
>  {
>         dump_properties = true;
> -       return 0;
> +       return 1;
>  }
>
>  __setup("dump_apple_properties", dump_properties_enable);
> --- linux-next-20220228.orig/drivers/firmware/efi/efi.c
> +++ linux-next-20220228/drivers/firmware/efi/efi.c
> @@ -212,7 +212,7 @@ static int __init efivar_ssdt_setup(char
>                 memcpy(efivar_ssdt, str, strlen(str));
>         else
>                 pr_warn("efivar_ssdt: name too long: %s\n", str);
> -       return 0;
> +       return 1;
>  }
>  __setup("efivar_ssdt=", efivar_ssdt_setup);
>
