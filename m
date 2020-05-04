Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68B11C3431
	for <lists+linux-efi@lfdr.de>; Mon,  4 May 2020 10:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgEDISD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 May 2020 04:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgEDISC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 4 May 2020 04:18:02 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A122206B9;
        Mon,  4 May 2020 08:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588580281;
        bh=OVUdf03GpdBKoKoEIdOkVqH3usUQTub5eg9rUM5Tk7E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ur+LDywLeocYQ8c521eEsiMHthn9gmXQVo7xuA5oS9uYyZXqj1b9DCTC6GDvA5/e1
         1xNJ1NVf+w7ZckeInrzJEfr+45bQT6kNZ9YemwsjDlN8U5owii+Ro6kl9x3ql6CHgE
         u4K81Peb95GhNXrew1TxoosEvdcbi4MP1TCnn8d8=
Received: by mail-il1-f170.google.com with SMTP id r2so10436129ilo.6;
        Mon, 04 May 2020 01:18:01 -0700 (PDT)
X-Gm-Message-State: AGi0PuYevqRfwbCgGCNdqFUzG3ySgI4efMubm0tXe/EW2Kl567zRgnYe
        6ntdCgHItNw+vcZ6YpQ0IQiPysFPErd3rCYH1vU=
X-Google-Smtp-Source: APiQypLhl3BTB/BJgQ22Pc7HsMxpk/V/B39J75KD7MfQp7B5jk4hb5eHO5Ghj7SzGZYovBjRreKKRXMOJzkcMXJ3be4=
X-Received: by 2002:a92:3c55:: with SMTP id j82mr15615706ila.258.1588580280680;
 Mon, 04 May 2020 01:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200429174120.1497212-1-nivedita@alum.mit.edu> <20200430182843.2510180-1-nivedita@alum.mit.edu>
In-Reply-To: <20200430182843.2510180-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 4 May 2020 10:17:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF=rcCLXZBe=_A_-Mn26eHPyuiaSES1RtJmfVjmHrFPVg@mail.gmail.com>
Message-ID: <CAMj1kXF=rcCLXZBe=_A_-Mn26eHPyuiaSES1RtJmfVjmHrFPVg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] efi: some cleanups/refactoring for efi/next
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 30 Apr 2020 at 20:28, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> This series is on top of efi/next.
>
> Patch 1 fixes the size allocated for x86 boot_params.
> Patch 2 refactors the setting of various hi/lo 32-bit fields, mainly on x86.
> Patch 3 renames pr_efi/pr_efi_err
> Patches 4-6 convert the remaining uses of efi_printk to print error
> messages to use efi_err instead.
> Patch 7 updates dtb= ignored message to efi_err.
> Patches 8-9 refactor initrd loading, moving it into efi-stub-helper.
> Patch 10 adds support for x86 builtin command line.
> Patch 11 adds error checking for efi_parse_options.
>
> Changes from v1:
> - Rename pr_efi/pr_efi_err
> - Drop the soft_limit-removing patch
> - Fix a couple of compile warnings
>
> Arvind Sankar (11):
>   efi/x86: Use correct size for boot_params
>   efi/libstub: Add a helper function to split 64-bit values
>   efi/libstub: Move pr_efi/pr_efi_err into efi namespace
>   efi/x86: Use efi_err for error messages
>   efi/gop: Use efi_err for error messages
>   efi/tpm: Use efi_err for error messages
>   efi/libstub: Upgrade ignored dtb= argument message to error
>   efi/x86: Move command-line initrd loading to efi_main
>   efi/libstub: Unify initrd loading across architectures
>   efi/x86: Support builtin command line
>   efi/libstub: Check return value of efi_parse_options
>

Thanks Arvind, I've queued these up now


>  drivers/firmware/efi/libstub/arm32-stub.c     |  12 +-
>  drivers/firmware/efi/libstub/arm64-stub.c     |  14 +-
>  .../firmware/efi/libstub/efi-stub-helper.c    |  46 ++++++-
>  drivers/firmware/efi/libstub/efi-stub.c       |  63 ++++-----
>  drivers/firmware/efi/libstub/efistub.h        |  32 ++---
>  drivers/firmware/efi/libstub/fdt.c            |  16 +--
>  drivers/firmware/efi/libstub/file.c           |  12 +-
>  drivers/firmware/efi/libstub/gop.c            |  16 +--
>  drivers/firmware/efi/libstub/pci.c            |   8 +-
>  drivers/firmware/efi/libstub/relocate.c       |   2 +-
>  drivers/firmware/efi/libstub/secureboot.c     |   4 +-
>  drivers/firmware/efi/libstub/tpm.c            |   2 +-
>  drivers/firmware/efi/libstub/x86-stub.c       | 122 ++++++++----------
>  13 files changed, 186 insertions(+), 163 deletions(-)
>
> --
> 2.26.2
>
