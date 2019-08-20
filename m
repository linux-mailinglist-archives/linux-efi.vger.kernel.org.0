Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98EC95DE5
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2019 13:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfHTLyh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Aug 2019 07:54:37 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36082 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTLyg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Aug 2019 07:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OXrOAN6eHe7BZs+9Ca5eeCBnDoTWb1Lr6g97dXXB9WM=; b=zBhndaa/3WKWlHsf0MJPuqHCj
        6PY8J/VVcKmPQNs6acc0JD/1ZGg/wzvOA4yJFAVUuZDGZAB9c4bsXLac+JNDYQeq5yFscGOydAKcb
        zfnbMQMthlxg5Q0PpJkhfopzLrmjelIWuCHRen60K9n0doSPf1j03OEWVholwJXwLsuvbiVMPgCe7
        CcTtQuST7v7WrlFMSTKfuCWM1irdDFhmRccsjDEGQ592LQ9tsx/m39X0y3e3yCX752OL0i0vvlvoO
        1mDVACdO20hRV1obmq3emxeOJHtKMARL2e8mg2B0Zean+dFnkka7qHVfc8PxvPhOUdOhS7aZqC4Dm
        KQVZ7a22A==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:54734)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i02iO-00020m-Pp; Tue, 20 Aug 2019 12:54:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i02iH-0005mO-H2; Tue, 20 Aug 2019 12:54:09 +0100
Date:   Tue, 20 Aug 2019 12:54:09 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Chester Lin <clin@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        Juergen Gross <JGross@suse.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Joey Lee <JLee@suse.com>, Gary Lin <GLin@suse.com>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the
 kernel base
Message-ID: <20190820115409.GO13294@shell.armlinux.org.uk>
References: <20190802053744.5519-1-clin@suse.com>
 <CAKv+Gu-yaNYsLQOOcr8srW91-nt-w0e+RBqxXGOagiGGT69n1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-yaNYsLQOOcr8srW91-nt-w0e+RBqxXGOagiGGT69n1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Aug 04, 2019 at 10:57:00AM +0300, Ard Biesheuvel wrote:
> (The first TEXT_OFFSET bytes are no longer used in practice, which is
> why putting a reserved region of 4 KB bytes works at the moment, but
> this is fragile).

That is not correct for 32-bit ARM.  The swapper page table is still
located 16kiB below the kernel.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
