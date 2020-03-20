Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE78518CF86
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 14:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCTNyc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Mar 2020 09:54:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCTNyb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Mar 2020 09:54:31 -0400
Received: from zn.tnic (p200300EC2F0A5A004DAD0A631927B72B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:4dad:a63:1927:b72b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 67BE21EC0CF9;
        Fri, 20 Mar 2020 14:54:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584712470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4kRlOKjHakNgyDMJ+wwWO6fJ9qGChnt/waqHmA/UUGY=;
        b=F0FOPtBwjQP0paqttkINRGbxEcmOMVhN4oL0yj58aGG1avkm9QONlkR8NBXjqQSmqDIw9L
        vxUZqNovMOIpqMvYdssliy14K12ktEZxIEt77Wsy46H0CUd3oWK+NCFRLHn2wB6zcdZ5JU
        D0uVIwOLBo4Llp8mhOb2XsweNN/eGPw=
Date:   Fri, 20 Mar 2020 14:54:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH] Revert "x86/reboot, efi: Use EFI reboot for Acer
 TravelMate X514-51T"
Message-ID: <20200320135436.GA23532@zn.tnic>
References: <20200312083341.9365-1-jian-hong@endlessm.com>
 <20200312104643.GA15619@zn.tnic>
 <CAD8Lp47ndRqeS5VbkCMR_Faq-du9eDW28rHOG4Owxq862t-kGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD8Lp47ndRqeS5VbkCMR_Faq-du9eDW28rHOG4Owxq862t-kGQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Mar 20, 2020 at 08:37:54PM +0800, Daniel Drake wrote:
> Based on that I was considering that the patch could be reverted for
> cleanliness/ At the same time, I do not have strong feelings on this,
> no issues if the quirk is left in place.

Oh, I'd take the revert on cleanliness grounds any day of the week. But
if that broken fw has snuck out and someone comes and complains that it
wouldn't reboot properly, then I'd have to revert the revert.

And looking at that reboot_dmi_table[] of who's who of broken BIOSes,
one entry less ain't gonna make it prettier.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
