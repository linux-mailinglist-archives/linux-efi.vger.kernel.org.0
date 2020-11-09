Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339F82AC497
	for <lists+linux-efi@lfdr.de>; Mon,  9 Nov 2020 20:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgKITF0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Nov 2020 14:05:26 -0500
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:42625
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727303AbgKITFZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 9 Nov 2020 14:05:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFFrp1vPtZShqiPX0HO9HzjNz+q4gE+bepqhx3Keuxm/rtCfJJbiYzBA0suV0mppDms8YhbmxJzw0roy2Sq6D2jgmBGgghjNMPQlMeSTEbDeGPoIM+EdzbOdPWwBOIPSPqL8z8NBEh3MX4QKhj2Jqdb61aqtllVD6pvP/M6xSCrUXb6uf26IsFFPMeeq2wFsumSWs/MdUtawbg/Ebpoz9W9TrTv+KWrjbetVPXqSGYyIn/ae1R0m2FRnoI/CaYf3yFEvnGAmH8bCTUMRJmp8kcxEwypVMmJw4WXHAPK7k5nesiEuTiYz4TbrWBH91BdnqgBTe0NFGswmAOOwxqX7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeAXrI/FXDPgaOwJCTbrr8i7cGeH6XpsCPb3Bp/W+5s=;
 b=AgPp0XSQlNszZGfu2ehQwAsXgxDKpgeHhGgiEpI4J/yrigNNcT1JmI4qNvWjEipl6akhkbQXPnwCFZ/vEQIXlnTXIG/RtMv3du3KkiFDpWAGvURPAQxy/XHR9tQi86OwpHV34LLPUeMLKZDb0orLXeuxRRCbC5NbR+/3ZLj3wUdZ0LRFCJaFg9eiy8wi1tLMyAm0s3h7EfiOQMYXFXQ6F0hlg6uxx0d6NJbssxdVREckp1RcCOvbR8bXQ5wnKBD3y6iIBVaNl4BmJblB0LGmgUgAkO/PNlD1f5hrAgRAzTrRDDvzGxJB2qsZm66G/sTycwuH7zr/SH7Lnz0gbxb8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeAXrI/FXDPgaOwJCTbrr8i7cGeH6XpsCPb3Bp/W+5s=;
 b=fmHtbFqjGvQPi7BZOMeLe7BGIpq/32shOsrIJTNfgY+4/hwLPapEemgr7+enfb/fU8G4RV+vf6KdQxJVVSZEAg3XZLrNsH1lxPSnsPPVyXVNQm700nic9ALvGmq797+XmmQueXFRooNMcD1XeiZElpQRQMO9A7grLNp/k3v+UlM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN1PR12MB2415.namprd12.prod.outlook.com (2603:10b6:802:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Mon, 9 Nov
 2020 19:05:22 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::a160:c63e:b49a:8f9a]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::a160:c63e:b49a:8f9a%3]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 19:05:22 +0000
