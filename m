Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EAD27E295
	for <lists+linux-efi@lfdr.de>; Wed, 30 Sep 2020 09:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgI3H21 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Sep 2020 03:28:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35198 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgI3H21 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 30 Sep 2020 03:28:27 -0400
X-Greylist: delayed 52179 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 03:28:27 EDT
Received: from zn.tnic (p200300ec2f092a00509dd0059ac29c82.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2a00:509d:d005:9ac2:9c82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 845EF1EC050F;
        Wed, 30 Sep 2020 09:28:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601450906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nG47gqqFB2N9hWPpdoxdZZqnk4JWRcv5yTlN1B8R5sI=;
        b=b43hVZbFr3FqBSPxX+yY9ddi05dUoRNiHDWCsLMVdCy7lewqXC9xbGauXdc6nUkassCw76
        eUsS8hs5kM0Lb5bMBllTAuytOcUSFf+TjHcT+GFa9BhmSF9bAt+G+rJlsDmarSCqyBpPDq
        MzqXr8OCfgNfdYDxX0DupVvFD39GSTk=
Date:   Wed, 30 Sep 2020 09:28:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] More EFI changes for v5.10
Message-ID: <20200930072817.GC6810@zn.tnic>
References: <20200929182405.31809-1-ardb@kernel.org>
 <CAMj1kXG8=tO+nSE_m5N=7tz6VOgMwuBj7dPis4jYhA1jw1q-Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXG8=tO+nSE_m5N=7tz6VOgMwuBj7dPis4jYhA1jw1q-Bw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 30, 2020 at 08:37:55AM +0200, Ard Biesheuvel wrote:
> The only difference between d2778b4891fb and 4a568ce29d3f is that I
> fixed up a typo in a person's name in the commit log, the patches are
> otherwise identical. I recreated the tag right after, and the correct
> commit ID is referenced in the PR I sent originally. However, I don't
> remember if I failed to push the changes to kernel.org right away, or
> whether this is a kernel.org mirroring issue, but the end result is
> that that the wrong version of the tag got merged into efi/core

Right.

> This is not the end of the world, as the patches are identical.
> However, if you prefer to fix it, please reset efi/core to
> tags/efi-next-for-v5.10-2 - it covers the whole batch of EFI changes
> for v5.10.

Pushed now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
