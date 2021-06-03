Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616ED39ABC5
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jun 2021 22:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCU3I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Jun 2021 16:29:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32912 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCU3I (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 3 Jun 2021 16:29:08 -0400
Received: from zn.tnic (p200300ec2f138500c7e12fc0802db454.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:c7e1:2fc0:802d:b454])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C77C1EC0246;
        Thu,  3 Jun 2021 22:27:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622752042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OdHEZyA0Yz82G9giMJIrJ6sLC/3gLs0Aj9USNqocCdM=;
        b=n/qUCf7CAevYLO1ua7Xqqjpw/2DKzujCT+H1jn+x5ugKmQ4H2WI5rxAl9X5LimeJKHbs2M
        kOUvyxeDDa1NQg8mJHgE84zLB/p8lkOiGljmxRGNZS3q9J3rhUJ5BPqkeW+gwtYIwq7KLo
        9nn344GKcSr0hzTiGpQkueO8Paj9s3Q=
Date:   Thu, 3 Jun 2021 22:27:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chester Lin <clin@suse.com>, Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v2 0/2] allow simple{fb,drm} drivers to be used on
 non-x86 EFI platforms
Message-ID: <YLk7HjX2OnLhMt4V@zn.tnic>
References: <20210601145912.774054-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210601145912.774054-1-javierm@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 01, 2021 at 04:59:10PM +0200, Javier Martinez Canillas wrote:
> The series touches different subystems and will need coordination between
> maintainers. Ard Biesheuvel said that can be merged through the EFI tree.

I'm always happy when code from arch/x86/ moves away so

Acked-by: Borislav Petkov <bp@suse.de>

Btw, for the future, please CC everyone on the whole patchset - I had to
go look at your 2/2 on lore to see what it does because I had only 1/2
in my mbox.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
