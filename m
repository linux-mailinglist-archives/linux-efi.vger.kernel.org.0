Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0E05F6497
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiJFK41 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 06:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJFK40 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 06:56:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA1098359;
        Thu,  6 Oct 2022 03:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16E44B8206D;
        Thu,  6 Oct 2022 10:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB77EC43140;
        Thu,  6 Oct 2022 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665053782;
        bh=n1sONnyBy19nROIXw+eEDPEBq0RR7AXvCLWvs323kMg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=miEGJUm4FWmWmXjKNlKsxMKtRsvnrlQNwL4YenRVPxZepzsh5uVbFYjDns3vA5BGr
         j3A53GwtViyBSfJhc9i2gpkxIEmRqWRqxApmKgmd3ePr3+ru+S4pGKCvum1TqjCy3f
         V+WjyeCjdyIkgZIBfN03LASLuB+Bj9rqCufVtEgMz5A2QGaP8lcbOrkobfcOXi0i7Q
         djXW0C1m63i56so2GEqGNWdT2QdSvHCOllHoB61FEdHSWFDBbGBf7mUjXa/mrAS4hj
         Xwy3J96SZAn6ybv4j6V423iJ3kfjAujIOH4Vi3Rb3uOEzy1eNyus7NOquQDiHweZrQ
         Ge8XYaEQ9Cx3Q==
Received: by mail-lf1-f50.google.com with SMTP id b2so2122534lfp.6;
        Thu, 06 Oct 2022 03:56:22 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ZyM8KXq+VMJC70nD2VTqDhSbBKeSllaqIdI8CDi8GPlznXuYZ
        jbadcemPjQ41nw+QDaZqMYuxTZ8+lUoPNkdpm58=
X-Google-Smtp-Source: AMsMyM5XVgXpY1Gi+XZfGzDdqbBl0FgkTmDXDWQCom0Pu7D17z12Oaq9iuMVD2YJY6S9f56SbO4uJ60/ZeBMaXqvFgw=
X-Received: by 2002:ac2:4d1c:0:b0:4a2:4119:f647 with SMTP id
 r28-20020ac24d1c000000b004a24119f647mr1502331lfi.426.1665053780725; Thu, 06
 Oct 2022 03:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220921145422.437618-1-ardb@kernel.org> <20220921145422.437618-3-ardb@kernel.org>
 <Yz6xBROUBPyaUSoB@zn.tnic>
In-Reply-To: <Yz6xBROUBPyaUSoB@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 6 Oct 2022 12:56:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGCWmay_=cncZpZwXoyLgzt7=2dVuXHaaQU=K6NEXrezQ@mail.gmail.com>
Message-ID: <CAMj1kXGCWmay_=cncZpZwXoyLgzt7=2dVuXHaaQU=K6NEXrezQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] x86/compressed: efi-mixed: move 32-bit
 entrypoint code into .text section
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 6 Oct 2022 at 12:42, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 21, 2022 at 04:54:08PM +0200, Ard Biesheuvel wrote:
> > Move the code that stores the arguments passed to the EFI entrypoint
> > into the .text section, so that it can be moved into a separate
> > compilation unit in a subsequent patch.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/head_64.S | 34 ++++++++++++--------
> >  1 file changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index d33f060900d2..1ba2fc2357e6 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -303,24 +303,28 @@ SYM_FUNC_START(efi32_stub_entry)
> >       popl    %ecx
> >       popl    %edx
> >       popl    %esi
> > +     jmp     efi32_entry
> > +SYM_FUNC_END(efi32_stub_entry)
> >
> > +     .text
> > +SYM_FUNC_START_LOCAL(efi32_entry)
> >       call    1f
> > -1:   pop     %ebp
> > -     subl    $ rva(1b), %ebp
> > -
> > -     movl    %esi, rva(efi32_boot_args+8)(%ebp)
> > -SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
> > -     movl    %ecx, rva(efi32_boot_args)(%ebp)
> > -     movl    %edx, rva(efi32_boot_args+4)(%ebp)
> > -     movb    $0, rva(efi_is64)(%ebp)
> > +1:   pop     %ebx
>
> I'm guessing according to the EFI mixed mode calling convention, %ebx is
> not a live register which gets overwritten here...?
>
> Looking at efi32_pe_entry() from where this is called, %ebx looks live.
>
> What am I missing?
>

efi32_pe_entry() preserves and restores the caller's value of %ebx,
because from there, we might actually return control to the firmware.
The value it keeps in %ebx itself is not live when it jumps to
efi32_entry - it stores its value into image_offset, which is reloaded
from memory at a later point.

efi32_stub_entry() is the 'EFI handover protocol' entry point, which
cannot return to the firmware (and we discard the return address
already) so %ebx can be clobbered.
