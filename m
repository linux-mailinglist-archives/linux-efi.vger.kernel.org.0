Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429CD12A71F
	for <lists+linux-efi@lfdr.de>; Wed, 25 Dec 2019 10:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfLYJuz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Dec 2019 04:50:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35772 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfLYJuz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Dec 2019 04:50:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so4097309wmb.0;
        Wed, 25 Dec 2019 01:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uUIcjORB9nRFSyWLet1DgaSxDKS1ZBSPNyG2RWrs+X0=;
        b=kIQ5TiSIn/4ihtFl9My93eQXD7DI5ixZJA2JE7zCgRQt0vAJxvDoo9xmCl69qve0+S
         TD6SNWygGIkK7bxhwK7pFTBdhVsgHVVSz4Q9p1X8nm5w5yeU9URd5hbxEK2FkKio8DgC
         iblh04KqdvqzN1SXv3CGSD1aO0YmkEonML+c/mPI9ae6hNfI4DNHux1ffuj6xC4h9XKe
         1Af/06SZcXF6L43XMdvLKw3Ye7OPQxk7Zdd8pbUhl4LbcWHr6uvngfu0KvX6SDtqMbtb
         ebxv1scGze+BvwL0g46wNmZsYW28zpku2s7hrhKDOQvkroGZSLb8KT9dc1yvYp98FJNn
         ySPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uUIcjORB9nRFSyWLet1DgaSxDKS1ZBSPNyG2RWrs+X0=;
        b=t026MKlPtfwjXB3ANdeneyDQQxJAQ8AeI7Tg2HVh3v0gYGdo3U5/5KGf7TH/tgcOJl
         QB+FIz3j/OsnMYN+HsS4EzD+bSpdJXunUR1Ly6BvEbaYkSksXv0bJcscbhRcxJb25SLm
         sdE70aZJzrqIpeRZfQcvybwUanRPZBlt8l2RqPYwBfi/6umJwM3YskiqsSNPIETueUCF
         SggiQDEq+Qjz9h4wXIuvqGDEdeEz6LdKO6cMvD0iqwXq03Zmfm7StjYeTMfYC+YZWx7Z
         +sKhQdtjAUqrJc3NP0DxxoAtfREJmD8KFTy746N7PT/XoMY/qsPiEnjUywN8eaten3LS
         zqOA==
X-Gm-Message-State: APjAAAW0K/W1T7WeY5thKWvNpxb0zdgoGM2x+sAlrD8yY3pcsGz09M4Y
        LIDzPzPEDd7J5bD2YtEHRfE=
X-Google-Smtp-Source: APXvYqw0JNwdFYz14eaGRl4M43XQ7IynkJCvisuLvd0Y+27+GCh+wAI2fvNnPXfAOKr53OJEfkyUNg==
X-Received: by 2002:a05:600c:2c53:: with SMTP id r19mr8549154wmg.39.1577267452614;
        Wed, 25 Dec 2019 01:50:52 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e18sm27160969wrr.95.2019.12.25.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2019 01:50:52 -0800 (PST)
