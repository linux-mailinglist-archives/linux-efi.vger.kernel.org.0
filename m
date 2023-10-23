Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAEE7D32BF
	for <lists+linux-efi@lfdr.de>; Mon, 23 Oct 2023 13:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjJWLX0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Oct 2023 07:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjJWLXQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Oct 2023 07:23:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A8E170B;
        Mon, 23 Oct 2023 04:23:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5600FC433C8;
        Mon, 23 Oct 2023 11:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698060187;
        bh=glLG5TEhfKd3JiZvDQuB9V+Fcua4mDvO1k0ZC6eacp0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=atv/E5gn+WmLReO/x2YKldnKkDthQNncv6YsghD8O/XQOsuHFgnRzr+fS8OnupBE4
         BbF1H3Ub6HISCeCvgvE9RKMozLiSvG3HIv4//GCiySQzZwu+vm3mmr+2RZ8FmE2Bik
         +HxqkXSq/+wkV8f3jzGUgr1/VJtxrx0JDwqg9wFxD/SnjgdFqsCutrQMredIk8IVuf
         Oo5akXVFtqeCkY37mV1PbBwlCPWvQKlli5xV1xND9num/mtWK2bgqnggjk+sgy5p/h
         EUXhX8m00pVO5vvjOGDwXyVbNgx7Mt2FoetnntVlGu5IqX2TTwNBLcxszDvS4t/nuL
         uVxJtkMsyPYfw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2c16757987fso46004781fa.3;
        Mon, 23 Oct 2023 04:23:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YzrrVvzO2/KbYj/HLSHv0v7WfIqT4LAY1iHBJHBUTRa0X3J+WSH
        IFg6+o8EeRf70AyITFwzLq6G8jicp7Qcx1hVHq8=
X-Google-Smtp-Source: AGHT+IFMHGhNMS8e7UjheLJvBMKsdamB7bLul9rLSzBwNBkxq1uPX4eBOFtTCDFcR+QAb3SBok+MzoHkgWwg3OTNUCQ=
X-Received: by 2002:a2e:905a:0:b0:2c5:50d:3fc3 with SMTP id
 n26-20020a2e905a000000b002c5050d3fc3mr5766127ljg.7.1698060185523; Mon, 23 Oct
 2023 04:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com> <ZRt2ToOHm2XT8MlU@desktop>
In-Reply-To: <ZRt2ToOHm2XT8MlU@desktop>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 23 Oct 2023 13:22:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH--86-pqHp6W0gsRDAMw-iuYKrgHEpmZzaJnpsVTkkxw@mail.gmail.com>
Message-ID: <CAMj1kXH--86-pqHp6W0gsRDAMw-iuYKrgHEpmZzaJnpsVTkkxw@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] x86/boot: Rework PE header generation
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     Ard Biesheuvel <ardb@google.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 3 Oct 2023 at 04:03, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> On 12 09:00:51, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Now that the EFI stub boot flow no longer relies on memory that is
> > executable and writable at the same time, we can reorganize the PE/COFF
> > view of the kernel image and expose the decompressor binary's code and
> > r/o data as a .text section and data/bss as a .data section, using 4k
> > alignment and limited permissions.
> >
> > Doing so is necessary for compatibility with hardening measures that are
> > being rolled out on x86 PCs built to run Windows (i.e., the majority of
> > them). The EFI boot environment that the Linux EFI stub executes in is
> > especially sensitive to safety issues, given that a vulnerability in the
> > loader of one OS can be abused to attack another.
>
> This split is also useful for the work of kexecing the next kernel as an
> EFI application. With the current EFI stub I have to set the memory both
> writable and executable which results in W^X warnings with a default
> config.
>
> What made this more confusing was that the flags of the .text section in
> current EFI stub bzImages are set to
> IMAGE_SCN_MEM_EXECUTE | IMAGE_SCN_MEM_READ. So if you load that section
> according to those flags the EFI stub will quickly run into issues.
>
> I assume current firmware on x86 machines does not set any restricted
> permissions on the memory. Can someone enlighten me on their behavior?
>

No current x86 firmware does not use restricted permissions at all.
All memory is mapped with both writable and executable permissions,
except maybe the stack.

The x86 Linux kernel has been depending on this behavior too, up until
recently (fixes are in -rc now for the v6.6 release). Before this, it
would copy its own executable image around in memory.

So EFI based kexec will need to support this behavior if it targets
older x86 kernels, although I am skeptical that this is a useful
design goal.

I have been experimenting with running the EFI stub code in user space
all the way until ExitBootServices(). The same might work for UKI if
it is layered cleanly on top of the EFI APIs (rather than poking into
system registers or page tables under the hood).

How this would work with signed images etc is TBD but I quite like the
idea of running everything in user space and having a minimal
purgatory (or none at all) if we can simply populate the entire
address space while running unprivileged, and just branch to it in the
kexec() syscall. I imagine this being something like a userspace
helper that is signed/trusted itself, and gets invoked by the kernel
to run EFI images that are trusted and tagged as being executable
unprivileged.
