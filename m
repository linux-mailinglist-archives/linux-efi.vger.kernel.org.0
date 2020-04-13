Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F12E1A6F86
	for <lists+linux-efi@lfdr.de>; Tue, 14 Apr 2020 00:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389808AbgDMW5I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 18:57:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55490 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgDMW5E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Apr 2020 18:57:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DMmxX5187003;
        Mon, 13 Apr 2020 22:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kUafvIvIPEKhK0ZXAQkw9p3e5TfvCeEnK9SeWV6yrHg=;
 b=aBq0BzhwY30bedc966EA/bLXU7M3sR/OI7yFtL8iWYhxsiQJW1SPWAo3INkFvLot96uA
 pluohDXKBDF0WwGzZO//4JJfcAghjUWwh5aCmzEJnIHl2zrPzhSEvsUvXEaPoRxs0g5z
 BDIcAXJMZC7aejTrzc9uLanfyF2GZMnHz3kBWk0uUZZq3kMgfS7v5Ki7FYHpy7soG9e7
 x1g/ZWqKlhTQIPxJnk/oJwXcorxbbkF8177UGchhjImHD6w5Opht6yuuyJRjp11CF8F7
 66E7fanNgdirIl0rsq69gmyQam2AcAWQ+DNZyXYp3b+Hy7Uh6wyd48ea2rdp4vgs6F44 Pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30b5ar19v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 22:56:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DMgupn047458;
        Mon, 13 Apr 2020 22:56:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30bqkynmxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 22:56:58 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03DMuwm3031399;
        Mon, 13 Apr 2020 22:56:58 GMT
Received: from [10.159.254.43] (/10.159.254.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Apr 2020 15:56:57 -0700
Subject: Re: [PATCH] efi/libstub/arm64: Enable __efistub_global define in
 .data section
To:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1586468669-21456-1-git-send-email-victor.erminpour@oracle.com>
 <CAMj1kXGgYYx=9rq-Ficw3vS6FX_0nb-hRStXijh7H4zdD=+Gaw@mail.gmail.com>
 <aee6c7cc-24c7-2822-47d5-1e05413a8024@oracle.com>
 <CAMj1kXFF3gR+LyE1VbLuwnRA3CzQtF90mv7rpw9x2RcyugO1JA@mail.gmail.com>
From:   Victor Erminpour <victor.erminpour@oracle.com>
Organization: Oracle America
Message-ID: <95f421ad-6ba7-b968-d605-c464bc1df4e2@oracle.com>
Date:   Mon, 13 Apr 2020 15:56:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFF3gR+LyE1VbLuwnRA3CzQtF90mv7rpw9x2RcyugO1JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004130165
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 4/10/20 11:39 PM, Ard Biesheuvel wrote:
> On Sat, 11 Apr 2020 at 00:12, Victor Erminpour
> <victor.erminpour@oracle.com> wrote:
>>
>>
>>
>> On 4/10/20 1:09 AM, Ard Biesheuvel wrote:
>>> On Thu, 9 Apr 2020 at 23:44, Victor Erminpour
>>> <victor.erminpour@oracle.com> wrote:
>>>>
>>>> Enable the __efistub_global define to place variables in the
>>>> .data section for both CONFIG_ARM and CONFIG_ARM64.
>>>>
>>>> This places the EFIstub sys_table variable and other EFIstub
>>>> static variables in the .data section for both CONFIG_ARM and
>>>> CONFIG_ARM64.
>>>>
>>>
>>> What does that achieve?
>>
>> Hi Ard,
>>
>> Without placing these global variables in .data, I get the
>> following errors when booting an ARM64 EFI system:
>>
>> EFI stub: ERROR: Exit boot services failed.
>> EFI stub: ERROR: Failed to update FDT and exit boot services
>>
> 
> Which boot loader are you using? Does this involve shim?
> 

grub2-efi-aa64-2.02-0.80.0.4.el7.aarch64
shim-aa64-15-1.0.4.el7.aarch64

> Also, does it help if you add 'efi=no_disable_early_pci_dma'?
> 

Tried this boot time option, but to no effect.

> 
>>
>> I know that the ARM64 linker script is supposed to put the
>> .init.bss into the .init.data section, but I don't think this
>> is happening for all systems.
>>
>> Having it explicitly enabled for CONFIG_ARM64 worked for me.
>>
> 
> OK, thanks for the report. However, we will be removing
> __efistub_global entirely during the next cycle, so this is not the
> right fix.

Thanks Ard, this sounds promising!

Regards,
--Victor


> 

-- 
Victor Hugo Erminpour
Principal Member of Technical Staff
Oracle America
