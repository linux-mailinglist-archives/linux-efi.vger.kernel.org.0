Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2A1E3A27
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2019 19:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503843AbfJXRez (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Oct 2019 13:34:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57686 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503819AbfJXRey (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Oct 2019 13:34:54 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id E5AD02010AC3;
        Thu, 24 Oct 2019 10:34:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5AD02010AC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571938494;
        bh=QdSrXCYUwtpMpli7Gl4G6qgqXWpnd26Qx0Uoa9NFbl8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FlkyGU6IaKamoiEDN/toTRVHqvED/hfEVum2YK7OArrnh9QkY5P2UtdQfRsl4N0jy
         vkbhCfgVkApKl8t6C8jHxRVPcOjzEMNfQnMzzKFHRN8mkOOm7N5MND7q9f8dTr7dus
         ixO6+VaWTm+bZrwM3e4YGcc88FR8Wm50wtymCoyg=
Subject: Re: [PATCH v9 2/8] powerpc/ima: add support to initialize ima policy
 rules
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
 <20191024034717.70552-3-nayna@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <dd7e04fc-25e8-280f-b565-bdb031939655@linux.microsoft.com>
Date:   Thu, 24 Oct 2019 10:35:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191024034717.70552-3-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/23/2019 8:47 PM, Nayna Jain wrote:

> +/*
> + * The "secure_rules" are enabled only on "secureboot" enabled systems.
> + * These rules verify the file signatures against known good values.
> + * The "appraise_type=imasig|modsig" option allows the known good signature
> + * to be stored as an xattr or as an appended signature.
> + *
> + * To avoid duplicate signature verification as much as possible, the IMA
> + * policy rule for module appraisal is added only if CONFIG_MODULE_SIG_FORCE
> + * is not enabled.
> + */
> +static const char *const secure_rules[] = {
> +	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
> +#ifndef CONFIG_MODULE_SIG_FORCE
> +	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
> +#endif
> +	NULL
> +};

Is there any way to not use conditional compilation in the above array 
definition? Maybe define different functions to get "secure_rules" for 
when CONFIG_MODULE_SIG_FORCE is defined and when it is not defined.
Just a suggestion.

  -lakshmi
