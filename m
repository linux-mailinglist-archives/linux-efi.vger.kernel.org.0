Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8790A5F85F6
	for <lists+linux-efi@lfdr.de>; Sat,  8 Oct 2022 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJHPvc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Oct 2022 11:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJHPvc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Oct 2022 11:51:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468694B9B8;
        Sat,  8 Oct 2022 08:51:31 -0700 (PDT)
Received: from nazgul.tnic (unknown [46.183.103.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CD591EC05B0;
        Sat,  8 Oct 2022 17:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665244285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uxaWHROtvKuI3TCMOwuvz0fxOuXD8C+Z6XGus1b9amg=;
        b=HNXgVe1w3AN9Cwkl0Z8KTxCufb9VEbHJ6Lia+ZW0cWq3lCSIiI4neIxaKg00pCTXHszHEd
        JMqQNxSZfTkiC1eT8YKXzAqyxMgSy3zBFUrNeMPScB9F9TaCwKIfjbJ0sTjaLTH56FCjWD
        9XnEC+9NArzHjrS+LcZX804d8AogMSk=
Date:   Sat, 8 Oct 2022 17:51:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: x86: Make the deprecated EFI handover protocol
 optional
Message-ID: <Y0GcZQZTaCgoNFGa@nazgul.tnic>
References: <20221007172918.3131811-1-ardb@kernel.org>
 <Y0GOKnD89SOjGzCf@nazgul.tnic>
 <CAMj1kXHK_9iDT8CSHnZ15yB+Z=+haZXjbQ99m20jQUr0NScK4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHK_9iDT8CSHnZ15yB+Z=+haZXjbQ99m20jQUr0NScK4Q@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Oct 08, 2022 at 05:41:40PM +0200, Ard Biesheuvel wrote:
> Yeah most distros have ~100 ore more patches against GRUB, but this
> isn't actually their fault. GRUB maintainership was defunct for a
> number of years, which is why we were stuck on GRUB version 2.02-beta3
> for such a long time. But in recent years, things have been getting
> better, and there is an agreement with the current maintainer not to
> merge the EFI handover protocol, and merge the new EFI protocol based
> initrd loading method instead, which works on all architectures
> instead of only on x86.

Aha, ok.

> Never tried that in .S files but I guess it should just work.

If not, at least in the .c files.

> I'd venture a guess that this will break the boot even your own x86
> boxes, given that almost nobody uses plain upstream GRUB..
> 
> I can work with the distros directly to start disabling this in their
> downstream configs once their GRUB builds are up to date with the new
> changes, so we can phase this out in a controlled manner.

Hm, that might turn out to be a multi-year effort considering how the
enterprise distros' kernels are moving. Yeah, yeah, they have good
reasons and so on.

> But disabling tthis right now by default is going to affect everyone
> who builds their own kernels and runs them on a distro Linux install.

Ok, I can try it on my SUSE and Debian partitions and see what happens.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
