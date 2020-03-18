Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810DC189CFB
	for <lists+linux-efi@lfdr.de>; Wed, 18 Mar 2020 14:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCRN1q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Mar 2020 09:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCRN1p (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Mar 2020 09:27:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A2C20772;
        Wed, 18 Mar 2020 13:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584538063;
        bh=oIHo118B/P4ps6bCbCVqy1PT/9fV4w7MXfcifS4hIdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvBTxOqdmnHsDg1WiZ0CR7fg6rQLSQUb/sx1NYSgsIpiLfoMcF+ZEqhKUZHMdL/Es
         16436zOaucxfW4wE1Kmm0fpm8NAgBEFAv0c2jXykiWkXGFjWNOUAZwr2RrRRSsZR2A
         6OKUexXnmMm5q3bx5th2BjaAg7CLS9TgTfBTRwb8=
Date:   Wed, 18 Mar 2020 14:27:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
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
Subject: Re: [PATCH v12 03/10] firmware: Rename FW_OPT_NOFALLBACK to
 FW_OPT_NOFALLBACK_SYSFS
Message-ID: <20200318132741.GA2794545@kroah.com>
References: <20200115163554.101315-1-hdegoede@redhat.com>
 <20200115163554.101315-4-hdegoede@redhat.com>
 <20200124085751.GA2957916@kroah.com>
 <d25d5d6e-0348-b19f-539e-048cfa70d6a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d25d5d6e-0348-b19f-539e-048cfa70d6a6@redhat.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 24, 2020 at 10:16:48AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 1/24/20 9:57 AM, Greg Kroah-Hartman wrote:
> > On Wed, Jan 15, 2020 at 05:35:47PM +0100, Hans de Goede wrote:
> > > This is a preparation patch for adding a new platform fallback mechanism,
> > > which will have its own enable/disable FW_OPT_xxx option.
> > > 
> > > Note this also fixes a typo in one of the re-wordwrapped comments:
> > > enfoce -> enforce.
> > > 
> > > Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > I've taken this in my tree for now in a quest to try to get others to
> > pay attention to this series...
> 
> Thank you.
> 
> As mentioned before I believe that this series is ready for merging now.
> 
> Andy Lutomirski had one last change request for v12 of the second
> patch in the series, specifically to replace the loop searching for
> the prefix with a memem, but the kernel does not have memmem.
> 
> Andy, are you ok with v12 as is, given that we don't have memmem ?
> 
> Assuming Andy is ok with v12 as is, then to merge this we need
> to probably wait for 5.6-rc1 and then have the x86/efi folks do
> an immutable branch with the first 2 patches of the series.

Did this every happen?  Or do I need to dump this all into my tree?

thanks,

greg k-h
