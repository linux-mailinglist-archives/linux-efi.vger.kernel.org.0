Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4069144DC29
	for <lists+linux-efi@lfdr.de>; Thu, 11 Nov 2021 20:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhKKTax (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Nov 2021 14:30:53 -0500
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:17408
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229710AbhKKTaw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 11 Nov 2021 14:30:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha140z4dhZjbRprZykwkjTvk8uKduYqmX40AvVwLOUydljQ1TwiayXnIyBxsppbZqshyQVyVOOcTKjihP6JcyDv/eb1FXcWhWsQFAXKLxz/2+bZI11jl/8hAKBx/KFQCta2m2jJkB90tytM63J4cag/7p2uDYXWH2zoKiPFShEVj2JOoEDI73AbncYYtOePrXsngg/P9SGMMuhz/9h2eprjPWkP9a83ceYhMmLDaK03OlBos2P1CDLRbngOIPihi+R5MTIWCio4EFcc6XodEMuZCcVp1sMQawo15F40DYmlQ2yRxprT27xwOq0wFv0Ssyr7eFP3boHAxznlXrrjB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwdJ6cuBX6in83SlpHeLAc8qPzHGh4aLmmfGmUEbMhQ=;
 b=CQaSwL3BOvdTo8t080twUxv4B6CQmYGui/6Qq1LsBjBLahOiW2JsFLK8+N+eYp2Q1aCw2sXQ6Bh96h8EqD81wptHYcumZrA8j/Zas/kyZ7dgrAD+EfFP4mTQLKVfVk61uXh7YafehHC9NyES5VnEutG83FqMUzHehQCdiWut3QIIuNMPCM6xOJzddwP0TBG63pJ3xHBzvqv+NtV/olcgsww9c3utXKCS9vWSlXHlIJ5qlT3/IHfW8VKZggmoT4qRVEEZZufwi69c77Wrdi8hsD+5FfZxJmV+ht4LA5lY/CcF3QwrECk9jzpU17nU7FW3gEgWWeeAhc3+OJ8jbVUvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwdJ6cuBX6in83SlpHeLAc8qPzHGh4aLmmfGmUEbMhQ=;
 b=DJXVwuP964vJrsabv5UoooNOSfVEd6M1ds/HjJ7aj6HRd9Zj9Da3oNvtpGRvSsDTjmByVGJpms0/WpFTOzcbOzkEPG8ELfqOHit1slyaouugR6U7DgwgviZg2yCaBG4EVgTg1iQ0OiPP7qeKh8Be89PTtonn/NULJlLspsHoXSE=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 11 Nov
 2021 19:27:58 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4669.020; Thu, 11 Nov 2021
 19:27:58 +0000
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 43/45] virt: Add SEV-SNP guest driver
To:     Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-44-brijesh.singh@amd.com>
 <e8baf85f-8f17-d43e-4656-ed9003affaa8@infradead.org>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <38e5047c-43a9-400b-c507-337011e0e605@amd.com>
Date:   Thu, 11 Nov 2021 13:27:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <e8baf85f-8f17-d43e-4656-ed9003affaa8@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36)
 To SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 19:27:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0687d810-3925-499f-2caf-08d9a5495e64
