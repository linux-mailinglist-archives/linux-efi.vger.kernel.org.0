Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BF842EE83
	for <lists+linux-efi@lfdr.de>; Fri, 15 Oct 2021 12:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbhJOKOk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Oct 2021 06:14:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41768 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237713AbhJOKOj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 15 Oct 2021 06:14:39 -0400
Received: from zn.tnic (p200300ec2f0cfb0087c6997658fca07e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:fb00:87c6:9976:58fc:a07e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5780B1EC058A;
        Fri, 15 Oct 2021 12:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634292751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x9ExC28dwFG7HBFMhGCvtbUKTI9nhQEY16yU0Z8wAiQ=;
        b=LrmxAo0dErCZikQNIqY5jqgoCxtlzjDBoQ9ouVgTvDxtSU8/OuIKD3KvbDxThXLVT1ma61
        E6hNO7PqJ/AJCg8xiStWww1NYSHX58Yn1pN4EK/M4CEdudweJMGze+36KDFIaiJsAdLqGT
        CbRA4r10NUy6aFffwCY9FvYmciNi+08=
Date:   Fri, 15 Oct 2021 12:12:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [GIT PULL] EFI updates for v5.16
Message-ID: <YWlUDRCqkb4SZLyQ@zn.tnic>
References: <20211014114643.2232141-1-ardb@kernel.org>
 <20211014114643.2232141-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014114643.2232141-2-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 14, 2021 at 01:46:43PM +0200, Ard Biesheuvel wrote:
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.16
> 
> for you to fetch changes up to 720dff78de360ad9742d5f438101cedcdb5dad84:
> 
>   efi: Allow efi=runtime (2021-09-28 22:44:15 +0200)
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> 
> ----------------------------------------------------------------
> EFI update for v5.16
> 
> Disable EFI runtime services by default on PREEMPT_RT, while adding the
> ability to re-enable them on demand by passing efi=runtime on the
> command line.
> 
> ----------------------------------------------------------------
> Sebastian Andrzej Siewior (2):
>       efi: Disable runtime services on RT
>       efi: Allow efi=runtime
> 
>  drivers/firmware/efi/efi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Both tags pulled,

thanks Ard!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
