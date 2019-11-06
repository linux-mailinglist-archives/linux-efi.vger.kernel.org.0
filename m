Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A074FF0C7E
	for <lists+linux-efi@lfdr.de>; Wed,  6 Nov 2019 04:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbfKFDHg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Nov 2019 22:07:36 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41418 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387917AbfKFDHg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Nov 2019 22:07:36 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7FD8720B7192;
        Tue,  5 Nov 2019 19:07:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7FD8720B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573009655;
        bh=t+UX8ssq46MLjcIIguwgYQLFTqBQfN20laK/0LJnJMk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b5tCaED+1a14jU4yDtJu7DHZpYKeU9bgyFe7/6cyEQ9AMFm/YaUzZN3tW3ammEHen
         3XQnptYEN3Xga6e/24SucJMjEQ/auFnVvUJ7eTfQW8LMG1nQVLpe/LyWzLc6mUNPRR
         6zW1QXKCY3gFLNwPy+gFg1B+uGOBz9wacrmAJUWA=
Subject: Re: [PATCH v6 1/4] powerpc/powernv: Add OPAL API interface to access
 secure variable
To:     Eric Richter <erichte@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
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
        Oliver O'Halloran <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20191105082450.14746-1-erichte@linux.ibm.com>
 <20191105082450.14746-2-erichte@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <3d2e3792-e78e-95a8-623e-1ddcf3ccf241@linux.microsoft.com>
Date:   Tue, 5 Nov 2019 19:07:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191105082450.14746-2-erichte@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/5/2019 12:24 AM, Eric Richter wrote:

> From: Nayna Jain <nayna@linux.ibm.com>
> 
> The X.509 certificates trusted by the platform and required to secure boot
> the OS kernel are wrapped in secure variables, which are controlled by
> OPAL.
> 
> This patch adds firmware/kernel interface to read and write OPAL secure
> variables based on the unique key.

I feel splitting this patch into smaller set of changes would make it 
easier to review. For instance roughly as below:

  1, opal-api.h which adds the #defines  OPAL_SECVAR_ and the API signature.
  2, secvar.h then adds secvar_operations struct
  3, powerpc/kernel for the Interface definitions
  4, powernv/opal-secvar.c for the API implementations
  5, powernv/opal-call.c for the API calls
  6, powernv/opal.c for the secvar init calls.

> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 378e3997845a..c1f25a760eb1 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -211,7 +211,10 @@
>   #define OPAL_MPIPL_UPDATE			173
>   #define OPAL_MPIPL_REGISTER_TAG			174
>   #define OPAL_MPIPL_QUERY_TAG			175
> -#define OPAL_LAST				175
> +#define OPAL_SECVAR_GET				176
> +#define OPAL_SECVAR_GET_NEXT			177
> +#define OPAL_SECVAR_ENQUEUE_UPDATE		178
> +#define OPAL_LAST				178

Please fix the indentation for the #defines


> +static int opal_get_variable(const char *key, uint64_t ksize,
> +			     u8 *data, uint64_t *dsize)
> +{
> +	int rc;
> +
> +	if (!key || !dsize)
> +		return -EINVAL;
> +
> +	*dsize = cpu_to_be64(*dsize);
> +
> +	rc = opal_secvar_get(key, ksize, data, dsize);
> +
> +	*dsize = be64_to_cpu(*dsize);

Should the return status (rc) from opal_secvar_get be checked before 
attempting to do the conversion (be64_to_cpu)?

> +static int opal_get_next_variable(const char *key, uint64_t *keylen,
> +				  uint64_t keybufsize)
> +{
> +	int rc;
> +
> +	if (!key || !keylen)
> +		return -EINVAL;
> +
> +	*keylen = cpu_to_be64(*keylen);
> +
> +	rc = opal_secvar_get_next(key, keylen, keybufsize);
> +
> +	*keylen = be64_to_cpu(*keylen);

Same comment as above - should rc be checke before attempting to convert?

> +
> +	return opal_status_to_err(rc);
> +}
> +
> +static int opal_set_variable(const char *key, uint64_t ksize, u8 *data,
> +			     uint64_t dsize)
> +{
> +	int rc;
> +
> +	if (!key || !data)
> +		return -EINVAL;

Is the key and data received here from a trusted caller? If not, should 
there be some validation checks done here before enqueuing the data?

  -lakshmi

