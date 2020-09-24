Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68A2777A8
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgIXRXm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 13:23:42 -0400
Received: from mail-bn7nam10on2048.outbound.protection.outlook.com ([40.107.92.48]:39265
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbgIXRXm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Sep 2020 13:23:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD4stcmK/1fkvms1Ix8Dap/DSE0aqEXwf7ryZ8BzYY8bkntz3Vw68AMEM5f0fkjn7aWSSx1CeDBuNA/6PP+nzjOAGXeV2n/OrfmWI3AfZYuerXyb8xUXT72H7QCifT5be+F33NrSjIogK5QzzS6KjbEtOnAyCjymbIGCxWbIQMp/Sh2Jy/tWyFOczDubd8Ot+87N/uViD9SFQnr4+J1S9oqiXE++UoyLOM9Fp5jkmRqL27aHjr/A22DWNbQRD1jzlWJVyxAd+I+Ef+iOy95pBR5ObvQNSOUPzyX4+wMLRFFjV8hcCjdmzh4oTm+xVuJb1XbK6ezTh5rh8duTejQa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz4bEvcZb4X/XcKk4w3y9L1+6TlNs0Qd0W1m8sT+gKg=;
 b=bF0O1xdts/ngHV4DtHEEPBwZfQU6NNNEaSM++D4Uows1NTplFOQQouhzYAvRx4UnzTfsMtTlLuRHeJ5nCZuwqoivmSEwwpCCYqS7Y8UPIsDCn5LF3r2q0YTdjl4gZQLF0pvsZC4I7rtOmqpdZkYYk/L+k/xBPw7fWePEhehpPmbxNjDBnjN768JPPbFTlzcUaz2ss4QinlwQMcIK+ReI6MpeaaZ/O1Wtit9mQRBw+v4D6It0mKedTYoCq6sSVhhAvA7LHQU8j0qJQ0vTECGSHx/uMfK6MRqMDuY5SpVurmpCCJXmhZgNDn3irjwZ5WLmbckD20Y7tEWUHn72xSRvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz4bEvcZb4X/XcKk4w3y9L1+6TlNs0Qd0W1m8sT+gKg=;
 b=C5KmXCTzZ3AoJTlhYTfMfQsDDuvd1iR1YFPi1RuEE/YK8Ugqdcf++EHFL7NX5NxtPwrC6I60mBhtSPDFYLybJEHG/UvsOSY90aZQhv2BVoEL8sCD2JhRlMDE/mD68ywii8KRchqVPzCTonZXRj4ijCk15xTJnZu5qDChZJ4IogI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 17:23:39 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409%5]) with mapi id 15.20.3391.026; Thu, 24 Sep 2020
 17:23:38 +0000
Subject: Re: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
 <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp> <20200923140512.GJ28545@zn.tnic>
 <87pn6chwil.fsf@kokedama.swc.toshiba.co.jp>