Date:   Wed, 25 Dec 2019 10:50:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [GIT PULL 00/25] EFI updates for v5.6
Message-ID: <20191225095050.GB73981@gmail.com>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> Ingo, Thomas,
> 
> Please consider the pull request below. I am anticipating some more
> changes for this cycle, but it would be good to get these queued up and
> into -next sooner rather than later, since there is some risk of
> breakage even though the changes have been tested on a variety of
> hardware.
> 
> If you have the stomach to go over them in detail: please take into
> account that these patches modify the same efi_call_xxx() macro
> definitions multiple times, in order to be bisectable, so please
> consider the end result first before commenting on coding style of the
> intermediate changes.
> 
> NOTE: this series depends on the efi-urgent PR that I just sent out, so
> please merge tip/efi/urgent into tip/efi/core before applying the
> changes below.
> 
> Thanks and happy Christmas,
> Ard.
> 
> 
> 
> The following changes since commit 77217fcc8e04f27127b32825376ed508705fd946:
> 
>   x86/efistub: disable paging at mixed mode entry (2019-12-23 16:25:21 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> 
> for you to fetch changes up to c51a0735389b92cb0025137af0034773773ad7da:
> 
>   efi/libstub/x86: avoid globals to store context during mixed mode calls (2019-12-24 15:32:22 +0100)
> 
> ----------------------------------------------------------------
> EFI changes for v5.6:
> - Cleanup of the GOP [graphics output] handling code in the EFI stub (Arvind)
> - Inspired by the above, and with a little bit of Arvind's help, a complete
>   refactor of the mixed mode handling in the x86 EFI stub, getting rid of a
>   lot of ugly and unnecessary wrapping and typecasting. This is a worthwhile
>   cleanup by itself, but it also addresses a recurring issue where stub code
>   often fails to compile on non-x86 because all the casting and thunking via
>   variadic wrapper routines is masking problems in the code.
> 
> ----------------------------------------------------------------
> Ard Biesheuvel (21):
>       efi/libstub: remove unused __efi_call_early() macro
>       efi/x86: rename efi_is_native() to efi_is_mixed()
>       efi/libstub: use a helper to iterate over a EFI handle array
>       efi/libstub: extend native protocol definitions with mixed_mode aliases
>       efi/libstub: distinguish between native/mixed not 32/64 bit
>       efi/libstub: drop explicit 32/64-bit protocol definitions
>       efi/libstub: use stricter typing for firmware function pointers
>       efi/libstub: annotate firmware routines as __efiapi
>       efi/libstub/x86: avoid thunking for native firmware calls
>       efi/libstub: avoid protocol wrapper for file I/O routines
>       efi/libstub: get rid of 'sys_table_arg' macro parameter
>       efi/libstub: unify the efi_char16_printk implementations
>       efi/libstub/x86: drop __efi_early() export and efi_config struct
>       efi/libstub: drop sys_table_arg from printk routines
>       efi/libstub: remove 'sys_table_arg' from all function prototypes
>       efi/libstub/x86: work around page freeing issue in mixed mode
>       efi/libstub: drop protocol argument from efi_call_proto() macro
>       efi/libstub: drop 'table' argument from efi_table_attr() macro
>       efi/libstub: rename efi_call_early/_runtime macros to be more intuitive
>       efi/libstub: tidy up types and names of global cmdline variables
>       efi/libstub/x86: avoid globals to store context during mixed mode calls
> 
> Arvind Sankar (4):
>       efi/gop: Remove bogus packed attribute from GOP structures
>       efi/gop: Remove unused typedef
>       efi/gop: Convert GOP structures to typedef and cleanup some types
>       efi/gop: Unify 32/64-bit functions
> 
>  arch/arm/include/asm/efi.h                     |  17 +-
>  arch/arm64/include/asm/efi.h                   |  16 +-
>  arch/x86/Kconfig                               |  11 +-
>  arch/x86/boot/compressed/Makefile              |   2 +-
>  arch/x86/boot/compressed/eboot.c               | 290 +++++-----
>  arch/x86/boot/compressed/eboot.h               |  30 +-
>  arch/x86/boot/compressed/efi_stub_32.S         |  87 ---
>  arch/x86/boot/compressed/efi_stub_64.S         |   5 -
>  arch/x86/boot/compressed/efi_thunk_64.S        |  17 +-
>  arch/x86/boot/compressed/head_32.S             |  64 +--
>  arch/x86/boot/compressed/head_64.S             |  97 +---
>  arch/x86/include/asm/efi.h                     |  77 ++-
>  arch/x86/platform/efi/efi.c                    |  12 +-
>  arch/x86/platform/efi/efi_64.c                 |   6 +-
>  arch/x86/platform/efi/quirks.c                 |   2 +-
>  arch/x86/xen/efi.c                             |   2 +-
>  drivers/firmware/efi/libstub/arm-stub.c        | 110 ++--
>  drivers/firmware/efi/libstub/arm32-stub.c      |  70 ++-
>  drivers/firmware/efi/libstub/arm64-stub.c      |  32 +-
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 278 +++++-----
>  drivers/firmware/efi/libstub/efistub.h         |  48 +-
>  drivers/firmware/efi/libstub/fdt.c             |  53 +-
>  drivers/firmware/efi/libstub/gop.c             | 163 +-----
>  drivers/firmware/efi/libstub/random.c          |  77 ++-
>  drivers/firmware/efi/libstub/secureboot.c      |  11 +-
>  drivers/firmware/efi/libstub/tpm.c             |  48 +-
>  include/linux/efi.h                            | 730 +++++++++++--------------
>  27 files changed, 914 insertions(+), 1441 deletions(-)
>  delete mode 100644 arch/x86/boot/compressed/efi_stub_32.S
>  delete mode 100644 arch/x86/boot/compressed/efi_stub_64.S

Applied to tip:efi/core, and merry Christmas to you too!

	Ingo
