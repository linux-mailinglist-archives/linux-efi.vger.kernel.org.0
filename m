Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7109E3FEFD2
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 17:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345707AbhIBPGu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 11:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234984AbhIBPGs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 Sep 2021 11:06:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 635D26108B;
        Thu,  2 Sep 2021 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630595150;
        bh=jPC3kdz5JKgIhlrA2cm66wzQSrTW00eesyq/cJjIgP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVgab2GXk4tPJkxwWhPBtJp2/t1ZBgllgVkDNuC8ZmFKnr3vk++R+EqSX7TxVMv5Q
         jtmI4RddhxcJY0vxhEHH07zyGoQOpMsKLrZtHs8cV1fmQBm3GzCj3WMouvH+hWpqMr
         fTGDGj+Jp7elGG+wepOuwH4cjICE7ZzCZs0O0QAM=
Date:   Thu, 2 Sep 2021 17:05:47 +0200
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
Message-ID: <YTDoS5XycY3gO4MM@kroah.com>
References: <20210809190157.279332-1-dovmurik@linux.ibm.com>
 <YTDKUe8rXrr0Zika@kroah.com>
 <e6fb1d54605690cc1877d7140fc9346c22268111.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6fb1d54605690cc1877d7140fc9346c22268111.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 02, 2021 at 07:35:10AM -0700, James Bottomley wrote:
> On Thu, 2021-09-02 at 14:57 +0200, Greg KH wrote:
> [...]
> > Wait, why are you using securityfs for this?
> > 
> > securityfs is for LSMs to use. 
> 
> No it isn't ... at least not exclusively; we use it for non LSM
> security purposes as well, like for the TPM BIOS log and for IMA.  What
> makes you think we should start restricting securityfs to LSMs only? 
> That's not been the policy up to now.

Well that was the original intent of the filesystem when it was created,
but I guess it's really up to the LSM maintainers now what they want it
for.

> >  If you want your own filesystem to play around with stuff like this,
> > great, write your own, it's only 200 lines or less these days.  We
> > used to do it all the time until people realized they should just use
> > sysfs for driver stuff.
> 
> This is a security purpose (injected key retrieval), so securityfs
> seems to be the best choice.  It's certainly possible to create a new
> filesystem, but I really think things with a security purpose should
> use securityfs so people know where to look for them.

knowing where to look should not be an issue, as that should be
documented in Documentation/ABI/ anyway, right?

It's just the overlap / overreach of using an existing filesystem for
things that don't seem to be LSM-related that feels odd to me.

Why not just make a cocofs if those people want a filesystem interface?
It's 200 lines or so these days, if not less, and that way you only
mount what you actually need for the system.

Why force this into securityfs if it doesn't have to be?

thanks,

greg k-h
