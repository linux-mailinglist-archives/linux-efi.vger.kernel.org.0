Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371A7266A04
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 23:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKV03 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 17:26:29 -0400
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com ([40.107.237.80]:2903
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbgIKV0V (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Sep 2020 17:26:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuPUlpjx18BuCPRk3ptNG3Tfs3TlEkp9CkNcS5qb3iJv39GUCngQRhWfQBoLT0ko6EXngj8ghBwbGXNxqhKBn3RsprAepAsZu70J66nIHLR9LZxW1dOytWUJ9dKLAvOR7hkOZwJtivV5mtame3rTgtRIz9coSq9tATpqsv0RjPUnzVpyfsLpB+ziAiNPgzm49+vJFejbviUe4UNRw6bojyJZSqX6Agxs5+GHNIuMs2fM44GPQWdYeKYI0sZFoflV+I2VW7narvsxR1V3XFb+S1UCYYIYOf0QsuqUOgMISf4HmHMWAvwlXYsIENOGuPbHIpfaoEa3XLUGoYxA8yWz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6M+NfjK9CA8FevSRdWv/cuR98fCBZ2nswWVqG+sa3U=;
 b=l1ddkgp4qbfTzd4I+F2qjqGS2FKAxXerBEic9OAcccQSbKdlvhmlB/C1G6GZDrPFtk3o9I4Plbw9lx6avX+7q3qILBOJCSKhfzWgC7cA/JHIxk8F3RM4LivvbFcIVS9kouZ9zYdYja5yIyftKcHtzqDZv3KviZqS6zSUxSLNMh42a27tFXCOfLvsuxSsfKkkEpdOSzgfTmB0nZrOBE3RRA6xdgKRPekwD7+UCV0vpiQcJG0ldML5y0jadTrn746jmNyZmiQeffbhVLf7bCPAvlfhQUfosgrExxMvUExFXJSlycr3Z1vIXhOzOfZtwXAE7HM+gXzB31yE+/Ezt266pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6M+NfjK9CA8FevSRdWv/cuR98fCBZ2nswWVqG+sa3U=;
 b=GJOGLbGguf1vu6WMBKxzD6oe7fD5PM6RyXTwdi/B3FUhu3C1Ps5F9rYo+xhl2egwC3A/bcqwSv3SI38/lKK0dN8fuSvSjLAqz7Qo96wXP5cXY5f2y6IJri0fnpdAHyDllObGq5wflyfOXhcCrkKZgrH27EYO13+sbAZgirNa91k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 11 Sep
 2020 21:26:17 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409%5]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 21:26:17 +0000
Subject: Re: [PATCH v2 1/2] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
To:     Ard Biesheuvel <ardb@kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20200828203332.11129-1-Smita.KoralahalliChannabasappa@amd.com>
 <20200828203332.11129-2-Smita.KoralahalliChannabasappa@amd.com>
 <878sdvv20h.fsf@kokedama.swc.toshiba.co.jp>
 <102d0c75-d642-8f8b-68c7-792499c2a62a@amd.com>
 <87a6y7qshg.fsf@kokedama.swc.toshiba.co.jp>
 <CAMj1kXGd8KgP6_-Ebec1wpxpCnjjOe4_uovcYW3GD1BA5au=3Q@mail.gmail.com>
From:   Smita Koralahalli Channabasappa <skoralah@amd.com>
Message-ID: <dbe4781f-124f-e4ae-dc68-406d555061f1@amd.com>
Date:   Fri, 11 Sep 2020 16:26:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <CAMj1kXGd8KgP6_-Ebec1wpxpCnjjOe4_uovcYW3GD1BA5au=3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: DM6PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::19) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2605:6000:101a:88d8:93:ec8d:8400:73ca] (2605:6000:101a:88d8:93:ec8d:8400:73ca) by DM6PR12CA0006.namprd12.prod.outlook.com (2603:10b6:5:1c0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 21:26:16 +0000
X-Originating-IP: [2605:6000:101a:88d8:93:ec8d:8400:73ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8adf0cdf-45d9-459d-dfd6-08d8569951df
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB455732278C69068A92E3079190240@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFGUxD0gHmembumRkNNNArVWF+iIKG39i6zwjEWh1f50EG+s4+wyJPzE/2uPMHvzZBvh4UOq1YVQIbj0eeG9mWXg1GpGRgr/aEIEiJuX3+YHdIEJVc9sZ416y7qbKpBdkGGQcaO2f7cFguRcooSPVb1UEJMOGmkS4T2CMqHxxGBFY7RdamfO6fWI1ZkNeavSRWQQmHV9ve8yrakIEI8AdZn/pWezfrxgLSWSZd7TLxE/XINoIp1NZGqsQRvCDNBMMnfXc8Cq2KR9Dif4jXqtHsszv78L0V2NmEliRG+kr/1REer5EKfS1D8lhq9FNbB6roj/3idG/iJPV6c+jjMm5Krs9CbsSOvOHpEGmXijFhFq0iOAg+v0e3eafp3d4wGHtyRaNRj7zu2LpBYsn3VxytDwn0sekIl2/4xVpUbIYpeV2Z8+SEHKZ+Gb0bZxrbXPQoewXCSLBR4KcUvM4uFAxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(53546011)(31686004)(36756003)(2906002)(66946007)(66476007)(66556008)(5660300002)(16526019)(52116002)(8936002)(2616005)(8676002)(31696002)(7416002)(186003)(478600001)(6486002)(966005)(110136005)(4326008)(316002)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4B/FcQIj1KbnZ/kCgxJH8vcAkMwkZrRkClSzbYvZRYFnxls+gkbTg5cNC423fIKrAcq3BUPVwNIzLbQin7hf6Ic0cErI4Yxb62j6v3KttxyVFvVolyxDtB9bxcbg9CxZ/+6RBpzBxzNm9L4Zxin7mnBUgz2mBapBhGjhEA9NGkriueErx7M8YxwBeor5X73CYt2fjkSMT1qyxT0OH84G804IT971EuD5X7CIYdOuJPGG4RlKNyac3ycnirLfBZw0Bbjm8S8BrBgupazBCqETWs2nvceESvgrlCyBldTVFXo2NQWDbsiNc+y17uB3vW/j8B3bl08q2byqkHrazyusxVzchO/+CKkQyN2/7+xHuehl5Gbf5G7gLHd3MjbxkQVfS5pTFoQM6feE5pF2OYBCNDM2x+117uGPNAo8Pl3ct8d2ACyCMbb3vXR3khd5kMz4oz6gEf3q9DKiZoN0uslj90pCFkNd+8yFegw/INALxh+HkOJAOCMV2lxacssH6fZ2++oiRelhZNYQ/9e2WsTk9zdddqSYEdmR1OMIIMvbtN1IgfkdnRjmG+ijNQi6MsjSMv/0ZeRiUc4xP7vwVgMggejN4uuLETTUakC4eis9jKv6cE/SjTt0j45V480bBr4DmlmUwbHR94Nse/gBiICAIf98zlaT7lLjVb7HMqNIuoDHMUg4OZ/2IZ5Zyc9hjopwxPhU8i+xDqnA8D+gPToaUw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adf0cdf-45d9-459d-dfd6-08d8569951df
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 21:26:17.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdO4AyVzHjdxtT1rJSyrgFDbFKGJ2alCxuKLNfkq1knUzMLIEMcZChW3p+LC3VRJOwSrZEuXiN1fpZMoAiJ5rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/11/20 1:23 PM, Ard Biesheuvel wrote:

> On Thu, 3 Sep 2020 at 09:34, Punit Agrawal <punit1.agrawal@toshiba.co.jp> wrote:
>> Hi Smita,
>>
>> Smita Koralahalli Channabasappa <skoralah@amd.com> writes:
>>
>>> On 8/31/20 12:05 AM, Punit Agrawal wrote:
>>>
>>>> Hi Smita,
>>>>
>>>> A couple of comments below -
>>>>
>>>> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> writes:
>>>>
>>>> [...]
>>>>
>>>>
>>>>> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
>>>>> index 2531de49f56c..374b8e18552a 100644
>>>>> --- a/drivers/firmware/efi/cper-x86.c
>>>>> +++ b/drivers/firmware/efi/cper-x86.c
>>>>> @@ -1,7 +1,7 @@
>>>>>    // SPDX-License-Identifier: GPL-2.0
>>>>>    // Copyright (C) 2018, Advanced Micro Devices, Inc.
>>>>>    -#include <linux/cper.h>
>>>> Why is the include dropped? AFAICT, the definitions from there are still
>>>> being used after this patch.
>>> Dropped because <acpi/apei.h> already includes <linux/cper.h>
>> Generally, you want to follow the rule that if a declaration from a
>> header file is being used, it should show up in the includes. The same
>> applies to both source as well as header files.
>>
>> It doesn't matter if another include in the source file in turn ends up
>> including the same header again; the #ifdef guards are there to prevent
>> duplicate declarations.
>>
>> The rationale is that if future changes remove the usage of
>> <acpi/apei.h>, the C file can still be compiled after dropping the
>> include; there should be no need to then re-introduce <linux/cper.h> at
>> that point.
>>
>> Hope that makes sense.
>>
> Agreed. If the code still uses declarations from linux/cper.h after
> the patch, the #include should remain.

Thanks, I have taken care of the comments and sent out the next revision now.
https://lkml.kernel.org/r/20200903234531.162484-2-Smita.KoralahalliChannabasappa@amd.com.
Please ignore my previous email.

Thanks,
Smita

