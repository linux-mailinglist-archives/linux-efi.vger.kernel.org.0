Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6253455EA25
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 18:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiF1Quu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 12:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243763AbiF1Qs5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 12:48:57 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F602B1B4
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v4DdRGOMrTFRfMhGOwofCftZuCBc0LK6jFGo1uAI728=; b=yihLH4crbvN1FDNhVvghJYjbe9
        x5qADhLVRFo2cjd0EwSWbaICUI1a9lG4My42NOrrgyOHGel8MtxcY0NCG+3UO9dMOs6op7IBRaEsf
        Js7Ni73B0fgYFsJtBvNlcDpyksaDnMXaVXXPYR1xJM5ZILgiQnCoPp6wIqG07VRCLp54BUS2DK84T
        1T5HLE5+u4itopKwBZoHQgqOz6aBikC4o5XRn2JMc839Bef9VcvxA9KakQcDizyFvoDNE0jX/aZeQ
        Z2niz75SdEtwaWGcjoSz03wLIVFECCt0hqOGfeeXxf/PpzmI9HAkDJX7yc+rp0RiK89meAHdSjjFl
        TJ3gbSew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33070)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o6ELa-0001rW-43; Tue, 28 Jun 2022 17:45:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o6ELY-000536-Tg; Tue, 28 Jun 2022 17:45:52 +0100
Date:   Tue, 28 Jun 2022 17:45:52 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: efi: Simplify arch_efi_call_virt() macro
Message-ID: <YrswQH7fsQpEtEK5@shell.armlinux.org.uk>
References: <20220628141821.849643-1-sudeep.holla@arm.com>
 <CAMj1kXHyMNn5bZceb4QnnQfBJ3bWpM5PLdZXR4ECGhmT7hzVbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHyMNn5bZceb4QnnQfBJ3bWpM5PLdZXR4ECGhmT7hzVbA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 28, 2022 at 06:29:52PM +0200, Ard Biesheuvel wrote:
> On Tue, 28 Jun 2022 at 16:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Currently, the arch_efi_call_virt() assumes all users of it will have
> > defined a type 'efi_##f##_t' to make use of it. It is unnecessarily
> > forcing the users to create a new typedef when __efi_rt_asm_wrapper()
> > actually expects void pointer.
> >
> > Simplify the arch_efi_call_virt() macro by eliminating the explicit
> > need for efi_##f##_t type for every user of this macro.
> >
> > This change is done to align with implementations on other similar
> > architectures.
> >
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> I'll queue this one up right away in the EFI tree, unless Russell has
> something else in mind?

No, looks good, thanks.

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