From:   Smita Koralahalli Channabasappa <skoralah@amd.com>
Message-ID: <52c50f37-a86c-57ad-30e0-dac0857e4ef7@amd.com>
Date:   Thu, 24 Sep 2020 12:23:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <87pn6chwil.fsf@kokedama.swc.toshiba.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: DM6PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:5:134::23) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2605:6000:101a:88d8:93:ec8d:8400:73ca] (2605:6000:101a:88d8:93:ec8d:8400:73ca) by DM6PR13CA0046.namprd13.prod.outlook.com (2603:10b6:5:134::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.16 via Frontend Transport; Thu, 24 Sep 2020 17:23:37 +0000
X-Originating-IP: [2605:6000:101a:88d8:93:ec8d:8400:73ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35c2fd30-d0db-4464-beb4-08d860ae9344
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4592305CA4AF46EF28CCCC5290390@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjpAED1G58icP2cN43NeptEthDnnchXJwsvnJpp1/gkfNBXlmRL8nUL52IrMRGGYDJToIU7+P+TPaCAiUhfNyW+aEkNuGriCbUeh45wrBxoh2+HG8wOAgNfi+t5kxIVo9ydadMGGoV2RPbR4mUPH+OuqsIYwZ1Zyg5TMCXxbb9QryTZqRzoNOiQKxk/g7fDpfjMcZp5WiMh0xpI4XNIOPO89eKPB7h1tlVOkwH5lF/KYjPuFQ48D9KFxT1ig0PlAhlueYsiYl3YXBJCEXVFL4We7j4LMKIYcBpbQGLh5m0Do6MTxnKQ+G+aQzjpDS7cwoltoD3FsCvAROHo5RRyQJuPel5a+K4Ooeb50zHuhI9KJeIYHC4p5/kxjRpaicS09gvhV/CU8m90AZmp1CWfrM5609vYDwc5vCaZCdKVtczB6KDuRcAILMMVKIRI2J2kI0BwD7j+13QC3GiKZTYVobQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(110136005)(5660300002)(66476007)(53546011)(36756003)(6666004)(7416002)(52116002)(66556008)(4326008)(16526019)(66946007)(6486002)(31696002)(8676002)(186003)(8936002)(2906002)(54906003)(966005)(478600001)(45080400002)(2616005)(316002)(31686004)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UoRm/N4t25tm5qFsmhqH4l+6al5t3NGAlUlh5kVzGTBg+6Ls3DPwTYGRDKUjcL/kiSbH7XL7fQCCybPMjV6IlOg/W6fUnxtzOaeaOzGkuNZCmmn7UmGlfcB5wkZi84yWU8KKgi9plWLSJgg9ciqk9g/mSdzuZNEYMiEm01Lz8/zHbgXYr9VB5olHCgJ/T3+F5rGNXnX5N2Kwb348vLGsqmXJOj6iXCW/yc4pHWpNX1tw/vr+XnerccPzC+aFeVIz/puS56x0Lv3Qd1oA0VSvUMiI8r3P6I1VVymyAMxkcI9XzCfsVKy8Prx+ggZRX0JJFgybUzs1dYe8z2eve1aQzDwGMy8DypMk9Z6b5vXtGvpl6FZmuRbKD6N8b6Jr9p/bfTOB7GIXv4hnjBTZEkj3H+ruRDRz4h4QladnR+sZviLlt1IBhah1PZajI5FbOSjrGqYAtG8E7xZzZKwyHABuadUfDHU1+fBTQ/YYIupeec92mRP/LjDInI22CDF1LS40n9Ho6AVFmhGziMk1STjM+dMC729SXo+nUV51xulCJN/LlMj7soyR5qFttpfxgsv4RGL7mcIt9/N+D3eIbLL2Qq498Zu15up/7I+6vihtjM8DtQK+5qefSLMJ5bvW0PSSKD/3tBajF6LEx7XijiTB8rDH8aqEiRtqwVsrMTNWw2onvemmU9zURLATRYEk3UskFEoJVoT9a1xGmathyZppJQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c2fd30-d0db-4464-beb4-08d860ae9344
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 17:23:38.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBjBpr7P7NWH5emfa33tePEN7n81eQMQK+wBLw9O6oY4dXcVh/8ZsUl4EVFpQ+PvbMQLzlSVZn5LDv2dBBYCaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/23/20 7:02 PM, Punit Agrawal wrote:

> Borislav Petkov <bp@alien8.de> writes:
>
>> Smita,
>>
>> pls sync the time of the box where you create the patch:
>>
>>   Date: Fri,  4 Sep 2020 09:04:44 -0500
>>
>> but your mail headers have:
>>
>>   Received: from ... with mapi id 15.20.3370.019; Fri, 18 Sep 2020 14:49:12 +0000
>>   						^^^^^^^^^^^^^^^^^^

Sorry for the trouble. I have fixed this.

>>> I know Boris asked you to add the reason for the Reported-by, but
>>> usually we don't track version differences in the committed patch.
>>>
>>> Boris, can you confirm if you want the Reported-by to be retained?
>> How else would you explain what the Reported-by: tag is for on a patch
>> which adds a feature?
> As Ard clarified, I was questioning the inclusion of the Reported-by:
> tag in the patch itself. But I also don't have enough of a strong
> opinion to obsess about it.
>
> [ Aside: One interesting consequence of this though is that by the same
> argument, changes resulting from comments on earlier versions are also
> legitimate content for the final patch. Not saying I agree. ]
>
>>>> + * The first expected register in the register layout of MCAX address space.
>>>> + * The address defined must match with the first MSR address extracted from
>>>> + * BERT which in SMCA systems is the bank's MCA_STATUS register.
>>>> + *
>>>> + * Note that the decoding of the raw MSR values in BERT is implementation
>>>> + * specific and follows register offset order of MCAX address space.
>>>> + */
>>>> +#define MASK_MCA_STATUS 0xC0002001
>>> The macro value is already defined in mce.h as
>>> MSR_AMD64_SMCA_MC0_STATUS.  Is there any reason to not use it?
>> Good point.

I indeed missed it. thanks!

>>> You can move the comment to where you check the status register.
>> No need if he really wants to use the first MCi_STATUS address.

Okay!

>>>> +	m.apicid = lapic_id;
>>>> +	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
>>>> +	m.status = *i_mce;
>>>> +	m.addr = *(i_mce + 1);
>>>> +	m.misc = *(i_mce + 2);
>>>> +	/* Skipping MCA_CONFIG */
>>>> +	m.ipid = *(i_mce + 4);
>>>> +	m.synd = *(i_mce + 5);
>>> Instead of using the raw pointer arithmetic, it is better to define a
>>> structure for the MCA registers? Something like -
>>>
>>>      struct {
>>>          u64 addr;
>>>          u64 misc;
>>>          u64 config;
>>>          u64 ipid;
>>>          ...
>>>      }
>>>
>>> Checking back, this was mentioned in the previous review comments as
>>> well. Please address all comments before posting a new version - either
>>> by following the suggestion or explaining why it is not a good idea.
>> Well, that was addressed in his reply last time:
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2Fa28aa613-8353-0052-31f6-34bc733abf59%40amd.com&amp;data=02%7C01%7CSmita.KoralahalliChannabasappa%40amd.com%7C1e8d8042158141af2c0a08d8601d31d7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637365025808391248&amp;sdata=C71Gp1ZNQhtckegVJbYPA%2FTNi6np%2Fl1Xl4BvI4kGX4Y%3D&amp;reserved=0
> Oops. My bad - sorry I missed the response.
>
> Copying the relevant comment here for discussion -
>
>>>> The registers here are implementation specific and applies only for
>>>> SMCA systems. So I have used pointer arithmetic as it is not defined
>>>> in the spec.
> Even though it's not defined in the UEFI spec, it doesn't mean a
> structure definition cannot be created. After all, the patch is relying
> on some guarantee of the meaning of the values and their ordering.
>
> If the patch is relying on the definitions in the SMCA spec it is a good
> idea to reference it here - both for review and providing relevant
> context for future developers.

Okay, I agree the structure definition will make the code less arbitrary
and provides relevant context compared to pointer arithmetic. I did not
think this way. I can try this out if no objections.

>> You might've missed it because you weren't CCed directly.
> Indeed, I missed it. Thanks for the pointer.

Sorry, I missed including you on CC. Will include henceforth!

Thanks,
Smita

