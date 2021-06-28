Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73A83B690F
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jun 2021 21:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhF1Ta6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Jun 2021 15:30:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42144 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhF1Ta4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Jun 2021 15:30:56 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 45A3320321;
        Mon, 28 Jun 2021 19:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624908509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spjOhj0RdTmIQg2aukZN3q0munQsuSA5Y7L7wCqfguI=;
        b=kum9qLfsUlboKei5qvWrTyknt6PtK1EN7QZexnJ1vuhznvjeAbpsjaNxH9g6T6F/bjHARF
        aIzGndtqvvW7YX5Z6EKHXBSP5A4QLQ1UgfdM9g6JJylddD4X5kBmEl2efNfrpiJd8KNVTh
        egFEkYklOK96OHfSBnrt9SqMWuYll7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624908509;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spjOhj0RdTmIQg2aukZN3q0munQsuSA5Y7L7wCqfguI=;
        b=lR6DRgFnjpYpWtf0FZBi3UndqvxL29rmrIlowjyCBmBg5zjNVuDgHkAhtlouhBwcROvBz6
        S01AVt54VGLmDVAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2F80B11906;
        Mon, 28 Jun 2021 19:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624908509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spjOhj0RdTmIQg2aukZN3q0munQsuSA5Y7L7wCqfguI=;
        b=kum9qLfsUlboKei5qvWrTyknt6PtK1EN7QZexnJ1vuhznvjeAbpsjaNxH9g6T6F/bjHARF
        aIzGndtqvvW7YX5Z6EKHXBSP5A4QLQ1UgfdM9g6JJylddD4X5kBmEl2efNfrpiJd8KNVTh
        egFEkYklOK96OHfSBnrt9SqMWuYll7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624908509;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spjOhj0RdTmIQg2aukZN3q0munQsuSA5Y7L7wCqfguI=;
        b=lR6DRgFnjpYpWtf0FZBi3UndqvxL29rmrIlowjyCBmBg5zjNVuDgHkAhtlouhBwcROvBz6
        S01AVt54VGLmDVAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id koyBCt0i2mA1HgAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 28 Jun 2021 19:28:29 +0000
Date:   Mon, 28 Jun 2021 21:28:09 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Laszlo Ersek <lersek@redhat.com>,
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
Subject: Re: [RFC PATCH v2 0/3] Allow access to confidential computing secret
 area
Message-ID: <YNoiydeow+ftvfYX@zn.tnic>
References: <20210628183431.953934-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210628183431.953934-1-dovmurik@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Just a couple of notes below:

On Mon, Jun 28, 2021 at 06:34:28PM +0000, Dov Murik wrote:
> Confidential computing hardware such as AMD SEV (Secure Encrypted
> Virtualization) allows guest owners to inject secrets into the VMs
> memory without the host/hypervisor being able to read them.  In SEV,
> secret injection is performed early in the VM launch process, before the
> guest starts running.
> 
> Support for secret injection is already available in OVMF (in its AmdSev
> package; see edk2 commit 01726b6d23d4 "OvmfPkg/AmdSev: Expose the Sev
> Secret area using a configuration table" [1]), but the secrets were not
> available in the guest kernel.
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
> This has been tested with AMD SEV guests, but the kernel side of
> handling the secret area has no SEV-specific dependencies, and therefore
> should be usable for any confidential computing hardware that can
> publish the secret area via the standard EFI config table entry.
> 
> Here is a simple example for usage of the sev_secret module in a guest to which
> secrets were injected during launch:

That's all fine and good but I miss the "why" in this explanation. I.e.,
a proper use case of a guest owner providing those sekrits to the guest
would be good.

> 
> # modprobe sev_secret
> # ls -la /sys/kernel/security/sev_secret/

So that sysfs URL becomes an ABI. Shouldn't this be:

/sys/kernel/security/coco/

instead which stands for "confidential computing" and contains all kinds
of protected guest things. TDX might wanna do something similar there,
for example.

> total 0
> drwxr-xr-x 2 root root 0 Jun 28 11:54 .
> drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
> -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
> -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
> -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
> -r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910
> 
> # xxd /sys/kernel/security/sev_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
> 00000000: 7468 6573 652d 6172 652d 7468 652d 6b61  these-are-the-ka
> 00000010: 7461 2d73 6563 7265 7473 0001 0203 0405  ta-secrets......
> 00000020: 0607                                     ..
> 
> # rm /sys/kernel/security/sev_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
> 
> # ls -la /sys/kernel/security/sev_secret/
> total 0
> drwxr-xr-x 2 root root 0 Jun 28 11:55 .
> drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
> -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
> -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
> -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
> 
> 
> [1] https://github.com/tianocore/edk2/commit/01726b6d23d4
> 
> v2 changes:
>  - Add unlink support in sev_secret securityfs.
> 
> 
> Dov Murik (3):
>   efi/libstub: Copy confidential computing secret area
>   efi: Reserve confidential computing secret area
>   virt: Add sev_secret module to expose confidential computing secrets
> 
>  drivers/firmware/efi/Makefile                 |   2 +-
>  drivers/firmware/efi/confidential-computing.c |  41 +++
>  drivers/firmware/efi/efi.c                    |   5 +
>  drivers/firmware/efi/libstub/Makefile         |   3 +-
>  .../efi/libstub/confidential-computing.c      |  68 ++++
>  drivers/firmware/efi/libstub/efi-stub.c       |   2 +
>  drivers/firmware/efi/libstub/efistub.h        |   2 +
>  drivers/firmware/efi/libstub/x86-stub.c       |   2 +
>  drivers/virt/Kconfig                          |   2 +
>  drivers/virt/Makefile                         |   1 +
>  drivers/virt/sev_secret/Kconfig               |  11 +
>  drivers/virt/sev_secret/Makefile              |   2 +
>  drivers/virt/sev_secret/sev_secret.c          | 298 ++++++++++++++++++
>  include/linux/efi.h                           |  11 +
>  14 files changed, 448 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/firmware/efi/confidential-computing.c
>  create mode 100644 drivers/firmware/efi/libstub/confidential-computing.c
>  create mode 100644 drivers/virt/sev_secret/Kconfig
>  create mode 100644 drivers/virt/sev_secret/Makefile
>  create mode 100644 drivers/virt/sev_secret/sev_secret.c

Those "confidential-computing.c" filenames are too long. I'd vote for
coco.c.

Same for your naming: efi_copy_confidential_computing_secret_area() -
that is a wow and doesn't look like kernel code to me. :)

Another example why it is too long:

+       {LINUX_EFI_CONFIDENTIAL_COMPUTING_SECRET_AREA_GUID,
+                                               &efi.confidential_computing_secret,
+                                                                       "ConfCompSecret"},

I'd do

	{ LINUX_EFI_COCO_SECRET_AREA_GUID, &efi.coco_secret, "ConfCompSecret" },


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
