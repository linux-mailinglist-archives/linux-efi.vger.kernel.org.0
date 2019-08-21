Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C97B98082
	for <lists+linux-efi@lfdr.de>; Wed, 21 Aug 2019 18:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfHUQqo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Aug 2019 12:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfHUQqo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 21 Aug 2019 12:46:44 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3487D22D6D;
        Wed, 21 Aug 2019 16:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566406003;
        bh=WQ2BlRv9mAl/kq+zQd+AH1qq87Y+Uvy3hDKIZvT8V28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+bfxgzitOAgmD3JoQz1FwTEvVsSra+bN8CblJi8UOvJ1nxyg0FOHGtPtAo758uIN
         b0c1KihRa1iKO2CDB3W4YkzKzYugI9s0tXhUxYuWu8tkx5bHWcqAyWfxUaerqSwdWL
         DwkJKMGD+XsH0HINst1IbsxbD8j3b5Ykc9ZEMbqg=
Date:   Wed, 21 Aug 2019 09:32:24 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v2 4/4] powerpc: load firmware trusted keys into kernel
 keyring
Message-ID: <20190821163224.GC28571@kroah.com>
References: <1566400103-18201-1-git-send-email-nayna@linux.ibm.com>
 <1566400103-18201-5-git-send-email-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566400103-18201-5-git-send-email-nayna@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 21, 2019 at 11:08:23AM -0400, Nayna Jain wrote:
> The keys used to verify the Host OS kernel are managed by OPAL as secure
> variables. This patch loads the verification keys into the .platform
> keyring and revocation keys into .blacklist keyring. This enables
> verification and loading of the kernels signed by the boot time keys which
> are trusted by firmware.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  security/integrity/Kconfig                    |  9 ++
>  security/integrity/Makefile                   |  3 +
>  .../integrity/platform_certs/load_powerpc.c   | 94 +++++++++++++++++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 security/integrity/platform_certs/load_powerpc.c
> 
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 0bae6adb63a9..2b4109c157e2 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -72,6 +72,15 @@ config LOAD_IPL_KEYS
>         depends on S390
>         def_bool y
>  
> +config LOAD_PPC_KEYS
> +	bool "Enable loading of platform and revocation keys for POWER"
> +	depends on INTEGRITY_PLATFORM_KEYRING
> +	depends on PPC_SECURE_BOOT
> +	def_bool y

def_bool y only for things that the system will not boot if it is not
enabled because you added a new feature.  Otherwise just do not set the
default.

> +	help
> +	  Enable loading of db keys to the .platform keyring and dbx keys to
> +	  the .blacklist keyring for powerpc based platforms.
> +
>  config INTEGRITY_AUDIT
>  	bool "Enables integrity auditing support "
>  	depends on AUDIT
> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> index 525bf1d6e0db..9eeb6b053de3 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -14,6 +14,9 @@ integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
>  				      platform_certs/load_uefi.o \
>  				      platform_certs/keyring_handler.o
>  integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
> +integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
> +					 platform_certs/load_powerpc.o \
> +					 platform_certs/keyring_handler.o
>  $(obj)/load_uefi.o: KBUILD_CFLAGS += -fshort-wchar
  
>  subdir-$(CONFIG_IMA)			+= ima
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
> new file mode 100644
> index 000000000000..f4d869171062
> --- /dev/null
> +++ b/security/integrity/platform_certs/load_powerpc.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Nayna Jain <nayna@linux.ibm.com>
> + *
> + * load_powernv.c

That's not the name of this file :(

And the perfect example of why you NEVER have the name of the file in
the file itself, as it's not needed and easy to get wrong :)

thanks,

greg k-h
