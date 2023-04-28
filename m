Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD29C6F1D3F
	for <lists+linux-efi@lfdr.de>; Fri, 28 Apr 2023 19:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbjD1ROo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Apr 2023 13:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD1ROn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Apr 2023 13:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7314610C6;
        Fri, 28 Apr 2023 10:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0265160ED6;
        Fri, 28 Apr 2023 17:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639A2C433EF;
        Fri, 28 Apr 2023 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682702081;
        bh=NiuqoaeWuPDwwSWViVSbLcMtEXaqPz9t4R/6XaWcI3I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aSdEfY+4uZ8xYHBo8TLpN5VRvXYLh0171NctTtY5XsSubQCs3jeQvYRXxENjXXzSh
         N/4afR12pxKfpOdB87gwo032xAe33S0HKLFEUn7Fgwiln/+Z84Aum6DTNn20R8/AH+
         4j76waM+tQYnAqL9bFUJ7RLHe4ftGJip2l+GZg72075wzTZFllfuijmmoeO3SWFlgP
         RO3qNFlKXK1lNbjjshX1qZjeiAMbQpwgJ1Yi7rUH1BuAVJVdQyb4sKtOsUFYS/Bmzm
         NU57BuZNfSTOpRCgrOdiZ9JQhwo2XL+p4n4VRIjIE6lh38946xZ7xBgWNr3pyCTVEu
         eT+1E9Lb9Ckfw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2a8bcfbf276so96046211fa.3;
        Fri, 28 Apr 2023 10:14:41 -0700 (PDT)
X-Gm-Message-State: AC+VfDxOD2dMo9ovBVgJlGWDFL36vjoCx1ZmkfJeQ+vpOmtp3wcy6jGw
        o7SApztqNZTohqP65u6Of0j1rEmp82PqSQh357c=
X-Google-Smtp-Source: ACHHUZ6GcFsKy61kn2TmnjS72bEm5sJn6gWlnruH6lSO/5s22ecgAzQjkMdLV5bJ4/jnPu+RD+CtaqB1Hc0Nzcy1vmM=
X-Received: by 2002:a2e:8716:0:b0:2aa:af16:5c58 with SMTP id
 m22-20020a2e8716000000b002aaaf165c58mr1738781lji.43.1682702079348; Fri, 28
 Apr 2023 10:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230424165726.2245548-1-ardb@kernel.org> <1d8389c7c4fb6efac18cc38c004f49ca@ispras.ru>
In-Reply-To: <1d8389c7c4fb6efac18cc38c004f49ca@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Apr 2023 18:14:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGOYhQL3-pJyxFn3P0aN16Q8CJA_WKL-GA-sPCHsGQe_g@mail.gmail.com>
Message-ID: <CAMj1kXGOYhQL3-pJyxFn3P0aN16Q8CJA_WKL-GA-sPCHsGQe_g@mail.gmail.com>
Subject: Re: [PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
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

On Fri, 28 Apr 2023 at 14:23, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2023-04-24 19:57, Ard Biesheuvel wrote:
> > This series is conceptually a combination of Evgeny's series [0] and
> > mine [1], both of which attempt to make the early decompressor code
> > more
> > amenable to executing in the EFI environment with stricter handling of
> > memory permissions.
> >
> > My series [1] implemented zboot for x86, by getting rid of the entire
> > x86 decompressor, and replacing it with existing EFI code that does the
> > same but in a generic way. The downside of this is that only EFI boot
> > is
> > supported, making it unviable for distros, which need to support BIOS
> > boot and hybrid EFI boot modes that omit the EFI stub.
> >
> > Evgeny's series [0] adapted the entire decompressor code flow to allow
> > it to execute in the EFI context as well as the bare metal context, and
> > this involves changes to the 1:1 mapping code and the page fault
> > handlers etc, none of which are really needed when doing EFI boot in
> > the
> > first place.
> >
> > So this series attempts to occupy the middle ground here: it makes
> > minimal changes to the existing decompressor so some of it can be
> > called
> > from the EFI stub. Then, it reimplements the EFI boot flow to
> > decompress
> > the kernel and boot it directly, without relying on the trampoline
> > code,
> > page table code or page fault handling code. This allows us to get rid
> > of quite a bit of unsavory EFI stub code, and replace it with two clear
> > invocations of the EFI firmware APIs to clear NX restrictions from
> > allocations that have been populated with executable code.
> >
> > The only code that is being reused is the decompression library itself,
> > along with the minimal ELF parsing that is required to copy the ELF
> > segments in place, and the relocation processing that fixes up absolute
> > symbol references to refer to the correct virtual addresses.
> >
> > Note that some of Evgeny's changes to clean up the PE/COFF header
> > generation will still be needed, but I've omitted those here for
> > brevity.
>
> My series also implements W^X for both UEFI and non-UEFI boot paths, but
> I
> agree that we can just consider non-UEFI code legacy and it would be
> better
> to avoid touching it and encourage everyone to use UEFI code path on x86
> instead. If PE format will also get fixed with either my patches or some
> others, I do like your approach more than mine, as it removes a lot of
> old
> cruft but does not break things (as far as I see). Seems like a perfect
> compromise between [1] and my approach.
>

Thanks, I'm glad we agree.

> I've briefly tested the patches and looked through them and they look
> good
> to me. Two things I've noticed:
>   * there's one TSC-related TODO;
>   * probably we want to clear .bss in efi32_stub_entry and
> efi64_stub_entry
>     for UEFI handover protocol, since it's unfortunately still present
> and
>     .bss will contain garbage.

I'll look into that.

> I'll probably do some more testing on the weekend and let you know if I
> find something.
>

Yes, please.

> Please tell me if/when you are going to merge these or similar, and I
> will
> clean up and rebase PE-related patches on top of these.
>
> I'd also like to send W^X patches for EFISTUB (omitting the non-UEFI
> boot
> path) as a follow up after the PE file header will get fixed. They will
> be
> considerably smaller with this approach and will not touch legacy code.
>
