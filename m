Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A829B1D7375
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 11:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgERJHj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 05:07:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45414 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgERJHi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 18 May 2020 05:07:38 -0400
Received: from zn.tnic (p200300ec2f06e800d0e940b9e23b2e71.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:e800:d0e9:40b9:e23b:2e71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A2CE01EC0337;
        Mon, 18 May 2020 11:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589792855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=A/D3q8YYDdeKyT3tygabeARK+4DUMllrL5T+0I7hDFU=;
        b=p8OBSAuqYqA5YLgDRnT25NeP8c+4NwxVwolZRI46j3088JJiY6wRMKmLgUKXmldSKl6H6M
        /K7mlVE63FwsAeogqjBWyDX4CzxqSJPeAJURSEZgXDHp5LJTyEqWFE6PErHnfNdcgSVIiE
        f27ohitVagUNRfpcQZbVFhCtVPmA14Q=
Date:   Mon, 18 May 2020 11:07:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        linux-acpi@vger.kernel.org, Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: Re: [GIT PULL 0/7] EFI fixes for v5.7
Message-ID: <20200518090727.GB25034@zn.tnic>
References: <20200517125754.8934-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200517125754.8934-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Sun, May 17, 2020 at 02:57:47PM +0200, Ard Biesheuvel wrote:
> The following changes since commit a088b858f16af85e3db359b6c6aaa92dd3bc0921:
> 
>   efi/x86: Revert struct layout change to fix kexec boot regression (2020-04-14 08:32:17 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

can you please make your tags unique? For example call this one:

efi-urgent-for-v5.7-rc6

or so so that the git history can show for which -rc that urgent tag was
meant?

I mean, technically one can do that already with git but it would be
easier if it had the rc in the name. We do that already in tip - either
-rc name or the date of the tag.

Also, using the same tag gives:

From git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi
 ! [rejected]                  efi-next           -> efi-next  (would clobber existing tag)
 ! [rejected]                  efi-urgent         -> efi-urgent  (would clobber existing tag)

when I try to fetch from you and I can delete the old tag but having
unique tag names makes the history more user-friendly, I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
