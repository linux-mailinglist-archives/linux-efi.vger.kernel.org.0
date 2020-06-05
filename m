Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D681EFBF0
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 16:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgFEO4T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgFEO4T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Jun 2020 10:56:19 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C17C08C5C2
        for <linux-efi@vger.kernel.org>; Fri,  5 Jun 2020 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WSnkHXfuDDSCVJZVApP+aQ8Ma5VVdPHq0ZMhO/z8y4c=; b=GNCuMd1lGyPC21rxPdRB9Xu7O
        rlpqfOJFXqf0md6YX5LUtiBUYidWQHENnl+LiGP2JT2ig9p7OtsMEeKlMZop/d/y+5st68Xmqf4jN
        j2fLj8i2pESLYJHO7KWe7gnOzNCLoSUnwy/rfsOXCKXqC0XEYs7nMgRYYvt7v1OmNJGSqPcXJWsCv
        3i/4J+BXJBDvaM4fS3AlzXd1VPEw2+Y0ctlUXh7Pk/z4Y6JBRFk1aGp0/cjSgzRbZhVwha+CaOIc7
        Mh535zSBIH4RTlXy21TvhZ2S3hDDu64OP4SmL2dk9/s9Wl4Ew8j4wCu3cDSqLH4Ptup6/LlUay5RO
        rbky0HFVw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:39224)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jhDlV-0002Nf-UU; Fri, 05 Jun 2020 15:56:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jhDlV-0007YG-68; Fri, 05 Jun 2020 15:56:13 +0100
Date:   Fri, 5 Jun 2020 15:56:13 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] efi/arm: decompressor: deal with HYP mode boot gracefully
Message-ID: <20200605145612.GJ1551@shell.armlinux.org.uk>
References: <20200605115200.413921-1-ardb@kernel.org>
 <4498d910-f5cb-8559-afba-34710e9ca730@gmx.de>
 <CAMj1kXHS8AVczRPzySgzkkztD0yT1MXnCyMwmOt=ihZ9Bvo0vQ@mail.gmail.com>
 <589478fe-14a6-a921-3fdf-ae527e14b945@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <589478fe-14a6-a921-3fdf-ae527e14b945@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 05, 2020 at 04:53:08PM +0200, Heinrich Schuchardt wrote:
> Hello Ard,
> 
> I have no board that prints this. Where did you actually see this output?

Note that the decompressor messages do not form part of the kernel
dmesg log.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
