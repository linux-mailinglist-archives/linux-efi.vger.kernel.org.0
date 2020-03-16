Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E2818686C
	for <lists+linux-efi@lfdr.de>; Mon, 16 Mar 2020 11:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgCPKBx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Mar 2020 06:01:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38530 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730558AbgCPKBx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 16 Mar 2020 06:01:53 -0400
Received: from zn.tnic (p200300EC2F06AB0069F33882ABEAD541.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:ab00:69f3:3882:abea:d541])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A0C71EC0CC5;
        Mon, 16 Mar 2020 11:01:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584352911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eo6Lnj2n6Gi2H5HDTW21SG50NWmPM4Kj2koyWSbmyHk=;
        b=I1X2Qv5g4XkDQqYw0Ot/gY9xVZEMZp9A8BVdRVlbUjBa8yWiz4CCunDQB6i+262pWm/OEO
        PffIe6vhAaI/VD5qH+s6VO+4I2Pt1n1bcJqAWvrNt/Lw1+ccNpGOW3WyhBmXaiOZiwGL1X
        A7wVN8cFLSC4qadSNKjbDI20tRyMaNU=
Date:   Mon, 16 Mar 2020 11:02:02 +0100
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
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH] Revert "x86/reboot, efi: Use EFI reboot for Acer
 TravelMate X514-51T"
Message-ID: <20200316100201.GG26126@zn.tnic>
References: <20200312083341.9365-1-jian-hong@endlessm.com>
 <20200312104643.GA15619@zn.tnic>
 <CAPpJ_eetjhmPwXXXn2y-vibRCK6rrKsFZgC+YGzxO4fMrCKpuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpJ_eetjhmPwXXXn2y-vibRCK6rrKsFZgC+YGzxO4fMrCKpuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 16, 2020 at 05:17:56PM +0800, Jian-Hong Pan wrote:
> But, that will raise another question:  Since the original quirk works
> for all Acer X514-51T and the quirk cannot be removed for older BIOS.
> Why not keep only original matching items for all Acer X514-51T
> laptops?

What does the "original matching items" mean?

> I am not sure which option is better.  Any comment?

If you mean, "let's not do anything and fix it only when there's really
a need to fix anything", then yes, I agree.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
