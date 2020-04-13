Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57CC1A6A0F
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 18:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbgDMQmD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 12:42:03 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55014 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbgDMQmD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Apr 2020 12:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qrKdv++jsx8OM0O4tG4mY11gjkLsOySPBw/dhIBWmSs=; b=1c6JnPLhZU5U395oA+UHFuwtK
        x3DeQFCfg0KACWgpiS6U9cnTPix+Gny8iXPmqx/iXvCpc7D9E7y9cBmrPJZNzk6V8xd5imdQVj38x
        cNHUkO0x2eFfsOjduW8jwdvn53mej+NDPP5PDtzoG/HIj1TMcw585bHiy1aq88hl75A0CJbuYoU3T
        Lod0VZZzl4NiTbS/Kvyf/rKbm1X1nB9FXixWUot+K+r8FvzfHPZjOLtmTTISeztQYZvtrYJO19ty+
        0RGh55Gb9LcBEqc1xO5H4lWSl7efQmpti+GoTgCPm5hKEhfgE2fsN1gkmIAm24TCKhtO6ReN1EBEn
        6ClCceD7w==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:45434)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jO29V-0002u4-RS; Mon, 13 Apr 2020 17:41:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jO29K-00078R-Uv; Mon, 13 Apr 2020 17:41:30 +0100
Date:   Mon, 13 Apr 2020 17:41:30 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/5] ARM: simplify handover from UEFI to decompressor
Message-ID: <20200413164130.GP25745@shell.armlinux.org.uk>
References: <20200413162135.14955-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413162135.14955-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 13, 2020 at 06:21:30PM +0200, Ard Biesheuvel wrote:
> The EFI stub in the ARM kernel runs in the context of the firmware, which
> means it runs with the caches and MMU on. Currently, we relocate the zImage
> so it appears in the first 128 MiB, disable the MMU and caches and invoke
> the decompressor via its ordinary entry point. However, since we can pass
> the base of DRAM directly, there is no need to relocate the zImage, which
> also means there is no need to disable and re-enable the caches and create
> new page tables etc.
> 
> This simplification is implemented by patch #5. Patches #1 - #4 are
> prerequisite changes to permit the decompressor to execute from the
> offset chosen by the UEFI firmware.

Why?  The decompressor is already fully relocatable, so this doesn't
explain why all these changes breaking up the single place where data
is stored into multiple smaller pieces, making the code more complex
is really necessary.  To me, this seems ot be change for change sake.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
