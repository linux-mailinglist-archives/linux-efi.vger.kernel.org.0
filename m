Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9972D1A0F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 20:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgLGTyp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 14:54:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgLGTyo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Dec 2020 14:54:44 -0500
Date:   Mon, 7 Dec 2020 21:53:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607370844;
        bh=BdQC2xqiYbPynB6ee1sdspvA3uTspzSbKGlxef667To=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbxSe+Y/JdDEtvEzmtinEDS3lvUlkk8ZbniyyDKsnPBeNYiZjGeBQwY9I59c4NxFk
         v+6syZLGTWmP55ItOhK3KMVEHhOFnYu6vYJhz4XikpGFjJ6zFxqtrhizL8gMNy+cs9
         7rZFF2ZlqVeRNSXiF+jMYZPEwQcy8uvGzhjWOgZZH+9Pco+xh2oaqSivE8USm+ygTo
         QGA1K5R+mybGUTwhITOTadiNOwZp8JhnmZakqCD6TznNb4+oIQvM1ozdjalRxapshX
         +VISJ1RQnvrPgSG/v+qE8DwS0ufYFF7OOfJd6iQn9LU9uErqg9Hfi7TnBskMmlkUpl
         PH2gy5ASiwbpA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Subject: Re: [PATCH v2 07/17] driver core: Add fwnode_init()
Message-ID: <20201207195357.GF693271@unreal>
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-8-saravanak@google.com>
 <20201206072621.GA687065@unreal>
 <CAGETcx9L0f5HPgunTf_WRsr9yeaYK1Ku5ESzeb0A1pkn3Yy2aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9L0f5HPgunTf_WRsr9yeaYK1Ku5ESzeb0A1pkn3Yy2aw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 07, 2020 at 11:25:15AM -0800, Saravana Kannan wrote:
> On Sat, Dec 5, 2020 at 11:26 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Nov 20, 2020 at 06:02:22PM -0800, Saravana Kannan wrote:
> > > There are multiple locations in the kernel where a struct fwnode_handle
> > > is initialized. Add fwnode_init() so that we have one way of
> > > initializing a fwnode_handle.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/acpi/property.c         | 2 +-
> > >  drivers/acpi/scan.c             | 2 +-
> > >  drivers/base/swnode.c           | 2 +-
> > >  drivers/firmware/efi/efi-init.c | 8 ++++----
> > >  include/linux/fwnode.h          | 6 ++++++
> > >  include/linux/of.h              | 2 +-
> > >  kernel/irq/irqdomain.c          | 2 +-
> > >  7 files changed, 15 insertions(+), 9 deletions(-)
> >
> > In this series, I didn't find any extension of fwnode_init() to be it more
> > than simple assignment. This change looks to me like unnecessary churn and
> > obfuscation rather than improvement.
> >
> > "...ops = &...;" is pretty standard in the kernel to initialize ops
> > structures.
>
> Subsequent patches make fwnode_init() do more stuff.

But not in this series, right?

Thanks

>
> -Saravana
