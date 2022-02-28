Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B22C4C71E8
	for <lists+linux-efi@lfdr.de>; Mon, 28 Feb 2022 17:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiB1Qqt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Feb 2022 11:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiB1Qqt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Feb 2022 11:46:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D75E694AD;
        Mon, 28 Feb 2022 08:46:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4223A61287;
        Mon, 28 Feb 2022 16:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D784C340F0;
        Mon, 28 Feb 2022 16:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646066765;
        bh=dNMO+y5r7S1RpzbmjvoBeO0lP33wFZ9Dgn/kJUsKbMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vtd/0n+GZXUMrEnaliViycb3tvSKAv5tgYj6MSPOMv5NV+VnkxhoJeoyLxHG/bZdA
         A+Ts8UOmTOY1P9oldac9kNkqzmlr4+XPEDdH2q+vUD9jFblWNyoS7qnBAnbJ1roovf
         nJyfgs/5elUdKtdea1F/Pj5u6C/aCom516RdDtZGrjZyyuz3KNS8V1mu4YiO9v15cH
         R4b0yggsxH/H8XF8n9aake+RAaap/eBM25dm/XrTLxVKOAtYWrvDljspLuWIMlRRCV
         wfZkt/uOkFOFbqCYZTzorUuNtK9ZkN+Mc5zaXZVZYoJ34kA3C0PO/rigv+67M8RdGC
         dqysJxed8Kv9A==
Received: by mail-yb1-f173.google.com with SMTP id w63so21697083ybe.10;
        Mon, 28 Feb 2022 08:46:05 -0800 (PST)
X-Gm-Message-State: AOAM532N1eYrFpdvqtY2/aGc4/kY7kyfoLaDeLegVikY9dm8Yyza7GxJ
        2C9aS0+i2RkIpTSHpM0yc7/CO5detzkFsvYVWjI=
X-Google-Smtp-Source: ABdhPJwAY7S8L1gKE1sVwGEO2B+Kak5FtQoUfWwIg8wYKyehkdeJy6gXURdid5dJuLchR2Il2/yZuRWBsoZXGf1m3co=
X-Received: by 2002:a25:58f:0:b0:628:67cd:c6b4 with SMTP id
 137-20020a25058f000000b0062867cdc6b4mr1426853ybf.533.1646066764724; Mon, 28
 Feb 2022 08:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20220224154330.26564-1-baskov@ispras.ru>
In-Reply-To: <20220224154330.26564-1-baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Feb 2022 17:45:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
Message-ID: <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] Handle UEFI NX-restricted page tables
To:     Baskov Evgeniy <baskov@ispras.ru>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

(cc Matt and Peter)

On Thu, 24 Feb 2022 at 16:45, Baskov Evgeniy <baskov@ispras.ru> wrote:
>
> This is another implementation of this patch. It uses DXE services
> to change memory protection flags as you suggested earlier.
>
> As I mentioned, you can reproduce this issue with any firmware,
> including OVMF by setting the PcdDxeNxMemoryProtectionPolicy policy:
> gEfiMdeModulePkgTokenSpaceGuid.PcdDxeNxMemoryProtectionPolicy|0x7FD4
> Restricting the user from creating executable pages is not an goal,
> but restricting one from creating both executable and writable pages
> is a goal, which is enforced in the firmware we use. We cannot allow
> allocating pages of any type that have RWX permissions.
> gDS->SetMemorySpaceAttributes() is technically part of the UEFI PI
> specification, so it is not too bad to rely on it. However:
> - DXE services is not something designed to be used by an UEFI application.
> - From what we know, no other operating system uses this interface,
> which means that it can easily break in production firmware on the
> boards we do not control before anyone could even notice.
> We do not strictly mind experimenting with this route, but it would be
> preferable for this interface to become more standard in this case:
> move it to UEFI Boot Services or a separate protocol and include it in
> UEFI conformance suite. It will also help if we enable this feature in
> Linux by default.
>

Thanks for exploring my suggestion to use the DXE services for this.

Given that this is a workaround for a very specific issue arising on
PI based implementations of UEFI, I consider this a quirk, and so I
think this approach is reasonable. I'd still like to gate it on some
kind of identification, though - perhaps something related to DMI like
the x86 core kernel does as well.

I've cc'ed Peter and Matt, who have much more experience dealing with
these kinds of things on x86 - my experience is mostly based on ARM,
which tends to be less quirky when it comes to UEFI support, given
that vendors that implement EFI actually care about being compliant
(instead of only about getting a windows sticker)

Matt, Peter, any thoughts?


> Baskov Evgeniy (2):
>        efi: declare DXE services table
>        libstub: ensure allocated memory to be executable
>
>  arch/x86/include/asm/efi.h              |  5 ++
>  drivers/firmware/efi/libstub/efistub.h  | 53 ++++++++++++++++++++
>  drivers/firmware/efi/libstub/x86-stub.c | 73 ++++++++++++++++++++++++++--
>  include/linux/efi.h                     |  2 +
>  4 files changed, 128 insertions(+), 5 deletions(-)
