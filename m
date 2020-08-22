Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DB24E7A2
	for <lists+linux-efi@lfdr.de>; Sat, 22 Aug 2020 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHVNgF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Aug 2020 09:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgHVNgE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Aug 2020 09:36:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6892C061573
        for <linux-efi@vger.kernel.org>; Sat, 22 Aug 2020 06:36:03 -0700 (PDT)
Received: from zn.tnic (p200300ec2f215f007115f791a9aa441d.dip0.t-ipconnect.de [IPv6:2003:ec:2f21:5f00:7115:f791:a9aa:441d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ABFEB1EC0330;
        Sat, 22 Aug 2020 15:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598103352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KhdE8DiHPW8tc66zRbgVlQyv0agK700vK8+goFESdWk=;
        b=RkyooHk+jYgTak3RmkmvZhVlf4+ulJ9w+v8u6Wtlf7w/rNIc1kdL5yUtIYbXPfUYhs1Jbo
        /GBuwEATd1u0npUfquE7/wJZjRcTfo7TzudVlEKdWoPeTpiYv2EihlJnSMTrRd0YtvGPTT
        0/Ebq0aYGa9Rgn6i+wbxY0SfoU9Likk=
Date:   Sat, 22 Aug 2020 15:35:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] EFI fixes for v5.9-rc1
Message-ID: <20200822133549.GB31906@zn.tnic>
References: <20200820092330.18120-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820092330.18120-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 20, 2020 at 11:23:30AM +0200, Ard Biesheuvel wrote:
> The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> 
>   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.9-rc1
> 
> for you to fetch changes up to fb1201aececc59990b75ef59fca93ae4aa1e1444:
> 
>   Documentation: efi: remove description of efi=old_map (2020-08-20 11:18:36 +0200)
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> 
> ----------------------------------------------------------------
> EFI fixes for v5.9-rc1:
> - Some followup fixes for the UV1 and EFI old_map removal
> - EFI stub command line fixes from Arvind
> - Stop mapping the kernel's .rodata executable in the mixed mode EFI page tables
> - Add missing cleanup on the efisubsys_init() error path
> 
> ----------------------------------------------------------------
> Ard Biesheuvel (2):
>       efi/x86: Move 32-bit code into efi_32.c
>       Documentation: efi: remove description of efi=old_map
> 
> Arvind Sankar (4):
>       efi/x86: Mark kernel rodata non-executable for mixed mode
>       efi/libstub: Stop parsing arguments at "--"
>       efi/libstub: Handle NULL cmdline
>       efi/libstub: Handle unterminated cmdline
> 
> Li Heng (1):
>       efi: add missed destroy_workqueue when efisubsys_init fails
> 
>  Documentation/admin-guide/kernel-parameters.txt |  5 +-
>  arch/x86/include/asm/efi.h                      | 10 ----
>  arch/x86/platform/efi/efi.c                     | 69 -------------------------
>  arch/x86/platform/efi/efi_32.c                  | 44 +++++++++++++---
>  arch/x86/platform/efi/efi_64.c                  |  2 +
>  drivers/firmware/efi/efi.c                      |  2 +
>  drivers/firmware/efi/libstub/efi-stub-helper.c  | 12 ++++-
>  7 files changed, 52 insertions(+), 92 deletions(-)

Merged, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
