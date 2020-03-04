Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575D0179BF6
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 23:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbgCDWtI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 17:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387931AbgCDWtI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 17:49:08 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D22021739
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 22:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583362147;
        bh=XGcZGdEgM/vF7v5mdp3torxe2y7WxwOP/Qm/IpOOGes=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gso1N108434AieE+ggenhKm/c6dmwGmd1liZEW63oqPD3UFK7cfjXn6I+S2fRAUgh
         Frp6IioKacGK2o6UzxTNASyT3P3piao7biNGmpoD2xmavxh4XKk4kSBLYgHoAEN+OD
         6DEk1W0TyBvir0TuP/5hjjDnjugW+UBlxnOoWcZk=
Received: by mail-wr1-f47.google.com with SMTP id h9so4563284wrr.10
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 14:49:07 -0800 (PST)
X-Gm-Message-State: ANhLgQ0YjArj7+SiH3DZrp5MG00pv4a2Q63JhNEW42uJLyC8L3kURotC
        0vLbKRaLkW7UFm6D1q79lgne6XMiDv2yLCMm+RjIng==
X-Google-Smtp-Source: ADFU+vsWSVNlJkST4UHauA5BWk+eWwcGbu9YRrgToE95Gya3bYNCXVsvtg6M1wlo3k6wmlTpbKSSwVECLp8UN6wlGYc=
X-Received: by 2002:adf:f84a:: with SMTP id d10mr6369353wrq.208.1583362145754;
 Wed, 04 Mar 2020 14:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20200228121408.9075-1-ardb@kernel.org>
In-Reply-To: <20200228121408.9075-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 23:48:54 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-Yj18WXurHNC4wCmLSA-neOTcc7d5fQyXEwC+o7KA2eg@mail.gmail.com>
Message-ID: <CAKv+Gu-Yj18WXurHNC4wCmLSA-neOTcc7d5fQyXEwC+o7KA2eg@mail.gmail.com>
Subject: Re: [GIT PULL 0/6] More EFI updates for v5.7
To:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 28 Feb 2020 at 13:14, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Hello Ingo, Thomas,
>
> A small set of EFI followup changes for v5.7. The last one fixes a boot
> regression in linux-next on x86 machines booting without EFI but with
> the IMA security subsystem enabled, which is why I am sending out the
> next batch a bit earlier than intended.
>

Please disregard this for now. I will send a v2 tomorrow or Friday
which will contain a few more fixes for the changes that are queued
for v5.7 already.

>
> The following changes since commit e9765680a31b22ca6703936c000ce5cc46192e10:
>
>   Merge tag 'efi-next' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core (2020-02-26 15:21:22 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
>
> for you to fetch changes up to be15278269343ec0e4d0e41bab5f64b49b0edb6b:
>
>   efi: mark all EFI runtime services as unsupported on non-EFI boot (2020-02-28 12:54:46 +0100)
>
> ----------------------------------------------------------------
> More EFI updates for v5.7
>
> A couple of followup fixes for the EFI changes queued for v5.7:
> - a fix for a boot regression on x86 booting without UEFI
> - memory encryption fixes for x86, so that the TPM tables and the RNG
>   config table created by the stub are correctly identified as living
>   in unencrypted memory
> - style tweak from Heinrich
> - followup to the ARM EFI entry code simplifications to ensure that we
>   don't rely on EFI_LOADER_DATA memory being RWX
>
> ----------------------------------------------------------------
> Ard Biesheuvel (3):
>       efi/arm: clean EFI stub exit code from cache instead of avoiding it
>       efi/arm64: clean EFI stub exit code from cache instead of avoiding it
>       efi: mark all EFI runtime services as unsupported on non-EFI boot
>
> Heinrich Schuchardt (1):
>       efi: don't shadow i in efi_config_parse_tables()
>
> Tom Lendacky (2):
>       efi/x86: Add TPM related EFI tables to unencrypted mapping checks
>       efi/x86: Add RNG seed EFI table to unencrypted mapping check
>
>  arch/arm/boot/compressed/head.S | 18 ++++++++----------
>  arch/arm64/kernel/efi-entry.S   | 26 +++++++++++++-------------
>  arch/arm64/kernel/image-vars.h  |  4 ++--
>  arch/x86/platform/efi/efi.c     |  3 +++
>  drivers/firmware/efi/efi.c      | 25 +++++++++++++------------
>  include/linux/efi.h             |  2 ++
>  6 files changed, 41 insertions(+), 37 deletions(-)