Subject: Re: [PATCH v5] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
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
From:   Smita Koralahalli Channabasappa <skoralah@amd.com>
Message-ID: <982e0243-b144-f8b6-d69d-45af94ed8bb9@amd.com>
Date:   Mon, 9 Nov 2020 13:05:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <874klz9vk9.fsf@kokedama.swc.toshiba.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2603:8080:1807:186d:2d3f:50b3:ce8f:b4ef]
X-ClientProxiedBy: SN2PR01CA0046.prod.exchangelabs.com (2603:10b6:800::14) To
 SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2603:8080:1807:186d:2d3f:50b3:ce8f:b4ef] (2603:8080:1807:186d:2d3f:50b3:ce8f:b4ef) by SN2PR01CA0046.prod.exchangelabs.com (2603:10b6:800::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 19:05:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a821bfc-c0d2-4c93-24e2-08d884e26839
X-MS-TrafficTypeDiagnostic: SN1PR12MB2415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24157EF4AC140D28079F9AFB90EA0@SN1PR12MB2415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvR4KlSmRFMytTwDqwDayHfN+LfFvafZa2Q1+ibPH3x070igjUC6r35h3Y/5RP8s2LMrvCVPFrduH8qhdcaOBb3ezsHWoYDB39f8ootV0ivR0JZbIuwV8q7Dp+b7kk9+L4+PhKUilxcRAmqwK0TPWWaIZF5Gl/76d2tkKwnE6TAtqnU9ITDHLJ1JkOXnYj1/VxHZqBsTYq5KH8aw5qFlw6wIhZFfxT2umA0TuTj1V5Lfh2uObjr0ttDcfoHsA3smQ05sACJJma2vaqHkVR9cVzXcrGIgdlu/I0iztTv9te+Maec061Iv9Nc7rvwUZtzEAG+3Z7JDbTe420SFc3BUX705LrSdvbkit+AoD+I5eMlPksnTcsIXJFIQmD44rI9y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(16526019)(186003)(4326008)(8676002)(36756003)(66476007)(8936002)(2906002)(66556008)(66946007)(52116002)(316002)(54906003)(110136005)(2616005)(31696002)(53546011)(5660300002)(6486002)(478600001)(31686004)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cGNBZkFPSmNDUkUxVkp1Y1FjRjNUTjUwVWdhQlI3WUR6Ykt5blhHa3pHQ3JV?=
 =?utf-8?B?WDJVL2VTeFFWdW91R0hGMm90S3pXUVFuVGt5QTlyV2t1WmgrQ0luMkNRU05B?=
 =?utf-8?B?Rnd0My94VitHVDk0c2duTVBJUWh2SlY3N3pDQ1ptWEIwWmcwdUJpMENjeWlM?=
 =?utf-8?B?QktzdE9SbGthdVVMbTNOZXhLZEhVUzVlVDBsMDQ0TkM2MFJSdUhTeGRrZTRh?=
 =?utf-8?B?RDh4TjBPSU1sWXQzMHR4dW9UMlUzSGdNVVBDM3RWTm1OMDZaV1cvckwyL2Qw?=
 =?utf-8?B?dGRkSE5RT1lLbHdEa1hHbUowNjcwc2FYVGprZGFpY0MvKzdjOWlNbHp1dU1F?=
 =?utf-8?B?bHJ5UTNVUUtLK2tpVVFxcWVzK0o3V04rNURyL1lvRW9weWxqUDFFNmdsSXZr?=
 =?utf-8?B?MU1iSlE4UStXL28wWVppQWNjRHVPNDNmRVhkYUs2bTRZSGdJK1RvNDBlaGhq?=
 =?utf-8?B?NjU0azMvYytCVm5LdWlXcGNVWFRucCs3TFZ2ZUh4dzU3bVUvM08yQzFQbS9l?=
 =?utf-8?B?R2V0OGdtZ0s0bjBQVUR6TG1iVG94L0JMaHZ1UzZWM3U4ekRndDBFaVA3cFlT?=
 =?utf-8?B?UUQvS29FWldFV3ZEaHk1UkpLa0RHNUJFaTlQQmVFQWVTcGpUamgrOHE3TW5l?=
 =?utf-8?B?djZ2dEVFazZsd2VLWmdSVFRraC85bUY0TUEyN0ZYbzRCOHVsaHRtY01adWcv?=
 =?utf-8?B?L2xOTFhOMFYrNmRaVisyaTcxWWJFZkpSbUFGQ0tUSy84VFA4Zy9WM2J0cjZi?=
 =?utf-8?B?T09iK01vSmFZMlJIT1FESm1CZFQxbmhXSlRrRERROE4zYmMzVFgwTHovNnJY?=
 =?utf-8?B?K3hqa3BqODlKUVJod2lrQTNtNmNHQWlzRldVN2tRVE1ua21pWXk5QkhwZjls?=
 =?utf-8?B?RVdsbnk1U3BzOGtiTnRXTGN1WlZILzljaUhodlBMaFRXa1VkSDBhWUMzQWd2?=
 =?utf-8?B?bkN5WHVsRjM2bFhTYktmem16Wk04WmszQkUyVVVoc25iakc4bUMxMGltN2l0?=
 =?utf-8?B?SEU3d1F3NVBDMGsrMjlza09MbFl0eGRWQjhIRWEvbWEyNmJGSW5FWjhCV3U2?=
 =?utf-8?B?WTgySnR0Q05qbnFMU2lxbzJ4NXBVK3FKUEY1bnhVUFZwSVpzeW1hMk82eFFQ?=
 =?utf-8?B?eUhYV3VxREdEUXhpbnMvSUhiRWppOUIzWnVjQ25MaEJEYWkxSmRYVkk3NE9O?=
 =?utf-8?B?SnJXa3BXVnUyclZwVkVJZ0VxYU9maE51M1hGOWFuYXNEdU5JRmhRWnVlS2tr?=
 =?utf-8?B?VndNRThyWEJOdG9IbENwUzBkOVFLV2F1OG9ka0hFRytwZmQwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a821bfc-c0d2-4c93-24e2-08d884e26839
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 19:05:22.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQ4DpLAI7qhlVPaDcIplV4MFp/wTkI7lbfPmqPJDqCoat86GyMu9O0UmRxWjc1vODPbn7RN2f2be78zqn1IZ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/8/20 7:18 PM, Punit Agrawal wrote:

> Borislav Petkov <bp@alien8.de> writes:
>
>> On Fri, Nov 06, 2020 at 02:36:46PM +0900, Punit Agrawal wrote:
>>>> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
>>>> index 2531de49f56c..438ed9eff6d0 100644
>>>> --- a/drivers/firmware/efi/cper-x86.c
>>>> +++ b/drivers/firmware/efi/cper-x86.c
>>>> @@ -2,6 +2,7 @@
>>>>   // Copyright (C) 2018, Advanced Micro Devices, Inc.
>>>>   
>>>>   #include <linux/cper.h>
>>>> +#include <linux/acpi.h>
>>> Did you mean to include <asm/acpi.h>?
>> Why?
> Because arch_apei_report_x86_error() used in the patch is defined
> there. The indirect include works but pulls in additional definitions
> not needed by the patch.
>
> Do you prefer the more generic include?

Okay.

I agree, it's generally a good practice to avoid pulling up additional
definitions. I had this when I made the declaration in generic header
file and may be I did not consider it changing initially as my build
didn't break after moving the declaration from generic header to arch
specific header file.

I will take care henceforth and make the changes as required.

Thanks,

