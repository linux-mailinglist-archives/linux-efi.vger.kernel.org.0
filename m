Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328AE3062A0
	for <lists+linux-efi@lfdr.de>; Wed, 27 Jan 2021 18:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhA0RvY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Jan 2021 12:51:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59072 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343847AbhA0RuA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 27 Jan 2021 12:50:00 -0500
Received: from zn.tnic (p200300ec2f0f5c00537ed9217074924f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5c00:537e:d921:7074:924f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63BA81EC04DA;
        Wed, 27 Jan 2021 18:49:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611769753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i9m0+oixWz9KJXHOAaimW/7os4efOug2mCnKLti8z+I=;
        b=cXwJpGiXWr0Gc5NKqcTWhKtGMAiEVe0Cl8aFoKrXzJ5SLjzNafhwTHazhoksi5gu8yfp8s
        NF/nzfvKyHWXRf8cCjZ4WVFrpEOF1tjKfzuNaQlKD7SwSBcFaZPCPXH4IzSngTWTZ8b6WB
        WWsSbHtn0bfHnbcejka7LAghFPDUPB4=
Date:   Wed, 27 Jan 2021 18:49:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] EFI fix for v5.11
Message-ID: <20210127174906.GE17424@zn.tnic>
References: <20210127105553.37741-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210127105553.37741-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 27, 2021 at 11:55:53AM +0100, Ard Biesheuvel wrote:
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.11
> 
> for you to fetch changes up to 355845b738e76445c8522802552146d96cb4afa7:
> 
>   efi/apple-properties: Reinstate support for boolean properties (2020-12-31 10:28:53 +0100)
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> 
> ----------------------------------------------------------------
> A single EFI fix from Lukas:
> 
> - handle boolean device properties imported from Apple firmware
>   correctly.
> 
> ----------------------------------------------------------------
> Lukas Wunner (1):
>       efi/apple-properties: Reinstate support for boolean properties
> 
>  drivers/firmware/efi/apple-properties.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Pulled, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
