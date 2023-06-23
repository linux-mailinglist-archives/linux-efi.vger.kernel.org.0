Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70A973B94E
	for <lists+linux-efi@lfdr.de>; Fri, 23 Jun 2023 16:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjFWOAq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Jun 2023 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFWOAp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Jun 2023 10:00:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4246B189;
        Fri, 23 Jun 2023 07:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4F1361A5C;
        Fri, 23 Jun 2023 14:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5B3C433D9;
        Fri, 23 Jun 2023 14:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687528843;
        bh=sU0qvZS8lc5okVj+Wd/3PIl9/7CnriyY1ONPXUzclvg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qAUdPn1VK3h4MfZkOBRgysXOcXGCCSnnEy2vUx5VsQVwb1UckT9ak0Ygke6HrEn3+
         aU99bG0JVQK4y7kZKHVuFq9wr9JPteuA534X9JYs7AKyfIrQHVrFDIKuiGDFQaBXq4
         DjWl1IBJQ6PcSVEcu9rwHraNB7q8OT1WaMFdc1TdfXY15kPuHyHV/kFVnxiZbp1YX0
         y0HX+AkzNJ7f+nRB7QxRldiOzTExk4j0OyXH3w07vlaNIUy+dpJvJ3VnV1DPBPtTFS
         FAdywzkkADKTTKvRijh6I5N1ndVe5wHkTBVZdJpse6XqpIsr58HYpb4KhtjBovvrpf
         O+iy4EDLOxMWg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f87592eccfso811033e87.2;
        Fri, 23 Jun 2023 07:00:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDytDiIB6TxMg0ZCMwXk6mYL28nt0C+YTowjVfaIB1osqWSe8E5g
        xoAHiJGUYbLrNehPnRJBEfp/CGAiA0gZL893ITE=
X-Google-Smtp-Source: ACHHUZ7dlvZFdLg6rqLtx54xFJSTh3bP79FeWHbu3TCecyS3reTwh0nF5kS4ALnX74kr/cXG7uP9L6LGJSG51Tmpkpk=
X-Received: by 2002:a05:6512:3c88:b0:4f9:6a7b:b8de with SMTP id
 h8-20020a0565123c8800b004f96a7bb8demr3628980lfv.3.1687528841114; Fri, 23 Jun
 2023 07:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230607072342.4054036-1-ardb@kernel.org> <20230607072342.4054036-6-ardb@kernel.org>
 <20230621110852.GAZJLaRAuGBCc5R4yb@fat_crate.local>
In-Reply-To: <20230621110852.GAZJLaRAuGBCc5R4yb@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 23 Jun 2023 16:00:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEyWJ7GgcLBdqd1GkEGEEX=4vi7d6ZVEAJ0zjU1Y+ioUQ@mail.gmail.com>
Message-ID: <CAMj1kXEyWJ7GgcLBdqd1GkEGEEX=4vi7d6ZVEAJ0zjU1Y+ioUQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/20] x86/decompressor: Use proper sequence to take
 the address of the GOT
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 21 Jun 2023 at 13:09, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jun 07, 2023 at 09:23:27AM +0200, Ard Biesheuvel wrote:
> > The 32-bit decompressor does not actually use a global offset table
> > (GOT), but as is common for 32-bit position independent code, it uses
> > the magic symbol _GLOBAL_OFFSET_TABLE_ as an anchor from which to derive
> > the actual runtime addresses of other symbols, using special @GOTOFF
> > symbol references that are resolved at link time, and populated with the
> > distance between the address of the magic _GLOBAL_OFFSET_TABLE_ anchor
> > and the address of the symbol in question.
> >
> > This means _GLOBAL_OFFSET_TABLE_ is the only symbol whose actual runtime
> > address needs to be determined explicitly, which is one of the first
> > things that happens in startup_32. However, it does so by taking the
> > absolute address via the immediate field of an ADD instruction (plus a
> > small offset), which seems to defeat the point.
> >
> > Fortunately, the assembler knows that _GLOBAL_OFFSET_TABLE_ is magic,
> > and emits a special relative relocation instead, and so the resulting
>
> Which special relocation do you mean?
>
> This guy:
>
> Relocation section '.rel.head.text' at offset 0x3a0 contains 12 entries:
>  Offset     Info    Type            Sym.Value  Sym. Name
> 00000010  00000d0a R_386_GOTPC       00000000   _GLOBAL_OFFSET_TABLE_
>
> ?

Yep.

if you assemble this

movl $_GLOBAL_OFFSET_TABLE_, %eax
movl $_GLOBAL_OFFSET_TABLE, %eax

you'll end up with

   0: b8 01 00 00 00        mov    $0x1,%eax
1: R_386_GOTPC _GLOBAL_OFFSET_TABLE_
   5: b8 00 00 00 00        mov    $0x0,%eax
6: R_386_32 _GLOBAL_OFFSET_TABLE

So it is not possible to take the absolute address of
_GLOBAL_OFFSET_TABLE_ via an absolute relocation, you will always get
the relative offset instead.
