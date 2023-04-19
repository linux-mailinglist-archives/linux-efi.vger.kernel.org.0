Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666326E715E
	for <lists+linux-efi@lfdr.de>; Wed, 19 Apr 2023 04:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjDSC5A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Apr 2023 22:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjDSC47 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Apr 2023 22:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C490468E
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 19:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681872975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HsWTHKuxuxUGNVADM5inzA7dGxU3Idq5dDRIxkAJWLo=;
        b=NmXCYENAMSOBljD+dPmTXQ+QsJH06xXHaRz1b9XaXjtq0rgxLzE6Bwml+X5Lx9YQO1lMwN
        CDObUK8sQCuFr7AHyrX4EJ/BRfSSXiYsxOYh0fSpvojjbmQbnANfKh6HNh0pXAHhdXOHt+
        LTom6bM5x8LosZF1Bgr56ITQD15rp5I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-H8EYPBu3N5OzisPn4uV5WA-1; Tue, 18 Apr 2023 22:56:11 -0400
X-MC-Unique: H8EYPBu3N5OzisPn4uV5WA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DCAF85A5A3;
        Wed, 19 Apr 2023 02:56:10 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (ovpn-13-73.pek2.redhat.com [10.72.13.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EE91492C3E;
        Wed, 19 Apr 2023 02:55:59 +0000 (UTC)
Date:   Wed, 19 Apr 2023 10:56:13 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 0/3] efi: Implement generic zboot support
Message-ID: <ZD9YTZtAWM34B3IW@darkstar.users.ipa.redhat.com>
References: <20230416120729.2470762-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416120729.2470762-1-ardb@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

[resend the reply since I mistakenly sent a html version, apologize for
those who received two of this reply]
On 04/16/23 at 02:07pm, Ard Biesheuvel wrote:
> This series is a proof-of-concept that implements support for the EFI
> zboot decompressor for x86. It replaces the ordinary decompressor, and
> instead, performs the decompression, KASLR randomization and the 4/5
> level paging switch while running in the execution context of EFI.
> 
> This simplifies things substantially, and makes it straight-forward to
> abide by stricter future requirements related to the use of writable and
> executable memory under EFI, which will come into effect on x86 systems
> that are certified as being 'more secure', and ship with an even shinier
> Windows sticker.
> 
> This is an alternative approach to the work being proposed by Evgeny [0]
> that makes rather radical changes to the existing decompressor, which
> has accumulated too many features already, e.g., related to confidential
> compute etc.
> 
> EFI zboot images can be booted in two ways:
> - by EFI firmware, which loads and starts it as an ordinary EFI
>   application, just like the existing EFI stub (with which it shares
>   most of its code);
> - by a non-EFI loader that parses the image header for the compression
>   metadata, and decompresses the image into memory and boots it.
> 
> Realistically, the second option is unlikely to ever be used on x86,
> given that it already has its existing bzImage, but the first option is
> a good choice for distros that target EFI boot only (and some distros
> switched to this format already for arm64). The fact that EFI zboot is
> implemented in the same way on arm64, RISC-V, LoongArch and [shortly]
> ARM helps with maintenance, not only of the kernel itself, but also the
> tooling around it relating to kexec, code signing, deployment, etc.

Hi Ard, since the kexec support is not yet ready, if no quick plan how
about change the Kconfig and make zboot can be enabled only when kexec
is not enabled.

> 
> Series can be pulled from [1], which contains some prerequisite patches
> that are only tangentially related.
> 
> [0] https://lore.kernel.org/all/cover.1678785672.git.baskov@ispras.ru/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-x86-zboot
> 
> Cc: Evgeniy Baskov <baskov@ispras.ru>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> 
> Ard Biesheuvel (3):
>   efi/libstub: x86: Split off pieces shared with zboot
>   efi/zboot: x86: Implement EFI zboot support
>   efi/zboot: x86: Clear NX restrictions on populated code regions
> 
>  arch/x86/Makefile                              |  18 +-
>  arch/x86/include/asm/efi.h                     |  10 +
>  arch/x86/kernel/head_64.S                      |  15 +
>  arch/x86/zboot/Makefile                        |  29 +
>  drivers/firmware/efi/Kconfig                   |   2 +-
>  drivers/firmware/efi/libstub/Makefile          |  15 +-
>  drivers/firmware/efi/libstub/Makefile.zboot    |   2 +-
>  drivers/firmware/efi/libstub/efi-stub-helper.c |   3 +
>  drivers/firmware/efi/libstub/x86-stub.c        | 592 +------------------
>  drivers/firmware/efi/libstub/x86-zboot.c       | 322 ++++++++++
>  drivers/firmware/efi/libstub/x86.c             | 612 ++++++++++++++++++++
>  drivers/firmware/efi/libstub/zboot.c           |   3 +-
>  drivers/firmware/efi/libstub/zboot.lds         |   5 +
>  13 files changed, 1031 insertions(+), 597 deletions(-)
>  create mode 100644 arch/x86/zboot/Makefile
>  create mode 100644 drivers/firmware/efi/libstub/x86-zboot.c
>  create mode 100644 drivers/firmware/efi/libstub/x86.c
> 
> -- 
> 2.39.2
> 

