Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206E820C9E1
	for <lists+linux-efi@lfdr.de>; Sun, 28 Jun 2020 21:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgF1Te4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Jun 2020 15:34:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40816 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgF1Te4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 28 Jun 2020 15:34:56 -0400
Received: from zn.tnic (p200300ec2f364000d578d82a00a34978.dip0.t-ipconnect.de [IPv6:2003:ec:2f36:4000:d578:d82a:a3:4978])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9AA001EC0281;
        Sun, 28 Jun 2020 21:34:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1593372894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Egwy2nAygP406z6NkgtK8coh3gIYkj0Hy/+KHc6DRXw=;
        b=J82GBzH/ovJ0DEhuRstjisUR7KF3G5Hl4eM3VXZ9GPJvNW3MB3yblZFGJe9s96NBtz7OR3
        0gtzTKKm6K2beyDo6RTtcy9HoR0cBaIA8sj8Tuw8EZUEHxtq5Bj0j9zsQd0iTwN4QRoHP0
        qRfQLRYALwyAm5iDjHV17QRA7B+LCtg=
Date:   Sun, 28 Jun 2020 21:34:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] EFI fixes
Message-ID: <20200628193448.GD18730@zn.tnic>
References: <20200628182601.GA84577@gmail.com>
 <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
 <CAMj1kXFfLb44ifgNqBR9WM5T6sT6ekqS8cYdvbuhvs5mqcD+tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFfLb44ifgNqBR9WM5T6sT6ekqS8cYdvbuhvs5mqcD+tw@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jun 28, 2020 at 09:26:45PM +0200, Ard Biesheuvel wrote:
> Arnd may know more, but I know one of the reasons 4.8 is significant
> is because RHEL 7 uses it, which will go EOL in 2024.

Yeah, I always question the relevance of this argument because distros:

* backport fixes for the compiler so gcc-4.8 in the distro is not always
upstream gcc-4.8

* they build the distro kernel with that compiler and former is
something old.

Yeah, it can happen that some backported patch has trouble building with
the distro compiler but that is kinda seldom.

IMHO, of course.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
