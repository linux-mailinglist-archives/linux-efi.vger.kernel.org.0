Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26927D4A20
	for <lists+linux-efi@lfdr.de>; Tue, 24 Oct 2023 10:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjJXIcc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Oct 2023 04:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjJXIcb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Oct 2023 04:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A36B10EA
        for <linux-efi@vger.kernel.org>; Tue, 24 Oct 2023 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698136307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ITFJy6PL18AxXcQ0tJtKX/riP17Qh3+LpE2GcIDMeCU=;
        b=dFy3KW0SV74+SGVa0/t7EawHPFUSTH3ropzlqORy6kW3dEpVLTtj6ye8JlNolZMd3gUooz
        HL9rB2GoS7gmV0QqhaudOSUHkOlDjtpxEItHn3dj3cmK/rOaDfA2NtlJf5ELjQFpk7muNb
        W7RhehYCLP/EFnLJBEmrSoJ2r6QS9r4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-uoMCQNMhM3WvwCiVWwbPlQ-1; Tue, 24 Oct 2023 04:31:45 -0400
X-MC-Unique: uoMCQNMhM3WvwCiVWwbPlQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3575e2e1dfaso12574735ab.1
        for <linux-efi@vger.kernel.org>; Tue, 24 Oct 2023 01:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136305; x=1698741105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITFJy6PL18AxXcQ0tJtKX/riP17Qh3+LpE2GcIDMeCU=;
        b=gpkN4wCiguieHfgwUSXXpCFncIie+/RID/XvAQFAIcoHNTjFi3sEx1a+JseJq4bu9n
         exZcdCdRvkoeY9GMC9v/y9TYI6r9SAcB6UOE1fJhzDSmLB6yhIWpXBQTPIVS3ner6IFr
         P8k6aeJ2ZGaXq6UON4GHLXj27j3WYqbFP6+3XM+k9CfWRX9wZfx1BvYtCHU592/Y9h9K
         diZUaWn3DaAqsD50+Y9ZRUw/xW7QwEbP3tQ8OE/N8Rl2xF52lcvCYwyQh/rvZ4pqI5B0
         bLT8AoQrM52yAqQNiVEjIGtGzMhR1m4bDB36yvjp6F8cz/FN75Wc8SFkQrZk+LXuSjrj
         if7g==
X-Gm-Message-State: AOJu0Yw+ghLF1enJS/J5sG6cPHdBChUFAlN+qed0nHN6pjk5MHfccCMK
        lc/qQmSVqK38sUYUzrVj7SW9fMer9jkX0znOkKp2goo7gdKo6oyPxnycgVGy+Fs6ZE1dA2ZEnmz
        t56ClnpWewQLIYqyA0VudxoG8MWOr5pogRFz4
X-Received: by 2002:a05:6e02:1d9d:b0:34f:7ba2:50e8 with SMTP id h29-20020a056e021d9d00b0034f7ba250e8mr13143880ila.2.1698136304717;
        Tue, 24 Oct 2023 01:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHTillXwi4Yy8mMt80SkVrJ/fr3lgQcdZQJr+vXNNVHsb99ljUAorE0YMkswPa6fZZ1r2eXFHDGKmKLVUFBEo=
X-Received: by 2002:a05:6e02:1d9d:b0:34f:7ba2:50e8 with SMTP id
 h29-20020a056e021d9d00b0034f7ba250e8mr13143861ila.2.1698136304468; Tue, 24
 Oct 2023 01:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com> <ZRt2ToOHm2XT8MlU@desktop>
 <CAMj1kXH--86-pqHp6W0gsRDAMw-iuYKrgHEpmZzaJnpsVTkkxw@mail.gmail.com>
 <ZTau5kbdB-9iRfcm@desktop> <CALu+AoQbBr0RyBG6JxyKO81Ur=0uG_FxZq3=-QYhF2OxV7+F7g@mail.gmail.com>
