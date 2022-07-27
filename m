Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C455829DB
	for <lists+linux-efi@lfdr.de>; Wed, 27 Jul 2022 17:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiG0Pn4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Jul 2022 11:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiG0Pnz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Jul 2022 11:43:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E42481F4;
        Wed, 27 Jul 2022 08:43:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 827E4B821AA;
        Wed, 27 Jul 2022 15:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171BAC433D6;
        Wed, 27 Jul 2022 15:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658936632;
        bh=FhzP6EtnAyU3KDS3EJ6iYz+5mn6jLVkjW8YztmcGl4k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LCLB/LIQxfVkquDX3qAy2D0nZdtjV+Ds/HXkxqoMR42lNB7iJRVtmwgx0dTWRKYyz
         jNUyzWebY2xgaUm1VfU6MbZQzh3ucAhjBHcByhXD9tr0rM6VQR4l7GEGmftdqKZRAI
         XYVwCXpNA9vBk0nVEjuGpXM7BMjH5R3h7X9tidjj1undBXE690jkwEEwqUEJcw4+21
         jx6JExl7aaMI7p1gyLpvFjC9dWEuxTt/KLAUVH24JByWuzyQrCfsP5atm6nzzdi3yY
         Q9tNRwdeRjGz/eghn2vs8Udb9ZU1WEeGsVmMfqeiD+mR/FnSjT/1zBFVuHi+JGsomh
         CCnDWX/kRNpQw==
Received: by mail-ot1-f42.google.com with SMTP id by10-20020a056830608a00b0061c1ac80e1dso13110057otb.13;
        Wed, 27 Jul 2022 08:43:52 -0700 (PDT)
X-Gm-Message-State: AJIora/IXQGRRtqpuO0oNP+E05xtCAY9GrSibmvtkuNj982pT539lDws
        B8mBhm/pH+N94bnp3UZy6p2X+4dYtiVNvlEE4JY=
X-Google-Smtp-Source: AGRyM1s3kCkD6CwNrVCc39W46O1zjkQNs7TTMmOfnDc110tVRPISSko2luED84ZKGorpnBEUF8TJK42jOZZaFgvUvo8=
X-Received: by 2002:a9d:2f2a:0:b0:61c:cc5a:22b with SMTP id
 h39-20020a9d2f2a000000b0061ccc5a022bmr8656111otb.71.1658936631138; Wed, 27
 Jul 2022 08:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220727140539.10021-1-jprvita@endlessos.org>
In-Reply-To: <20220727140539.10021-1-jprvita@endlessos.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 27 Jul 2022 08:43:40 -0700
X-Gmail-Original-Message-ID: <CAMj1kXH4fOqdj4EN8r+=SvRLcn_ky1hKWqHzOG5csAc8P5QVog@mail.gmail.com>
Message-ID: <CAMj1kXH4fOqdj4EN8r+=SvRLcn_ky1hKWqHzOG5csAc8P5QVog@mail.gmail.com>
Subject: Re: [PATCH] docs: efi-stub: Fix paths for x86 / arm stubs
To:     =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux@endlessos.org,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessos.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 27 Jul 2022 at 07:06, Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.com=
> wrote:
>
> This fixes the paths of x86 / arm efi-stub source files.
>
> Signed-off-by: Jo=C3=A3o Paulo Rechi Vita <jprvita@endlessos.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  Documentation/admin-guide/efi-stub.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin=
-guide/efi-stub.rst
> index 833edb0d0bc4..b24e7c40d832 100644
> --- a/Documentation/admin-guide/efi-stub.rst
> +++ b/Documentation/admin-guide/efi-stub.rst
> @@ -7,10 +7,10 @@ as a PE/COFF image, thereby convincing EFI firmware loa=
ders to load
>  it as an EFI executable. The code that modifies the bzImage header,
>  along with the EFI-specific entry point that the firmware loader
>  jumps to are collectively known as the "EFI boot stub", and live in
> -arch/x86/boot/header.S and arch/x86/boot/compressed/eboot.c,
> +arch/x86/boot/header.S and drivers/firmware/efi/libstub/x86-stub.c,
>  respectively. For ARM the EFI stub is implemented in
>  arch/arm/boot/compressed/efi-header.S and
> -arch/arm/boot/compressed/efi-stub.c. EFI stub code that is shared
> +drivers/firmware/efi/libstub/arm32-stub.c. EFI stub code that is shared
>  between architectures is in drivers/firmware/efi/libstub.
>
>  For arm64, there is no compressed kernel support, so the Image itself
> --
> 2.20.1
>
