Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20E34A5DAD
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 14:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbiBANuz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 08:50:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43292 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiBANuz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 08:50:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41A3B6159D;
        Tue,  1 Feb 2022 13:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01212C340EB;
        Tue,  1 Feb 2022 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643723454;
        bh=ldq7bhd25XbE5kFzQtjZQM2k7oQhrQBRZZi85C+Hwts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyE+zUDJSrEZ9Q9Ye/QchpMFVu3J7iYkahV+mZ0c7QZkEIvj2dBruxSK+UOLi5C/k
         ag0aaGZJOEII5ShkiuXppByTUhWhl6dz2R1JtCzomHDB+99o2Z3tUlJ7I/OJXNOTQ/
         YvTkN25TEpK6wGiq/MTQsMCRWlaNzHUKKXixfLD8=
Date:   Tue, 1 Feb 2022 14:50:52 +0100
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
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <Yfk6vEuZFtgtA+G+@kroah.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 01, 2022 at 12:44:08PM +0000, Dov Murik wrote:
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
> The patch series keeps the address of the EFI-provided memory for
> injected secrets, and exposes the secrets to userspace via securityfs
> using a new efi_secret kernel module.  The module is autoloaded (by the
> EFI driver) if the secret area is populated.
> 
> The first patch in EFI keeps the address of the secret area as passed in
> the EFI configuration table.  The second patch is a quirk fix for older
> firmwares didn't mark the secrets page as EFI_RESERVED_TYPE.  The third
> patch introduces the new efi_secret module that exposes the content of
> the secret entries as securityfs files, and allows clearing out secrets
> with a file unlink interface.  The fourth patch auto-loads the
> efi_secret module during startup if the injected secrets area is
> populated.  The last patch documents the data flow of confidential
> computing secret injection.
> 
> As a usage example, consider a guest performing computations on
> encrypted files.  The Guest Owner provides the decryption key (= secret)
> using the secret injection mechanism.  The guest application reads the
> secret from the efi_secret filesystem and proceeds to decrypt the files
> into memory and then performs the needed computations on the content.
> 
> In this example, the host can't read the files from the disk image
> because they are encrypted.  Host can't read the decryption key because
> it is passed using the secret injection mechanism (= secure channel).
> Host can't read the decrypted content from memory because it's a
> confidential (memory-encrypted) guest.
> 
> This has been tested with AMD SEV and SEV-ES guests, but the kernel side
> of handling the secret area has no SEV-specific dependencies, and
> therefore might be usable (perhaps with minor changes) for any
> confidential computing hardware that can publish the secret area via the
> standard EFI config table entry.
> 
> To enable this functionality, set CONFIG_EFI_SECRET=m when building the
> guest kernel.
> 
> Here is a simple example for usage of the efi_secret module in a guest
> to which an EFI secret area with 4 secrets was injected during launch:
> 
> # ls -la /sys/kernel/security/coco/efi_secret
> total 0
> drwxr-xr-x 2 root root 0 Jun 28 11:54 .
> drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
> -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
> -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
> -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
> -r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910
> 
> # xxd /sys/kernel/security/coco/efi_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
> 00000000: 7468 6573 652d 6172 652d 7468 652d 6b61  these-are-the-ka
> 00000010: 7461 2d73 6563 7265 7473 0001 0203 0405  ta-secrets......
> 00000020: 0607                                     ..
> 
> # rm /sys/kernel/security/coco/efi_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
> 
> # ls -la /sys/kernel/security/coco/efi_secret
> total 0
> drwxr-xr-x 2 root root 0 Jun 28 11:55 .
> drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
> -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
> -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
> -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2

Please see my comments on the powerpc version of this type of thing:
	https://lore.kernel.org/r/20220122005637.28199-1-nayna@linux.ibm.com


You all need to work together to come up with a unified place for this
and stop making it platform-specific.

Until then, we can't take this.

sorry,

greg k-h
