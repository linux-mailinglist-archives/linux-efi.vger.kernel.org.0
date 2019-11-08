Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBEC0F43B1
	for <lists+linux-efi@lfdr.de>; Fri,  8 Nov 2019 10:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbfKHJml (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Nov 2019 04:42:41 -0500
Received: from ozlabs.org ([203.11.71.1]:53119 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731436AbfKHJmj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Nov 2019 04:42:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 478b0W3jgtz9sP6;
        Fri,  8 Nov 2019 20:42:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1573206156;
        bh=HX/zf896+L+aLj5O52hjw0t0TJACu18gwzubsdQDKao=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fR/E8RyIIV9SH5jJ24k4CkSnV7QgtDW3LJ+kkvk99VO/lnDNUOeEMuzs+17FqtD9s
         f9aDOFogdkIoR66y2NBPqigmk+WXxeltzF0G18vpZNKTHgjj1tVXNfIl4qcwr49R+4
         KjvsjjfYuOPp1jNkkvlHTM308O3ZfX5yO6V74oyTLvNWwFqPkL1vDIlRqjih0EXEeZ
         /YnjCKOb7FacQDI7/ZRvygb/VyPh+EZRIvOhLR9gsJ9Jp8PPUWb//aUfqzafQDh4vo
         roR1lEI0zAvgko5ZtaCyObtNxgeQDkeADjto2j3KY+ZDFRFBaBnwMwY+aVCteqyxZ1
         JhwFXFnfFOOPw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Eric Richter <erichte@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v7 4/4] powerpc: load firmware trusted keys/hashes into kernel keyring
In-Reply-To: <20191107042205.13710-5-erichte@linux.ibm.com>
References: <20191107042205.13710-1-erichte@linux.ibm.com> <20191107042205.13710-5-erichte@linux.ibm.com>
Date:   Fri, 08 Nov 2019 20:42:26 +1100
Message-ID: <87eeyi4scd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Eric Richter <erichte@linux.ibm.com> writes:
> From: Nayna Jain <nayna@linux.ibm.com>
>
> The keys used to verify the Host OS kernel are managed by firmware as
> secure variables. This patch loads the verification keys into the .platform
> keyring and revocation hashes into .blacklist keyring. This enables
> verification and loading of the kernels signed by the boot time keys which
> are trusted by firmware.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Eric Richter <erichte@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig                          |  1 +
>  security/integrity/Kconfig                    |  8 ++
>  security/integrity/Makefile                   |  4 +-
>  .../integrity/platform_certs/load_powerpc.c   | 98 +++++++++++++++++++
>  4 files changed, 110 insertions(+), 1 deletion(-)
>  create mode 100644 security/integrity/platform_certs/load_powerpc.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index cabc091f3fe1..498967a5ef4e 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -939,6 +939,7 @@ config PPC_SECURE_BOOT
>  	bool
>  	depends on PPC_POWERNV
>  	depends on IMA_ARCH_POLICY
> +	select LOAD_PPC_KEYS

This gave me a warning:

WARNING: unmet direct dependencies detected for LOAD_PPC_KEYS
  Depends on [n]: INTEGRITY [=y] && INTEGRITY_PLATFORM_KEYRING [=n] && PPC_SECURE_BOOT [=y]
  Selected by [y]:
  - PPC_SECURE_BOOT [=y] && PPC_POWERNV [=y] && IMA_ARCH_POLICY [=y]

I think you should probably just drop the select ..

> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 0bae6adb63a9..26abee23e4e3 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -72,6 +72,14 @@ config LOAD_IPL_KEYS
>         depends on S390
>         def_bool y
>  
> +config LOAD_PPC_KEYS
> +	bool "Enable loading of platform and blacklisted keys for POWER"
> +	depends on INTEGRITY_PLATFORM_KEYRING
> +	depends on PPC_SECURE_BOOT
> +	help
> +	  Enable loading of keys to the .platform keyring and blacklisted
> +	  hashes to the .blacklist keyring for powerpc based platforms.

And instead make this default y, if you think it should be enabled by
default when its prerequisites are met.

cheers
