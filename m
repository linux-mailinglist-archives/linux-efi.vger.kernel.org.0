Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD92D2AF9D6
	for <lists+linux-efi@lfdr.de>; Wed, 11 Nov 2020 21:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgKKUhi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Nov 2020 15:37:38 -0500
Received: from mail-mw2nam12on2086.outbound.protection.outlook.com ([40.107.244.86]:60896
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbgKKUhh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 11 Nov 2020 15:37:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W56Wvu8ku6MwGB2dC8DRcPW1YQLd1xctNU5mfb1a81iDNfHogp4du4xrTmHl7GFOuf1/hU361j798mUtboPGrQYuzOmzcm+kOWzFrmw1UWqsCIuoASrf5bTJmPAJpQ9D9dsecrrznMNaBGt57X9XioAhUYQQs8VhKgUGh1N4AxnXFB6+XhOad8QQ/c0zY2FSrRzU+delp+7EIrrbhKqsFzoX5BmR+11efCbUShvFQqzn1BUDhZYZ4YhopFd4OHmfOkE1RsDhca5YDea3Nuic6dmmnlz48AAs6UiLOm536jwpuuf0wUfhGVjvJDw/iwgFG9e03yYVxsNR7cS3r2ujag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxeCTyHawwcEmWvz8X0ctbv4qA40ywc94iv127apNqE=;
 b=j4lYeQ4itt8V44HCdtBsmmphsiXqGvp8tNNVMHzhxEpB7OaHZMaUi0aGQ76PaEQsMfRkkANKQEbNgI1xYIsZrt/coNVuI7W6B75Y9Z7vxDs8VBkrara7y96Tl54/JD3xMnO5lyUTiEW5bTcFOCeqepTFwCxPQSgP+Bl2UTRnLZ7hkKxwKTVtvPVKajp8b7geaCG3oi0Is3QzjPYH84knSC4AbhHQs++C/NAWkzmWI8I5ZB9P2ezPumkw9wNjKbAfKBdTSA8SKkxhoeeJN5nDGb1Jfud+7X2V56VbmKPF39tC2wOmqqAecsrdEt3t2aSry65LqVTWjlA8KRPkPQTDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxeCTyHawwcEmWvz8X0ctbv4qA40ywc94iv127apNqE=;
 b=RWdJh7XFr7Q8pXtd//SyjvBdoFSgEPWcHJf1P0TjkxS3pi9MKdt0wii2jq5sTsIyQ00EfQtyDi3rKpZ6pUvdgj5p0KEdq9ukaWXhdzfUr5s5HivTnYxZ40zgY838JIUL7SlV1GupXLaOXykH6FxtFl2zr53KVJCZHA6Nj5T469k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 20:37:34 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::a160:c63e:b49a:8f9a]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::a160:c63e:b49a:8f9a%3]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 20:37:34 +0000
Subject: Re: [PATCH v5] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
From:   Smita Koralahalli Channabasappa <skoralah@amd.com>
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20201103164952.5126-1-Smita.KoralahalliChannabasappa@amd.com>
 <87a6vv9hch.fsf@kokedama.swc.toshiba.co.jp> <20201106120950.GC14914@zn.tnic>
 <874klz9vk9.fsf@kokedama.swc.toshiba.co.jp>
 <982e0243-b144-f8b6-d69d-45af94ed8bb9@amd.com>
Message-ID: <651b7dba-d36a-d4db-4a0f-fd67aa9b985f@amd.com>
Date:   Wed, 11 Nov 2020 14:37:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <982e0243-b144-f8b6-d69d-45af94ed8bb9@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2603:8080:1840:5c4:2d3f:50b3:ce8f:b4ef]
X-ClientProxiedBy: DM5PR2001CA0009.namprd20.prod.outlook.com
 (2603:10b6:4:16::19) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2603:8080:1840:5c4:2d3f:50b3:ce8f:b4ef] (2603:8080:1840:5c4:2d3f:50b3:ce8f:b4ef) by DM5PR2001CA0009.namprd20.prod.outlook.com (2603:10b6:4:16::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Wed, 11 Nov 2020 20:37:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa6fe525-6a81-48ca-2ca1-08d886819ec7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23675E71B8535F55D09383E090E80@SN1PR12MB2367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8VEB0bDruBWogtTxiLi8iuhHuTi19+fbpr4jXkzQidSLY6qiNVu0Mf6HhTa+jpx9HintzpPjlZD7br0uMBAbfwh+U2xbOuJXVsXvymrBh7y4QnbZBJ25M3EjaVoWIVfDiWrthTfGZbgEc04fcmbDzOMdsz970D1ZnyUe8g8iukvv6O+327hLXZY6KmZQKRCeyJuLeKR57V+Hc1ZrNKgleayyFtC5nrS4ySFjwFAPD1lEWvh8jcAxoAPN7PocYTwN7SXAqnDCuGfHg36SN3UkRZdLnygA7wzCsTb310RwNjEycMPfzxmP1gxp6BcpXfIwQzFY1IbiMq3cd+DpsZ5PjYtJGHJNm2D3JPuWTQ/GQR3UDodMTOwBssCpY8z7TBN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(478600001)(36756003)(110136005)(54906003)(316002)(2906002)(31696002)(83380400001)(31686004)(53546011)(16526019)(186003)(8676002)(66556008)(2616005)(5660300002)(7416002)(8936002)(6486002)(4326008)(6666004)(66946007)(66476007)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cHhYeXA5d2Zkd0l3elN0VU54bHJ2NzdsNzAwTitPWHpWczl0RnZqRkIyOCtw?=
 =?utf-8?B?UkwzRHpHanBNUVIyOGg5WXZ6dkNwaVQ2VThpbk9hNitaanJJYnVrVCtMUGty?=
 =?utf-8?B?U1d4K1RtR2RvNHRXbXlreHJvY0N3cG9FKzY5Qzlvc1V5RnplOWhOSk9iTmNL?=
 =?utf-8?B?MDU0YVZlY2tEWHNXL3VmRXZqZGJoTFJzdkFoenphOFlmMTVDUWVuSFJmVTU4?=
 =?utf-8?B?dmZzbmkydkpxY040Q2lFSTdLWWc3anNJVG1wOWVNdmVBMy9INCtLSmhzb05U?=
 =?utf-8?B?ODU3UnVqL1NkaXN6aENtUDRvS3E1Z2dJMEFJcmhGb2J1cDF4UFlDM29Wb3hy?=
 =?utf-8?B?bWo2eXJ2YlAyZVVvb3JzRitxOHVqYVNqUFVPS2pmOXlSN1JITnMwcStaeE5L?=
 =?utf-8?B?OU5JSEdGOVArNk1zME9EcCtFNys4UU11akVmMjZvN3ZFL1VndVRkUVBqMkpL?=
 =?utf-8?B?L1BXK3VPTlZWSzFROE5MWG11eVVXUVBGQStjY09VV08xNUhobmx1QkMwZW9L?=
 =?utf-8?B?QkhVc3YwL0QxZ2Z1b2QrbFNMU3BzbitOTmJVK2pPdzlncjNKeTU2MUZpaUhk?=
 =?utf-8?B?M25SNmN5TlpnKytVT240NE50emtoU05KUTQzN2NzeHFhTGVFRzM1eThTTlp0?=
 =?utf-8?B?ak1pM0dIVGJ6K2tYQ1FuZ3dlZ2pxN1dNZFFGY1BNVHE2QlEyU0pWTTVuTExM?=
 =?utf-8?B?a3NTRDd1bmZ1a1NOY2hRT1JEekF2TWVia2srSU83QlBRVWVuV0cyRzdiQ0tr?=
 =?utf-8?B?MjdXdHRyZ0cyRVNRU2lnd0FyQXhneGhTbk55cDczd1ZEb3RrZGlIK2JsRU51?=
 =?utf-8?B?UHFsVVFUMGhzSVc0UTZZV3lydFd6Yk9ydWlXNjRjMFR4U1hRcEE3SGNuVnNh?=
 =?utf-8?B?YTlVZWNpTU1PcFl1c2tVbVEvRi84MVNsdXlHSGxPRUZBRGdCM1lBUndvdVha?=
 =?utf-8?B?UDZmTVYzU2JxNGlQaWNET090UExFQnZrRFVWYjNCV015UHZPdmxNYUtNWU4v?=
 =?utf-8?B?dThIVjF4NGRpdmYxU2RITExJN1lwYnU1MmtrbHhWRkxMMURnTjVjZnNhbUxW?=
 =?utf-8?B?TWFpV2J4cEFnUHluNWc3dktaNUIwWGIydVhubHg2bjNvVWxSTDQraTNVdVJ2?=
 =?utf-8?B?di83T2ZyalYvNWhTd0oxSDFlQzFBK1NDUnE3ODM1QmlienlmQ0RSaVk4b1Nk?=
 =?utf-8?B?Zk5LNTlvVm51L3dQSitnOWFjSkpqQmw4VFpGdjEweVh4UXFKQXlsZTZiV094?=
 =?utf-8?B?WWdyekltTkNkRkNNaThZZkdFQUNRcmIvUkJ3UkhsSGJkQm1Wdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6fe525-6a81-48ca-2ca1-08d886819ec7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 20:37:34.8050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T25XRBktqS343o6u0Q4FK72bxfKeS8Gasy05k4FkrSVDqIulgHNShMdUtD2pw8iAkMHxLMOFmgKziXHj8HvNug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Punit,

On 11/9/20 1:05 PM, Smita Koralahalli Channabasappa wrote:

> On 11/8/20 7:18 PM, Punit Agrawal wrote:
>> Borislav Petkov <bp@alien8.de> writes:
>>> On Fri, Nov 06, 2020 at 02:36:46PM +0900, Punit Agrawal wrote:
>>>>> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
>>>>> index 2531de49f56c..438ed9eff6d0 100644
>>>>> --- a/drivers/firmware/efi/cper-x86.c
>>>>> +++ b/drivers/firmware/efi/cper-x86.c
>>>>> @@ -2,6 +2,7 @@
>>>>>    // Copyright (C) 2018, Advanced Micro Devices, Inc.
>>>>>      #include <linux/cper.h>
>>>>> +#include <linux/acpi.h>
>>>> Did you mean to include <asm/acpi.h>?
>>> Why?
>> Because arch_apei_report_x86_error() used in the patch is defined
>> there. The indirect include works but pulls in additional definitions
>> not needed by the patch.
>>
>> Do you prefer the more generic include?
> I agree, it's generally a good practice to avoid pulling up additional
> definitions. I had this when I made the declaration in generic header
> file and may be I did not consider it changing initially as my build
> didn't break after moving the declaration from generic header to arch
> specific header file.
> I will take care henceforth and make the changes as required.

The asm specific include throws out a warning when I run checkpatch.pl

WARNING: Use #include <linux/acpi.h> instead of <asm/acpi.h>
#215: FILE: drivers/firmware/efi/cper-x86.c:5:
+#include <asm/acpi.h>

Should I just keep the generic include?

Thanks,
Smita

