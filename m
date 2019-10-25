Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B3CE52F1
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2019 20:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfJYSCr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Oct 2019 14:02:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55672 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731197AbfJYSCr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Oct 2019 14:02:47 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 35AE72010AC6;
        Fri, 25 Oct 2019 11:02:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35AE72010AC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572026566;
        bh=7hGCl+P0baIDKMMzceGB2joTvpQFYOW1rsl65AwaESg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=czTwe7iEXiYO6JkheRJPPNMnL5Cbg61vTN7/+dfgsvKoyQ7DzcAkTVmgEHaD44Y/h
         jbDjF2ZBpVUKnbsyoUyslQapQJhi9p/QuR0SQXCtdREc4TW2b9zURqy/JaFZ00xmBr
         UuMXyYCz38KvLS+eL4dyR4/GY0NDH+IiFMK2xe2E=
Subject: Re: [PATCH v9 2/8] powerpc/ima: add support to initialize ima policy
 rules
To:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
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
 <dd7e04fc-25e8-280f-b565-bdb031939655@linux.microsoft.com>
 <27dbe08e-5473-4dd0-d2ad-2df591e23f5e@linux.vnet.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <482b2f08-f810-6ed0-4b32-0d5e64246ece@linux.microsoft.com>
Date:   Fri, 25 Oct 2019 11:03:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <27dbe08e-5473-4dd0-d2ad-2df591e23f5e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/25/2019 10:02 AM, Nayna Jain wrote:

 >> Is there any way to not use conditional compilation in
 >> the above array definition? Maybe define different functions to get
 >> "secure_rules" for when CONFIG_MODULE_SIG_FORCE is defined and when
 >> it is not defined.
 >
 > How will you decide which function to be called ?

Define the array in the C file:

const char *const secure_rules_kernel_check[] = {
    "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
    NULL
};

const char *const secure_rules_kernel_module_check[] = {
    "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
    "appraise func=MODULE_CHECK appraise_type=imasig|modsig",
    NULL
};

And, in the header file :

extern const char *const secure_rules_kernel_check;
extern const char *const secure_rules_kernel_module_check;

#ifdef CONFIG_MODULE_SIG_FORCE
const char *secure_rules() { return secure_rules_kernel_check; }
#else
const char *secure_rules() { return secure_rules_kernel_module_check;}
#endif // #ifdef CONFIG_MODULE_SIG_FORCE

If you want to avoid duplication, secure_rules_kernel_check and 
secure_rules_kernel_module_check could be defined in separate C files 
and conditionally compiled (in Makefile).


I was just trying to suggest the guidelines given in
"Section 21) Conditional Compilation" in coding-style.rst.

It says:
Whenever possible don't use preprocessor conditionals (#ifdef, #if) in 
.c files;...

Feel free to do what you think is appropriate.

thanks,
  -lakshmi


