Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8838434CEC
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 15:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJTOBo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 10:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhJTOBo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Oct 2021 10:01:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CACF61354;
        Wed, 20 Oct 2021 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634738370;
        bh=EogA4m8QcEPrdZgSxOG4zqctZRvv2RAgbCI5sSqQN6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8Zo6QDi6gTuq8flLTOs5+88WYCzw6dHMnFok+3MBmFzJ1ZT5yJLkUREELCYEfZ63
         FuppCEhDtToFOGkwKMC5CTAjEdZQsudcrkirqI0LOXYjtrdgNHc5UjVlSAEbbvuB47
         xVUr9zkn4RIbMRtfdChrESCuBkSVVUUZOcwT2Azk=
Date:   Wed, 20 Oct 2021 15:59:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     James Bottomley <jejb@linux.ibm.com>, linux-efi@vger.kernel.org,
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
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] efi/libstub: Copy confidential computing secret
 area
Message-ID: <YXAgvyZ9ZxPxJ3lp@kroah.com>
References: <20211020061408.3447533-1-dovmurik@linux.ibm.com>
 <20211020061408.3447533-2-dovmurik@linux.ibm.com>
 <YW+5phDcxynJD2qy@kroah.com>
 <fb309e2686ca42df2c053cc1b060b1bc774fd3e7.camel@linux.ibm.com>
 <YXAHgkcfwSCBeCbh@kroah.com>
 <bfa4872d-f64a-0559-1c5d-c5d1ae333eee@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfa4872d-f64a-0559-1c5d-c5d1ae333eee@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 20, 2021 at 03:52:49PM +0300, Dov Murik wrote:
> 
> 
> On 20/10/2021 15:11, Greg KH wrote:
> > On Wed, Oct 20, 2021 at 08:00:28AM -0400, James Bottomley wrote:
> >> On Wed, 2021-10-20 at 08:39 +0200, Greg KH wrote:
> >>> On Wed, Oct 20, 2021 at 06:14:06AM +0000, Dov Murik wrote:
> >> [...]
> >>>> +	help
> >>>> +	  Copy memory reserved by EFI for Confidential Computing (coco)
> >>>> +	  injected secrets, if EFI exposes such a table entry.
> >>>
> >>> Why would you want to "copy" secret memory?
> >>>
> >>> This sounds really odd here, it sounds like you are opening up a
> >>> security hole.  Are you sure this is the correct text that everyone
> >>> on the "COCO" group agrees with?
> >>
> >> The way this works is that EFI covers the secret area with a boot time
> >> handoff block, which means it gets destroyed as soon as
> >> ExitBootServices is called as a security measure ... if you do nothing
> >> the secret is shredded.  This means you need to make a copy of it
> >> before that happens if there are secrets that need to live beyond the
> >> EFI boot stub.
> > 
> > Ok, but "copy secrets" does sound really odd, so you all need a much
> > better description here, and hopefully somewhere else in Documentation/
> > to describe exactly what this new API is and is to be used for.
> > 
> 
> 
> So something like:
> 
> 
> config EFI_COCO_SECRET
> 	bool "Keep the EFI Confidential Computing secret area"
> 	depends on EFI
> 	help
> 	  Confidential Computing platforms (such as AMD SEV) allow for
> 	  secrets injection during guest VM launch.  The secrets are
> 	  placed in a designated EFI memory area.  EFI destorys
> 	  the confidential computing secret area when ExitBootServices
> 	  is called.

That last sentence does not make much sense to me, sorry.

> 	  In order to use the secrets in the kernel, the secret area
> 	  must be copied to kernel-reserved memory (before it is erased).
> 
> 	  If you say Y here, the EFI stub will copy the EFI secret area (if
> 	  available) and reserve it for use inside the kernel.  This will
> 	  allow the virt/coco/efi_secret module to access the secrets.

Really this is about getting that data out to userspace, right?  Should
you mention that here?

> and some new file like Documentation/security/coco/efi_secret.rst which
> describes this whole protocol (from secret injection at VM launch
> into an EFI page, through efistub and efi in linux, to the efi_secret
> module which exposes the secrets).

Yes, that would be good to have documented.

thanks,

greg k-h
