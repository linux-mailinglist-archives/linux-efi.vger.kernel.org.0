Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2798FC4079
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2019 20:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfJAS4b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Oct 2019 14:56:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726043AbfJAS4b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Oct 2019 14:56:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91IpkHO037151;
        Tue, 1 Oct 2019 14:55:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vcc22rwxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 14:55:55 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91IqCau038177;
        Tue, 1 Oct 2019 14:55:54 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vcc22rwxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 14:55:54 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91IrRcc005347;
        Tue, 1 Oct 2019 18:55:54 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 2v9y585qkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 18:55:54 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x91ItqbP60031400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Oct 2019 18:55:52 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B22EBE04F;
        Tue,  1 Oct 2019 18:55:52 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41B77BE051;
        Tue,  1 Oct 2019 18:55:50 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.224.222])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  1 Oct 2019 18:55:49 +0000 (GMT)
Subject: Re: [PATCH] sysfs: add BIN_ATTR_WO() macro
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Matthew Garret <matthew.garret@nebula.com>,
        linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-integrity@vger.kernel.org,
        George Wilson <gcwilson@linux.ibm.com>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
 <1566825818-9731-3-git-send-email-nayna@linux.ibm.com>
 <20190826140131.GA15270@kroah.com>
 <ff9674e1-1b27-783a-38f3-4fd725353186@linux.vnet.ibm.com>
 <20190826150153.GD18418@kroah.com>
 <7546990b-8060-9451-129a-19aaa856d2e1@linux.vnet.ibm.com>
 <20191001181601.GA3705194@kroah.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <30330438-bd1d-000f-a9ec-57fd993eb569@linux.vnet.ibm.com>
Date:   Tue, 1 Oct 2019 14:55:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191001181601.GA3705194@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=933 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010151
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 10/01/2019 02:16 PM, Greg Kroah-Hartman wrote:
> On Tue, Oct 01, 2019 at 02:08:53PM -0400, Nayna wrote:
>> Hi Greg,
>>
>>
>> On 08/26/2019 11:01 AM, Greg Kroah-Hartman wrote:
>>> This variant was missing from sysfs.h, I guess no one noticed it before.
>>>
>>> Turns out the powerpc secure variable code can use it, so add it to the
>>> tree for it, and potentially others to take advantage of, instead of
>>> open-coding it.
>>>
>>> Reported-by: Nayna Jain <nayna@linux.ibm.com>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>
>>> I'll queue this up to my tree for 5.4-rc1, but if you want to take this
>>> in your tree earlier, feel free to do so.
>>>
>>>    include/linux/sysfs.h | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
>>> index 965236795750..5420817ed317 100644
>>> --- a/include/linux/sysfs.h
>>> +++ b/include/linux/sysfs.h
>>> @@ -196,6 +196,12 @@ struct bin_attribute {
>>>    	.size	= _size,						\
>>>    }
>>> +#define __BIN_ATTR_WO(_name) {						\
>>> +	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
>>> +	.store	= _name##_store,					\
>>> +	.size	= _size,						\
>>> +}
>>> +
>>>    #define __BIN_ATTR_RW(_name, _size)					\
>>>    	__BIN_ATTR(_name, 0644, _name##_read, _name##_write, _size)
>>> @@ -208,6 +214,9 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR(_name, _mode, _read,	\
>>>    #define BIN_ATTR_RO(_name, _size)					\
>>>    struct bin_attribute bin_attr_##_name = __BIN_ATTR_RO(_name, _size)
>>> +#define BIN_ATTR_WO(_name, _size)					\
>>> +struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
>>> +
>>>    #define BIN_ATTR_RW(_name, _size)					\
>>>    struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
>> I am sorry. I didn't notice it via inspection but there is a bug in this
>> macro. When I actually try using it, compilation fails. Here's a likely
>> patch:
>>
>> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
>> index 5420817ed317..fa7ee503fb76 100644
>> --- a/include/linux/sysfs.h
>> +++ b/include/linux/sysfs.h
>> @@ -196,9 +196,9 @@ struct bin_attribute {
>>          .size   = _size,                                                \
>>   }
>> -#define __BIN_ATTR_WO(_name) {                                         \
>> +#define __BIN_ATTR_WO(_name, _size) {                                  \
>>          .attr   = { .name = __stringify(_name), .mode = 0200 },         \
>> -       .store  = _name##_store,                                        \
>> +       .write  = _name##_write,                                        \
>>          .size   = _size,                                                \
>>   }
>>
> Heh, good catch.  Can you send a real patch for this that I can apply to
> give you the proper credit for finding and fixing this?

Sure.. Thanks Greg !!

Thanks & Regards,
       - Nayna
