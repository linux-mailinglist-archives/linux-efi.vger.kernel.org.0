Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6DE7A36F1
	for <lists+linux-efi@lfdr.de>; Sun, 17 Sep 2023 19:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbjIQRvS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 Sep 2023 13:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbjIQRu7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 17 Sep 2023 13:50:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1378F4;
        Sun, 17 Sep 2023 10:50:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31ff2ce9d4cso2308051f8f.0;
        Sun, 17 Sep 2023 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694973052; x=1695577852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RsA+hRq8jXdzx3chUO9nLgZ4Kj4gCRlN/+BYBBGrajM=;
        b=dzkJtJ8YFFTyiUHdrB+um+g7JLJbGrIWzAsIQGyfkGU1QHGM/vXDABpWj5p8taVUkQ
         96zrioFsfZJefl13b2gZpxIS2LUBLL3avfCxmOYjoM0exEnTcBQb78Lh719v8Qu6+QRd
         m66wWR42OCd1FlA1MtU4aJeI0cVfoH0LRsim7YW7i5i+/fmaEZ5OkCI5GiZoylyVNqxx
         aborTdJFcOGNKAqCkRTWcT7Pm8YfuoozH9N11jgfoe836tGQUF0vROY6VHOEuQJF1iCK
         13N9zXGbSdKfLR6nQhtQkbvxyRqGwJnsLE7Cwp1vVP6FUqKAUYoeUvwSeP9Y4A66ECfI
         2svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694973052; x=1695577852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsA+hRq8jXdzx3chUO9nLgZ4Kj4gCRlN/+BYBBGrajM=;
        b=EyQGGNWoPOhm7f7IKZjVbGRwc8nWYvMfc1zy0+PFcsnhmeBDXnSp6O7ptxv7QUlo9s
         uexD6gEH2TlN2iG/tm6eZ6/h9rlNWvV+01GBxOoC/152D9h6ncjUb2TtTC5gIpZtBv9E
         W7/FRhKA4d+HcaOMSHNSeRZKERRwsyyPdMNsNM+oS863J0RUrQBIFjgvQB1Yn3dM2h34
         QPEWF0AtuyJ4IYTMWgpJeuG8gPbaLHVDz9uHYTMTwp9qQMi6wgbMDODmovcP0VvhHkgK
         FotOfv0M/g2EeFfBLTvxJVgcA9NaUL7QQA2R/Uq87ddT4HwviH4Dfxs1nMLdPeGYJvlQ
         l0DA==
X-Gm-Message-State: AOJu0YxGoxx6QPFaSe3JoDK8hc89VwgxRx7j1hRmaYxzt7vmIaxsh9mB
        YGe5VG0YZ5te2OIBM1721f0=
X-Google-Smtp-Source: AGHT+IGlBSQ2Nuz/iu8K0q3PDUrGJ5vNgiCxBhLXQOS1kYqZbIDKBE/zqOUZdV7ZtIM7KSARRF2zuQ==
X-Received: by 2002:adf:dcc1:0:b0:317:5168:c21f with SMTP id x1-20020adfdcc1000000b003175168c21fmr5157340wrm.31.1694973052095;
        Sun, 17 Sep 2023 10:50:52 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d4e46000000b003198a9d758dsm10271331wrt.78.2023.09.17.10.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 10:50:51 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 17 Sep 2023 19:50:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@google.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/8] x86/boot: Rework PE header generation
Message-ID: <ZQc8efDzNs8gnv6X@gmail.com>
References: <20230915171623.655440-10-ardb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915171623.655440-10-ardb@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Now that the EFI stub boot flow no longer relies on memory that is
> executable and writable at the same time, we can reorganize the PE/COFF
> view of the kernel image and expose the decompressor binary's code and
> r/o data as a .text section and data/bss as a .data section, using 4k
> alignment and limited permissions.
> 
> Doing so is necessary for compatibility with hardening measures that are
> being rolled out on x86 PCs built to run Windows (i.e., the majority of
> them). The EFI boot environment that the Linux EFI stub executes in is
> especially sensitive to safety issues, given that a vulnerability in the
> loader of one OS can be abused to attack another.
> 
> In true x86 fashion, this is a lot more complicated than on other
> architectures, which have implemented this code/data split with 4k
> alignment from the beginning. The complicating factor here is that the
> boot image consists of two different parts, which are stitched together
> and fixed up using a special build tool.
> 
> After this series is applied, the only remaining task performed by the
> build tool is generating the CRC-32. Even though this checksum is
> usually wrong (given that distro kernels are signed for secure boot in a
> way that corrupts the CRC), this feature is retained as we cannot be
> sure that nobody is relying on this.
> 
> This supersedes the work proposed by Evgeniy last year, which did a
> major rewrite of the build tool in order to clean it up, before updating
> it to generate the new 4k aligned image layout. As this series proves,
> the build tool is mostly unnecessary, and we have too many of those
> already.
> 
> Changes since v2:
> - rebase onto tip/master
> - drop patches that have been picked up already
> - fix issue in the linker script that resulted in a bogus setup_size in
>   some cases when using ld.bfd
> - fix comment capitalization
> 
> Changes since v1:
> - drop patch that removed the CRC and the build tool
> - do not use fixed setup_size but derive it in the setup.ld linker
>   script
> - reorganize the PE header so the .compat section only covers its
>   payload and the padding that follows it
> - add hpa's ack to patch #4
> 
> Cc: Evgeniy Baskov <baskov@ispras.ru>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> 
> 
> Ard Biesheuvel (8):
>   x86/boot: Grab kernel_info offset from zoffset header directly
>   x86/boot: Set EFI handover offset directly in header asm
>   x86/boot: Define setup size in linker script
>   x86/boot: Derive file size from _edata symbol
>   x86/boot: Construct PE/COFF .text section from assembler
>   x86/boot: Drop PE/COFF .reloc section
>   x86/boot: Split off PE/COFF .data section
>   x86/boot: Increase section and file alignment to 4k/512
> 
>  arch/x86/boot/Makefile                 |   2 +-
>  arch/x86/boot/compressed/vmlinux.lds.S |   5 +-
>  arch/x86/boot/header.S                 | 146 +++++++------
>  arch/x86/boot/setup.ld                 |   7 +-
>  arch/x86/boot/tools/build.c            | 223 +-------------------
>  5 files changed, 97 insertions(+), 286 deletions(-)

Applied to tip:x86/boot, thanks!

	Ingo
