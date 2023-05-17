Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AD9706FB6
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjEQRmE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 May 2023 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjEQRmE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 May 2023 13:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F53AD19;
        Wed, 17 May 2023 10:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56AE464390;
        Wed, 17 May 2023 17:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB806C433A1;
        Wed, 17 May 2023 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684345207;
        bh=lvKXtjDORl9iw1fOnUstd2Teiz7vlo2hm0s7WvCeLOw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O2/GZIQPJR7wKLD/kkg345IgeUxO7+DWoYfnD3C6KtrDK/zJ6ar7goy5CIJ6Ppipc
         733okSusKkLdhjUNFQwi8+Ypm8inMUdnUxz7WmjvIKxDYski5+VE+X86zDLS2OlyrF
         wQg2A0uQz65PiN14AQ5x9k+IIgLSEW/IBJkfTe70bNAeT8aZxnArwypLq9CNgN6koD
         u1DfcrRG7qVARqk5rrwFDCNvE3FDSg73eR/Mc2Ro1w+69SEEEfK1r88hxfQwgr0iS/
         io0Xj8SQ9EOH3IVlzfrqVdrej0auJhcq78gnxVd1EV/f2NnH4Vzar2Cim2auxGcPfr
         s/DMtDawCmnvQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ac78bb48eeso10566331fa.1;
        Wed, 17 May 2023 10:40:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDw6PawqVpOr410hJWxy5UfhT2Q4R0JBdWpBDzHx871vLLgMZ1t+
        fJdsFHYYx6HYIPxz9swn0dwgQFYIoyaNZLM+YoY=
X-Google-Smtp-Source: ACHHUZ7ozEnt3lrP9zs/vkbvExkQeNd4j79UcSA8GzPGwJSHKpNjphHbp4xCSRrH1MiNlH3GcFsXoFJbf25Oa6a0AhI=
X-Received: by 2002:a2e:99c7:0:b0:2ad:dab5:fe8e with SMTP id
 l7-20020a2e99c7000000b002addab5fe8emr7223536ljj.47.1684345205492; Wed, 17 May
 2023 10:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230508070330.582131-1-ardb@kernel.org> <20230508070330.582131-2-ardb@kernel.org>
 <20230517173145.GEZGUPgRTiUFB2GwgG@fat_crate.local>
In-Reply-To: <20230517173145.GEZGUPgRTiUFB2GwgG@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 May 2023 19:39:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHbKSEpPzqedHTzs62Frm6rEEQO7XYcVadHNcYcYVOmNg@mail.gmail.com>
Message-ID: <CAMj1kXHbKSEpPzqedHTzs62Frm6rEEQO7XYcVadHNcYcYVOmNg@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] x86: decompressor: Use proper sequence to take
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
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 17 May 2023 at 19:31, Borislav Petkov <bp@alien8.de> wrote:
>
> Please fix all your subjects as explained here:
>
> https://kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject
>
> On Mon, May 08, 2023 at 09:03:11AM +0200, Ard Biesheuvel wrote:
> > We don't actually use a global offset table (GOT) in the 32-bit
>
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.
>
> Personal pronouns are ambiguous in text, especially with
> so many parties/companies/etc developing the kernel so let's avoid them
> please.
>

Ack.

> > diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> > index 987ae727cf9f0d04..53cbee1e2a93efce 100644
> > --- a/arch/x86/boot/compressed/head_32.S
> > +++ b/arch/x86/boot/compressed/head_32.S
> > @@ -58,7 +58,7 @@ SYM_FUNC_START(startup_32)
> >       leal    (BP_scratch+4)(%esi), %esp
> >       call    1f
> >  1:   popl    %edx
> > -     addl    $_GLOBAL_OFFSET_TABLE_+(.-1b), %edx
> > +     leal    (_GLOBAL_OFFSET_TABLE_ - 1b)(%edx), %edx
>
> Yeah, that's a bit better.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
