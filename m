Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A40D783D73
	for <lists+linux-efi@lfdr.de>; Tue, 22 Aug 2023 12:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjHVKA0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Aug 2023 06:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjHVKA0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Aug 2023 06:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3F51B2
        for <linux-efi@vger.kernel.org>; Tue, 22 Aug 2023 03:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B4F464112
        for <linux-efi@vger.kernel.org>; Tue, 22 Aug 2023 10:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A20C433D9
        for <linux-efi@vger.kernel.org>; Tue, 22 Aug 2023 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692698423;
        bh=9GARsK5qa8TdRG3H2o8UuS5MKJUgo+pxbOOPw0cMGeA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IDMkk47V8ZXAWxhSOLri4NOdiMt2MlxuxRNURXGkCRqxhmvB82nETfhcDHsDIJHrU
         2OXzz3Dxcc3xwtByJTFT59hiLITufTNoyimS99UN4v+W6YzfA5yHVXDUooev2h16g/
         7lWtzaqVhfZXhjC1qCDL0r8gd9YKIKqEVu9weRNRF+TL8OOGa1PcUo/tqXQqicElZ5
         1eJtvHVgsCO525CqUiydI8a+gk9vwvFxf8heGuS0lHf+mL3LfxsMv2MZGZI2bpO6Fy
         uhTNXVe0vnG+m4xUfMFeS1u7sm2EmVZ5aREyEulObpNMliR85mEwNicTamzsGm6Edn
         AtqpKv0T9HeaQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4ffa6e25ebbso4298046e87.0
        for <linux-efi@vger.kernel.org>; Tue, 22 Aug 2023 03:00:23 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy5qPU1A9sfcPA0ZFzkpN/HwQCsfMsYvpl9TueMX6qdry1/S07K
        6MCuKy6qx3uh3snO8HJC0LO8I2hJy1k/E0BAYr0=
X-Google-Smtp-Source: AGHT+IF/wbvYAXXp7f76cY67rBM2JQorxHfAjTSok3kTXWvpkPCcxbwElbocpqNe887QImljrmmkAKGAUBTHGitl+vA=
X-Received: by 2002:a05:6512:1587:b0:4fe:27a0:68bc with SMTP id
 bp7-20020a056512158700b004fe27a068bcmr3090263lfb.27.1692698421282; Tue, 22
 Aug 2023 03:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230818113724.368492-1-ardb@kernel.org> <20230822020138.GA2027761@dev-arch.thelio-3990X>
 <CAMj1kXGy7E9+EUMgm9Fe5SdSsPf6EOX42=DG2RsNMDekhg3_sQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGy7E9+EUMgm9Fe5SdSsPf6EOX42=DG2RsNMDekhg3_sQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Aug 2023 12:00:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHztqo1dpBf4arSOi3-4d_hi2s39gXEiQCmgS6jb1WRnA@mail.gmail.com>
Message-ID: <CAMj1kXHztqo1dpBf4arSOi3-4d_hi2s39gXEiQCmgS6jb1WRnA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] efi: Clean up runtime wrapper and wire it up for PRM
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 22 Aug 2023 at 09:53, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 22 Aug 2023 at 04:01, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Ard,
> >
> > On Fri, Aug 18, 2023 at 01:37:13PM +0200, Ard Biesheuvel wrote:
> >
> > <snip>
> >
> > > Ard Biesheuvel (11):
> > >   efi/x86: Move EFI runtime call setup/teardown helpers out of line
> > >   efi/arm64: Move EFI runtime call setup/teardown helpers out of line
> > >   efi/riscv: Move EFI runtime call setup/teardown helpers out of line
> > >   efi/runtime-wrappers: Use type safe encapsulation of call arguments
> > >   efi/runtime-wrapper: Move workqueue manipulation out of line
> > >   efi/runtime-wrappers: Remove duplicated macro for service returning
> > >     void
> > >   efi/runtime-wrappers: Don't duplicate setup/teardown code
> > >   acpi/prmt: Use EFI runtime sandbox to invoke PRM handlers
> > >   efi/runtime-wrappers: Clean up white space and add __init annotation
> > >   efi/x86: Realign EFI runtime stack
> > >   efi/x86: Rely on compiler to emit MS ABI calls
> >
> > I took this series for a spin on my arm64 and x86_64 systems that boot
> > under EFI. I noticed two issues for x86_64, none for arm64. I was hoping
> > to have a little more information by this point but I had some personal
> > stuff to deal with today but I figured I would report this initially
> > and if you want to continue on the ClangBuiltLinux issue tracker, we
> > certainly can.
> >
> > 1. I see some kCFI failures with this series on x86_64. The fact that
> > the target is not a symbol makes me think that a function defined in a
> > .S file is being called indirectly? The following stacktrace is repeated
> > over and over on all my machines.
> >
>
> This has to do with the indirect calls being made by the EFI code to
> the firmware services, which are not part of the kernel build.
>
> Before, those indirect calls were hidden from the compiler, as they
> were made from assembler, but now they are generated by the compiler,
> and so we have to inform it that those functions do not have kCFI
> metadata.
>
> The below should have fixed it, but I am getting lots of build errors
> along the lines of
>
> error: '__no_sanitize__' attribute only applies to functions,
> Objective-C methods, and global variables
>
> when I add this. Suggestions welcome on how to inform the compiler
> that calls via those function pointers should have __nocfi semantics.
>

OK, so it is a property of the caller, not the callee. So it is simply
a matter of marking every user of the EFI runtime services with
__nocfi. So basically, every routine marked __efi_realign_stack should
be marked __nocfi as well.
