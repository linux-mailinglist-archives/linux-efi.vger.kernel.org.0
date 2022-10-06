Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E47F5F6607
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 14:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiJFM2S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 08:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiJFM2M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 08:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C01DA0260;
        Thu,  6 Oct 2022 05:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88EE461923;
        Thu,  6 Oct 2022 12:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA237C433C1;
        Thu,  6 Oct 2022 12:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665059287;
        bh=urtUav8EHxk8QIZbs99s2vaaP7fgK18dDTxYek/PK/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MGd/f6SC2hJdz2DUtXTC8bCTjgoDbo1mPp+A+6rv6qTz1pYyBGtslNhLtVkgdjKoB
         zvA3W/OTOixUb4SZdAE0/lBfXxyG2+JlhBHBqSSPDKQ2wupXyotgDcUAyeiCeyOqpu
         FRI6VOd5pvGYnjuFE0aLvQaHKSUMyaDgW3cInIzC4voOM2VNOcEPAOgM1Vsp4DSBrz
         IQoInj4w5HWPwtaiLnJdV9Ibjf5eJh+R77JhQTMzFCsAFmxb7QEmSpmWp7WnZ2YWAC
         H8+osg39yty0DNTDTX+1Tc6cQ6xwkzEzIH/4AubxGjlfvX5EHvQEkX3FyPU+kdIVQ1
         /6H/T9jOSsuCA==
Received: by mail-lf1-f46.google.com with SMTP id s20so2430027lfi.11;
        Thu, 06 Oct 2022 05:28:07 -0700 (PDT)
X-Gm-Message-State: ACrzQf0Gi2F9OFMwqFrbvifBQcUWxC3uyMbiamamvuYebLtIh3RfQhRb
        /8RwBvSIkH2Q6lN2SxVSmVWWwodeIZRjyaEZLIw=
X-Google-Smtp-Source: AMsMyM7FAlX2JWCm+WLZcvulAY1vV5cAzgFbZmJKJHjIuB1KuNERAiyFQrMP1Y94GY3DmoLHqI+07sMZuC/Q/x9FSPw=
X-Received: by 2002:a05:6512:2026:b0:4a2:3bb6:302 with SMTP id
 s6-20020a056512202600b004a23bb60302mr1752074lfs.539.1665059285847; Thu, 06
 Oct 2022 05:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220921145422.437618-1-ardb@kernel.org> <20220921145422.437618-3-ardb@kernel.org>
 <Yz6xBROUBPyaUSoB@zn.tnic> <CAMj1kXGCWmay_=cncZpZwXoyLgzt7=2dVuXHaaQU=K6NEXrezQ@mail.gmail.com>
 <Yz64aMVo4W+D70Fz@zn.tnic> <CAMj1kXHi4TgGd=vicfxVOUnzDrhSfsiR=572L6cEwi47JO17jw@mail.gmail.com>
In-Reply-To: <CAMj1kXHi4TgGd=vicfxVOUnzDrhSfsiR=572L6cEwi47JO17jw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 6 Oct 2022 14:27:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEkX=dZ0uUAdXoe5JC_Zv2+ndTMYwDiixYmWT-ip8OOOg@mail.gmail.com>
Message-ID: <CAMj1kXEkX=dZ0uUAdXoe5JC_Zv2+ndTMYwDiixYmWT-ip8OOOg@mail.gmail.com>
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

On Thu, 6 Oct 2022 at 13:19, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 6 Oct 2022 at 13:13, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Thu, Oct 06, 2022 at 12:56:09PM +0200, Ard Biesheuvel wrote:
> > > efi32_pe_entry() preserves and restores the caller's value of %ebx,
> > > because from there, we might actually return control to the firmware.
> > > The value it keeps in %ebx itself is not live when it jumps to
> > > efi32_entry - it stores its value into image_offset, which is reloaded
> > > from memory at a later point.
> >
> > Hmm, might be prudent to have a comment there because it is using %ebx a
> > couple of insns before the JMP:
> >
> >         subl    %esi, %ebx
> >                       ^^^^
> >         movl    %ebx, rva(image_offset)(%ebp)   // save image_offset
> >
> > <--- I think you mean that after this, %ebx is not needed anymore?
> >
>
> Exactly.
>
> >         xorl    %esi, %esi
> >         jmp     efi32_entry
> >
> > 2:      popl    %edi                            // restore callee-save registers
> >         popl    %ebx
> >
> > and this restores its original value ofc.
> >
> > > efi32_stub_entry() is the 'EFI handover protocol' entry point, which
> > > cannot return to the firmware (and we discard the return address
> > > already) so %ebx can be clobbered.
> >
> > That info would be good to have in a comment above it.
> >
>
> Fair enough.

I'll add the below in the next revision

--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -307,6 +307,19 @@ SYM_FUNC_START(efi32_stub_entry)
 SYM_FUNC_END(efi32_stub_entry)

        .text
+/*
+ * This is the common EFI stub entry point for mixed mode.
+ *
+ * Arguments:  %ecx    image handle
+ *             %edx    EFI system table pointer
+ *             %esi    struct bootparams pointer (or NULL when not using
+ *                     the EFI handover protocol)
+ *
+ * Since this is the point of no return for ordinary execution, no registers
+ * are considered live except for the function parameters. [Note that the EFI
+ * stub may still exit and return to the firmware using the Exit() EFI boot
+ * service.]
+ */
 SYM_FUNC_START_LOCAL(efi32_entry)
        call    1f
 1:     pop     %ebx
@@ -837,7 +850,8 @@ SYM_FUNC_START(efi32_pe_entry)
        subl    %esi, %ebx
        movl    %ebx, rva(image_offset)(%ebp)   // save image_offset
        xorl    %esi, %esi
-       jmp     efi32_entry
+       jmp     efi32_entry                     // pass %ecx, %edx, %esi
+                                               // no other registers
remain live

 2:     popl    %edi                            // restore callee-save registers
        popl    %ebx
