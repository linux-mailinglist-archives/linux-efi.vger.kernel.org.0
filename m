Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C6226912A
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 18:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgINQMV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 12:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgINQMP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Sep 2020 12:12:15 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E14AC06174A
        for <linux-efi@vger.kernel.org>; Mon, 14 Sep 2020 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tx2oyzwJ353auCr9j8+1rUMRZV2tvoeGzr96u2q0vNY=; b=BrmSRTAF6/oIIJ0uFAzjvCe8X
        agrzFTin+ApJsBXrJMakDbc6FqBJguRulw/v+NsZogKd9BM6OfcrE0zPM7YS2kqAs7w99mCSX9nqE
        PBgklYFd3JUhrFpoPDEfnRzolsr0x3D3+YWCnIHGOCO55v60zEkcAZTAJayGXZ2RgVSfPOjaecORs
        Caol/k97AAIreXTzl77OnKk0VJ7/d6p86SKMjb5c6DzHYWCESjtzKVozIZGtK27J7CWMQQzIx9N3G
        23hUXBddrLhkhov2xejDrCuj27zGbner+64UTkJIVU5drEVAsQ3F40OpAeZGb+motzpxzx7ls05H2
        O1CFuvgHw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33610)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kHr59-0001lr-O0; Mon, 14 Sep 2020 17:11:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kHr57-0002nP-JW; Mon, 14 Sep 2020 17:11:53 +0100
Date:   Mon, 14 Sep 2020 17:11:53 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 03/12] ARM: module: add support for place relative
 relocations
Message-ID: <20200914161153.GM1551@shell.armlinux.org.uk>
References: <20200914095706.3985-1-ardb@kernel.org>
 <20200914095706.3985-4-ardb@kernel.org>
 <nycvar.YSQ.7.78.906.2009140927490.4095746@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.78.906.2009140927490.4095746@knanqh.ubzr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 14, 2020 at 09:35:41AM -0400, Nicolas Pitre wrote:
> On Mon, 14 Sep 2020, Ard Biesheuvel wrote:
> 
> > When using the new adr_l/ldr_l/str_l macros to refer to external symbols
> > from modules, the linker may emit place relative ELF relocations that
> > need to be fixed up by the module loader. So add support for these.
> 
> Just wondering if that capability requirement should be added to the 
> module signature somehow...?
> 
> Maybe not. The MODULE_ARCH_VERMAGIC definition only contains things that 
> are configurable for a given build.

It doesn't need to be. If a module contains a relocation we don't know
how to handle, it will fail to load.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
