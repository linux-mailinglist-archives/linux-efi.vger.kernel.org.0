Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72FFDEB600
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 18:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfJaRWN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Oct 2019 13:22:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34652 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfJaRWN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Oct 2019 13:22:13 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8794120B7192;
        Thu, 31 Oct 2019 10:22:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8794120B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572542532;
        bh=lGGAmFcY9SA4jmgoRVD92VXxiStVLCF3ODqAcpuQBN8=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=r9G79qhHEiU1XZa3cy6omxvf9PHpey4azvnm8fkhQ56IbemOVR4aMas5KpQ74vrGa
         gN/hYNlyYLqn7foHZF33hQ/GhuwMoTRHFUKFGTGSFa5ns1Sih4BTJEnPqkV8xR09Qg
         2BW81Ycq2VA8LtG28wfkvkEdAJjDAEPHTQWi2Low=
Subject: Re: [PATCH v10 5/9] ima: make process_buffer_measurement() generic
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
 <1572492694-6520-6-git-send-email-zohar@linux.ibm.com>
 <de6077ad-6d45-ef99-3ba7-79b3c48ae944@linux.microsoft.com>
Message-ID: <cadb8196-6bfb-2832-229f-24f67befdf78@linux.microsoft.com>
Date:   Thu, 31 Oct 2019 10:22:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <de6077ad-6d45-ef99-3ba7-79b3c48ae944@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/31/19 10:02 AM, Lakshmi Ramasubramanian wrote:

> On 10/30/19 8:31 PM, Mimi Zohar wrote:
> 
>>   void ima_kexec_cmdline(const void *buf, int size)
>>   {
>> -    u32 secid;
>> -
>> -    if (buf && size != 0) {
>> -        security_task_getsecid(current, &secid);
>> +    if (buf && size != 0)
> 
> Open brace { is missing in the above if statement.

My mistake -
I now see that the braces {} have been removed in the if statement since 
there is only line body  the call to process_buffer_measurement()

  -lakshmi

> 
>>           process_buffer_measurement(buf, size, "kexec-cmdline",
>> -                       current_cred(), secid);
>> -    }
>> +                       KEXEC_CMDLINE, 0);
>>   }
> 
>   -lakshmi

