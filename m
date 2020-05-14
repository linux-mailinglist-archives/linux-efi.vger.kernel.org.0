Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E665D1D2AE2
	for <lists+linux-efi@lfdr.de>; Thu, 14 May 2020 11:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgENJGL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 May 2020 05:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgENJGL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 May 2020 05:06:11 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9876320675;
        Thu, 14 May 2020 09:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589447170;
        bh=a9zKcEcwX/U5AWN8Z2tVlAOpo48QZnatONbuVLLd7nc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xb6qpGNWYMht0PHK8bOzrNf0LVIqYlpL+LvVGElkxt8cw97mcLjL9iY4aFFjkHhsr
         O0BkApmXFSVkzFBaCQJo2jwdLnrjzZ2D5I2jHmaNrDKm9+o2wd37RH+WzLPHc7U9uu
         eYxCUsGB8QxtzaPggWrb8x9EfmOM1ScG/Y4XqUjE=
Received: by mail-il1-f181.google.com with SMTP id b71so2542210ilg.8;
        Thu, 14 May 2020 02:06:10 -0700 (PDT)
X-Gm-Message-State: AOAM532aG9b9oBX1/nHT+mBfr1Z3RWezLORFQwApmeZ9SYHW857DWbVQ
        lZGIAE29ZlaFvSqgSCyDq+OXpRoxbAf1uHprffg=
X-Google-Smtp-Source: ABdhPJxUY8qmQknQYvjuoNLqWGW1gmT+lBVl8yewXTfNDssK2v13BAUGPfAUrwUumsFRdibTsVDcu8Yz5UAiYTp8k18=
X-Received: by 2002:a92:a312:: with SMTP id a18mr3693540ili.80.1589447169779;
 Thu, 14 May 2020 02:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200508180157.1816-1-ardb@kernel.org>
In-Reply-To: <20200508180157.1816-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 May 2020 11:05:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHwj4SkoBH7Ft5Oa1DzL7jU0FhyTg2FUCz2aLaLXP91tw@mail.gmail.com>
Message-ID: <CAMj1kXHwj4SkoBH7Ft5Oa1DzL7jU0FhyTg2FUCz2aLaLXP91tw@mail.gmail.com>
Subject: Re: [GIT PULL 00/15] More EFI changes for v5.8
To:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 8 May 2020 at 20:02, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The following changes since commit 4da0b2b7e67524cc206067865666899bc02e1cb0:
>
>   efi/libstub: Re-enable command line initrd loading for x86 (2020-04-25 12:26:32 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-next
>
> for you to fetch changes up to 4026229934f6ca0cb44af7b9df00e647b2f1f787:
>
>   efi/libstub: Correct comment typos (2020-05-06 11:27:55 +0200)
>
> ----------------------------------------------------------------
> More EFI changes for v5.8:
> - Rename pr_efi/pr_efi_err to efi_info/efi_err, and use them consistently
> - Simplify and unify initrd loading
> - Parse the builtin command line on x86 (if provided)
> - Some fixes for issues introduced by the first batch of v5.8 changes
>
> ----------------------------------------------------------------
> Ard Biesheuvel (2):
>       efi/libstub/x86: Work around LLVM ELF quirk build regression
>       efi/libstub: Make efi_printk() input argument const char*
>
> Arvind Sankar (12):
>       efi/x86: Use correct size for boot_params
>       efi/libstub: Add a helper function to split 64-bit values
>       efi/libstub: Move pr_efi/pr_efi_err into efi namespace
>       efi/x86: Use efi_err for error messages
>       efi/gop: Use efi_err for error messages
>       efi/tpm: Use efi_err for error messages
>       efi/libstub: Upgrade ignored dtb= argument message to error
>       efi/x86: Move command-line initrd loading to efi_main
>       efi/libstub: Unify initrd loading across architectures
>       efi/x86: Support builtin command line
>       efi/libstub: Check return value of efi_parse_options
>       efi/libstub: Fix mixed mode boot issue after macro refactor
>
> Joe Perches (1):
>       efi/libstub: Correct comment typos
>

Ping?
