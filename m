Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7200A1A477B
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 16:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDJOeB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 10:34:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40056 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgDJOeA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Apr 2020 10:34:00 -0400
Received: from zn.tnic (p200300EC2F0CB700FCB27CAA9217AC57.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:b700:fcb2:7caa:9217:ac57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41CF21EC0CE0;
        Fri, 10 Apr 2020 16:34:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586529240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pAL0TBvXuX49d8+80p+PRJuaLeJMlvRmSNuFeMYFYDY=;
        b=PztOC/gFR4jFBAQhlRbHiVy83/8LEDbo08gaTBKXpfOyZFWQLTSpOIUc9Tg7HefNSlvcOb
        cR1XoQbCe1Yd7rXTkfGuG54+TP6V5gA3EwRJlRyPqVWrAypIyTqVtwKR4DWP4EEhdYhVUA
        P7/a8Tm8TfT8KmH8DHiWrEHPI1ajtmY=
Date:   Fri, 10 Apr 2020 16:33:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Ingo Molnar <mingo@kernel.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH] efi/x86: Revert struct layout change to fix kexec boot
 regression
Message-ID: <20200410143313.GB8205@zn.tnic>
References: <20200410074320.16589-1-ardb@kernel.org>
 <20200410135644.GB6772@dhcp-128-65.nay.redhat.com>
 <20200410140151.GC6772@dhcp-128-65.nay.redhat.com>
 <CAMj1kXEM13Y5FCh8GvJGTueen3fa0u_JX66j0X10KPf4Z0c4Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEM13Y5FCh8GvJGTueen3fa0u_JX66j0X10KPf4Z0c4Jg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 10, 2020 at 04:22:49PM +0200, Ard Biesheuvel wrote:
> > BTW, a fixes tag is good to have..
> 
> I usually omit those for patches that fix bugs that were introduced in
> the current cycle.

A valid use case for having the Fixes: tag anyway are the backporting
kernels gangs which might pick up the first patch for whatever reason
and would probably be thankful if they find the second one, i.e., the
fix for the first one, through grepping or other, automated means.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
