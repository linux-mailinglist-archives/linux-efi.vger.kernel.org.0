Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D597E3A5A
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2019 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392772AbfJXRsD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Oct 2019 13:48:03 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34088 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391933AbfJXRsC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Oct 2019 13:48:02 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id BDA842007698;
        Thu, 24 Oct 2019 10:48:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BDA842007698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571939281;
        bh=3ZUalX6KkoUAF5B6PB7Omcj6z9c3JtgzJCEvYAwd0VY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NmpVP5wJwINzCT0SPLjmqinpkGdSwyezoHpWRuvlMuBoj9iE7RB28lUD40Bbxfjey
         ekY0mojRGuFy3P8GrrjWA9dKAcBB4rHMFXuK7nh/PpQdPkp4tcss7tqrIo+VXeYYry
         tOfu2KguYoTByJZvD24zDoXytbjBV/MhtxKq9PlQ=
Subject: Re: [PATCH v9 7/8] ima: check against blacklisted hashes for files
 with modsig
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
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
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
References: <20191024034717.70552-1-nayna@linux.ibm.com>
 <20191024034717.70552-8-nayna@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <8e6dde58-17c2-a834-9ec3-1271b4ffd3a8@linux.microsoft.com>
Date:   Thu, 24 Oct 2019 10:48:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191024034717.70552-8-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/23/2019 8:47 PM, Nayna Jain wrote:

> +/*
> + * ima_check_blacklist - determine if the binary is blacklisted.
> + *
> + * Add the hash of the blacklisted binary to the measurement list, based
> + * on policy.
> + *
> + * Returns -EPERM if the hash is blacklisted.
> + */
> +int ima_check_blacklist(struct integrity_iint_cache *iint,
> +			const struct modsig *modsig, int pcr)
> +{
> +	enum hash_algo hash_algo;
> +	const u8 *digest = NULL;
> +	u32 digestsize = 0;
> +	int rc = 0;
> +
> +	if (!(iint->flags & IMA_CHECK_BLACKLIST))
> +		return 0;
> +
> +	if (iint->flags & IMA_MODSIG_ALLOWED && modsig) {
> +		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
> +
> +		rc = is_binary_blacklisted(digest, digestsize);
> +		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
> +			process_buffer_measurement(digest, digestsize,
> +						   "blacklisted-hash", NONE,
> +						   pcr);
> +	}

The enum value "NONE" is being passed to process_buffer_measurement to 
indicate that the check for required action based on ima policy is 
already done by ima_check_blacklist. Not sure, but this can cause 
confusion in the future when someone updates process_buffer_measurement.

Would it instead be better to add another parameter to 
process_buffer_measurement to indicate the above condition?

  -lakshmi
