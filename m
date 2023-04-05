Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6EF6D84A3
	for <lists+linux-efi@lfdr.de>; Wed,  5 Apr 2023 19:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDERNn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Apr 2023 13:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjDERNm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Apr 2023 13:13:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262B1BEF;
        Wed,  5 Apr 2023 10:13:39 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9E381EC041F;
        Wed,  5 Apr 2023 19:13:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680714818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l1yYjOVfDDFDfs+ACNRWWBr1VXqTIVZyacyw+scxJDU=;
        b=Gmn6hTWrm+VCwVrg4U8luazNYwEGUj0L7/c8GfWaRGh/2QUA59eMWi9NEYt8MRAyVGeyzA
        qXNifYvSySqG3DJL92TIzWdPoRPuar8waRlL8Tv7rX97R0nZNT6hatwJ6jvmis/4L7nLps
        mRcXntv6qCLJqe6IowxCItjNC8wChHg=
Date:   Wed, 5 Apr 2023 19:13:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 01/27] x86/boot: Align vmlinuz sections on page size
Message-ID: <20230405171333.GDZC2sPc3D7rDdK6TH@fat_crate.local>
References: <cover.1678785672.git.baskov@ispras.ru>
 <159597c484778da5e59c3a5728669f131f800b5a.1678785672.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159597c484778da5e59c3a5728669f131f800b5a.1678785672.git.baskov@ispras.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 14, 2023 at 01:13:28PM +0300, Evgeniy Baskov wrote:
> To protect sections on page table level each section needs to be
> aligned on page size (4KB).

Protect against what?

> Set sections alignment in linker script for the kernel decompressor
> (boot/compressed/vmlinux.lds.S).

Do not talk about *what* the patch is doing in the commit message - that
should be obvious from the diff itself. Rather, concentrate on the *why*
it needs to be done.

> Also introduce symbols that can be used to reference compressed
> kernel blob section later in the later patches.

Introduce those with the respective patch that uses them. This one is
adding section alignment only and that's all that it should do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
