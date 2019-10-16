Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695CFD9150
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2019 14:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393201AbfJPMps (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Oct 2019 08:45:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41957 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390973AbfJPMps (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Oct 2019 08:45:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id t10so11224042plr.8;
        Wed, 16 Oct 2019 05:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MW2OPawZ1/S7yUUbg0Iwr6wr8CBZilFP35Sgfd8NrvI=;
        b=llxF/QUkrOKyUU+KdhmQpMmMY9Gfd9z6w6tCedM4LOBAEk9O2YvP0V/NAHXsK4va1G
         3Nwq9K+MBR+hkNVSiEOjfcj5JuCrTBk/BVAo8oCyEkLB/OXxMLy1UD78kDB4JPS9pbVR
         rN61qwQL/SesmJPyMleE46qq4H+ZjZhNYJC4OBohquCLqVjIG5yz3sIIlKOpd5mZO2ZU
         1H9H+aTjvNj8CwM1QBi+eUzpkpMgq+enRUamJvlsXMNkEaAfBFAwXwBZrKBEszwMAIfX
         hlsP8IT6YHuRDbiDt4HiaFU4dmRlDX8EUncTUGvQFYKgDwqxsK2IqKIFMCSGMuslhguX
         OCdw==
X-Gm-Message-State: APjAAAVO9aPh0mKppK5HK6pDai7eZbfEuhx6j0rN8RAnZOjY5Bhd2LGF
        gADR1yRtLRMQxhsklCqiX0g=
X-Google-Smtp-Source: APXvYqyKGPR4ZK3MbBMfiZ9W9A5wG/MAiwUafwAuA5NTnFoMudfkEXwGcJ82nnpb3T+NzAZR6dFXmw==
X-Received: by 2002:a17:902:8e81:: with SMTP id bg1mr7131785plb.137.1571229945751;
        Wed, 16 Oct 2019 05:45:45 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c34sm3935476pgb.35.2019.10.16.05.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 05:45:44 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9DF5140251; Wed, 16 Oct 2019 12:45:43 +0000 (UTC)
Date:   Wed, 16 Oct 2019 12:45:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v7 0/8] efi/firmware/platform-x86: Add EFI embedded fw
 support
Message-ID: <20191016124543.GF16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191011141036.GK16384@42.do-not-panic.com>
 <7fed4882-efa7-18d0-1ef6-9138fbdddfc4@redhat.com>
 <20191011153823.GS16384@42.do-not-panic.com>
 <20191011163819.GA1295750@kroah.com>
 <20191014092216.GA16384@42.do-not-panic.com>
 <20191014092929.GA3050866@kroah.com>
 <20191014103150.GB16384@42.do-not-panic.com>
 <20191014105754.GA34057@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014105754.GA34057@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 14, 2019 at 12:57:54PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 14, 2019 at 10:31:50AM +0000, Luis Chamberlain wrote:
> > On Mon, Oct 14, 2019 at 11:29:29AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 14, 2019 at 09:22:16AM +0000, Luis Chamberlain wrote:
> > > > On Fri, Oct 11, 2019 at 06:38:19PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Oct 11, 2019 at 03:38:23PM +0000, Luis Chamberlain wrote:
> > > > > > On Fri, Oct 11, 2019 at 04:31:26PM +0200, Hans de Goede wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On 10/11/19 4:10 PM, Luis Chamberlain wrote:
> > > > > > > > Hey Hans, thanks for staying on top of this and follow up! For some
> > > > > > > > reason the universe conspired against your first and last patch ([1/8],
> > > > > > > > [8/8]), and I never got them. Could you bounce these or resend in case
> > > > > > > > others confirm they also didn't get it?
> > > > > > > 
> > > > > > > I have received feedback from others on the first patch, so at least
> > > > > > > that one has reached others. I've bounced patches 1 and 8 to you.
> > > > > > 
> > > > > > Thanks, can you also bounce the feedback received?
> > > > > 
> > > > > That is what lore.kernel.org is for...
> > > > 
> > > > If I have feedback on an email which I did not get I cannot easily reply to it.
> > > 
> > > I meant, use lore.kernel.org to download the mbox of the thread and then
> > > use your email client to respond to whatever you need there.  This all
> > > is public, no need to ask anyone else to bounce emails to you.
> > 
> > Last I looked it didn't allow you to downlaod an mbox of a thread...
> 
> It can, from the front page of "all" threads, or on the thread itself,
> at the bottom of the page.  Search for "download" on the page.

Sweet! <insert sound of discovering an item in Legend of Zelda>

  Luis