X-MS-TrafficTypeDiagnostic: SN6PR12MB2685:
X-Microsoft-Antispam-PRVS: <SN6PR12MB26850CA605BA836054479F4EE5949@SN6PR12MB2685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TwXCuk3RiJnxhmmdsDv3dZQFHQS/nAxCnqAVwjP+4BtxvwyhN8YvYd5ak5tVlUTt6PbSBiPR65dPNGPROuLQHFP6TRlcFYw+RTGNJLzO6ite/IGbn4aJR6tXPkvh7R/fKCEOamNUFnPCwK8z+llRf73zeiuDh6xWQT1n/Q+/sZoWYz1KUmMtIM9OT+QuDIetQogZwH7opOsKVv1qNQK7jdv7Sg+iq+sT5E1kDo8/18BYN+anjYMyUJ84OM5rfkf5RtpDY4mN4pRocrkkIww3etVXEulsVPaCbj4y+MKR/1OK4o5wdWp980pyLwh7bIBooZrfQq+QbD4Ep+yzA5VIXsB8HGpEUCy4mY3rSVDgg0u2cCg28NPX/i+dk5DrrVjW2JxgYXF5wTZxdV6uQOOpymUmwL7blfXyAz0Xyj+VTrbb7yXTssSux8yEPDojdkCgKKyGKhmiYfgBliiR0jLf+YpqACziDfVKKcSZNJScGoccJeYbBJ8U7HbTeF3kIQad56woTZPFssB5G2M0Hg7dhz36UcFgmp7oZLfRX1EB714mohEcI4KuuvVWnpI/Kd8+I2/3AsiFCkTL4EmC9h7PufDtp/ifhJOQYOiDkP+HWkTRbi/FcvHY6gczVCJWkU4WXfd3he7e4VIHxbYSmOEATn5D+PT1alRezpcHuLh6ZGwRpZQW/9zvWTy8nxy20CLVvjUgme9FSSk52+hEduhHfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(26005)(66946007)(16576012)(53546011)(5660300002)(54906003)(2616005)(2906002)(6486002)(31696002)(38100700002)(316002)(83380400001)(44832011)(31686004)(508600001)(956004)(36756003)(7416002)(8936002)(66476007)(66556008)(7406005)(8676002)(186003)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0h4LzNvY3cxRVN0cVh0bzVXNXhIMVY3dkVDbWFQbUxkcEhqckJtY3NDYmpq?=
 =?utf-8?B?ZW92ZTlLU3pxUTNTR2h2dnVNc3dMQytLQ3JKRW5pMXpmKzlNb1hVSk5mWmgw?=
 =?utf-8?B?RzJEQVlpeDdndVpGYnUydXNWQ2lXYlpaeDhnSXI3REdueUZKdmUxRkdTbVMx?=
 =?utf-8?B?TnN4Zi9QZmNGcmFuMWJCSFk0d0NRd2FORWxNSkliWDBreEVGS3ZPbkNDalcx?=
 =?utf-8?B?UDNVQmtpdDcrSjAwdXZXenBlbzk3M25IYWExbFlYbzR3bzBrRTluMEFmS2hK?=
 =?utf-8?B?MVFyTmVDTGJZaWF6aENkeGoxb2dzc2x2QUJqdldYU2hlc3ZGV04rUFZGRXhM?=
 =?utf-8?B?RDBRR1pyU0x6VTg5RkVrT25TZWszaitoT1pGeFdUcXEyU2RrcXRIMzU2OU5N?=
 =?utf-8?B?aS9PU3ZuRmNoRWt0S2VLSDVBQStBNkU2SG1INUl2RXpVdXlHblhVVW1hUnc3?=
 =?utf-8?B?Z1dSL1NZRXRRTTk4ck5VdnVyMCtTTDFKVjdRY0l1R290U2FaaGFoN0NBMlJC?=
 =?utf-8?B?VjUrVGZzbUViamJWMHVaWjF5WmdBam1XM1NyWmhxV2VIa2d5S3pob251Mkxm?=
 =?utf-8?B?VkxXV3JYbUY0ZkFKdmk4eXBWeTNwUW5DRC9CR1V6YWNnMXJmeXl1Q09HZWEw?=
 =?utf-8?B?QUFBUDN0bnR3eEg2RGNuUnJLb1hKanQ5MkliNnM4ZG01SDVjclNZZnpYVHh2?=
 =?utf-8?B?eW5MQnMwcFIwcnBQT1Uvb1hhL3Q1NTdFQk5rU1RQQzhHaTJyMzM4WDZYbEtE?=
 =?utf-8?B?VVFZMUxydnZxTERrNnJMaEphWW9HOGFIMnZ3bUJVV3hUK3JXa0duam44MTNB?=
 =?utf-8?B?eU1WS3JSbExIUHZrRnBsTEgrVW9zZm00S3ZoTlJ3Q0M0MlZnUVR4aU1KZ3lO?=
 =?utf-8?B?SEUvb0lFVHdaTkVoNWt5SGgrNHQ4V3oxbkdCT0pOcjFxbVNQUlUwcTNXbHo0?=
 =?utf-8?B?WHJaeEZNbG95Yml4aFl1RUMwdThwYXJlYnQ5dTBPUFc2MC9Qd0picUhoTVV6?=
 =?utf-8?B?QWQ4QTdMWWZYdTVLZmtNOFhwSUpuMzJTOWl4WDlWaGl3SGRqanEwaUMrcVdp?=
 =?utf-8?B?STUzTmlpR3EyNmlRNGxjd1BIMkVlY3F4bFEvOXkrTWF4VzJEYUlENEF4OXZD?=
 =?utf-8?B?RnhLZnJuN05IQURtQTVIMU9nWm42WFNtajZteFg2V1l5Zit2T0tVVElFY1Vu?=
 =?utf-8?B?N2RwL053bER2TmpmM2ZWdDRBdVYwbXVNdlZUd2lMZjlhdS9CbTJPVkJ0c21i?=
 =?utf-8?B?WjFIYXVnbXlTQW4vY0NLcUxkVEQzRklIOFp0OUpzNmZUenB5V2k5cks0bzJu?=
 =?utf-8?B?NUdwRkNQQWpYYk1keFByalpiVkhkdi9MbkUxTW9JWExKb1dYMndla0MwSzlh?=
 =?utf-8?B?S0lITmVWazJnemNFc0w0VFNDYmtWSGhDUk9QYjErcklWYWVSTmdMMVprVXM4?=
 =?utf-8?B?cFdJRU1TSWJuc3dFSzJiZVFvNG11QitNRmtWbDJNVjdlSnN0cC9aV3orZUtX?=
 =?utf-8?B?SVlHNGFNSHlLYkc4NEgxdkRraDNMQ3ZFSy9lcTZaRzJmTElsOEJmVnRnUmRG?=
 =?utf-8?B?bC8vZVovQm5jTlgvSnZidkZLdW11bWYyMzdPYU93a2c5czdBT3dqZGFPR2la?=
 =?utf-8?B?MmNySndwWVZ6Q2tEUTNRaE5Za2VGZFNZbE81MWI3RS9qRXZUem5CUldWUGRp?=
 =?utf-8?B?RWVoeDBqR2k3ODVlcWhHa1hBZ3I0WldYRStWb3RMTWlzZjRrcXZGNHE2OEpF?=
 =?utf-8?B?SU0wa2U5SFZaZWF1a201RUowVGQ4blhwTnhONm14cUF6T0Nnc1MreVhNVmdP?=
 =?utf-8?B?TjRtZE9QMkdGT2xmcWZKdGlQL0NINktkTllmSG9Yc1MwaEI0bEVaVTZsVWxj?=
 =?utf-8?B?bUM2Wkl1bTlVRkdhNUNQNnk5TmZPNGNMNmoyVk8yUDM2TVlEK3BnKzNmWnV3?=
 =?utf-8?B?ZUhZb2hJNHk4RlZLc1N5YnZLMjNRM0FsazY5bjhHTDdUS3ZCNU9vamlaNkk4?=
 =?utf-8?B?YWVOc2xZUHMyZld1blVRRzdXTlRFZmlJTlU0aXdvdkVVTjkvMlRuMHFSN24y?=
 =?utf-8?B?S3dwRHZNektNNFVSVHUrVEhmYnJiWHByWjZKR3ZKaWxjL00yaEFwR0xNSlcr?=
 =?utf-8?B?VEw1cjgyODJlQnVaZFlic2tPOTBKc1BPRDhEQ0xRVENpZVpjN21oZWVYSFdX?=
 =?utf-8?Q?15Tv+Nn8qqagG8Vr4QdT1Gw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0687d810-3925-499f-2caf-08d9a5495e64
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 19:27:58.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnxssjhrK+smCbUElDoomUJsJG4WWMpGt1+zIQ6VW8o/Jxg6EOs4VaSP2j+XrZqGgL9z3X0tV61pj6m5HkBDpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Randy,

