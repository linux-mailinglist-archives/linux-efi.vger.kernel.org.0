Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29992A8FA0
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 07:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgKFGpI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Nov 2020 01:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgKFGpH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 6 Nov 2020 01:45:07 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3532206B2;
        Fri,  6 Nov 2020 06:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604645106;
        bh=gSrHcJPj/8i6uoEotdwklqj12Wa4bQLC0DC3nlOvvX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fqCwGQQooVimXHzYmO7cAz4NdXlOMrQUsSVT8WS0kLlV7zYpTh5L6yALgqgkVEIir
         wqFoj8Rwnf5YtDUNtkRONC9AeT5Q8ce1vHaVwdlmxhbEwaznloYSfrrVD2txQBfElX
         rGYohEflm6ap2RJAX2b6h39mD4p2ez8fJ6vew7VU=
Date:   Fri, 6 Nov 2020 07:45:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Android Kernel Team <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 16/18] efi: Update implementation of add_links() to
 create fwnode links
Message-ID: <20201106064503.GB697514@kroah.com>
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-17-saravanak@google.com>
 <20201105094318.GF3439341@kroah.com>
 <CAGETcx_Kh32AjVoUB3uiYBRhB+24JrceTp+HxG6vK6Ks=-e26w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_Kh32AjVoUB3uiYBRhB+24JrceTp+HxG6vK6Ks=-e26w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 05, 2020 at 03:27:52PM -0800, Saravana Kannan wrote:
> On Thu, Nov 5, 2020 at 1:42 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 04, 2020 at 03:23:53PM -0800, Saravana Kannan wrote:
> > > The semantics of add_links() has changed from creating device link
> > > between devices to creating fwnode links between fwnodes. So, update the
> > > implementation of add_links() to match the new semantics.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/firmware/efi/efi-init.c | 23 ++---------------------
> > >  1 file changed, 2 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> > > index b148f1459fb3..c0c3d4c3837a 100644
> > > --- a/drivers/firmware/efi/efi-init.c
> > > +++ b/drivers/firmware/efi/efi-init.c
> > > @@ -316,11 +316,10 @@ static struct device_node *find_pci_overlap_node(void)
> > >   * resource reservation conflict on the memory window that the efifb
> > >   * framebuffer steals from the PCIe host bridge.
> > >   */
> > > -static int efifb_add_links(const struct fwnode_handle *fwnode,
> > > +static int efifb_add_links(struct fwnode_handle *fwnode,
> > >                          struct device *dev)
> >
> > So you are fixing the build warning you added a few patches ago here?
> > Please fix up the function signatures when you made that change, not
> > here later on.
> 
> I'm trying not to have a mega patcht that changes a lot of code.
> 
> I guess I can drop this "const" diff from this patch and then merge it
> with the earlier patch that removes the const. But still leave the
> rest of the changes in this patch as is. Does that work for you?

Yes, that's fine, you just can't add build warnings along the way.

thanks,

greg k-h
