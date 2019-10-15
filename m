Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B869AD74EB
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2019 13:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfJOL3L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Oct 2019 07:29:11 -0400
Received: from ozlabs.org ([203.11.71.1]:49985 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfJOL3K (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Oct 2019 07:29:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46stVV0Fdwz9sPF;
        Tue, 15 Oct 2019 22:29:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1571138947;
        bh=eiKZbgxz3hog9R6u0egOQIZApWFVFlSoBtdgdYJ0/7M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pSwXFH/TU4AQEX6P4+z7GJgQHQpZIu4f600CBCxsdk7/jdhlUsPsBqITeS3a2SO38
         WgDfoyvdxP0b5cyDRcSlwQcdMBhxyjzC4jtXjoYkGrVyL1XSGjnQQ3EDN25UB/zKQy
         LhEvwLbABdpgn4rLBDMqSPiFjk9tIB6WIH1Mrxw82EaCdZx3jZWqRAKADTJFzeZKRS
         gfcqU5PIuXq34hKfsvjBN5EkdBuhcAYBthiH8enDclevZBoX+zkD0grkbpJyCs2m3n
         oqLoBOudkskUdlLWT61d3/Kt7z1h+wJGq6X1vrA70Eoq3f8Lb1YyHilhr8474UWPJq
         3RDu+U0k8sRow==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
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
Subject: Re: [PATCH v7 4/8] powerpc/ima: add measurement rules to ima arch specific policy
In-Reply-To: <1570497267-13672-5-git-send-email-nayna@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com> <1570497267-13672-5-git-send-email-nayna@linux.ibm.com>
Date:   Tue, 15 Oct 2019 22:29:02 +1100
Message-ID: <8736fuuu0x.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Nayna Jain <nayna@linux.ibm.com> writes:
> This patch adds the measurement rules to the arch specific policies on
> trusted boot enabled systems.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  arch/powerpc/kernel/ima_arch.c | 45 +++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
> index c22d82965eb4..88bfe4a1a9a5 100644
> --- a/arch/powerpc/kernel/ima_arch.c
> +++ b/arch/powerpc/kernel/ima_arch.c
> @@ -12,8 +12,19 @@ bool arch_ima_get_secureboot(void)
>  	return is_powerpc_os_secureboot_enabled();
>  }
>  
> -/* Defines IMA appraise rules for secureboot */
> +/*
> + * The "arch_rules" contains both the securebot and trustedboot rules for adding
> + * the kexec kernel image and kernel modules file hashes to the IMA measurement
> + * list and verifying the file signatures against known good values.
> + *
> + * The "appraise_type=imasig|modsig" option allows the good signature to be
> + * stored as an xattr or as an appended signature. The "template=ima-modsig"
> + * option includes the appended signature, when available, in the IMA
> + * measurement list.
> + */
>  static const char *const arch_rules[] = {
> +	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
> +	"measure func=MODULE_CHECK template=ima-modsig",
>  	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
>  #if !IS_ENABLED(CONFIG_MODULE_SIG_FORCE)
>  	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
> @@ -22,12 +33,40 @@ static const char *const arch_rules[] = {
>  };
>  
>  /*
> - * Returns the relevant IMA arch policies based on the system secureboot state.
> + * The "measure_rules" are enabled only on "trustedboot" enabled systems.
> + * These rules add the kexec kernel image and kernel modules file hashes to
> + * the IMA measurement list.
> + */
> +static const char *const measure_rules[] = {
> +	"measure func=KEXEC_KERNEL_CHECK",
> +	"measure func=MODULE_CHECK",

Why do these ones not have "template=ima-modsig" on the end?

> +	NULL
> +};
> +
> +/*
> + * Returns the relevant IMA arch policies based on the system secureboot
> + * and trustedboot state.
>   */
>  const char *const *arch_get_ima_policy(void)
>  {
> -	if (is_powerpc_os_secureboot_enabled())
> +	const char *const *rules;
> +	int offset = 0;
> +
> +	for (rules = arch_rules; *rules != NULL; rules++) {
> +		if (strncmp(*rules, "appraise", 8) == 0)
> +			break;
> +		offset++;
> +	}

This seems like kind of a hack, doesn't it? :)

What we really want is three sets of rules isn't it? But some of them
are shared between the different sets. But they just have to be flat
arrays of strings.

I think it would probably be cleaner to just use a #define for the
shared part of the rules, eg something like:

#ifdef CONFIG_MODULE_SIG_FORCE
#define APPRAISE_MODULE
#else
#define APPRAISE_MODULE \
	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
#endif

#define APPRAISE_KERNEL \
	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig"

#define MEASURE_KERNEL \
	"measure func=KEXEC_KERNEL_CHECK"

#define MEASURE_MODULE \
	"measure func=MODULE_CHECK"

#define APPEND_TEMPLATE_IMA_MODSIG		\
	" template=ima-modsig"

static const char *const secure_and_trusted_rules[] = {
	MEASURE_KERNEL APPEND_TEMPLATE_IMA_MODSIG,
	MEASURE_MODULE APPEND_TEMPLATE_IMA_MODSIG,
	APPRAISE_KERNEL,
	APPRAISE_MODULE
	NULL
};

static const char *const secure_rules[] = {
	APPRAISE_KERNEL,
	APPRAISE_MODULE
	NULL
};

static const char *const trusted_rules[] = {
	MEASURE_KERNEL,
	MEASURE_MODULE,
	NULL
};


> +
> +	if (is_powerpc_os_secureboot_enabled()
> +	    && is_powerpc_trustedboot_enabled())
>  		return arch_rules;
>  
> +	if (is_powerpc_os_secureboot_enabled())
> +		return arch_rules + offset;
> +
> +	if (is_powerpc_trustedboot_enabled())
> +		return measure_rules;

Those is_foo() routines print each time they're called don't they? So on
a system with only trusted boot I think that will print:

	secureboot mode disabled
	secureboot mode disabled
	trustedboot mode enabled

Which is a bit verbose :)

cheers
