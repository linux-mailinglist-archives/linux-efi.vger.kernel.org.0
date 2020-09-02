Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7D25B468
	for <lists+linux-efi@lfdr.de>; Wed,  2 Sep 2020 21:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgIBT3f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Sep 2020 15:29:35 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:48448
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbgIBT3e (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Sep 2020 15:29:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM3dFzZYw9CdnujdazSYQ3hMf7vXsrBtrUa1lXPLUnys/C5wTw4cK1nBFV9fELDEPPac2rlOgIslywgorzH560P1GeEjbTrNkP+P4ILqeMl2WzLG6+1EiEn+k5BxkOIbhjMB0WG555QRJBEqBV9vbB3r0KkrCLGdHUSxai5J7KOjSueJp6zRAfqiCTY1hXpzLRBDsjIhTweabzdyXvLGjCJwElIxauHCODez8pXd51OIZtXNpKuQr0+N4BnlivXmDB1HHRvo9wtp3+604rulqGwlNzfoXXQcPrU3vSJVi5EVGlBH8HVugCMRlriF5ExsAXem2rJ+1LyV3Y6+4EUaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NGe9071dH2fGGayYbJedj9F1gjaLZ2rymGzxIujeKA=;
 b=bHg0K6h6L9T5lMOFiQ6tIkwzsijzLuPx/D/mn6j2fQBExgvaCPG7h6B0O9s8vk6i2gW5Lcjcw3ZtCZQ7lxt7VsT+fMHEs2euVLheqpJSU+9sHiRXQ/9UY/cKNO7YoXCHMyg9TtoAjMTgFg4ucHGnDY+r2tsgGJekN1d9MulsILZiNFWP2hb4OmaV/XE9orgq+003O8qTE16DB5ep/Tz6HRpIYK4dlTKpR81ZikA3qw7JTVVHuD+LP9onundDm5H6094uLRRC9U6ZaFa6qsT5EL1oA8LMp5ZhewDeCL/SIv8rUG+ZrBEma6LQjda6PRqGiSUtVeQ1q78qo7k9Y37Lug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NGe9071dH2fGGayYbJedj9F1gjaLZ2rymGzxIujeKA=;
 b=g7fOCMAGjFFwWLofyWd38W6fpnoh7PZH/8nAtz+p/2LzozMMRWVvwn4dTW3XPSZjZWnRMOModCUOGAj5yeBSNgalfyv5O4zRwh81UZhBymmRxVDYRqa+nQTcV0HPS2JPltfwYyNPYSMD+ZRtYOjwG8l8iIpO/yu1ceFe0TkToDE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Wed, 2 Sep
 2020 19:29:30 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86%5]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 19:29:30 +0000
Subject: Re: [PATCH v2 1/2] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20200828203332.11129-1-Smita.KoralahalliChannabasappa@amd.com>
 <20200828203332.11129-2-Smita.KoralahalliChannabasappa@amd.com>
 <878sdvv20h.fsf@kokedama.swc.toshiba.co.jp>
