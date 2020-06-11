Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9861F7083
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jun 2020 00:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgFKWns (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Jun 2020 18:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKWns (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Jun 2020 18:43:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C4C03E96F
        for <linux-efi@vger.kernel.org>; Thu, 11 Jun 2020 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vl6rCo7uqYpLu8Kp1gCo/gH0TyF1wOMb17imQIGNMOM=; b=cL7bDyAivKkYlQRhVOEchrf+4
        ePuenP0KEFsDgOsVlWXmm3GE4Hs5pTcHttmUYhtePMTMmTdT+iAgCJAWA/2V6qkBwAPkP3lI/h8di
        V/tp3aCuTaOMa0sYaJOw5X2L637gG6Q+TcrAi4cu5drIh3crZuXd9m1k5i+tMs1ATJL1pXJOhF8Xx
        lOsG0i2vFgL8J9caMbkwyJojwd+0aC+Oqa1QRws0nsrPAfU4kswMQ3IHryzH/gbKBldMC2qqI0OKZ
        qwek3dylwnaT14mdrvNernjO9ncXS8YC17zTQaAVrY3LzXe5v0xrap0w3wlYGIXTrh/cpnXHZ0vU+
        6GhMiu76g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44360)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jjVpi-0001Ox-FU; Thu, 11 Jun 2020 23:38:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jjVpg-0005an-LY; Thu, 11 Jun 2020 23:38:00 +0100
Date:   Thu, 11 Jun 2020 23:38:00 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 1/2] efi/arm: decompressor: deal with HYP mode boot
 gracefully
Message-ID: <20200611223800.GZ1551@shell.armlinux.org.uk>
References: <20200607135834.898294-1-ardb@kernel.org>
 <20200607135834.898294-2-ardb@kernel.org>
 <96a36110-68e1-89e3-2d59-b16f01abae21@gmx.de>
 <CAMj1kXG9XTtsyLQ=njM8LPCYCE2tOrrYQtctU_acNAxLfe=5oQ@mail.gmail.com>
 <f8a485d2-1e00-1d02-58a4-2e1684bfbfb4@gmx.de>
 <CAMj1kXGLoKDLJAihThkkcYwNpr12inneEB3dMOqvcZFm9oR5_w@mail.gmail.com>
 <CAMj1kXFjuMy6+amsMmmepkNATCec4vsxeiVVFq9CFZ64wbmGaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFjuMy6+amsMmmepkNATCec4vsxeiVVFq9CFZ64wbmGaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 12, 2020 at 12:18:43AM +0200, Ard Biesheuvel wrote:
> I've given this a spin myself on a RPi4 running 32-bit U-boot, and
> everything works as expected, both with and without the GRUB hack
> enabled.
> 
> Russell, given that this only affects code inside #ifdef
> CONFIG_EFI_STUB, do you have any objections to me taking this as a fix
> via the EFI tree? I have a set of fixes I need to queue up and send
> out anyway, and I intend to do so early next week.

Please don't, I'll be basing my branches off -rc1 (as normal), and if
you then submit this as a fix through the EFI tree for merging after
rc1, and then send me further EFI work to go through the ARM tree,
we'll end up in exactly the same merge issues as we did prior to this
merge window.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
