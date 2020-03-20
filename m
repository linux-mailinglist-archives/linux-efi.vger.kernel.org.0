Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4EF18CFA1
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 15:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCTOCs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Mar 2020 10:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCTOCs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Mar 2020 10:02:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F21AA2051A;
        Fri, 20 Mar 2020 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584712965;
        bh=5Z1pwexTYyYy7sJMHe5keJj5QUuvGZ/XrTgYgp87Uzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CU1YZ99qYJjikO714HJH+W1kSSWtM3oLBz3Ba5Qr9MKPBBgyb81IhZjckTVEYTERa
         0qZq+Oz5Wb63F44ixOBDajGaMzEvL6yRLxI/ao0QE5aP/fhFTp68/17ewN2mScGYWN
         tx1uwXKWpzgaWa6Dycv2plDnaEhOoo9lzTw5v9PE=
Date:   Fri, 20 Mar 2020 15:02:43 +0100
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
Message-ID: <20200320140243.GA636547@kroah.com>
References: <20200115163554.101315-1-hdegoede@redhat.com>
 <20200115163554.101315-4-hdegoede@redhat.com>
 <20200124085751.GA2957916@kroah.com>
 <d25d5d6e-0348-b19f-539e-048cfa70d6a6@redhat.com>
 <20200318132741.GA2794545@kroah.com>
 <8fa336bd-339f-40e0-08fe-e6b968736679@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa336bd-339f-40e0-08fe-e6b968736679@redhat.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 18, 2020 at 02:56:23PM +0100, Hans de Goede wrote:
> Hi Greg,
> 
> On 3/18/20 2:27 PM, Greg Kroah-Hartman wrote:
> > On Fri, Jan 24, 2020 at 10:16:48AM +0100, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 1/24/20 9:57 AM, Greg Kroah-Hartman wrote:
> > > > On Wed, Jan 15, 2020 at 05:35:47PM +0100, Hans de Goede wrote:
> > > > > This is a preparation patch for adding a new platform fallback mechanism,
> > > > > which will have its own enable/disable FW_OPT_xxx option.
> > > > > 
> > > > > Note this also fixes a typo in one of the re-wordwrapped comments:
> > > > > enfoce -> enforce.
> > > > > 
> > > > > Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > 
> > > > I've taken this in my tree for now in a quest to try to get others to
> > > > pay attention to this series...
> > > 
> > > Thank you.
> > > 
> > > As mentioned before I believe that this series is ready for merging now.
> > > 
> > > Andy Lutomirski had one last change request for v12 of the second
> > > patch in the series, specifically to replace the loop searching for
> > > the prefix with a memem, but the kernel does not have memmem.
> > > 
> > > Andy, are you ok with v12 as is, given that we don't have memmem ?
> > > 
> > > Assuming Andy is ok with v12 as is, then to merge this we need
> > > to probably wait for 5.6-rc1 and then have the x86/efi folks do
> > > an immutable branch with the first 2 patches of the series.
> > 
> > Did this every happen?  Or do I need to dump this all into my tree?
> 
> Ard has done a immutable branch with just the 2 patches:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/tag/?h=stable-shared-branch-for-driver-tree
> 
> I did not see any mails about this being pulled / merged, but I just
> checked and this has landed in the tip tree 10 days ago:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/include/linux/efi.h?h=efi/core
> 
> So if you merge the stable-shared-branch-for-driver-tree tag and then
> merge patches 3-8 of this series (or rather 4-8 since you already
> merged 3 IIRC) that would be great.

Ok, I've merged the above branch with just the two patches, and the rest
of yours now, sorry this took so long.

greg k-h
