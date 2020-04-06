Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650F919F1C2
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgDFIoi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 04:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgDFIoh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Apr 2020 04:44:37 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ECAB206F8;
        Mon,  6 Apr 2020 08:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586162677;
        bh=GMSN1Fphc0U27YnwyS5FIVCfGSyo0Vdyse+rVe68+u0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hw9JZp+sxmxwCLJOGybQgiAhE5dxZ9gQtevlNtRlL601yRe8EmkT3xKSGhOzd7jkr
         Q+BwRlEdRsRwwN2ZxOHXNu0VzOVTyxrVOOApTuOvXevxkvsQjQKGqnV6ethl+WG+rO
         K853If+U4eaiVjO1GA/O2MKnA/cRNyeD7cNBMi5A=
Received: by mail-io1-f50.google.com with SMTP id u2so1415590iop.10;
        Mon, 06 Apr 2020 01:44:37 -0700 (PDT)
X-Gm-Message-State: AGi0PuYTDwPMfscu0pofzH83G2HJwwmCvuS30LVVGL+RdMJfuXt5OvZq
        VrZCODM743ckF1puDnasNs6MFUeLMEmJK3wvqVo=
X-Google-Smtp-Source: APiQypKcgJlcQ+QfizU2up5W3JzZNmYLCXBV2b6cTe9E4edKtqO1fbd7lSkhNSlmYYKafhbcNPb7Bulmj8VTb20MDcY=
X-Received: by 2002:a6b:f413:: with SMTP id i19mr18731580iog.203.1586162676498;
 Mon, 06 Apr 2020 01:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200109150218.16544-1-nivedita@alum.mit.edu> <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan>
In-Reply-To: <20200405231845.GA3095309@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Apr 2020 10:44:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHWhPmnaCS74n=1MYLfnsKqf+UAfmaLGQYx9jH3YsXvfg@mail.gmail.com>
Message-ID: <CAMj1kXHWhPmnaCS74n=1MYLfnsKqf+UAfmaLGQYx9jH3YsXvfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from bzImage
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Sergey Shatunov <me@prok.pw>, bp@alien8.de, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 6 Apr 2020 at 01:18, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sun, Apr 05, 2020 at 10:42:46PM +0700, Sergey Shatunov wrote:
> > This patch causes some strange things happens with my laptop.
> >
> > Cold boot crashed in some early initilization logic with message 'Failed to execute /esp/.../linux.efi: Buffer Too Small'.
> > After couple reboots into firmware setup (bios) or hot reboot from other working kernel (without that commit) helps it to boot.
> > During bisecting couple times I saw different message: 'exit_efi() failed; efi_main() failed', but above tricks helps it too.

Could you please try adding 'efi=no_disable_early_pci_dma' to the
kernel command line? The lack of BSS zeroization may result in that
option to get inadvertently enabled, and it is known to break
exit_boot() on some systems.
