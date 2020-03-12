Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517EA182E1E
	for <lists+linux-efi@lfdr.de>; Thu, 12 Mar 2020 11:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgCLKqm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Mar 2020 06:46:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLKqm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 12 Mar 2020 06:46:42 -0400
Received: from zn.tnic (p200300EC2F0DBF00894A3A768C8141DF.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:bf00:894a:3a76:8c81:41df])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EBE0D1EC0CF8;
        Thu, 12 Mar 2020 11:46:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584010001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h9ufmfACEP9wthZWwpWI3tKNBhqEf8SV+AxE3rwYr9c=;
        b=bqbTBOCppYPX9tpBsHgOizmdTbt4XCOJ7+iJ997dEg5vDu35TdlNOKM8GrnYXJwDHbOK2k
        hPOV/7eqTYiQkn0+TwNYCv+0fIVIgXc52tGVsprENUj7G5YJ39LgzHbqIEJENmpP7WPowY
        Z9f5rdKFpPc1OKvrSh3k2c5YhqxjkTI=
Date:   Thu, 12 Mar 2020 11:46:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux@endlessm.com
Subject: Re: [PATCH] Revert "x86/reboot, efi: Use EFI reboot for Acer
 TravelMate X514-51T"
Message-ID: <20200312104643.GA15619@zn.tnic>
References: <20200312083341.9365-1-jian-hong@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312083341.9365-1-jian-hong@endlessm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 12, 2020 at 04:33:42PM +0800, Jian-Hong Pan wrote:
> This reverts commit 0082517fa4bce073e7cf542633439f26538a14cc.
> 
> According to Acer's information, this reboot issue is fixed since 1.08
> and newer BIOS. So, we can revert the quirk.

We can?

How do you know *everyone* affected will update their BIOS?

And what's the downside of keeping it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
