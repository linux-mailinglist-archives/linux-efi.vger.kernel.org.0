Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A466051E7
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 23:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJSVXQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 17:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJSVXP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 17:23:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAA518D821;
        Wed, 19 Oct 2022 14:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C6F1619CB;
        Wed, 19 Oct 2022 21:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ACDC43470;
        Wed, 19 Oct 2022 21:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666214593;
        bh=JRvVcp/rqi1K8yZPC/1qfvyLBzl4zZ4GfoWHrtACY4o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L+0qF3UebihgTSDn0LdCsyS2+SClgm7ZMNFljE+1PnVvRSszMXLZIj1BRyzlme9vw
         PXQ9dVsU3d1J9svfXroQftez3O09Xf/leA0Zsx21Nymplw2aZZe9PYLQdEdu8KBtl8
         NqvKHkXDPsouk3l2P8+v+Chbq/I2/V7r13vkXO6cxypCUvdEW8KAM8ph3/G0oAQ1Tu
         3QRaIfjaHAKcUuPdbQ9U0V+IYOwodSm255vyqGo/UiV8hA6DqM4tk3BDbFQ4tu0Zv6
         pwoF1/KP2LXRqCAiOGUlQ/s09h2I5xRMCgR0fRz9QbcK6AJNcWt8OldHpZqtfQ3FjD
         sBiUvKKtJXpXQ==
Received: by mail-lf1-f46.google.com with SMTP id j4so30347108lfk.0;
        Wed, 19 Oct 2022 14:23:13 -0700 (PDT)
X-Gm-Message-State: ACrzQf1TJTIysfraUqc5CQViMrJ8yFeiBEwKBTAPDjXcncck9j1+yRkq
        mg1DbP00nPaVT09QEJTDSgen2psMhQ3YYfErM5I=
X-Google-Smtp-Source: AMsMyM5Zw9wNz4cXzIBSsR+mxUtdGnWlCcT5ojzAmUiDolf8SLSjfYeoNwMuL5tK6FI5p1w0fGd7SNAbshR3AvAQnmQ=
X-Received: by 2002:a05:6512:314a:b0:4a2:d0b9:aa20 with SMTP id
 s10-20020a056512314a00b004a2d0b9aa20mr4025751lfi.110.1666214591460; Wed, 19
 Oct 2022 14:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <23DC077F-69DF-402C-A940-2E7EEABF2D97@live.com>
In-Reply-To: <23DC077F-69DF-402C-A940-2E7EEABF2D97@live.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 23:23:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG03-0AdM_ROf2UhH-N2Z52v7ox_emSQw=y5p3sMeTrMA@mail.gmail.com>
Message-ID: <CAMj1kXG03-0AdM_ROf2UhH-N2Z52v7ox_emSQw=y5p3sMeTrMA@mail.gmail.com>
Subject: Re: [REGRESSION] Failure to write the NVRAM variables starting from
 kernel 6.0 on T2 Macs
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Aditya

On Wed, 19 Oct 2022 at 21:26, Aditya Garg <gargaditya08@live.com> wrote:
>
> Starting from linux kernel 6.0, the ability to write to the NVRAM has been lost on T2 Macs.
>
> This has been observed especially during installation of boot loaders like GRUB, causing errors as shown :-
>
> Installing for x86_64-efi platform.
> grub-install: warning: Cannot set EFI variable Boot0001.
> grub-install: warning: efivarfs_set_variable: writing to fd 7 failed: Invalid argument.
> grub-install: warning: _efi_set_variable_mode: ops->set_variable() failed: Invalid argument.
> grub-install: error: failed to register the EFI boot entry: Invalid argument.
>

Thanks for the report. I did identify an issue in some refactoring
work of the efivars layer that went into 6.0

Can you please check whether the change below fixes the issue for you?

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index dd74d2ad3184..35edba93cf14 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -209,7 +209,7 @@ efivar_set_variable_blocking(efi_char16_t *name,
efi_guid_t *vendor,
        if (data_size > 0) {
                status = check_var_size(attr, data_size +
                                              ucs2_strsize(name, 1024));
-               if (status != EFI_SUCCESS)
+               if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
                        return status;
        }
        return __efivars->ops->set_variable(name, vendor, attr,
data_size, data);
@@ -242,7 +242,7 @@ efi_status_t
efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
        if (data_size > 0) {
                status = check_var_size_nonblocking(attr, data_size +

ucs2_strsize(name, 1024));
-               if (status != EFI_SUCCESS)
+               if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
                        return status;
        }
        return setvar(name, vendor, attr, data_size, data);
