Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1AB782420
	for <lists+linux-efi@lfdr.de>; Mon, 21 Aug 2023 09:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjHUHE7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Aug 2023 03:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjHUHE6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Aug 2023 03:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831B2B8;
        Mon, 21 Aug 2023 00:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 109AE6112E;
        Mon, 21 Aug 2023 07:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50780C433CB;
        Mon, 21 Aug 2023 07:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692601491;
        bh=VNweNV1L08Rq884RMKUGXDd7wmz0jE86MHEuZ1Jj6tE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uiukNN7seQyV9G5FKIlRX6fsyrhTK2/bOfeMI+qNuDabh+SLh2xX8g6Hb8QxxqbA5
         ReQ1GoBuAlM2lwcKwYtDMFjjTBHY4DYO3n5pptpUo+uZC52InGwBNdS9rKTvFOs+Mc
         I9BAC2ihmE/e64HyBsXuTGnZHctzJjhoksI14Dg49eHyRLfgmBFndKdAE9+thhp83q
         Zv5voY67YJz644OK/5gwzzNznPdV07aWPPqN+8vSMzW+QxvSd6cyz2Tnx9AV0L0LKY
         /ERDxYZfsRV59MSTmCqnVJZWjKJKeDJHr5242aQEwNxN6gd44phqdcRTNlzqeily8Y
         dwW91v6HrzXOA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so4405815e87.2;
        Mon, 21 Aug 2023 00:04:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YxAcd2immdEhtFROUMot6iMz0v/na2P0V2DbBRxxxD78y7vucXm
        oiN0phpwaWJ2mAsGZyVofQHp01GKBKoFK8DQYqg=
X-Google-Smtp-Source: AGHT+IGuvoBE2EpEdTnjYx1Pb6if7EzgP3pUW2uJRFuVnJZjxZ0bR/bf5bSdGiCvqj4k/9uNpjOuvPz+Ycny8SySERs=
X-Received: by 2002:a05:6512:e93:b0:4fb:7c40:9f95 with SMTP id
 bi19-20020a0565120e9300b004fb7c409f95mr4756212lfb.47.1692601489315; Mon, 21
 Aug 2023 00:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230818134422.380032-1-ardb@kernel.org> <20230818134422.380032-18-ardb@kernel.org>
 <46832047-567e-5699-fbec-8c3e991cfe0a@zytor.com> <CAMj1kXG5X2ZUNs2W8o5_c83fznRDjLjPZcEqEgfpFUBS1DX5Pg@mail.gmail.com>
 <d8c2f362-bfe9-560a-541c-a298f8685be1@zytor.com>
In-Reply-To: <d8c2f362-bfe9-560a-541c-a298f8685be1@zytor.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 21 Aug 2023 09:04:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGw5_pLx=+RSFndd6PxXBe5-TyOmWDpyD5v4+YhOxYMBA@mail.gmail.com>
Message-ID: <CAMj1kXGw5_pLx=+RSFndd6PxXBe5-TyOmWDpyD5v4+YhOxYMBA@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 21 Aug 2023 at 02:37, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 8/20/23 05:57, Ard Biesheuvel wrote:
> >
> > I understand. I deliberately put this change at the very end because I
> > was anticipating some debate on this.
> >
> > Do you have any recollection of why this CRC32 was introduced in the
> > first place? The commit logs are empty and the lore thread doesn't
> > contain any justification either.
>  >
>
> The justification is that firmware is notoriously unreliable and gives
> the boot loader an independent way to verify the load and have a
> fallback, rather than jumping to the kernel and having the decompressor
> fail.
>
> At this time it is impossible to know what might rely on it. The EFI
> signing issue aside, there are a ton of Linux bootloaders for non-EFI
> systems using the BIOS or raw kernel entry points - and there is no
> telling what those environments might do.
>

Fair enough.

The PE header happens to have a checksum field that a) is not used by
EFI at all, and b) is not covered by the signature. So it wouldn't be
too hard to put a doctored value in that field that forces the CRC-32
of the entire image to 0xffff_ffff *after* signing, and this would
even work if the image did not have a CRC-32 at the end in the first
place. (So the signing tools wouldn't need to know whether they are
signing a x86 bzImage or some other PE executable). Note that pesign
and sbsign currently follow the PE/windows spec for generating this
checksum, but EFI never looks at it. (It is documented as being
intended for checksumming critical system DLLs on Windows)

But that is a lot of trouble for no known use case, so let's not
bother with that right now. But I'll withdraw this patch from the
series.

Thanks,
Ard.
