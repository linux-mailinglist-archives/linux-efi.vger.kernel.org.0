Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF6B781DE3
	for <lists+linux-efi@lfdr.de>; Sun, 20 Aug 2023 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjHTM6f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Aug 2023 08:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjHTM6e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 20 Aug 2023 08:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23DB2708;
        Sun, 20 Aug 2023 05:57:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AC8260B78;
        Sun, 20 Aug 2023 12:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FA4C433CC;
        Sun, 20 Aug 2023 12:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692536273;
        bh=fcsuD7fz9v/IclWG2I71Y/R988pOew81aApxgxsrKo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qxAgXHo7/bJiE7qroDk6Z+ooFpHeJ4hvo/rsG2kCPn/6kUNR+KrdfdzkePiWLuARV
         diJj9iPRyBoZpPJaBvNHzsfTEmXOZdde8ivdnZJIQzLQPYt6SVydD35wewi7/WZ4uj
         hy0Gk+/y2K1Xosdd0i+O9lmT59a1rPEapBzY6lmYGK29WHXrCeJvkrxx4TOZljbrOq
         umxx+Sm8gGJ0zGzpQ2+s/hm1vPW4VO8Vbo/j/YLNXs+M4rM9moS/Y7J4B9ksFlPytx
         NfdSxLXeD20ydJrlQ1da684QbqViKscPbuhBpU9RszC6VsvlZxA1gyVNj/y8Mrj7ML
         U4hV3Vl9A1+5Q==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so3838738e87.1;
        Sun, 20 Aug 2023 05:57:53 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywfqlz4MMUAzy7HDAgMmFemU7lZkdPIy21UjGqvXNwwZf5+Al8o
        MFaNLuKBv9FzwZclvoSavgkt3FImkkJliU1Oqcg=
X-Google-Smtp-Source: AGHT+IEpojHK3XclTm7bLGD1JAsiWNW/SqO6r2htVkcC5V6IFe/AT1++PbDN6Nc5YFtLB1br9bchN1/sXKBjrTK0zl8=
X-Received: by 2002:a19:385e:0:b0:4fb:bef0:948e with SMTP id
 d30-20020a19385e000000b004fbbef0948emr2196628lfj.5.1692536271618; Sun, 20 Aug
 2023 05:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230818134422.380032-1-ardb@kernel.org> <20230818134422.380032-18-ardb@kernel.org>
 <46832047-567e-5699-fbec-8c3e991cfe0a@zytor.com>
In-Reply-To: <46832047-567e-5699-fbec-8c3e991cfe0a@zytor.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 20 Aug 2023 14:57:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG5X2ZUNs2W8o5_c83fznRDjLjPZcEqEgfpFUBS1DX5Pg@mail.gmail.com>
Message-ID: <CAMj1kXG5X2ZUNs2W8o5_c83fznRDjLjPZcEqEgfpFUBS1DX5Pg@mail.gmail.com>
Subject: Re: [PATCH 17/17] x86/boot: Drop CRC-32 checksum and the build tool
 that generates it
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Marvin_H=C3=A4user?= <mhaeuser@posteo.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 20 Aug 2023 at 03:03, H. Peter Anvin <hpa@zytor.com> wrote:
>
>
>
> On 8/18/23 06:44, Ard Biesheuvel wrote:
> > The only remaining task carried out by the boot/tools/build.c build tool
> > is generating the CRC-32 checksum of the bzImage. This feature was added
> > in commit
> >
> >    7d6e737c8d2698b6 ("x86: add a crc32 checksum to the kernel image.")
> >
> > without any motivation (or any commit log text, for that matter). This
> > checksum is not verified by any known bootloader, and given that
> >
> > a) the checksum of the entire bzImage is reported by most tools (zlib,
> >     rhash) as 0xffffffff and not 0x0 as documented,
> > b) the checksum is corrupted when the image is signed for secure boot,
> >     which means that no distro ships x86 images with valid CRCs,
> >
> > it seems quite unlikely that this checksum is being used, so let's just
> > drop it, along with the tool that generates it.
> >
>
> This one I have concerns with.
>

I understand. I deliberately put this change at the very end because I
was anticipating some debate on this.

Do you have any recollection of why this CRC32 was introduced in the
first place? The commit logs are empty and the lore thread doesn't
contain any justification either.
