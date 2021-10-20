Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CCD434AE0
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 14:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJTMOD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 08:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhJTMOC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Oct 2021 08:14:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B553611C6;
        Wed, 20 Oct 2021 12:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634731908;
        bh=/7MMHoYfZK7XLnUrE2PQLC1zWR1tC3EW2Hg6y4POQUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KnG137UxBUNq+tAFiuBegbFpBqPiWBkXFxzbh0G/hCORY/I1RUNpOzov3Yaun84At
         kkxE+Vr5ue7UsnvsRDv2JDt/bun8Kvz9SSjvfQ+xX/8L0e3KU9lg1VtUnMJgNO64PC
         ZluY515zwhcw+NufsIT5v0Z9fRRT9CDvvc7d9xVE=
Date:   Wed, 20 Oct 2021 14:11:46 +0200
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
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] efi/libstub: Copy confidential computing secret
 area
Message-ID: <YXAHgkcfwSCBeCbh@kroah.com>
References: <20211020061408.3447533-1-dovmurik@linux.ibm.com>
 <20211020061408.3447533-2-dovmurik@linux.ibm.com>
 <YW+5phDcxynJD2qy@kroah.com>
 <fb309e2686ca42df2c053cc1b060b1bc774fd3e7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb309e2686ca42df2c053cc1b060b1bc774fd3e7.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 20, 2021 at 08:00:28AM -0400, James Bottomley wrote:
> On Wed, 2021-10-20 at 08:39 +0200, Greg KH wrote:
> > On Wed, Oct 20, 2021 at 06:14:06AM +0000, Dov Murik wrote:
> [...]
> > > +	help
> > > +	  Copy memory reserved by EFI for Confidential Computing (coco)
> > > +	  injected secrets, if EFI exposes such a table entry.
> > 
> > Why would you want to "copy" secret memory?
> > 
> > This sounds really odd here, it sounds like you are opening up a
> > security hole.  Are you sure this is the correct text that everyone
> > on the "COCO" group agrees with?
> 
> The way this works is that EFI covers the secret area with a boot time
> handoff block, which means it gets destroyed as soon as
> ExitBootServices is called as a security measure ... if you do nothing
> the secret is shredded.  This means you need to make a copy of it
> before that happens if there are secrets that need to live beyond the
> EFI boot stub.

Ok, but "copy secrets" does sound really odd, so you all need a much
better description here, and hopefully somewhere else in Documentation/
to describe exactly what this new API is and is to be used for.

Otherwise I read this as "hey a backdoor to read the secrets I wasn't
supposed to be able to see!"

thanks,

greg k-h
