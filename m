Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE444A5E77
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 15:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbiBAOlZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 09:41:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48250 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbiBAOlZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 09:41:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2672FB82CCC;
        Tue,  1 Feb 2022 14:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19819C340EB;
        Tue,  1 Feb 2022 14:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643726482;
        bh=4sxxBUCUngbxSjMsWZ+Vhdr/PDT3NXWPXmrp4T/JV24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsViJyuTsNcR7cmH3MW9ScowqbBG6PK76wdZIFQnQv/jFd4F1DUATML5W8uxrUP3D
         5qYQ7V+/ybnm/5F4GYw4GOwAUmj8oytNQM/UihGDvZbzQ0y1pD0N191mvZ4c6ocQmx
         trc8KkrOshzAwcnNgbOVhAMTqSuMRq/4nODL2GzY=
Date:   Tue, 1 Feb 2022 15:41:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        dougmill@linux.vnet.ibm.com, gcwilson@linux.ibm.com,
        gjoyce@ibm.com, linuxppc-dev@lists.ozlabs.org, mjg59@srcf.ucam.org,
        mpe@ellerman.id.au, dja@axtens.net
Subject: Re: [PATCH v7 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <YflGkNwyI6LUSVVk@kroah.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <Yfk6vEuZFtgtA+G+@kroah.com>
 <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 01, 2022 at 09:24:50AM -0500, James Bottomley wrote:
> [cc's added]
> On Tue, 2022-02-01 at 14:50 +0100, Greg KH wrote:
> > On Tue, Feb 01, 2022 at 12:44:08PM +0000, Dov Murik wrote:
> [...]
> > > # ls -la /sys/kernel/security/coco/efi_secret
> > > total 0
> > > drwxr-xr-x 2 root root 0 Jun 28 11:55 .
> > > drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
> > > -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-
> > > 06879ce3da0b
> > > -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-
> > > d3a0b54312c6
> > > -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-
> > > ff17f78864d2
> > 
> > Please see my comments on the powerpc version of this type of thing:
> > 	
> > https://lore.kernel.org/r/20220122005637.28199-1-nayna@linux.ibm.com
> 
> If you want a debate, actually cc'ing the people on the other thread
> would have been a good start ...
> 
> For those added, this patch series is at:
> 
> https://lore.kernel.org/all/20220201124413.1093099-1-dovmurik@linux.ibm.com/

Thanks for adding everyone.

> > You all need to work together to come up with a unified place for
> > this and stop making it platform-specific.
> 
> I'm not entirely sure of that.  If you look at the differences between
> EFI variables and the COCO proposal: the former has an update API
> which, in the case of signed variables, is rather complex and a UC16
> content requirement.  The latter is binary data with read only/delete. 
> Plus each variable in EFI is described by a GUID, so having a directory
> of random guids, some of which behave like COCO secrets and some of
> which are EFI variables is going to be incredibly confusing (and also
> break all our current listing tools which seems somewhat undesirable).
> 
> So we could end up with 
> 
> <common path prefix>/efivar
> <common path prefix>/coco

The powerpc stuff is not efi.  But yes, that is messy here.  But why
doesn't the powerpc follow the coco standard?

> To achieve the separation, but I really don't see what this buys us. 
> Both filesystems would likely end up with different backends because of
> the semantic differences and we can easily start now in different
> places (effectively we've already done this for efi variables) and
> unify later if that is the chosen direction, so it doesn't look like a
> blocker.
> 
> > Until then, we can't take this.
> 
> I don't believe anyone was asking you to take it.

I was on the review list...

