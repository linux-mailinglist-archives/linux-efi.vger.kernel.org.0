Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608B53062CC
	for <lists+linux-efi@lfdr.de>; Wed, 27 Jan 2021 18:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhA0R5m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Jan 2021 12:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344026AbhA0R53 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Jan 2021 12:57:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D67C061574
        for <linux-efi@vger.kernel.org>; Wed, 27 Jan 2021 09:56:49 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f5c00537ed9217074924f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5c00:537e:d921:7074:924f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB9A51EC04DA;
        Wed, 27 Jan 2021 18:56:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611770207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pvmkLXLTUyVvEPfCKZYzBSnRVSLND4KECwHqXgGbImA=;
        b=YlMMYLIfAWrF8G4QbeECRxE8vlt6MsRLQpPkCNvo53K2CsqUIpKK3PciznTBESd13oAkwK
        fw6HgmBUqx4At2SgR6efONygejXqcxZycFHScSAgNW+3Jh9g0bcFaxV22/4ZCgnjzS/kqM
        Ge7H7akIY4PDaHvcrHHsCt071MT4dqE=
Date:   Wed, 27 Jan 2021 18:56:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] EFI changes for v5.12
Message-ID: <20210127175647.GF17424@zn.tnic>
References: <20210127105604.37790-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210127105604.37790-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 27, 2021 at 11:56:04AM +0100, Ard Biesheuvel wrote:
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.12
> 
> for you to fetch changes up to 1c761ee9da1ac6ba7e40d14457fac94c87eaff35:
> 
>   efi/arm64: Update debug prints to reflect other entropy sources (2021-01-21 10:54:08 +0100)
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> 
> ----------------------------------------------------------------
> EFI updates for v5.12
> 
> A few cleanups left and right, some of which were part of a initrd
> measured boot series that needs some more work, and so only the cleanup
> patches have been included for this release.
> 
> ----------------------------------------------------------------
> Ard Biesheuvel (6):
>       efi: ia64: move IA64-only declarations to new asm/efi.h header
>       efi/libstub: whitespace cleanup
>       efi/libstub: fix prototype of efi_tcg2_protocol::get_event_log()
>       efi/libstub: move TPM related prototypes into efistub.h
>       efi: x86: move mixed mode stack PA variable out of 'efi_scratch'
>       efi: x86: clean up previous struct mm switching
> 
> Mark Brown (1):
>       efi/arm64: Update debug prints to reflect other entropy sources
> 
>  arch/ia64/include/asm/efi.h               | 13 +++++++++++++
>  arch/ia64/kernel/efi.c                    |  1 +
>  arch/ia64/kernel/machine_kexec.c          |  1 +
>  arch/ia64/kernel/mca.c                    |  1 +
>  arch/ia64/kernel/smpboot.c                |  1 +
>  arch/ia64/kernel/time.c                   |  1 +
>  arch/ia64/kernel/uncached.c               |  4 +---
>  arch/ia64/mm/contig.c                     |  1 +
>  arch/ia64/mm/discontig.c                  |  1 +
>  arch/ia64/mm/init.c                       |  1 +
>  arch/x86/include/asm/efi.h                | 20 ++++++--------------
>  arch/x86/platform/efi/efi_64.c            | 29 ++++++++++++++++-------------
>  arch/x86/platform/efi/efi_thunk_64.S      |  6 +++++-
>  drivers/firmware/efi/libstub/arm64-stub.c |  4 ++--
>  drivers/firmware/efi/libstub/efistub.h    | 11 ++++++++++-
>  include/linux/efi.h                       | 19 ++-----------------
>  16 files changed, 63 insertions(+), 51 deletions(-)
>  create mode 100644 arch/ia64/include/asm/efi.h

Pulled, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
