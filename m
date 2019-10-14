Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7492D5EB0
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2019 11:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfJNJWU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Oct 2019 05:22:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45200 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730778AbfJNJWU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Oct 2019 05:22:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so10032791pfb.12;
        Mon, 14 Oct 2019 02:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TC2+yBE1e1TW1803J0hwiR3w1U8Tt2d/K4s4HsSBGNI=;
        b=WCbXRL4Iu+JEu2SQ4JFzy71ExxWDu8U4DNA57Mkp+PKu4Cz9VBSyoV/5X6pXNXaiPD
         DDthlPC7f66ZJbQnMn2Dd+MVXft3zwA2pCeQGyDI/HM9H4SjLzbOehkyiU1S9zA3E6SO
         I1jRgOvKHRGopRAclaTEMRIg4IVHaNNDHgy4sTs30AKp7Ij8hIolZIDTMWy7g7QZUWax
         QTuC5bFBjZkIKunkgeOJ7oMEnNc+0NyQ5D+vKp+qnDE72oQ4Kp5G9VkVqzvngAh+47Hd
         ep+TohyImGC8SBie7sVziTWXwP9ljAwgVRMAMd4IlZwJ9HT5MVqbZp4jzbLUfirf1lMr
         ZlMQ==
X-Gm-Message-State: APjAAAWh1UCo1wINM11SnGMZOo17D4Fr1D06C9l+jIC/Tkc06tTH64pc
        SxvscsAQl65BSiCf1L2PQos=
X-Google-Smtp-Source: APXvYqyjC/Y1Gw4qt/B40j2VP+yRTueZa4UHCuOIUcLRPr9er+3d5llcSv3ZgbzhnB9y74rDy7Xyrg==
X-Received: by 2002:a65:53c4:: with SMTP id z4mr1556834pgr.155.1571044938307;
        Mon, 14 Oct 2019 02:22:18 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q2sm19933776pfg.144.2019.10.14.02.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 02:22:17 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 70BBC4021A; Mon, 14 Oct 2019 09:22:16 +0000 (UTC)
Date:   Mon, 14 Oct 2019 09:22:16 +0000
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
Message-ID: <20191014092216.GA16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191011141036.GK16384@42.do-not-panic.com>
 <7fed4882-efa7-18d0-1ef6-9138fbdddfc4@redhat.com>
 <20191011153823.GS16384@42.do-not-panic.com>
 <20191011163819.GA1295750@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011163819.GA1295750@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 11, 2019 at 06:38:19PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 11, 2019 at 03:38:23PM +0000, Luis Chamberlain wrote:
> > On Fri, Oct 11, 2019 at 04:31:26PM +0200, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 10/11/19 4:10 PM, Luis Chamberlain wrote:
> > > > Hey Hans, thanks for staying on top of this and follow up! For some
> > > > reason the universe conspired against your first and last patch ([1/8],
> > > > [8/8]), and I never got them. Could you bounce these or resend in case
> > > > others confirm they also didn't get it?
> > > 
> > > I have received feedback from others on the first patch, so at least
> > > that one has reached others. I've bounced patches 1 and 8 to you.
> > 
> > Thanks, can you also bounce the feedback received?
> 
> That is what lore.kernel.org is for...

If I have feedback on an email which I did not get I cannot easily reply to it.
In the future I'd like lore to let me bounce emails from a thread to me,
but that is not possible today AFAICT?

  Luis
