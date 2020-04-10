Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 630661A4BBD
	for <lists+linux-efi@lfdr.de>; Sat, 11 Apr 2020 00:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJWMi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 18:12:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44704 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJWMh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Apr 2020 18:12:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03AMA1nx187200;
        Fri, 10 Apr 2020 22:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=D0Y+sCK6rKCNXMeoxaoYpvvgm89nbthtQcMvcu2PWx4=;
 b=sTjcXYGXMzAriDNrMtQYWAjqAtwfPbt1mkCR0DwcW8TTP5BgToI6FUFXL+o8s9sxT2S1
 /DTUkNNO7SwzQxjx0ZVUvgFL6QF8i4fjXKQ1rcBK+bzo30ZTAObZajkVYQfO1bia1CcQ
 aKSqrxC88psP07VDdCVEdbBQlHdaiQ7mBKzKCnRvPwITpj7FfZACtpmrNsObSpAHawak
 tBOkmMMIOxKvNt+ZfoJ73WAZigxIypyKMmPlYR2ZRMquLSSrndCho11bmCOsqND2JRKl
 I1GCObFdKVAJ88sOw7m9mwhuL2JDbfXv+Smz8RQ/kNqzl3hAMdqOk0dAgJzAEXQEsq3G fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3091m186ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Apr 2020 22:12:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03AM7ZKM098900;
        Fri, 10 Apr 2020 22:12:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3091m8mj65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Apr 2020 22:12:34 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03AMCXUD024840;
        Fri, 10 Apr 2020 22:12:33 GMT
Received: from [10.159.140.158] (/10.159.140.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Apr 2020 15:12:33 -0700
Subject: Re: [PATCH] efi/libstub/arm64: Enable __efistub_global define in
 .data section
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1586468669-21456-1-git-send-email-victor.erminpour@oracle.com>
 <CAMj1kXGgYYx=9rq-Ficw3vS6FX_0nb-hRStXijh7H4zdD=+Gaw@mail.gmail.com>
From:   Victor Erminpour <victor.erminpour@oracle.com>
Organization: Oracle America
Message-ID: <aee6c7cc-24c7-2822-47d5-1e05413a8024@oracle.com>
Date:   Fri, 10 Apr 2020 15:12:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGgYYx=9rq-Ficw3vS6FX_0nb-hRStXijh7H4zdD=+Gaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9587 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9587 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100156
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 4/10/20 1:09 AM, Ard Biesheuvel wrote:
> On Thu, 9 Apr 2020 at 23:44, Victor Erminpour
> <victor.erminpour@oracle.com> wrote:
>>
>> Enable the __efistub_global define to place variables in the
>> .data section for both CONFIG_ARM and CONFIG_ARM64.
>>
>> This places the EFIstub sys_table variable and other EFIstub
>> static variables in the .data section for both CONFIG_ARM and
>> CONFIG_ARM64.
>>
> 
> What does that achieve?

Hi Ard,

Without placing these global variables in .data, I get the
following errors when booting an ARM64 EFI system:

EFI stub: ERROR: Exit boot services failed.
EFI stub: ERROR: Failed to update FDT and exit boot services


I know that the ARM64 linker script is supposed to put the
.init.bss into the .init.data section, but I don't think this
is happening for all systems.

Having it explicitly enabled for CONFIG_ARM64 worked for me.


Regards,
--Victor


> 
>> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
>> ---
>>   drivers/firmware/efi/libstub/efistub.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
>> index c244b16..59932d6 100644
>> --- a/drivers/firmware/efi/libstub/efistub.h
>> +++ b/drivers/firmware/efi/libstub/efistub.h
>> @@ -25,7 +25,7 @@
>>   #define EFI_ALLOC_ALIGN                EFI_PAGE_SIZE
>>   #endif
>>
>> -#ifdef CONFIG_ARM
>> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
>>   #define __efistub_global       __section(.data)
>>   #else
>>   #define __efistub_global

-- 
Victor Hugo Erminpour
Principal Member of Technical Staff
Oracle America
