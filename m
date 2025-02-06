Return-Path: <linux-efi+bounces-2768-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EBEA2B321
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 21:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BE6166090
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 20:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C1D1CEAC3;
	Thu,  6 Feb 2025 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxx9enKx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D852B136352;
	Thu,  6 Feb 2025 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738872801; cv=none; b=AFjeYBOb9NePRPiNKx0fkvBHbvsuDFg6eUgLnvVpACcLD58bss6wgcZHYyGKVmPmQmluK/wdwtY/oLT4cnDqPvIUsvhDUOB0lwjk5cwzLkUhmwfVPDAsb1n9u/gI3UiY94g6gf4M0ebpsH/Fvy242+MfOrU6iZ0Dl+UUqqe2WbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738872801; c=relaxed/simple;
	bh=U78ohRtvWW4LXD8QwA9JOGrsvbfL0MT5zsKtYl0AGYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz+iwVte8J57wN9/4yneM196Mv4ZVde7N0FNa7lj8GmhuIPhwJX56Opksz51jVoCeoS/sOgWCMtoCz/8Q2RMw7b1LgZ03hZfpZkKlRzMQk+zc4fwkQ+mKMX1SOfne24rXDvGprCl8dIeuNTFmOFwyVs6nTsWOZJaFLgBreVZfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxx9enKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66C1C4CEDD;
	Thu,  6 Feb 2025 20:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738872800;
	bh=U78ohRtvWW4LXD8QwA9JOGrsvbfL0MT5zsKtYl0AGYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nxx9enKxZtm0pLVEhcpuBWqfJ6YGeLl4MK4zdg8ThwI+lHlEkl0rY43l2DP09L9ay
	 blOz8FTptgbE5kzYdgd4xgqzjdvldNhXy/Xl0I4UJUSQOZ6jPrLti40Rv3G3dXAWJT
	 /ILtpSJH7+gJqapfheRRBTwiHJdtBjc3NXpA9SagckHE1ERx9eOF7B9tjEBPuikVf8
	 7PKRHwIUdTF3F1iaIA5ECSHI0xk5x/tv2hIXyYvBOqFrHvZ7LYTJ94HO+lJovClB34
	 4hPPb6TwqhpCpMuBBobtzrg22geO46U5Kygl7QTmVxaZ1kdWHdjLTHIeUYk/5125Tw
	 v2XvfcRJZlCPw==
Date: Thu, 6 Feb 2025 22:13:15 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: linux-security-module@vger.kernel.org, dhowells@redhat.com,
	dwmw2@infradead.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, ardb@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	mic@digikod.net, casey@schaufler-ca.com, stefanb@linux.ibm.com,
	ebiggers@kernel.org, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH v3 07/13] keys: Add ability to track intended usage
 of the public key
Message-ID: <Z6UU7anXtW43AhNR@kernel.org>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-8-eric.snowberg@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017155516.2582369-8-eric.snowberg@oracle.com>

On Thu, Oct 17, 2024 at 09:55:10AM -0600, Eric Snowberg wrote:
> Add two new fields in public_key_signature to track the intended usage of
> the signature.  Also add a flag for the revocation pass.  During signature
> validation, two verifications can take place for the same signature.  One
> to see if it verifies against something on the .blacklist keyring and
> the other to see if it verifies against the supplied keyring. The flag
> is used to determine which stage the verification is in.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Mimi, was this the patch set you asked to look at while ago?</offtopic>

This patch adds PKS_REVOCATION_PASS and REVOCATION_SET. It would be
nice to put in simple terms how they are used in down to eart terms.

> ---
>  certs/blacklist.c                     |  3 +++
>  crypto/asymmetric_keys/pkcs7_trust.c  | 20 ++++++++++++++++++++
>  crypto/asymmetric_keys/pkcs7_verify.c |  4 ++++
>  include/crypto/pkcs7.h                |  3 +++
>  include/crypto/public_key.h           |  4 ++++
>  5 files changed, 34 insertions(+)
> 
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 675dd7a8f07a..dd34e56a6362 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -17,6 +17,7 @@
>  #include <linux/uidgid.h>
>  #include <keys/asymmetric-type.h>
>  #include <keys/system_keyring.h>
> +#include <crypto/public_key.h>
>  #include "blacklist.h"
>  
>  /*
> @@ -289,7 +290,9 @@ int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
>  {
>  	int ret;
>  
> +	pkcs7_set_usage_flag(pkcs7, PKS_REVOCATION_PASS);
>  	ret = pkcs7_validate_trust(pkcs7, blacklist_keyring);
> +	pkcs7_clear_usage_flag(pkcs7, PKS_REVOCATION_PASS);
>  
>  	if (ret == 0)
>  		return -EKEYREJECTED;
> diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
> index 9a87c34ed173..64d70eb68864 100644
> --- a/crypto/asymmetric_keys/pkcs7_trust.c
> +++ b/crypto/asymmetric_keys/pkcs7_trust.c
> @@ -131,6 +131,26 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
>  	return 0;
>  }
>  
> +void pkcs7_clear_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage)
> +{
> +	struct pkcs7_signed_info *sinfo;
> +
> +	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
> +		if (sinfo->sig)
> +			clear_bit(usage, &sinfo->sig->usage_flags);
> +	}
> +}
> +
> +void pkcs7_set_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage)
> +{
> +	struct pkcs7_signed_info *sinfo;
> +
> +	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
> +		if (sinfo->sig)
> +			set_bit(usage, &sinfo->sig->usage_flags);
> +	}
> +}
> +
>  /**
>   * pkcs7_validate_trust - Validate PKCS#7 trust chain
>   * @pkcs7: The PKCS#7 certificate to validate
> diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
> index 1dc80e68ce96..44b8bd0ad4d8 100644
> --- a/crypto/asymmetric_keys/pkcs7_verify.c
> +++ b/crypto/asymmetric_keys/pkcs7_verify.c
> @@ -455,6 +455,10 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
>  			return ret;
>  		}
>  		actual_ret = 0;
> +		if (sinfo->sig) {
> +			sinfo->sig->usage = usage;
> +			set_bit(PKS_USAGE_SET, &sinfo->sig->usage_flags);
> +		}
>  	}
>  
>  	kleave(" = %d", actual_ret);
> diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
> index 38ec7f5f9041..6c3c9061b118 100644
> --- a/include/crypto/pkcs7.h
> +++ b/include/crypto/pkcs7.h
> @@ -32,6 +32,9 @@ extern int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
>  extern int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
>  				struct key *trust_keyring);
>  
> +extern void pkcs7_set_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage);
> +extern void pkcs7_clear_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage);
> +
>  /*
>   * pkcs7_verify.c
>   */
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index b7f308977c84..394022b5d856 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -49,6 +49,10 @@ struct public_key_signature {
>  	const char *pkey_algo;
>  	const char *hash_algo;
>  	const char *encoding;
> +	u32 usage;		/* Intended usage */

I'd would not size encode this but instead use "unsigned int".

> +	unsigned long usage_flags;

It would be less convoluting if this was just "flags". Now this leaves
to wonder what it is encoded for. E.g. for ioctl API one doees it for
the API to be size agnostic between 32/64-bit kernels.

> +#define PKS_USAGE_SET		0
> +#define PKS_REVOCATION_PASS	1
>  };

I'd add these before the struct and:

/* ... */
#define PKS_USAGE_SET		0

/* ... */
#define PKS_REVOCATION_PASS	1

>  
>  extern void public_key_signature_free(struct public_key_signature *sig);
> -- 
> 2.45.0
> 

BR, Jarkko

