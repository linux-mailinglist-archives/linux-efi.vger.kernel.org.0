Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C36AF727
	for <lists+linux-efi@lfdr.de>; Tue,  7 Mar 2023 22:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCGVEn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Mar 2023 16:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjCGVEj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Mar 2023 16:04:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20B091B60;
        Tue,  7 Mar 2023 13:04:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE7BFB81A16;
        Tue,  7 Mar 2023 21:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4982BC4339C;
        Tue,  7 Mar 2023 21:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678223073;
        bh=DS6yzuywiCT1bLOxlyq/uv37YqP/xjFKbdUaphEyHSE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dgy5sj5VEZUW427VZx3IXrp8AYjjouvAGwe0bArTag/9Yb9RsV3K0OJbfxORHDS8Q
         C+mM6cQHpdsyXlHaDRXoaswcuaHDO1nFm2f8xCx2h41JZDIAPHCMIsp6+kVnosRNDg
         e56hatBvoWurrz3dBaElEPnPTn2JxjcAyYKR5GT9oZ4ZcxtNyrGsKbZt3fuqLr2NnF
         uqSaAygXhvHUoc2yaaK3gHyAy4BsTCoHSL10NTffTuF6SvXofCkRSBjU/aHSSj3d1R
         8diTwB0KtpKoI8FjItM9DI1M7vvHvyI3qi/mKFpRoCEX0VRCBGXyL8/iBjc3ZTzVyA
         0HEFUJy/EriLw==
Received: by mail-lf1-f50.google.com with SMTP id s20so18777905lfb.11;
        Tue, 07 Mar 2023 13:04:33 -0800 (PST)
X-Gm-Message-State: AO0yUKWR++Z7NznjCz4UuRwNynruz3FrusUYv4ov84u/N9rjf0yjXxjy
        OJLHH8T5wKfg+b3LwjQHBPVcf+080uwL6fVYVqg=
X-Google-Smtp-Source: AK7set8R2LFjtHPeN1T2CzNK7J9UpFg/SpVEV4mEneQfihwSgPhnHHmdfhBxvh3AVHx3/vqTIYYjVc4CcbWRd/DfTKk=
X-Received: by 2002:a19:7517:0:b0:4dd:805b:5b75 with SMTP id
 y23-20020a197517000000b004dd805b5b75mr4865609lfe.7.1678223071275; Tue, 07 Mar
 2023 13:04:31 -0800 (PST)
MIME-Version: 1.0
References: <20230307203356.882479-1-helgaas@kernel.org>
In-Reply-To: <20230307203356.882479-1-helgaas@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Mar 2023 22:04:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF35gT_pfg0XsWVssnG-_h-XFw_3oQ_kemr4FOYoXXmkA@mail.gmail.com>
Message-ID: <CAMj1kXF35gT_pfg0XsWVssnG-_h-XFw_3oQ_kemr4FOYoXXmkA@mail.gmail.com>
Subject: Re: [PATCH] cper-arm: Remove unnecessary aer.h include
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Mar 2023 at 21:34, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> <linux/aer.h> is unused, so remove it.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Feel free to take this, or otherwise I can queue it as a fix.

> ---
>  drivers/firmware/efi/cper-arm.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
> index 36d3b8b9da47..fa9c1c3bf168 100644
> --- a/drivers/firmware/efi/cper-arm.c
> +++ b/drivers/firmware/efi/cper-arm.c
> @@ -12,7 +12,6 @@
>  #include <linux/dmi.h>
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
> -#include <linux/aer.h>
>  #include <linux/printk.h>
>  #include <linux/bcd.h>
>  #include <acpi/ghes.h>
> --
> 2.25.1
>
