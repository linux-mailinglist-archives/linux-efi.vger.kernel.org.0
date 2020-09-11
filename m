Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A082663F0
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 18:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgIKQ1y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 12:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgIKPUY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Sep 2020 11:20:24 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5DDC21D81;
        Fri, 11 Sep 2020 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599837460;
        bh=gupGZfyCWjzyTybhAS/ra1qQ28eHy8myobsIyy93VJA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m0oQPP2XCKYz+rwQfM4O1rdYT4yltshP7twQJqK62UXdUmP7mAN8yidHGu/qxh5wR
         Yij4F3nIw3qQ22KKyVgxcdpg6bGWact2evoQ35oegTLBfPZJEJ5LnXeQ+DJE8vaGkX
         teW2jpUmwLifBSRr7/LlebUSQIbQk94yNv2wTGMo=
Received: by mail-ot1-f49.google.com with SMTP id a2so8597256otr.11;
        Fri, 11 Sep 2020 08:17:39 -0700 (PDT)
X-Gm-Message-State: AOAM5329fU0dMKxiltpkEdCwL44njWjCTLPvn4OUDQFPDYfmzv+Hu79G
        SSBCht3DMXWMVF2GUDd9hzsCJNa9gsNtbPeJj+U=
X-Google-Smtp-Source: ABdhPJzOyF/HBAXFTBoyNO5I33yKfSijH56wjqNzdZ68h+mmUbhU+Ox68k7PwAF8A8PvXqxLJLUtyECmO01vhMnpYb4=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr1472882otk.108.1599837459251;
 Fri, 11 Sep 2020 08:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200905013107.10457-1-lszubowi@redhat.com>
In-Reply-To: <20200905013107.10457-1-lszubowi@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 11 Sep 2020 18:17:28 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHOcGiwOT_sNTQRA=G7GCQSKLk2HSNoS2vEQYPzQpn0nw@mail.gmail.com>
Message-ID: <CAMj1kXHOcGiwOT_sNTQRA=G7GCQSKLk2HSNoS2vEQYPzQpn0nw@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] integrity: Load certs from EFI MOK config table
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>, zohar@linux.ibm.com,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>, prarit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 5 Sep 2020 at 04:31, Lenny Szubowicz <lszubowi@redhat.com> wrote:
>
> Because of system-specific EFI firmware limitations, EFI volatile
> variables may not be capable of holding the required contents of
> the Machine Owner Key (MOK) certificate store when the certificate
> list grows above some size. Therefore, an EFI boot loader may pass
> the MOK certs via a EFI configuration table created specifically for
> this purpose to avoid this firmware limitation.
>
> An EFI configuration table is a simpler and more robust mechanism
> compared to EFI variables and is well suited for one-way passage
> of static information from a pre-OS environment to the kernel.
>
> Entries in the MOK variable configuration table are named key/value
> pairs. Therefore the shim boot loader can create a MokListRT named
> entry in the MOK configuration table that contains exactly the same
> data as the MokListRT UEFI variable does or would otherwise contain.
> As such, the kernel can load certs from the data in the MokListRT
> configuration table entry data in the same way that it loads certs
> from the data returned by the EFI GetVariable() runtime call for the
> MokListRT variable.
>
> This patch set does not remove the support for loading certs from the
> EFI MOK variables into the platform key ring. However, if both the EFI
> MOK configuration table and corresponding EFI MOK variables are present,
> the MOK table is used as the source of MOK certs.
>
> The contents of the individual named MOK config table entries are
> made available to user space as individual sysfs binary files,
> which are read-only to root, under:
>
>         /sys/firmware/efi/mok-variables/
>
> This enables an updated mokutil to provide support for:
>
>         mokutil --list-enrolled
>
> such that it can provide accurate information regardless of whether
> the MOK configuration table or MOK EFI variables were the source
> for certs. Note that all modifications of MOK related state are still
> initiated by mokutil via EFI variables.
>
> V2: Incorporate feedback from V1
>   Patch 01: efi: Support for MOK variable config table
>   - Minor update to change log; no code changes
>   Patch 02: integrity: Move import of MokListRT certs to a separate routine
>   - Clean up code flow in code moved to load_moklist_certs()
>   - Remove some unnecessary initialization of variables
>   Patch 03: integrity: Load certs from the EFI MOK config table
>   - Update required due to changes in patch 02.
>   - Remove unnecessary init of mokvar_entry in load_moklist_certs()
>
> V1:
>   https://lore.kernel.org/lkml/20200826034455.28707-1-lszubowi@redhat.com/
>
> Lenny Szubowicz (3):
>   efi: Support for MOK variable config table
>   integrity: Move import of MokListRT certs to a separate routine
>   integrity: Load certs from the EFI MOK config table
>
>  arch/x86/kernel/setup.c                       |   1 +
>  arch/x86/platform/efi/efi.c                   |   3 +
>  drivers/firmware/efi/Makefile                 |   1 +
>  drivers/firmware/efi/arm-init.c               |   1 +
>  drivers/firmware/efi/efi.c                    |   6 +
>  drivers/firmware/efi/mokvar-table.c           | 360 ++++++++++++++++++
>  include/linux/efi.h                           |  34 ++
>  security/integrity/platform_certs/load_uefi.c |  85 ++++-
>  8 files changed, 472 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/firmware/efi/mokvar-table.c
>

Thanks. I have tentatively queued these up in efi/next.

Mimi, please let me know if you have any thoughts on 3/3, and whether
your R-b on 2/3 [v1] implies that you are ok with the series going
through the EFI tree.

-- 
Ard.
