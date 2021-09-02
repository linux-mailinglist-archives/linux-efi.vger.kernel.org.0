Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A693FEE2D
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344481AbhIBM6y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 08:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234249AbhIBM6y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 Sep 2021 08:58:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD8AC60EBA;
        Thu,  2 Sep 2021 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630587476;
        bh=Bps1FaIxz5iNAoCtnYdnUEPVPlf7hRaEFB3v0KWO/ts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwGTRJ7r6NQQRm+VL1BKDs8+rxJnY0VmZPsqJG2vp5+0E5u6Hc5/fCNbzpcQwMsVH
         4WfHNWeYCNrh0WAUlQGrWpyU1b+10KjxETY3Yxd3j1YxblND4YI8qLzo43o+i0IjcO
         G+ryL1YDtkydujh5SJvmsQKcxKxA+kp5jKRupNLE=
Date:   Thu, 2 Sep 2021 14:57:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Allow access to confidential computing secret area
 in SEV guests
Message-ID: <YTDKUe8rXrr0Zika@kroah.com>
References: <20210809190157.279332-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809190157.279332-1-dovmurik@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 09, 2021 at 07:01:54PM +0000, Dov Murik wrote:
> Confidential computing (coco) hardware such as AMD SEV (Secure Encrypted
> Virtualization) allows guest owners to inject secrets into the VMs
> memory without the host/hypervisor being able to read them.  In SEV,
> secret injection is performed early in the VM launch process, before the
> guest starts running.
> 
> OVMF already reserves designated area for secret injection (in its
> AmdSev package; see edk2 commit 01726b6d23d4 "OvmfPkg/AmdSev: Expose the
> Sev Secret area using a configuration table" [1]), but the secrets were
> not available in the guest kernel.
> 
> The patch series copies the secrets from the EFI-provided memory to
> kernel reserved memory, and optionally exposes them to userspace via
> securityfs using a new sev_secret kernel module.
> 
> The first patch in efi/libstub copies the secret area from the EFI
> memory to specially allocated memory; the second patch reserves that
> memory block; and the third patch introduces the new sev_secret module
> that exposes the content of the secret entries as securityfs files, and
> allows clearing out secrets with a file unlink interface.
> 
> As a usage example, consider a guest performing computations on
> encrypted files.  The Guest Owner provides the decryption key (= secret)
> using the secret injection mechanism.  The guest application reads the
> secret from the sev_secret filesystem and proceeds to decrypt the files
> into memory and then performs the needed computations on the content.
> 
> In this example, the host can't read the files from the disk image
> because they are encrypted.  Host can't read the decryption key because
> it is passed using the secret injection mechanism (= secure channel).
> Host can't read the decrypted content from memory because it's a
> confidential (memory-encrypted) guest.
> 
> This has been tested with AMD SEV guests, but the kernel side of
> handling the secret area has no SEV-specific dependencies, and therefore
> might be usable (perhaps with minor changes) for any confidential
> computing hardware that can publish the secret area via the standard EFI
> config table entry.
> 
> Here is a simple example for usage of the sev_secret module in a guest
> to which a secret are with 4 secrets was injected during launch:
> 
> # modprobe sev_secret
> # ls -la /sys/kernel/security/coco/sev_secret


Wait, why are you using securityfs for this?

securityfs is for LSMs to use.  If you want your own filesystem to play
around with stuff like this, great, write your own, it's only 200 lines
or less these days.  We used to do it all the time until people realized
they should just use sysfs for driver stuff.

But this isn't a driver, so sure, add your own virtual filesystem, mount
it somewhere and away you go, no messing around with securityfs, right?

thanks,

greg k-h
