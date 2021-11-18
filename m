Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2FA455BA5
	for <lists+linux-efi@lfdr.de>; Thu, 18 Nov 2021 13:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbhKRMqR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 07:46:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344732AbhKRMqO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Nov 2021 07:46:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1057161A88;
        Thu, 18 Nov 2021 12:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637239392;
        bh=ISqhDxz5Iegi2xrEg2J4FJ7nmqrYT+ERaPMbSV7C1oU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RG/rQQai3M6LtztxSdQ+xNuV2jEPfnIQq9a20MVYXG05QFtHIdIo4mtThhVouat7J
         z3dTxZo/R5nHcCHF/WOIm8boZgF11ewho92DLceSoUsZPyMQHl4IHDQbm5Pij3mmiF
         lI4wyi+oQYp+8n71AtxeH+lpPWr+UEITiJU16vIU=
Date:   Thu, 18 Nov 2021 13:43:10 +0100
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
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] virt: Add efi_secret module to expose
 confidential computing secrets
Message-ID: <YZZKXowcApyC/CEF@kroah.com>
References: <20211118113359.642571-1-dovmurik@linux.ibm.com>
 <20211118113359.642571-4-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118113359.642571-4-dovmurik@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 18, 2021 at 11:33:58AM +0000, Dov Murik wrote:
> The new efi_secret module exposes the confidential computing (coco)
> EFI secret area via securityfs interface.
> 
> When the module is loaded (and securityfs is mounted, typically under
> /sys/kernel/security), a "coco/efi_secret" directory is created in
> securityfs.  In it, a file is created for each secret entry.  The name
> of each such file is the GUID of the secret entry, and its content is
> the secret data.
> 
> This allows applications running in a confidential computing setting to
> read secrets provided by the guest owner via a secure secret injection
> mechanism (such as AMD SEV's LAUNCH_SECRET command).
> 
> Removing (unlinking) files in the "coco/efi_secret" directory will zero
> out the secret in memory, and remove the filesystem entry.  If the
> module is removed and loaded again, that secret will not appear in the
> filesystem.
> 
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> ---
>  .../ABI/testing/securityfs-coco-efi_secret    |  50 +++
>  drivers/virt/Kconfig                          |   3 +
>  drivers/virt/Makefile                         |   1 +
>  drivers/virt/coco/efi_secret/Kconfig          |  11 +
>  drivers/virt/coco/efi_secret/Makefile         |   2 +
>  drivers/virt/coco/efi_secret/efi_secret.c     | 341 ++++++++++++++++++
>  6 files changed, 408 insertions(+)
>  create mode 100644 Documentation/ABI/testing/securityfs-coco-efi_secret
>  create mode 100644 drivers/virt/coco/efi_secret/Kconfig
>  create mode 100644 drivers/virt/coco/efi_secret/Makefile
>  create mode 100644 drivers/virt/coco/efi_secret/efi_secret.c
> 
> diff --git a/Documentation/ABI/testing/securityfs-coco-efi_secret b/Documentation/ABI/testing/securityfs-coco-efi_secret
> new file mode 100644
> index 000000000000..ae56976db1bc
> --- /dev/null
> +++ b/Documentation/ABI/testing/securityfs-coco-efi_secret
> @@ -0,0 +1,50 @@
> +What:		security/coco/efi_secret
> +Date:		October 2021
> +Contact:	Dov Murik <dovmurik@linux.ibm.com>
> +Description:
> +		Exposes confidential computing (coco) EFI secrets to
> +		userspace via securityfs.
> +
> +		EFI can declare memory area used by confidential computing
> +		platforms (such as AMD SEV and SEV-ES) for secret injection by
> +		the Guest Owner during VM's launch.  The secrets are encrypted
> +		by the Guest Owner and decrypted inside the trusted enclave,
> +		and therefore are not readable by the untrusted host.
> +
> +		The efi_secret module exposes the secrets to userspace.  Each
> +		secret appears as a file under <securityfs>/coco/efi_secret,
> +		where the filename is the GUID of the entry in the secrets
> +		table.
> +
> +		Two operations are supported for the files: read and unlink.
> +		Reading the file returns the content of secret entry.
> +		Unlinking the file overwrites the secret data with zeroes and
> +		removes the entry from the filesystem.  A secret cannot be read
> +		after it has been unlinked.
> +
> +		For example, listing the available secrets::
> +
> +		  # modprobe efi_secret
> +		  # ls -l /sys/kernel/security/coco/efi_secret
> +		  -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
> +		  -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
> +		  -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
> +		  -r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910
> +
> +		Reading the secret data by reading a file::
> +
> +		  # cat /sys/kernel/security/coco/efi_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
> +		  the-content-of-the-secret-data
> +
> +		Wiping a secret by unlinking a file::
> +
> +		  # rm /sys/kernel/security/coco/efi_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
> +		  # ls -l /sys/kernel/security/coco/efi_secret
> +		  -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
> +		  -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
> +		  -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
> +
> +		Note: The binary format of the secrets table injected by the
> +		Guest Owner is described in
> +		drivers/virt/coco/efi_secret/efi_secret.c under "Structure of
> +		the EFI secret area".
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 8061e8ef449f..fe7a6579b974 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -36,4 +36,7 @@ source "drivers/virt/vboxguest/Kconfig"
>  source "drivers/virt/nitro_enclaves/Kconfig"
>  
>  source "drivers/virt/acrn/Kconfig"
> +
> +source "drivers/virt/coco/efi_secret/Kconfig"
> +
>  endif
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index 3e272ea60cd9..efdb015783f9 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -8,3 +8,4 @@ obj-y				+= vboxguest/
>  
>  obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
>  obj-$(CONFIG_ACRN_HSM)		+= acrn/
> +obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
> diff --git a/drivers/virt/coco/efi_secret/Kconfig b/drivers/virt/coco/efi_secret/Kconfig
> new file mode 100644
> index 000000000000..a39a5a90a1e5
> --- /dev/null
> +++ b/drivers/virt/coco/efi_secret/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config EFI_SECRET
> +	tristate "EFI secret area securityfs support"
> +	depends on EFI
> +	select EFI_COCO_SECRET
> +	select SECURITYFS
> +	help
> +	  This is a driver for accessing the EFI secret area via securityfs.
> +
> +	  To compile this driver as a module, choose M here.
> +	  The module will be called efi_secret.


Shouldn't this module auto-load only if the efi secret area is present?

What is going to cause the module to be loaded by a distro if it does
not have some sort of way to tell userspace what resources it belongs
to?  Can you trigger off of a DMI or EFI attribute somehow for this?

Otherwise you are going to force distros to modify their init scripts
for this functionality, how is that going to happen?

thanks,

greg k-h
