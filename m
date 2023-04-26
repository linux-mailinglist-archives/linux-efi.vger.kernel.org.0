Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9C6EFC7F
	for <lists+linux-efi@lfdr.de>; Wed, 26 Apr 2023 23:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbjDZVaV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Apr 2023 17:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbjDZVaF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Apr 2023 17:30:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E04E40C8;
        Wed, 26 Apr 2023 14:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AC386394C;
        Wed, 26 Apr 2023 21:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C62C433A1;
        Wed, 26 Apr 2023 21:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682544591;
        bh=yLi2JTeqjSBCZyJRqKGRsMaMom6VAZo/Dwzd3fLD8nk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UQMer08dWmP8i4EiUN/cLZ3ZUb7RgcamF/k5bFz6xHSkug0SQZUORXx7VcAoCVk9P
         qTMKow2h70Pgpy5xsxOL8jjuCVhg8yip10kC9sEQcphp98AHMXp7HEggB07BJl8Gyc
         Vm5LIGU2qj5GzjOU8WxT1hpjxtoa4icfod1gvgCTFCbEeJIwvdUE+iIU3O48HxJ2Ck
         VgXOk//PfM/CpARvNR0ZyhGABL82TFAuGuFOEfmK+vNRqCrp9X83BkilCFPIfvP1+v
         lNHDjt/tnEq/o2MEw5CPFtHxAjJFdLPoDKLgKf/ZJl4wvVq1oGlXFdSjyTbGjyEPyS
         aJj+vf5/9Uqcw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4ec816c9d03so8460030e87.2;
        Wed, 26 Apr 2023 14:29:50 -0700 (PDT)
X-Gm-Message-State: AAQBX9dIOOyMXH3HE0MSznhpNvwUf1M2wiYRYj9KtH9DaoSjHrKG/Q9e
        PLSXewC8G/GnFReytrF6dQ//aHopr69wXZbMBy0=
X-Google-Smtp-Source: AKy350YBdfM7Iay7B3diQtQJlXEUS1LpawWoNJtXnV0FykEhmRIC8cQ/rLoQqXAMr4IvgC5U9s1+0wbAFbTk9uevI3g=
X-Received: by 2002:a19:a40d:0:b0:4ed:cb37:7d95 with SMTP id
 q13-20020a19a40d000000b004edcb377d95mr5947487lfc.44.1682544589032; Wed, 26
 Apr 2023 14:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230424165726.2245548-1-ardb@kernel.org> <20230424165726.2245548-5-ardb@kernel.org>
 <20230426104200.drmuewhwmhh3xljh@box.shutemov.name>
In-Reply-To: <20230426104200.drmuewhwmhh3xljh@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Apr 2023 22:29:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEhZ_R7tvdjKfnt63y41JE98wi3vOpav=a_Hqhnmo0xXw@mail.gmail.com>
Message-ID: <CAMj1kXEhZ_R7tvdjKfnt63y41JE98wi3vOpav=a_Hqhnmo0xXw@mail.gmail.com>
Subject: Re: [PATCH 4/6] x86: efistub: Perform 4/5 level paging switch from
 the stub
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
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
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 26 Apr 2023 at 11:42, Kirill A . Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Mon, Apr 24, 2023 at 06:57:24PM +0200, Ard Biesheuvel wrote:
> > In preparation for updating the EFI stub boot flow to avoid the bare
> > metal decompressor code altogether, implement the support code for
> > switching between 4 and 5 levels of paging before jumping to the kernel
> > proper.
>
> I must admit it is neat. I like it a lot.
>

Thanks!

> Any chance we can share the code with the traditional decompressor?
> There's not much that EFI specific here. It should be possible to isolate
> it from the rest, no?
>

I agree. The EFI boot code should still avoid the bare metal
trampoline allocation/deallocation, but the actual payload could be
the same - it's just an indirect call with the GDT and page table
pointers as arguments.

>
> > @@ -792,6 +925,14 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
> >                               (get_efi_config_table(ACPI_20_TABLE_GUID) ?:
> >                                get_efi_config_table(ACPI_TABLE_GUID));
> >
> > +#ifdef CONFIG_X86_64
> > +     status = efi_setup_5level_paging();
> > +     if (status != EFI_SUCCESS) {
> > +             efi_err("efi_setup_5level_paging() failed!\n");
> > +             goto fail;
> > +     }
> > +#endif
> > +
> >       /*
> >        * If the kernel isn't already loaded at a suitable address,
> >        * relocate it.
> > @@ -910,6 +1051,10 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
> >               goto fail;
> >       }
> >
> > +#ifdef CONFIG_X86_64
> > +     efi_5level_switch();
> > +#endif
> > +
> >       return bzimage_addr;
> >  fail:
> >       efi_err("efi_main() failed!\n");
>
> Maybe use IS_ENABLED() + dummy efi_setup_5level_paging()/efi_5level_switch()
> instead of #ifdefs?
>

These are functions returning void so I can just move the #ifdef into
the function implementation. Wo do need #ifdefs at some level, as i386
does not provide a definition for __KERNEL32_CS
