Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846654A6C10
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 08:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244909AbiBBHFf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 02:05:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55722 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbiBBHF3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 02:05:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A17AB83023;
        Wed,  2 Feb 2022 07:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AF7C340EC;
        Wed,  2 Feb 2022 07:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643785527;
        bh=coZm+4It0SjWaIfb3t2MkJl7FPFYDrkHgtvlecwJN5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mVs87BvyssNJyznmo0e3HSuwEwBXAzALSzWcRcNheffVRi6Kf1JR4ut64f5BwbxRL
         0zuRUCPC31fUxEJf1CRFr7nm141jlrxB6se24fPrLHYhFx58Np6AE78JgAbusQ6sTQ
         FIz2pChVjifI/SZQpkCdf9dRaQKsmn9pnzG5MIBI=
Date:   Wed, 2 Feb 2022 08:05:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org,
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
        gjoyce@ibm.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        dja@axtens.net
Subject: Re: [PATCH v7 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <YfotMyQiQ66xfCOQ@kroah.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <Yfk6vEuZFtgtA+G+@kroah.com>
 <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
 <20220202040157.GA8019@srcf.ucam.org>
 <YfogOurPZb7+Yelo@kroah.com>
 <20220202065443.GA9249@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202065443.GA9249@srcf.ucam.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 02, 2022 at 06:54:43AM +0000, Matthew Garrett wrote:
> On Wed, Feb 02, 2022 at 07:10:02AM +0100, Greg KH wrote:
> > On Wed, Feb 02, 2022 at 04:01:57AM +0000, Matthew Garrett wrote:
> > > We're talking about things that have massively different semantics.
> > 
> > I see lots of different platforms trying to provide access to their
> > "secure" firmware data to userspace in different ways.  That feels to me
> > like they are the same thing that userspace would care about in a
> > unified way.
> 
> EFI variables are largely for the OS to provide information to the 
> firmware, while this patchset is to provide information from the 
> firmware to the OS. I don't see why we'd expect to use the same userland 
> tooling for both.

I totally agree, I'm not worried about EFI variables here, I don't know
why that came up.

> In the broader case - I don't think we *can* use the same userland
> tooling for everything. For example, the patches to add support for 
> manipulating the Power secure boot keys originally attempted to make it 
> look like efivars, but the underlying firmware semantics are 
> sufficiently different that even exposing the same kernel interface 
> wouldn't be a sufficient abstraction and userland would still need to 
> behave differently. Exposing an interface that looks consistent but 
> isn't is arguably worse for userland than exposing explicitly distinct 
> interfaces.

So what does userspace really need here?  Just the ability to find if
the platform has blobs that it cares about, and how to read/write them.

I see different platform patches trying to stick these blobs in
different locations and ways to access (securityfs, sysfs, char device
node), which seems crazy to me.  Why can't we at least pick one way to
access these to start with, and then have the filesystem layout be
platform-specific as needed, which will give the correct hints to
userspace as to what it needs to do here?

thanks,

greg k-h