In-Reply-To: <CALu+AoQbBr0RyBG6JxyKO81Ur=0uG_FxZq3=-QYhF2OxV7+F7g@mail.gmail.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Tue, 24 Oct 2023 16:31:27 +0800
Message-ID: <CALu+AoSPqDOAhwoLCYkGRnE96X6r7rpOwERmse+=YQyA4OW2ug@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] x86/boot: Rework PE header generation
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb@google.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Goyal, Vivek" <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 24 Oct 2023 at 16:21, Dave Young <dyoung@redhat.com> wrote:
>
> On Tue, 24 Oct 2023 at 01:37, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
> >
> > On 23 13:22:53, Ard Biesheuvel wrote:
> > > On Tue, 3 Oct 2023 at 04:03, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
> > > >
> > > > On 12 09:00:51, Ard Biesheuvel wrote:
> > > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > >
> > > > > Now that the EFI stub boot flow no longer relies on memory that is
> > > > > executable and writable at the same time, we can reorganize the PE/COFF
> > > > > view of the kernel image and expose the decompressor binary's code and
> > > > > r/o data as a .text section and data/bss as a .data section, using 4k
> > > > > alignment and limited permissions.
> > > > >
> > > > > Doing so is necessary for compatibility with hardening measures that are
> > > > > being rolled out on x86 PCs built to run Windows (i.e., the majority of
> > > > > them). The EFI boot environment that the Linux EFI stub executes in is
> > > > > especially sensitive to safety issues, given that a vulnerability in the
> > > > > loader of one OS can be abused to attack another.
> > > >
> > > > This split is also useful for the work of kexecing the next kernel as an
> > > > EFI application. With the current EFI stub I have to set the memory both
> > > > writable and executable which results in W^X warnings with a default
> > > > config.
> > > >
> > > > What made this more confusing was that the flags of the .text section in
> > > > current EFI stub bzImages are set to
> > > > IMAGE_SCN_MEM_EXECUTE | IMAGE_SCN_MEM_READ. So if you load that section
> > > > according to those flags the EFI stub will quickly run into issues.
> > > >
> > > > I assume current firmware on x86 machines does not set any restricted
> > > > permissions on the memory. Can someone enlighten me on their behavior?
> > > >
> > >
> > > No current x86 firmware does not use restricted permissions at all.
> > > All memory is mapped with both writable and executable permissions,
> > > except maybe the stack.
> > >
> > > The x86 Linux kernel has been depending on this behavior too, up until
> > > recently (fixes are in -rc now for the v6.6 release). Before this, it
> > > would copy its own executable image around in memory.
> > >
> > > So EFI based kexec will need to support this behavior if it targets
> > > older x86 kernels, although I am skeptical that this is a useful
> > > design goal.
> >
> > I don't see this as an important goal either.
> >
> > > I have been experimenting with running the EFI stub code in user space
> > > all the way until ExitBootServices(). The same might work for UKI if
> > > it is layered cleanly on top of the EFI APIs (rather than poking into
> > > system registers or page tables under the hood).
> > >
> > > How this would work with signed images etc is TBD but I quite like the
> > > idea of running everything in user space and having a minimal
> > > purgatory (or none at all) if we can simply populate the entire
> > > address space while running unprivileged, and just branch to it in the
> > > kexec() syscall. I imagine this being something like a userspace
> > > helper that is signed/trusted itself, and gets invoked by the kernel
> > > to run EFI images that are trusted and tagged as being executable
> > > unprivileged.
> >
> > I've been experimenting with running EFI apps inside kernel space instead.
> > This is the more natural approach for signed images. Sure, a malicious EFI
> > app could do arbitrary stuff in kernel mode, but they're signed. On the other
> > hand running this entirely in user space would at least guarantee that the
> > system can not crash due to a misbehaving EFI app (at least until
> > ExitBootServices()).
> >
> > The question of whether or not to make this the job of a userspace helper that
> > is signed must have come up when kexec_file_load syscall was added. It would
> > have also been an option at the time to extend trust to a signed version of
> > the userspace kexec tool.
> >
> > Why was kexec_file_load created instead of restricting kexec_load to a signed
> > version of the kexec userspace tool?
>
> I think one of the reasons is that it is hard to handle dynamic linked
> libraries, not only the kexec-tools binary.

Hmm, another one is that ptrace needs to be disabled in some way,
anyway I think it is way too complicated, but I do not remember the
details, added Vivek in cc.
See this article: https://lwn.net/Articles/532778/

>
> Thanks
> Dave