From:   Smita Koralahalli Channabasappa <skoralah@amd.com>
Message-ID: <102d0c75-d642-8f8b-68c7-792499c2a62a@amd.com>
Date:   Wed, 2 Sep 2020 14:29:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <878sdvv20h.fsf@kokedama.swc.toshiba.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN6PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:805:66::42) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN6PR08CA0029.namprd08.prod.outlook.com (2603:10b6:805:66::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 19:29:29 +0000
X-Originating-IP: [2605:6000:101a:88d8:7cc2:c97e:51db:6288]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9bf4d514-830c-4c3a-cead-08d84f76836c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB276677306DB92136916E69E2902F0@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dY8CXfcKp2x1VouSW9EVGfVRd72MVnY36AFpPTdNhGxO65py64t6wx3cNb1ccc4E9pRWC69NLAEkLVkWobCDUTUJ1YFk4Y6DFdKasHUFXtxxUkArdCPBH5dZEXRyP7jrdi/ReVGCS8nPrOJR5q8wwStherKggF7lYaDLQ0Ub9ZkFrW+opvXsUfoGqDOTiulijjEnQZecNBpXussmZJR2La8H21FJ/nYylDJRAzebRK8Xjid8jpXXvJaTrbR1CDijKjuzMRWOH2n5yrCSn2cNT7niEaysEicIlbsA2YadReneQaaO3i5rONlunhWOt2pyiDGw0H0sjuPzsPlknWQTFoVk7QekCWHXc6LNvHb5Kdq6NYcw1NbT8RyGz+oD4R2A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(52116002)(7416002)(53546011)(8676002)(66946007)(66556008)(66476007)(186003)(4326008)(31696002)(31686004)(2906002)(6486002)(54906003)(6916009)(478600001)(316002)(5660300002)(16576012)(8936002)(956004)(36756003)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bUp6CPAoh18BzfZ3ptygou6uiHGtwa3q+SJtqvFU5W87X61vj9xk+jcCQLEkMMityfPtk7HEZGEO17iHgcPU4cRDIoj9Rv4qEepch6xbKHeJtqR2xO0Jx9wOFJ/+RgkimsxprZWApN7yeAYQwO+4sRbltU6c0T6FkWlUKceM94/0nk9gMZRoVva7PabNCtUDDsJRuGvVW31bPxUdo+zPmeGapYLrnufti8ihV1O35XJ/ZD6r8+rpab2Bs3K/OgbPljhKMOuTUWecsOl8KoR9E21fGpljAQHr8YhlO6WGqThWo6RzShntNn+vKLxbhowugq9o9CYGS0hHsD8p3WqUdoPf9t/+UwK3dEopc7/A+MWMHwpN8Q6n2NLbqNmCYJWV3iVH2qLjmrkkgw3XUMEPYU6kRyrE8SNql6FxBGJsIjpCCFqSCZkBNmOhUTN+XkhzjQZxalDld9tCRMmTqeLIDPdF+HV0W7LZ5cwaHbZUhRz1io3joONJkR4WHoVjSBE9O8Z+TR7MrurkEk9KU1UW4WizTnbAQWcA0wPBP6CtqZ+8hOhTjN9DRQr8R+vvyqqkimKI3obpcP4b7P+YJB1pAyIr8Xi3Zn1QOBuE4I1+JJxTAaPqjCR6AHsKMVTBxbodE83A+qtOxwhlG79VeDuPSvFyj5Zv/mZ/3E6PjA7KzDE2Y6Ne3W/SwI82IBKAtuUd/6bGY25I2aRxfnNk6swgVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf4d514-830c-4c3a-cead-08d84f76836c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 19:29:30.4895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/FA9DIIxzL7Yz4TfkYI5QWufjBkMl4ZhIGsrIXeIBJwzGX6W9hdf1Ks3v+ajq/KtFNV26aR8A3iYQVuKHPaIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/31/20 12:05 AM, Punit Agrawal wrote:

> Hi Smita,
>
> A couple of comments below -
>
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> writes:
>
> [...]
>
>
>> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
>> index 2531de49f56c..374b8e18552a 100644
>> --- a/drivers/firmware/efi/cper-x86.c
>> +++ b/drivers/firmware/efi/cper-x86.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   // Copyright (C) 2018, Advanced Micro Devices, Inc.
>>   
>> -#include <linux/cper.h>
> Why is the include dropped? AFAICT, the definitions from there are still
> being used after this patch.

Dropped because <acpi/apei.h> already includes <linux/cper.h>

>> +#include <acpi/apei.h>

[...]

>> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
>> index 680f80960c3d..44d4d08acce0 100644
>> --- a/include/acpi/apei.h
>> +++ b/include/acpi/apei.h
>> @@ -33,8 +33,15 @@ extern bool ghes_disable;
>>   
>>   #ifdef CONFIG_ACPI_APEI
>>   void __init acpi_hest_init(void);
>> +int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
>> +			       u64 lapic_id);
>>   #else
>>   static inline void acpi_hest_init(void) { return; }
>> +static inline int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
>> +					     u64 lapic_id)
>> +{
>> +	return -EINVAL;
>> +}
>>   #endif
> Adding the declaration to this include violates the separation of
> generic and architecture specific code.
>
> Can this be moved to the appropriate architecture specific header?
> Perhaps arch/x86/include/asm/apei.h.

Yes, I have fixed this and moved into arch/x86/include/asm/acpi.h.

>>   typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>> @@ -51,6 +58,8 @@ int erst_clear(u64 record_id);
>>   
>>   int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
>>   void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
>> +int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
>> +			       u64 lapic_id);
>
> Why is the additional declaration needed?

Will fix in the next revision.

Thanks,
Smita

[...]

