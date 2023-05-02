Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CF76F4555
	for <lists+linux-efi@lfdr.de>; Tue,  2 May 2023 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjEBNlQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 May 2023 09:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjEBNkq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 May 2023 09:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8FB7692;
        Tue,  2 May 2023 06:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D0DC62478;
        Tue,  2 May 2023 13:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9E2C4331D;
        Tue,  2 May 2023 13:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683034795;
        bh=UrLf5MCgEWmhFr7QZLZel3w/tJ513gf+BfWANEZIh4k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jjGz66+vvx99VLj19o1VcyIwqkju0c+V75YRps1BNDpSecyNKigLKqEBamMlXEjpn
         +JuxhTloEYjm881med0+4H1IsdUblWEcm2+s21f19LGabnJeBZO8lC0Yrvn6Bzj2Ux
         VP/HyoHRo5HitkM7LOhmD+rqxaAZzAKPWik8gc9gASu8IOiK9hjxRR5fG9PIYfZMtt
         rVxTJvFgInTghv3F0nfaQBqhWedEzSsS+S03FWkwdEuTwNjGTpVnKtMycBDCdaFbQy
         Mpa5Fj8QzXqHZSkHqOovw9GMV4ETciRoWF1Z6UXTX6mkoBeRRRZ8PMq4YNdHuUm3wu
         44uFBX0iSdBIA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4eff4ea8e39so4485195e87.1;
        Tue, 02 May 2023 06:39:55 -0700 (PDT)
X-Gm-Message-State: AC+VfDwXo9ZxgrAueUAdOFOJ5f5zzo+BWWDAwNvm28FSS5YuzSImHtFd
        /HQmA/uE67UWhgmN6tvAiyc0xSnH4aOTzTKfklA=
X-Google-Smtp-Source: ACHHUZ5s8yBnAB+FJCHFkBS6HmoDmeZnOGMzVYhzBzz7PCcMSgAGdkeRiyAQPLHy+MQHFR8+MPg3oR3CpRL1svUEPYY=
X-Received: by 2002:ac2:455b:0:b0:4eb:20e:6aec with SMTP id
 j27-20020ac2455b000000b004eb020e6aecmr4827293lfm.40.1683034793427; Tue, 02
 May 2023 06:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230424165726.2245548-1-ardb@kernel.org> <ecbcc066-3636-9620-8db9-2c066d16e717@amd.com>
In-Reply-To: <ecbcc066-3636-9620-8db9-2c066d16e717@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 2 May 2023 15:39:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG8ZrdEUNTiSCet+aT+1ZyrbguFsGtNhVV+XgCssZgj9w@mail.gmail.com>
Message-ID: <CAMj1kXG8ZrdEUNTiSCet+aT+1ZyrbguFsGtNhVV+XgCssZgj9w@mail.gmail.com>
Subject: Re: [PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
To:     Tom Lendacky <thomas.lendacky@amd.com>
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2 May 2023 at 15:37, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 4/24/23 11:57, Ard Biesheuvel wrote:
> > This series is conceptually a combination of Evgeny's series [0] and
> > mine [1], both of which attempt to make the early decompressor code more
> > amenable to executing in the EFI environment with stricter handling of
> > memory permissions.
> >
> > My series [1] implemented zboot for x86, by getting rid of the entire
> > x86 decompressor, and replacing it with existing EFI code that does the
> > same but in a generic way. The downside of this is that only EFI boot is
> > supported, making it unviable for distros, which need to support BIOS
> > boot and hybrid EFI boot modes that omit the EFI stub.
> >
> > Evgeny's series [0] adapted the entire decompressor code flow to allow
> > it to execute in the EFI context as well as the bare metal context, and
> > this involves changes to the 1:1 mapping code and the page fault
> > handlers etc, none of which are really needed when doing EFI boot in the
> > first place.
> >
> > So this series attempts to occupy the middle ground here: it makes
> > minimal changes to the existing decompressor so some of it can be called
> > from the EFI stub. Then, it reimplements the EFI boot flow to decompress
> > the kernel and boot it directly, without relying on the trampoline code,
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
> I tried booting an SEV and an SEV-ES guest using this and both failed to boot:
>
> EFI stub: WARNING: Decompression failed: Out of memory while allocating
> z_stream
>
> I'll have to take a closer look as to why, but it might be a couple of
> days before I can get to it.
>

Thanks Tom.

The internal malloc() seems to be failing, which is often caused by
BSS clearing problems. Could you elaborate a little bit on the boot
environment you are using here?
