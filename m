Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93421E523A
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2019 19:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409928AbfJYRZV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Oct 2019 13:25:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388862AbfJYRZU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Oct 2019 13:25:20 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PHGptb026689;
        Fri, 25 Oct 2019 13:24:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vv4b0t3rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 13:24:52 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9PHHnoQ029356;
        Fri, 25 Oct 2019 13:24:51 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vv4b0t3r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 13:24:51 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9PHNsFF009592;
        Fri, 25 Oct 2019 17:24:51 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 2vqt48a6nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 17:24:50 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PHOnL462587380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 17:24:49 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C49BC6059;
        Fri, 25 Oct 2019 17:24:49 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7DE4C6057;
        Fri, 25 Oct 2019 17:24:46 +0000 (GMT)
Received: from [9.85.155.79] (unknown [9.85.155.79])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 17:24:46 +0000 (GMT)
Subject: Re: [PATCH v9 5/8] ima: make process_buffer_measurement() generic
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
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
        "Oliver O'Halloran" <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
References: <20191024034717.70552-1-nayna@linux.ibm.com>
 <20191024034717.70552-6-nayna@linux.ibm.com>
 <1ae56786-4d5c-ba8e-e30c-ced1e15ccb9c@linux.microsoft.com>
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
Message-ID: <24cf44d5-a1f0-f59e-9884-c026b1ee2d3b@linux.vnet.ibm.com>
Date:   Fri, 25 Oct 2019 12:24:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1ae56786-4d5c-ba8e-e30c-ced1e15ccb9c@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250158
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 10/24/19 10:20 AM, Lakshmi Ramasubramanian wrote:
> On 10/23/19 8:47 PM, Nayna Jain wrote:
>
> Hi Nayna,
>
>> +void process_buffer_measurement(const void *buf, int size,
>> +                const char *eventname, enum ima_hooks func,
>> +                int pcr)
>>   {
>>       int ret = 0;
>>       struct ima_template_entry *entry = NULL;
>
>> +    if (func) {
>> +        security_task_getsecid(current, &secid);
>> +        action = ima_get_action(NULL, current_cred(), secid, 0, func,
>> +                    &pcr, &template);
>> +        if (!(action & IMA_MEASURE))
>> +            return;
>> +    }
>
> In your change set process_buffer_measurement is called with NONE for 
> the parameter func. So ima_get_action (the above if block) will not be 
> executed.
>
> Wouldn't it better to update ima_get_action (and related functions) to 
> handle the ima policy (func param)?


The idea is to use ima-buf template for the auxiliary measurement 
record. The auxiliary measurement record is an additional record to the 
one already created based on the existing policy. When func is passed as 
NONE, it represents it is an additional record. I am not sure what you 
mean by updating ima_get_action, it is already handling the ima policy.

Thanks & Regards,

     - Nayna

