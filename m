Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BC7635B54
	for <lists+linux-efi@lfdr.de>; Wed, 23 Nov 2022 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiKWLLo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Nov 2022 06:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiKWLLG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Nov 2022 06:11:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B64F241A;
        Wed, 23 Nov 2022 03:09:13 -0800 (PST)
Received: from zn.tnic (p200300ea9733e747329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e747:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D1B11EC0409;
        Wed, 23 Nov 2022 12:09:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669201752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Je7PCOr7h3btmMnUFWEHR7IqjkRixXwbZa0p/sBqG3s=;
        b=EM8KLLu9Px4fBxk3iA86XDYA+m4/+Vlt9u/w+z48SKxn25mmzmrJyJtWSBkmD7hzFuF17o
        2jeEV9BhaQqFQmcTTX+YIdNLY14uKaO3aP68Q7vmfFtmAuSF4XyX8Cue7OInouw5jz2g17
        P94JXU42BYOuefQpvuGP6mrUrBV50+k=
Date:   Wed, 23 Nov 2022 12:09:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
Message-ID: <Y33/VIsB5HGREY4i@zn.tnic>
References: <20221122161017.2426828-1-ardb@kernel.org>
 <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
 <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
 <26c34f9e-3b09-7b10-09a2-993a50790447@amd.com>
 <Y336yE4P3NjCGavN@zn.tnic>
 <CAMj1kXGnGz+V3tmonitY+3TiWuWJFWj-mQLUbRo+xp8UwZ_SpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGnGz+V3tmonitY+3TiWuWJFWj-mQLUbRo+xp8UwZ_SpQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 23, 2022 at 11:52:32AM +0100, Ard Biesheuvel wrote:
> The patch moves it from .data to .bss inadvertently, and I am not
> convinced Tom's analysis is entirely accurate: we may simply have
> garbage in image_offset if we access it before .bss gets cleared.

That should not be too hard to find out: add an endless loop in asm in
the guest right after the first image_offset access:

1:
	jmp 1b

and then dump its value.

Or Tom might have an even better solution.

But looking at the code, BSS clearing happens later, at .Lrelocated and
the EFI stub comes before it. AFAICT.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
