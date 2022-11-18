Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBDE62FCB5
	for <lists+linux-efi@lfdr.de>; Fri, 18 Nov 2022 19:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbiKRS2c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Nov 2022 13:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242753AbiKRS1i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Nov 2022 13:27:38 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763FCA7C1F;
        Fri, 18 Nov 2022 10:26:35 -0800 (PST)
Received: from zn.tnic (p200300ea9733e767329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e767:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7DB381EC058B;
        Fri, 18 Nov 2022 19:26:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668795993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bjJQgdhCImWkeCRBvWJ7qLNfjqyKIYHkYnv8P42ph7o=;
        b=TBmmkn8hcQKg3kKMcLjxUnCPDj5i7LlUotsd2o48hzlHlvbAx1mi7SI3JPf5RW+kA8OKDz
        4KePM33CWFfoGDGkW/d4aEcmDyKyVsxNQjUhjxRLh2G00fnm6EPzseDy8IMiLj7v7Mu6KI
        AKsGsKWS+z9QJO9kNSru8AmD1gDEsF8=
Date:   Fri, 18 Nov 2022 19:26:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 00/16] x86: head_64.S spring cleaning
Message-ID: <Y3fOVRp1IlBF7nhm@zn.tnic>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 21, 2022 at 04:54:06PM +0200, Ard Biesheuvel wrote:
>  arch/x86/boot/compressed/Makefile       |   8 +-
>  arch/x86/boot/compressed/efi_mixed.S    | 337 ++++++++++++++++++++
>  arch/x86/boot/compressed/efi_thunk_64.S | 195 -----------
>  arch/x86/boot/compressed/head_32.S      |   4 -
>  arch/x86/boot/compressed/head_64.S      | 299 +----------------
>  arch/x86/boot/compressed/mem_encrypt.S  | 152 ++++++++-
>  drivers/firmware/efi/libstub/x86-stub.c |   2 +-
>  7 files changed, 496 insertions(+), 501 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/efi_mixed.S
>  delete mode 100644 arch/x86/boot/compressed/efi_thunk_64.S

Ok, it all looks ok to me.

You could send me a refreshed version ontop of latest tip/master, after
having tested the EFI side and I'll test the memory encryption side.

If there's no fallout, I think we could queue this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
