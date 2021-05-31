Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88498395A37
	for <lists+linux-efi@lfdr.de>; Mon, 31 May 2021 14:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhEaMPt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 May 2021 08:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhEaMPs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 31 May 2021 08:15:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 816FA611CB;
        Mon, 31 May 2021 12:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622463248;
        bh=aJqByJbF/rFKmsSRS5lwvYsm0YCBd40N7Fa8DEM41g0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FufOfm6Jbh2nbcp+IzqxGu9pj+hjBulvwWfVDgda+qtyujG5ZEUZkl2z3RO/+2kkN
         0hYlqJFDjmDbygmyvcjAk3QVQD4DyaQRaSQ7n3EIQcvQ0cLrXNB2GK1SUjFHO8RVHU
         0d8amqxMT4YHHszA+3U1PAH2yqZHRKXHgpxm5fqYbv7DUNlg0ckCX+4z4akCfzqmBz
         qSUWtAiDqRiGsAAJLPBQbrXICcfr1NtW0sUYpsWrFWMDh0oO7wyMEsgWaLu4u2mz1n
         Dt48+lXPNsr56Y1KoeTU5+oGhJw6CyaSzDqo9A5I/Y2NwnSwKeBrZA5T7nGdbBva3B
         iFSzFQn/h+gVA==
Date:   Mon, 31 May 2021 15:13:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     lijiang <lijiang@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, kexec@lists.infradead.org,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        luto@amacapital.net, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] x86/efi: unconditionally hold the whole low-1MB
 memory regions
Message-ID: <YLTTBpX13mWCysWx@kernel.org>
References: <20210531090023.16471-1-lijiang@redhat.com>
 <YLSnkKeoQnokXVsK@zn.tnic>
 <YLSzUBQ/7CyINu87@kernel.org>
 <YLS/1sqz6Bncg5VU@zn.tnic>
 <CANU+ZyeFxeGXhxDx_ojB_hmiD-b8aTkqJcmc4fBHAS39vS7ZiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANU+ZyeFxeGXhxDx_ojB_hmiD-b8aTkqJcmc4fBHAS39vS7ZiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 31, 2021 at 07:00:59PM +0800, lijiang wrote:
> Thank you for the information, Boris and Mike.
> 
> BTW: I just noticed that Mike's patch is incorrect, maybe it's a typo:
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 7850111008a8b..e262ca858787f 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -450,6 +450,18 @@ void __init efi_free_boot_services(void)
> size -= rm_size;
> }
> + /*
> + * Don't free memory under 1M for two reasons:
> + * - BIOS might clobber it
> + * - Crash kernel needs it to be reserved
> + */
> + if (start + size < SZ_1M)
> + continue;
> + if (start < SZ_1M) {
> + size -= (start - SZ_1M);
> ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> It looks like: size -= (SZ_1M - start);

Right, thanks!

> + start = SZ_1M;
> + }
> +
> memblock_free_late(start, size);
> }
> 
> Mike's patch link:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?h=x86/
> reservelow&id=479fb34676ac448529b605854cf48c007e796ccd
 
-- 
Sincerely yours,
Mike.
