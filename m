Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C347D60C0
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2019 12:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfJNK57 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Oct 2019 06:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731305AbfJNK57 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Oct 2019 06:57:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAE3D207FF;
        Mon, 14 Oct 2019 10:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571050677;
        bh=M/q4WcNPrO/M2s3hdWU+TCGsA3virwS9Z2V34PZ8m3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oINYM8IPV1QLRqgf7V4NEt9mVkstEH6S0YH7BlbqZyblv0XXcz3fi9xDINcKxuUfZ
         u6+FJf2ySAEMueB7ULrjbKMhvuhgzw2t1LQhmn1Qomt0Qqg6T3FS/9BHUT4kAP3xhS
         2YBsZHn5KTc8k9jxaoxYfH6CaJHlplnBNiRkn4ls=
Date:   Mon, 14 Oct 2019 12:57:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <20191014105754.GA34057@kroah.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191011141036.GK16384@42.do-not-panic.com>
 <7fed4882-efa7-18d0-1ef6-9138fbdddfc4@redhat.com>
 <20191011153823.GS16384@42.do-not-panic.com>
 <20191011163819.GA1295750@kroah.com>
 <20191014092216.GA16384@42.do-not-panic.com>
 <20191014092929.GA3050866@kroah.com>
 <20191014103150.GB16384@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014103150.GB16384@42.do-not-panic.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 14, 2019 at 10:31:50AM +0000, Luis Chamberlain wrote:
> On Mon, Oct 14, 2019 at 11:29:29AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Oct 14, 2019 at 09:22:16AM +0000, Luis Chamberlain wrote:
> > > On Fri, Oct 11, 2019 at 06:38:19PM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, Oct 11, 2019 at 03:38:23PM +0000, Luis Chamberlain wrote:
> > > > > On Fri, Oct 11, 2019 at 04:31:26PM +0200, Hans de Goede wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On 10/11/19 4:10 PM, Luis Chamberlain wrote:
> > > > > > > Hey Hans, thanks for staying on top of this and follow up! For some
> > > > > > > reason the universe conspired against your first and last patch ([1/8],
> > > > > > > [8/8]), and I never got them. Could you bounce these or resend in case
> > > > > > > others confirm they also didn't get it?
> > > > > > 
> > > > > > I have received feedback from others on the first patch, so at least
> > > > > > that one has reached others. I've bounced patches 1 and 8 to you.
> > > > > 
> > > > > Thanks, can you also bounce the feedback received?
> > > > 
> > > > That is what lore.kernel.org is for...
> > > 
> > > If I have feedback on an email which I did not get I cannot easily reply to it.
> > 
> > I meant, use lore.kernel.org to download the mbox of the thread and then
> > use your email client to respond to whatever you need there.  This all
> > is public, no need to ask anyone else to bounce emails to you.
> 
> Last I looked it didn't allow you to downlaod an mbox of a thread...

It can, from the front page of "all" threads, or on the thread itself,
at the bottom of the page.  Search for "download" on the page.

greg k-h
