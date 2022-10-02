Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AA25F23DC
	for <lists+linux-efi@lfdr.de>; Sun,  2 Oct 2022 17:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJBP2c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Oct 2022 11:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBP2b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Oct 2022 11:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54013C173
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 08:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E3A660EEA
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 15:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC784C433D7
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664724509;
        bh=dy82pQG7ql0IwW+viUNLh+icWSzz3k+/LHJT8RbQjtQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cOvFu0R8bBfUuxa2VzCKCfDr8fQ16Pyt/Ks9J8lwiS7rZ+F81/jFcOqEIiq1tA2w8
         U0CetRc9XbJXn4aWrSpIHgS2ydoVrmf4hneU2Y+zN1B+vD8tKsbUnOqK3tHcbz2CPA
         evBEP4fHyFg4wxgc9B+jpRQObzd/frt3IjWIbSvPsi3KASymF5bEE5eonyUaxTvCza
         kOgOySHINWpuj5MrdOVHSgq87Mca7nLRjVyfCnahsoTJW9qAiyEcKo1auAgFeaEic2
         Ya2pYLt2ilurMwrO2zoOTe4q8P/INEF3XX/MzSme7PJ3SJTEGguz7puTMbcgdC4zab
         NCgZsN98wbgKg==
Received: by mail-lj1-f176.google.com with SMTP id q17so9445993lji.11
        for <linux-efi@vger.kernel.org>; Sun, 02 Oct 2022 08:28:29 -0700 (PDT)
X-Gm-Message-State: ACrzQf2Tg27ABgt6vTqHDZk669TSmtQuuwcgmlm02MhddXAGlUdWpJUM
        foHpfTifykSNzWrz7ytYNIIN9fHGQxMOmhucNJg=
X-Google-Smtp-Source: AMsMyM5B7F+JgYcyGL2iUKTCV3/Lbf9Ibma4A9fZgLpF7+smYgYYA0w17jmPT559APVn8pVrS8qLLIEoMiN4am7BqTU=
X-Received: by 2002:a05:651c:b13:b0:26c:679f:ea66 with SMTP id
 b19-20020a05651c0b1300b0026c679fea66mr5682185ljr.516.1664724507844; Sun, 02
 Oct 2022 08:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221002150037.ad3tgbllhvt6zwwy@tartarus.xdbob.net>
In-Reply-To: <20221002150037.ad3tgbllhvt6zwwy@tartarus.xdbob.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 2 Oct 2022 17:28:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGqtoX7yVgCu+5mmFUiRCytyxrgJnRjD6LwnA4C-L6=2w@mail.gmail.com>
Message-ID: <CAMj1kXGqtoX7yVgCu+5mmFUiRCytyxrgJnRjD6LwnA4C-L6=2w@mail.gmail.com>
Subject: Re: Disable lockdown while keeping SecureBoot enabled
To:     Antoine Damhet <antoine@damhet.fr>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 2 Oct 2022 at 17:00, Antoine Damhet <antoine@damhet.fr> wrote:
>
> Hello,
>
> Since `5f56a74cc0a6d9b9f8ba89cea29cd7c4774cb2b1`[1] I can't have both
> SecureBoot enabled and lockdown disabled (I need to do that to allow
> undervolting on my intel laptop).
>
> My current bootchain is:
>
> systemd-boot -> kernel+initrd+cmdline as a unified kernel image and
> signed using a personal custom key. I don't use the shim loader.
>
> Until now I disabled the lockdown by setting the `MokSBState` +
> `MokSBStateRT` UEFI variables to 1. Now they need to be volatile.
>

OK, so this means the patch works as intended: MokSBState is owned by
shim, and you are not booting via shim, and so honouring those
variables was a bug.

> Would you be open to either add a variable or a command-line argument to
> disable the kernel lockdown while keeping SecureBoot enabled ?

Can't you just omit the lockdown LSM from your kernel build?

> If so
> what would be the right way to express it ?
>
> Thanks,
>
> [1]: https://lore.kernel.org/linux-efi/20220920153743.3598053-1-ardb@kernel.org/
>
> --
> Antoine 'xdbob' Damhet
