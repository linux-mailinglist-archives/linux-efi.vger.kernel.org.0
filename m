Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42EA39B9C0
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jun 2021 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFDNYQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Jun 2021 09:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhFDNYP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Jun 2021 09:24:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 666EB613E7;
        Fri,  4 Jun 2021 13:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622812939;
        bh=iRXTZJ1/j6y4+BU2gyPMGifKfRMorvLra+BpePakUZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWcoC2X3RFj7LIg0etg9XR+Ol4cYUMRjxMauHNEGImBMoOF7MscH3Lk4Hb6THjogO
         JzU7e9iNBriY/qU+Jk+VCz5o+C+lOYYF8EbbYgh9jsZBcK5nvZXMwjpMpFt86I7vUB
         Oy2RV60O8ouBKi6GmOLV4gyi7XH2gPYXGeKNvvRI=
Date:   Fri, 4 Jun 2021 15:22:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Chester Lin <clin@suse.com>, Dinh Nguyen <dinguyen@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 1/2] drivers/firmware: move x86 Generic System
 Framebuffers support
Message-ID: <YLopCCCkrci1IF9v@kroah.com>
References: <20210601145912.774054-1-javierm@redhat.com>
 <20210601145912.774054-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601145912.774054-2-javierm@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 01, 2021 at 04:59:11PM +0200, Javier Martinez Canillas wrote:
> The x86 architecture has generic support to register a system framebuffer
> platform device. It either registers a "simple-framebuffer" if the config
> option CONFIG_X86_SYSFB is enabled, or a legacy VGA/VBE/EFI FB device.
> 
> But the code is generic enough to be reused by other architectures and can
> be moved out of the arch/x86 directory.
> 
> This will allow to also support the simple{fb,drm} drivers on non-x86 EFI
> platforms, such as aarch64 where these drivers are only supported with DT.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
