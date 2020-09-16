Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C6E26C6F0
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 20:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgIPSKw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Sep 2020 14:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgIPSKo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Sep 2020 14:10:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4284C06174A;
        Wed, 16 Sep 2020 11:10:33 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c3e00d1c41ee080a628ee.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:3e00:d1c4:1ee0:80a6:28ee])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 50C851EC0380;
        Wed, 16 Sep 2020 20:10:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600279831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8AMmW7Bvo1yK12Dhb305WK6iubhLC0h7i2uyYoqgfeA=;
        b=mLnkd5FMnPRvoq5f3oqSYw3op2h0vGG0ajHPkwCtP2gm4Nu5zQ+2fqLJtA6Co4uplJj8bs
        1x9LsdFgEC/SIgI+N1Apy+5jy7leXD7OV+wWbDZ1y778kWjmRvlvumsTDRS7Pamll4U7Lp
        UI5Ksm3Embaz7BlK+ODjuVsgZ6fgl2w=
Date:   Wed, 16 Sep 2020 20:10:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Alex Kluver <alex.kluver@hpe.com>, linux-edac@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mchehab@kernel.org, russ.anderson@hpe.com,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        kluveralex@gmail.com
Subject: Re: [PATCH v2 1/2] edac,ghes,cper: Add Row Extension to Memory Error
 Record
Message-ID: <20200916181030.GR2643@zn.tnic>
References: <20200819143544.155096-1-alex.kluver@hpe.com>
 <20200819143544.155096-2-alex.kluver@hpe.com>
 <20200915163312.GO14436@zn.tnic>
 <CAMj1kXHmVhB88qZc-1mHAD1ovNJQnWRBncmQJTR_4+kV0fXG5w@mail.gmail.com>
 <CAMj1kXGvfiqZz-j5=LU0Z6yYCkr24pCz6aJS62QL8cBYUP_S=w@mail.gmail.com>
 <20200915171910.GQ14436@zn.tnic>
 <CAMj1kXE6PKb==h_154hRKwZLr3Ek+4z4A8FdTHx=co18ww5d3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXE6PKb==h_154hRKwZLr3Ek+4z4A8FdTHx=co18ww5d3Q@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 16, 2020 at 04:09:36PM +0300, Ard Biesheuvel wrote:
> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next

Looks good and no conflicts, builds fine too.

[boris@zn: ~/kernel/linux> git fetch efi
remote: Enumerating objects: 85, done.
remote: Counting objects: 100% (85/85), done.
remote: Compressing objects: 100% (14/14), done.
remote: Total 131 (delta 71), reused 85 (delta 71), pack-reused 46
Receiving objects: 100% (131/131), 113.14 KiB | 1.69 MiB/s, done.
Resolving deltas: 100% (89/89), completed with 33 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi
 + 84780c5438ef...744de4180a43 next                    -> efi/next  (forced update)
   fb1201aececc..46908326c6b8  urgent                  -> efi/urgent
 * [new tag]                   efi-next-for-v5.10      -> efi-next-for-v5.10
 * [new tag]                   efi-urgent-for-v5.9-rc5 -> efi-urgent-for-v5.9-rc5
 * [new tag]                   efi-riscv-shared-for-v5.10 -> efi-riscv-shared-for-v5.10
[boris@zn: ~/kernel/linux> git checkout -b test-merge ras/edac-for-next
Branch 'test-merge' set up to track remote branch 'edac-for-next' from 'ras'.
Switched to a new branch 'test-merge'
[boris@zn: ~/kernel/linux> git merge efi/next
Auto-merging drivers/firmware/efi/libstub/efi-stub-helper.c
Auto-merging drivers/firmware/efi/efi.c
Auto-merging drivers/edac/ghes_edac.c
Auto-merging arch/x86/platform/efi/efi.c
Merge made by the 'recursive' strategy.
 arch/arm/include/asm/efi.h                      |  23 +++--
 arch/arm64/include/asm/efi.h                    |   5 +-
 arch/x86/kernel/setup.c                         |   1 +
 arch/x86/platform/efi/efi.c                     |   3 +
 drivers/edac/ghes_edac.c                        |  17 +++-
 drivers/firmware/efi/Makefile                   |   3 +-
 drivers/firmware/efi/cper.c                     |  18 +++-
 drivers/firmware/efi/{arm-init.c => efi-init.c} |   1 +
 drivers/firmware/efi/efi.c                      |   6 ++
 drivers/firmware/efi/libstub/arm32-stub.c       | 178 +++++++---------------------------
 drivers/firmware/efi/libstub/arm64-stub.c       |   1 -
 drivers/firmware/efi/libstub/efi-stub-helper.c  | 101 +++++++++++++++++++-
 drivers/firmware/efi/libstub/efi-stub.c         |  48 +---------
 drivers/firmware/efi/libstub/efistub.h          |  61 +++++++++++-
 drivers/firmware/efi/libstub/file.c             |   5 +-
 drivers/firmware/efi/libstub/relocate.c         |   4 +-
 drivers/firmware/efi/libstub/vsprintf.c         |   2 +-
 drivers/firmware/efi/mokvar-table.c             | 360 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cper.h                            |  24 ++++-
 include/linux/efi.h                             |  34 +++++++
 include/linux/pe.h                              |   3 +
 security/integrity/platform_certs/load_uefi.c   |  85 +++++++++++++----
 22 files changed, 746 insertions(+), 237 deletions(-)
 rename drivers/firmware/efi/{arm-init.c => efi-init.c} (99%)
 create mode 100644 drivers/firmware/efi/mokvar-table.c

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
