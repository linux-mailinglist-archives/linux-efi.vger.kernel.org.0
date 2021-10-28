Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D840343E809
	for <lists+linux-efi@lfdr.de>; Thu, 28 Oct 2021 20:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhJ1SNA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Oct 2021 14:13:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41262 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230496AbhJ1SM7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 28 Oct 2021 14:12:59 -0400
Received: from zn.tnic (p200300ec2f13a700349123b1f000d126.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:a700:3491:23b1:f000:d126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B221B1EC0682;
        Thu, 28 Oct 2021 20:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635444630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vvQSJWH5onGxrczFBQFZWKyJ2kBC7ZhZK16OGtRf+Zo=;
        b=n/YabruUnkp7SfAlqrsLGV3PnD9QLfvuaya1gP23SYcI1v87jus4XcSgtP5FxjaU4+y8IY
        RpExUZAL0zP0u3p4Wi5qgQzKvtPH+vl6Lt64h4tLd0hozY/rk8v6Yc8wCBEZv6zGlxS1aP
        6dQoogFGm/iuNR2+G4VRsRunbnHfR5w=
Date:   Thu, 28 Oct 2021 20:10:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-efi@vger.kernel.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Daniel Gutson <daniel.gutson@eclypsium.com>
Subject: Re: [PATCH v2 0/5] [RFC] x86: Export information about hardware
 memory encryption to sysfs
Message-ID: <YXrnkxgdjWbcPlJA@zn.tnic>
References: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
 <8a8e0743-e54d-ec96-da4e-1d101b550274@intel.com>
 <CAKgze5Z3fT9F0S-mogfP6is9sL3=0imtCbfy6ZYrd3zgaBUqRg@mail.gmail.com>
 <YXq50yzJQqrJk13v@zn.tnic>
 <CAD2FfiFS++2-Sn5nCft8Eb-R41MM6abCjXyDn8bOVY-_miCpRA@mail.gmail.com>
 <YXrRN+pDr4Uv5p0t@zn.tnic>
 <CAKgze5av=duAc+inw6XnroT1WxHoP6pA2=Bb2tjK45yO6aDfOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKgze5av=duAc+inw6XnroT1WxHoP6pA2=Bb2tjK45yO6aDfOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 28, 2021 at 02:39:52PM -0300, Martin Fernandez wrote:
> Because it's not convenient to parse dmesg. And about /proc/cpuinfo,
> it tells you about TME, as a feature of the cpu but it doesn't tell
> you if it is activated,

We can make "tme" or whatever string we decide upon, visible only when
the feature is activated - not a problem. Just like we do on AMD.

> and even if it is activated you will need to be sure that you are
> storing your data in a region flagged with this new attribute.

Can you have a system where some of the memory is crypto-capable and
some of it is not? I've never heard about such a system. At least, on
AMD SME, all your memory gets encrypted...

> Here we discussed about it some time ago:
> http://lkml.iu.edu/hypermail/linux/kernel/2006.2/06753.html . That
> comment is what triggered this patch.

... or maybe dhansen knows more.

So, you folks feeding us piecemeal all these "requirements" won't get
you very far. So please sit down and write a detailed use case about
which customers, when and what exactly they need extracted from the
system and why.

Because this is not all - there's TDX and SEV and SEV-ES and SEV-SNP and
all those partition and encrypt the system or part of it in a different
way. And I'm sure customers will wanna know about that too. Are they
running in an encrypted guest in a public cloud, what security they
have, blabla, everything you can imagine.

And so we won't be adding a different reporting method for each type of
encryption that happens.

But we don't know what we need to report unless we know the use case.
Which is not in the least clear to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
