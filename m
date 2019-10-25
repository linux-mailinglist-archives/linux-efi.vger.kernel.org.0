Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA2E5261
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2019 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505919AbfJYRcg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Oct 2019 13:32:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44696 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505918AbfJYRcg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Oct 2019 13:32:36 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 842D42010AC6;
        Fri, 25 Oct 2019 10:32:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 842D42010AC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572024755;
        bh=iHY0BIhRWj4FzzaW9EX78Sx4D3Z7kMMY/gOg/k9uflQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b4k6pMTqdO0i5AHVntdRqb4yi/qWfuDe297Y4pVfsE9IwlqDobrs/tLPUl+9ivN5b
         zC09JHzsrtGqzkxAf1TyRDOKYDtFhWkiwt8kKCn6n+8juEF+oUKh/Xre6rTa7V7oqx
         gXpCwzYTGfcDpRGf+rPMrMDWxHAqu7BtE/1yEZ+s=
Subject: Re: [PATCH v9 5/8] ima: make process_buffer_measurement() generic
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
 <20191024034717.70552-6-nayna@linux.ibm.com>
 <1ae56786-4d5c-ba8e-e30c-ced1e15ccb9c@linux.microsoft.com>
 <24cf44d5-a1f0-f59e-9884-c026b1ee2d3b@linux.vnet.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <8a97301a-0e25-2718-bd81-d778cb58e1d3@linux.microsoft.com>
Date:   Fri, 25 Oct 2019 10:32:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <24cf44d5-a1f0-f59e-9884-c026b1ee2d3b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 10/25/2019 10:24 AM, Nayna Jain wrote:
> 
> On 10/24/19 10:20 AM, Lakshmi Ramasubramanian wrote:
>> On 10/23/19 8:47 PM, Nayna Jain wrote:
>>
>> Hi Nayna,
>>
>>> +void process_buffer_measurement(const void *buf, int size,
>>> +                const char *eventname, enum ima_hooks func,
>>> +                int pcr)
>>>   {
>>>       int ret = 0;
>>>       struct ima_template_entry *entry = NULL;
>>
>>> +    if (func) {
>>> +        security_task_getsecid(current, &secid);
>>> +        action = ima_get_action(NULL, current_cred(), secid, 0, func,
>>> +                    &pcr, &template);
>>> +        if (!(action & IMA_MEASURE))
>>> +            return;
>>> +    }
>>
>> In your change set process_buffer_measurement is called with NONE for 
>> the parameter func. So ima_get_action (the above if block) will not be 
>> executed.
>>
>> Wouldn't it better to update ima_get_action (and related functions) to 
>> handle the ima policy (func param)?
> 
> 
> The idea is to use ima-buf template for the auxiliary measurement 
> record. The auxiliary measurement record is an additional record to the 
> one already created based on the existing policy. When func is passed as 
> NONE, it represents it is an additional record. I am not sure what you 
> mean by updating ima_get_action, it is already handling the ima policy.
>

I was referring to using "func" in process_buffer_measurement to 
determine ima action. In my opinion, process_buffer_measurement should 
be generic.

ima_get_action() should instead determine the required ima action, 
template, pcr, etc. based on "func" passed to it.

thanks,
  -lakshmi

