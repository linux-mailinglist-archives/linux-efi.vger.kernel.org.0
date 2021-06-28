Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8211E3B691E
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jun 2021 21:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhF1TdI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Jun 2021 15:33:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42352 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbhF1TdI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Jun 2021 15:33:08 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1791B20325;
        Mon, 28 Jun 2021 19:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624908641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEQN+ccfOjcpFsKF9tjkkDsFaoGwhe01Beu6Uhltj9o=;
        b=KUVrjBJerwzMYPd+lZdMk1zvDrO5H78ZthMidfFr0lN4i2RwtVwO6lDpo/aIamAToJsEis
        55Lj0NFL5dkNHH8u+osiOfPEgte/+CrVniZFDX889a6eIHI0nE6/7UeGbzXje5DmgxXvdl
        2fN5r+zrsuPpOmNZGuw7hCzjbNhAxZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624908641;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEQN+ccfOjcpFsKF9tjkkDsFaoGwhe01Beu6Uhltj9o=;
        b=aC+0FI3oJVelbkw2MSiOs94AD5YXdDgLOP7S5XaDEIOP628vj+WaEPdz2scDT7de3adsoJ
        +K+fWbDwlm1jjXCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 03CC611906;
        Mon, 28 Jun 2021 19:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624908641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEQN+ccfOjcpFsKF9tjkkDsFaoGwhe01Beu6Uhltj9o=;
        b=KUVrjBJerwzMYPd+lZdMk1zvDrO5H78ZthMidfFr0lN4i2RwtVwO6lDpo/aIamAToJsEis
        55Lj0NFL5dkNHH8u+osiOfPEgte/+CrVniZFDX889a6eIHI0nE6/7UeGbzXje5DmgxXvdl
        2fN5r+zrsuPpOmNZGuw7hCzjbNhAxZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624908641;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEQN+ccfOjcpFsKF9tjkkDsFaoGwhe01Beu6Uhltj9o=;
        b=aC+0FI3oJVelbkw2MSiOs94AD5YXdDgLOP7S5XaDEIOP628vj+WaEPdz2scDT7de3adsoJ
        +K+fWbDwlm1jjXCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id xrVsO2Aj2mAZHwAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 28 Jun 2021 19:30:40 +0000
Date:   Mon, 28 Jun 2021 21:30:40 +0200
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
Subject: Re: [RFC PATCH v2 3/3] virt: Add sev_secret module to expose
 confidential computing secrets
Message-ID: <YNojYBIwk0xCHQ0v@zn.tnic>
References: <20210628183431.953934-1-dovmurik@linux.ibm.com>
 <20210628183431.953934-4-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210628183431.953934-4-dovmurik@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 28, 2021 at 06:34:31PM +0000, Dov Murik wrote:
> The new sev_secret module exposes the confidential computing secret area
> via securityfs interface.
> 
> When the module is loaded (and securityfs is mounted, typically under
> /sys/kernel/security), an "sev_secret" directory is created in
> securityfs.  In it, a file is created for each secret entry.  The name
> of each such file is the GUID of the secret entry, and its content is
> the secret data.
> 
> This allows applications running in a confidential computing setting to
> read secrets provided by the guest owner via a secure secret injection
> mechanism (such as AMD SEV's LAUNCH_SECRET command).
> 
> Removing (unlinking) files in the "sev_secret" directory will zero out
> the secret in memory, and remove the filesystem entry.  If the module
> is removed and loaded again, that secret will not appear in the
> filesystem.
> 
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> ---
>  drivers/virt/Kconfig                 |   2 +
>  drivers/virt/Makefile                |   1 +
>  drivers/virt/sev_secret/Kconfig      |  11 +
>  drivers/virt/sev_secret/Makefile     |   2 +
>  drivers/virt/sev_secret/sev_secret.c | 298 +++++++++++++++++++++++++++
>  5 files changed, 314 insertions(+)
>  create mode 100644 drivers/virt/sev_secret/Kconfig
>  create mode 100644 drivers/virt/sev_secret/Makefile
>  create mode 100644 drivers/virt/sev_secret/sev_secret.c

Same question here: maybe have 

drivers/virt/coco/

and put all coco guest stuff in there.

> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 8061e8ef449f..c222cc625891 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -36,4 +36,6 @@ source "drivers/virt/vboxguest/Kconfig"
>  source "drivers/virt/nitro_enclaves/Kconfig"
>  
>  source "drivers/virt/acrn/Kconfig"
> +
> +source "drivers/virt/sev_secret/Kconfig"
>  endif
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index 3e272ea60cd9..0765e5418d1d 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -8,3 +8,4 @@ obj-y				+= vboxguest/
>  
>  obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
>  obj-$(CONFIG_ACRN_HSM)		+= acrn/
> +obj-y				+= sev_secret/
> diff --git a/drivers/virt/sev_secret/Kconfig b/drivers/virt/sev_secret/Kconfig
> new file mode 100644
> index 000000000000..4505526b8ef1
> --- /dev/null
> +++ b/drivers/virt/sev_secret/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config AMD_SEV_SECRET_SECURITYFS
> +	tristate "AMD SEV secret area securityfs support"
> +	depends on EFI

That probably needs to depend on CONFIG_AMD_MEM_ENCRYPT - otherwise
what's the point for it.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
