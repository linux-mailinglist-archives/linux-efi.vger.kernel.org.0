Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28CF3FF173
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 18:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242414AbhIBQdH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 12:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345905AbhIBQdA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 Sep 2021 12:33:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5C406023F;
        Thu,  2 Sep 2021 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630600321;
        bh=B9mcUFqJNGZAURjFxYwd81UPlQdY2dl8ve7nusbvJp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIvtGjmucVVCDn0Og/6GBqZQgKZ0dZAC3GKI+qze5/utAM5fXeF/fSf01VNcQyViL
         x5i9CS80x36maY4qAvas5xv9cl7hKuJ0isz/SNVRDu/jZiSfkzSmZ/wdCfzsn6SfbP
         JOqGe5jeqkco3/aa+hgMCsmV6hX+LlNbzQT5EKwY=
Date:   Thu, 2 Sep 2021 18:31:58 +0200
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
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Allow access to confidential computing secret area
 in SEV guests
Message-ID: <YTD8fkAfjutR8G/o@kroah.com>
References: <20210809190157.279332-1-dovmurik@linux.ibm.com>
 <YTDKUe8rXrr0Zika@kroah.com>
 <e6fb1d54605690cc1877d7140fc9346c22268111.camel@linux.ibm.com>
 <YTDoS5XycY3gO4MM@kroah.com>
 <6cb65cb3bd69ae69bde044f809525e478bdb8512.camel@linux.ibm.com>
 <YTD3U70FCkXzNMrF@kroah.com>
 <61212d923295203173b1a8c3c24b6dd19835c57e.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61212d923295203173b1a8c3c24b6dd19835c57e.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 02, 2021 at 09:19:13AM -0700, James Bottomley wrote:
> On Thu, 2021-09-02 at 18:09 +0200, Greg KH wrote:
> > On Thu, Sep 02, 2021 at 08:19:51AM -0700, James Bottomley wrote:
> > > On Thu, 2021-09-02 at 17:05 +0200, Greg KH wrote:
> > > > On Thu, Sep 02, 2021 at 07:35:10AM -0700, James Bottomley wrote:
> > > > > On Thu, 2021-09-02 at 14:57 +0200, Greg KH wrote:
> > > > > [...]
> > > > > > Wait, why are you using securityfs for this?
> > > > > > 
> > > > > > securityfs is for LSMs to use. 
> > > > > 
> > > > > No it isn't ... at least not exclusively; we use it for non LSM
> > > > > security purposes as well, like for the TPM BIOS log and for
> > > > > IMA.  What makes you think we should start restricting
> > > > > securityfs to LSMs only?  That's not been the policy up to now.
> > > > 
> > > > Well that was the original intent of the filesystem when it was
> > > > created, but I guess it's really up to the LSM maintainers now
> > > > what they want it for.
> > > > 
> > > > > >  If you want your own filesystem to play around with stuff
> > > > > > like this, great, write your own, it's only 200 lines or less
> > > > > > these days.  We used to do it all the time until people
> > > > > > realized they should just use sysfs for driver stuff.
> > > > > 
> > > > > This is a security purpose (injected key retrieval), so
> > > > > securityfs seems to be the best choice.  It's certainly
> > > > > possible to create a new filesystem, but I really think things
> > > > > with a security purpose should use securityfs so people know
> > > > > where to look for them.
> > > > 
> > > > knowing where to look should not be an issue, as that should be
> > > > documented in Documentation/ABI/ anyway, right?
> > > > 
> > > > It's just the overlap / overreach of using an existing filesystem
> > > > for things that don't seem to be LSM-related that feels odd to
> > > > me.
> > > > 
> > > > Why not just make a cocofs if those people want a filesystem
> > > > interface?
> > > > It's 200 lines or so these days, if not less, and that way you
> > > > only mount what you actually need for the system.
> > > 
> > > Secrets transfer is actually broader than confidential computing,
> > > although confidential computing is a first proposed use, so I think
> > > cocofs would be too narrow.
> > > 
> > > > Why force this into securityfs if it doesn't have to be?
> > > 
> > > It's not being forced.  Secrets transfer is a security function in
> > > the same way the bios log is.
> > 
> > Is the bios log in securityfs today?
> 
> Yes. It's under /sys/kernel/security/tpm0/  All the ima policy control
> and its log is under /sys/kernel/security/ima/  that's why I think
> declaring securityfs as being for anything security related is already
> our de facto (if not de jure) policy.
> 
> > Anyway, it's up to the securityfs maintainer (i.e. not me), but
> > personally, I think this should be a separate filesystem as that
> > would probably make things easier in the long run...
> 
> I know Al likes this business of loads of separate filesystems, but
> personally I'm not in favour.  For every one you do, you not only have
> to document it all,

Wait, why would you not have to document your new files no matter what?
That should not be an issue either way.

> you also have to find a preferred mount point that
> the distributions can agree on and also have them agree to enable the
> mount for,

You create that yourself, just like tracefs does, and set the standard
right away, not an issue.

> which often takes months of negotiation.

Enabling it does take time, which is good because if they do not think
it should be present because they do not want to use it, then it will
not be, which means either they do not need your new feature, or you
have not made it useful enough.

So again, not an issue.
And you can even mount it yourself from the kernel if you insist on it
always being present.

> Having fewer
> filesystems grouped by common purpose which have agreed mount points
> that distros actually mount seems a far easier approach to enablement.

The issue is that random things gets added to those filesystems,
exposing stuff that perhaps some systems do NOT want exposed to
userspace.  Making it explicit as to what they have to mount to get
access to that is a good thing because you have less of an "attack
surface" and all of that.

So again, this should not be an issue.  If coco stuff is so important
that people need it, then having them have to add it to their init
scripts just to mount the filesystem is not an issue as there are other
userspace components of all of this mess that they had to install
anyway.  Just make it part of the userspace tools that are going to be
accessing these files because you have to get those onto the systems no
matter what.

greg k-h
