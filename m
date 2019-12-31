Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E1F12DA0B
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 17:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfLaQF6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 11:05:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43980 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfLaQF6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Dec 2019 11:05:58 -0500
Received: from zn.tnic (p200300EC2F00E700D4DBF7ADAE8A475A.dip0.t-ipconnect.de [IPv6:2003:ec:2f00:e700:d4db:f7ad:ae8a:475a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 601831EC0273;
        Tue, 31 Dec 2019 17:05:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577808356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:references;
        bh=VZmNom2p9YD5OZ6gwQDDmFwOolpP+ihIiOAQ+RqT5kU=;
        b=rRMUoPWA+BqFch2i3XMvmTynjVYMQMM70iCi7DxeOVgboH0Du/Z+vmgGf4RVAFGmJ00dfl
        vidkK+KqfFyEyYXrA5jL6+oV7QSAHVlRiq5avPp/ZpjD43tk3b8V/+5VsBDQnwdmwxYp5x
        m9N0TfOmIwdtuXiiE/ieVq42bSk1g0Q=
Date:   Tue, 31 Dec 2019 17:05:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>
Subject: Re: [RFC PATCH] efi/x86: limit EFI old memory map to SGI UV1 machines
Message-ID: <20191231160547.GB13549@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu82ZCk3Wy6NHHyRs0CAFXJDMfDu2KpH3PZ-Le1SjsQLLQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 31, 2019 at 12:13:18PM +0100, Ard Biesheuvel wrote:
> (adding Boris and Dave for the historical perspective)
> 
> On Thu, 26 Dec 2019 at 10:55, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > We carry a quirk in the x86 EFI code to switch back to an older
> > method of mapping the EFI runtime services memory regions, because
> > it was deemed risky at the time to implement a new method without
> > providing a fallback to the old method in case problems arose.
> >
> > Such problems did arise, but they appear to be limited to SGI UV1
> > machines, and so these are the only ones for which the fallback gets
> > enabled automatically (via a DMI quirk). The fallback can be enabled
> > manually as well, by passing efi=old_map, but there is very little
> > evidence that suggests that this is something that is being relied
> > upon in the field.
> >
> > Given that UV1 support is not enabled by default by the distros
> > (Ubuntu, Fedora), there is no point in carrying this fallback code
> > all the time if there are no other users. So let's refactor it a bit
> > to make it depend on CONFIG_X86_UV, and remove the ability to enable
> > it by hand.
> >
> > Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> > Cc: Mike Travis <mike.travis@hpe.com>
> > Cc: Hedi Berriche <hedi.berriche@hpe.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Boris, since you were the one that added efi=old_map: do you know of
> any cases beyond SGI UV1 where it was actually needed? There is some
> mention of using it to work around transient breakage on 32-bit caused
> by your original changes, but other than that, Google doesn't seem to
> know about any cases where efi=old_map is being used to deal with
> actual firmware quirks.
> 
> As a followup to this change, I'd like to move the old memmap handling
> into the UV1 support code, so it is omitted unless UV support is
> compiled it, and so it can be retired with the rest of it once that
> time comes.

Good idea.

So I remember "some apple laptops" but reading this again:

https://lore.kernel.org/patchwork/patch/704853/

looks like mfleming meant the opposite: some apple laptops don't like
the 1:1 runtime mapping. But there might be more and I believe mjg59 had
some use case at the time but I could be remembering it wrong.

Let me add them both to Cc for comment.

So one other reason for adding the =old_map thing is having a fallback
to the old method in case we break some boxes. It even says so in the
commit message of:

d2f7cbe7b26a ("x86/efi: Runtime services virtual mapping")

"While at it, add a chicken bit called "efi=old_map" which can be used
as a fallback to the old runtime services mapping method in case there's
some b0rkage with a particular EFI implementation..."

But I'm not aware of people still booting with "old_map" so I guess
deprecating it should be probably ok...

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
