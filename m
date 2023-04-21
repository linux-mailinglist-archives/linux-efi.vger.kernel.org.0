Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B650F6EABEB
	for <lists+linux-efi@lfdr.de>; Fri, 21 Apr 2023 15:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjDUNmI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Apr 2023 09:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjDUNl6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Apr 2023 09:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC0512C94;
        Fri, 21 Apr 2023 06:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90F4460F58;
        Fri, 21 Apr 2023 13:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F179AC433A0;
        Fri, 21 Apr 2023 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682084482;
        bh=jmL7jjhJpMgLgsPp3lSfIdaZinFM9dLDmJnz8qauV/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c3DEmm6M3HGcdosy8rOaoav1wbY/o367RwqBsoV5zlLbH8DdF9jiVW7y6e1Io0FEf
         r1a8AjuYhVv6iBGsj9wkFoALjEnNq3dwfAoABqVEAUaX6c8NGlpkUXjpCO+YYZEfjb
         pE4SRI06xZDPq+nzdfP7Q9DNBcLayEJdvFCI3sBzSlGLB8/ivJRwgoUaHzETDZvV8o
         M4lMDE0JmfBZ9wIva7K217thmILb7twcg4g6k4XkNkaksQ+owM+3U1tA/LlRbjTtA1
         X7x7QW2MW6qimR9+/H4ef/7lHAHOxqNYRRxRhLmVgcfA18TfX23Jqq7pA4chgF5ZUD
         rvSWVMf1VsRVQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4edcc885d8fso1770294e87.1;
        Fri, 21 Apr 2023 06:41:21 -0700 (PDT)
X-Gm-Message-State: AAQBX9dEDWhwZLlsYkJtAYubKoUEFm6miNS6eQO/OdHpr3Mop2MOWtBM
        OWY/ENbMcmnhKyhfx/AT4zmwsdsfpMNaD1IFCSc=
X-Google-Smtp-Source: AKy350axRmOck8EWAJk5hraoYul70AWCHQZT9buPn7jrTBRl724j9gnT/m32e+W6Y8V9sk77yqIcyhWmoyjHc16Cb+w=
X-Received: by 2002:ac2:5e83:0:b0:4ed:c537:d0ca with SMTP id
 b3-20020ac25e83000000b004edc537d0camr1581044lfq.59.1682084479979; Fri, 21 Apr
 2023 06:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230416120729.2470762-1-ardb@kernel.org> <5694ea5d-da9a-413e-9499-02a54588a953@app.fastmail.com>
In-Reply-To: <5694ea5d-da9a-413e-9499-02a54588a953@app.fastmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 21 Apr 2023 15:41:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH5+scbFuaOP+VC7EHEZcn-tmp3nk=9uYGYGfJyb0S92Q@mail.gmail.com>
Message-ID: <CAMj1kXH5+scbFuaOP+VC7EHEZcn-tmp3nk=9uYGYGfJyb0S92Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] efi: Implement generic zboot support
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 21 Apr 2023 at 15:30, Andy Lutomirski <luto@kernel.org> wrote:
>
>
>
> On Sun, Apr 16, 2023, at 5:07 AM, Ard Biesheuvel wrote:
> > This series is a proof-of-concept that implements support for the EFI
> > zboot decompressor for x86. It replaces the ordinary decompressor, and
> > instead, performs the decompression, KASLR randomization and the 4/5
> > level paging switch while running in the execution context of EFI.
>
> I like the concept.  A couple high-level questions, since I haven=E2=80=
=99t dug into the code:
>
> Could zboot and bzImage be built into the same kernel image?  That would =
get this into distros, and eventually someone could modify the legacy path =
to switch to long mode and invoke zboot (because zboot surely doesn=E2=80=
=99t need actual UEFI =E2=80=94 just a sensible environment like what UEFI =
provides.)
>

That's an interesting question, and to some extent, that is actually
what Evgeny's patch does: execute more of what the decompressor does
from inside the EFI runtime context.

The main win with zboot imho is that we get rid of all the funky
heuristics that look for usable memory for trampolines and
decompression buffers in funky ways, and instead, just use the EFI
APIs for allocating pages and remapping them executable as needed
(which is the important piece here) I'd have to think about whether
there is any middle ground between this approach and Evgeny's - I'll
have to get back to you on that.

> Does zboot set up BSS correctly?  I once went down a rabbit hole trying t=
o get the old decompressor to jump into the kernel with BSS already usable =
and zeroed, and the result was an incredible mess =E2=80=94 IIRC the decomp=
ressor does some in-place shenanigans that looked incompatible with handlin=
g BSS without a rewrite. And so we clear BSS in C after jumping to the kern=
el, which is gross.
>

Zboot pads the image to include BSS, so that the zboot metadata covers
the actual memory footprint of the image rather than just the image
size, and it will get zeroed out as a result of the decompression too,
which is a nice bonus. I did this mainly to try and make it idiot
proof for other (non-EFI) consumers of the zboot header and compressed
payload, but it means that the zboot EFI loader doesn't have to bother
either.