On 11/10/21 4:27 PM, Randy Dunlap wrote:
> Hi,
> 
> On 11/10/21 2:07 PM, Brijesh Singh wrote:
>> diff --git a/drivers/virt/coco/sevguest/Kconfig 
>> b/drivers/virt/coco/sevguest/Kconfig
>> new file mode 100644
>> index 000000000000..96190919cca8
>> --- /dev/null
>> +++ b/drivers/virt/coco/sevguest/Kconfig
>> @@ -0,0 +1,9 @@
>> +config SEV_GUEST
>> +    tristate "AMD SEV Guest driver"
>> +    default y
> 
> For this to remain as "default y", you need to justify it.
> E.g., if a board cannot boot with an interrupt controller,
> the driver for the interrupt controller can be "default y".
> 
> So why is this default y?
> No other drivers in drivers/virt/ are default y.
> 

I choose the default "y" for two reasons:

1.  The driver is built if the user enables the AMD memory encryption 
support. If the user has selected the AMD memory encryption support, 
they will be querying an attestation report to verify that the guest is 
running on AMD memory encryption enabled hardware.

2. Typically, an attestation report is retrieved from an initial ramdisk 
(before mounting the disk). IIUC, the standard initramfs build tools may 
not include the driver by default and requires the user to go through hoops.

However, I have no strong reason to keep it to "y" if other prefers "m".

thanks
