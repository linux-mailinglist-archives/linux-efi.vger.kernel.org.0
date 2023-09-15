Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E58F7A1A74
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjIOJX3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 05:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjIOJX3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 05:23:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462923A99;
        Fri, 15 Sep 2023 02:22:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-402d499580dso20623725e9.1;
        Fri, 15 Sep 2023 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694769750; x=1695374550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+R4xG30s2x016nX2JuEZD/dAKGo/2m5y0j0kuBiC4Q=;
        b=NQid+HjNTimoetByM0uewi+HvZ3IccN6CyUt/fXWDtMjfu2v5XCDOBUBfESG6opaqD
         W2sc8DojgSdM6gtwVrDHRiMzxnthJuDVltAQVB3/CCw5JFmrT8DrqKoNuhzAe1F1zVpH
         st5TJsBU30H0OG/J+aNEfYqFXoEZvZ2d41cuztlq59mrCG3k71cYG8FneWYKA6v4Q3fr
         1mXYMwHmGtfKf2/IC/NKVfxY15Bfdyttd+lf7AcFabw06Je4JT8YKASFq5vTPX84zlz3
         DdxuCsSDwA0JYbxb/185rTmV+wJqTbZL8gGRHQuTgFMCU2fVybsc3EtFYHnSR9oBcwtb
         S6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769750; x=1695374550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+R4xG30s2x016nX2JuEZD/dAKGo/2m5y0j0kuBiC4Q=;
        b=N4PkZ+vpXgbO2ikALNZQap00scVFOFYBx9XkZr9XBWLLJRXBeejzLAcdkgf3QoeJyX
         Xcg0yf0ifO/qSNwzdmXyUKwsfqdcD8zqG3SP0L36r0lZtpn0kCXH+9V+DwO/qvE8JFIS
         aOSeIL6nsNRctLPjAbZejWOkWGun9OXL99WGR3V7u+gMUp76RldVJUhWDGH5x9dB250m
         b0MiS/LXMeNzRWNL7EZKyaY/9tHKCHHOaBkU8irlPJzGfvpOBuDKLthQt6hmdDfaajW/
         GKB6txJ89XUk4HTOInmeEmBoOFQm1gewgtD6Ib9yocY/GsqYvqzoYazxzihxNtP24kOU
         b+lQ==
X-Gm-Message-State: AOJu0Yx58tWGfnizsy6LPi3b5irLKRVpQKsCryqvOcfVt7n0bMrUjV2t
        JLXcbE2YkdyaEt3IjwmJYvV7IyTx/eU=
X-Google-Smtp-Source: AGHT+IHiUO2sUuMy09UXvC0/OikwNDW3oqIuHHPQb7S2SX9ghnJtnWDrhpUm3jHgtcZN5RXg4+J+Fg==
X-Received: by 2002:a1c:790d:0:b0:404:7670:90b8 with SMTP id l13-20020a1c790d000000b00404767090b8mr1067795wme.27.1694769750379;
        Fri, 15 Sep 2023 02:22:30 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b00403c8dde953sm6435275wmo.22.2023.09.15.02.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:22:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 11:22:27 +0200
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
Subject: Re: [PATCH v2 00/15] x86/boot: Rework PE header generation
Message-ID: <ZQQiUxh5vmeZnp7s@gmail.com>
References: <20230912090051.4014114-17-ardb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
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
> Ard Biesheuvel (15):
>   x86/efi: Drop EFI stub .bss from .data section
>   x86/efi: Disregard setup header of loaded image
>   x86/efi: Drop alignment flags from PE section headers
>   x86/boot: Remove the 'bugger off' message
>   x86/boot: Omit compression buffer from PE/COFF image memory footprint
>   x86/boot: Drop redundant code setting the root device
>   x86/boot: Grab kernel_info offset from zoffset header directly
>   x86/boot: Drop references to startup_64

I've applied these first 8 patches to tip:x86/boot with minor edits.
(Please preserve existing comment capitalization conventions ...)

>   x86/boot: Set EFI handover offset directly in header asm
>   x86/boot: Define setup size in linker script
>   x86/boot: Derive file size from _edata symbol
>   x86/boot: Construct PE/COFF .text section from assembler
>   x86/boot: Drop PE/COFF .reloc section
>   x86/boot: Split off PE/COFF .data section
>   x86/boot: Increase section and file alignment to 4k/512

The rest conflicted with recent upstream changes, and I suppose it's
prudent to test these changes bit by bit anyway.

Thanks,

	Ingo
