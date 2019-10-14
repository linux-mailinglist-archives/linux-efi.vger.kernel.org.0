Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1DBD6032
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2019 12:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfJNKby (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Oct 2019 06:31:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42040 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbfJNKby (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Oct 2019 06:31:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so7821232pls.9;
        Mon, 14 Oct 2019 03:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p52zOb8AkWjiHUW3lM+HOVr/SY7iwqKrbhUSsHYKydI=;
        b=aKAN9G7S15wLAKjZdCk0TnvTdskk6ME9hd+nCHWwGBd2gO2ywsZkeW38VfYFGY3Yov
         9ua1sLe+6BOwNwcYxN7INb16HuJ36whfxEHfaOsLZ+Nowk7uq9He+qFmoQS7sgLdRzto
         N2z7/tEMzkUj9cgV0HWkxnAy/wqLQFt8yGQJVBfs+BdQplzsPhIMSfaPUJZ3DIP/bRN/
         iqbFlyNLDA04wVUsWnxzXGyu29iIXr/cDYlc9KMQ2sEgw67LA1T7RXqNnSkb9dO0tdHI
         8WgohWVdvJTZ4lt7Q/7qZcSbrMa01gf9yMPWQRfU76ROm+gGTcB0T68/9zR5PvG6FGv9
         jKEQ==
X-Gm-Message-State: APjAAAUMR4rOivVc2wsi92EyCczUg+Myau3aaYWebSpAG1UuLaMA5f/e
        wss+12eMPKXWhFRaZZbjwDQ=
X-Google-Smtp-Source: APXvYqwZaInwYLIRhKrxWj7gBZex+kOMBky3fc37KYVcVOUwoOaIUp8L1sRbMp8Fh1etp/Z1E5xNAA==
X-Received: by 2002:a17:902:6b88:: with SMTP id p8mr27888381plk.251.1571049112966;
        Mon, 14 Oct 2019 03:31:52 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c1sm27085900pfb.135.2019.10.14.03.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 03:31:51 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D2D324021A; Mon, 14 Oct 2019 10:31:50 +0000 (UTC)
Date:   Mon, 14 Oct 2019 10:31:50 +0000
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
Message-ID: <20191014103150.GB16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191011141036.GK16384@42.do-not-panic.com>
 <7fed4882-efa7-18d0-1ef6-9138fbdddfc4@redhat.com>
 <20191011153823.GS16384@42.do-not-panic.com>
 <20191011163819.GA1295750@kroah.com>
 <20191014092216.GA16384@42.do-not-panic.com>
 <20191014092929.GA3050866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014092929.GA3050866@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 14, 2019 at 11:29:29AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 14, 2019 at 09:22:16AM +0000, Luis Chamberlain wrote:
> > On Fri, Oct 11, 2019 at 06:38:19PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Oct 11, 2019 at 03:38:23PM +0000, Luis Chamberlain wrote:
> > > > On Fri, Oct 11, 2019 at 04:31:26PM +0200, Hans de Goede wrote:
> > > > > Hi,
> > > > > 
> > > > > On 10/11/19 4:10 PM, Luis Chamberlain wrote:
> > > > > > Hey Hans, thanks for staying on top of this and follow up! For some
> > > > > > reason the universe conspired against your first and last patch ([1/8],
> > > > > > [8/8]), and I never got them. Could you bounce these or resend in case
> > > > > > others confirm they also didn't get it?
> > > > > 
> > > > > I have received feedback from others on the first patch, so at least
> > > > > that one has reached others. I've bounced patches 1 and 8 to you.
> > > > 
> > > > Thanks, can you also bounce the feedback received?
> > > 
> > > That is what lore.kernel.org is for...
> > 
> > If I have feedback on an email which I did not get I cannot easily reply to it.
> 
> I meant, use lore.kernel.org to download the mbox of the thread and then
> use your email client to respond to whatever you need there.  This all
> is public, no need to ask anyone else to bounce emails to you.

Last I looked it didn't allow you to downlaod an mbox of a thread...
I'll take a look next time I miss a few emails.

  Luis
