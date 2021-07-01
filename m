Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0063B9831
	for <lists+linux-efi@lfdr.de>; Thu,  1 Jul 2021 23:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhGAVfE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Jul 2021 17:35:04 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:27393
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229934AbhGAVfE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 1 Jul 2021 17:35:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5l9TtX8cO71NOG44/WRVL+jDBTYZyS5Rf5T0paajjCbVKxsTQfQ7+0YyF1qnDJ2cX78ouh9K0/sncFBcx7/AAmeF6WeJJdxBTBOuGCmd5eecKB1wok7An24OTpe1sLxNoZo0p5HkAvulWVVHzsTxekaUwed9ViqWxfrIKtIr5gvQ/1hPMiB6E7kt+OzuSFzEA9666v/RSlPGfcHO9T8dvM/1rB0syKFe/OtuwilwlRszuO042hVulMLnr7ANTCzmSneOuzguJFoWoxLNBpfEa9UPM9tTeh0NCfEEmvZQC6/BkbsR5e00ph74rPgkx/z/QmuM+ERxZ7Iw01NbK+SLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLb+DQNtdNhY8DyDlt6JZO25i1CVWLje6cwrD5uew04=;
 b=fJaYzPv16RI7TNw1a4fU2En/vEzdc/vJCJ/ZG8aRPn+mR3At2z5PgGX6iq3Z1VLQqSKWulR3BEfkS6bfXsLC014iVEGIJ8EeDhjPdx3bxDvn5MpozfIqoxeojsT4Z0/Qxac7tej39qHkaAet20f+9oj4Lz5JlSiWa1uVpL7AxfUuzkM+Y4EEJlL5GMTQPcGLyr3hgqZulxu7yKY+izd0qO6r76J/zal7F2Z9KT0M0F2jAyXmmAaqDg/aY3v3uKTWzyj3+J4v2i8KngWtQnsqxv/EhV3ONm8kxxpfB4ldvBipiDPMtHaAfeMGOJDO69cV0zG5wPA8RZRuOaWzrEQ2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLb+DQNtdNhY8DyDlt6JZO25i1CVWLje6cwrD5uew04=;
 b=5rCo+4YnIqseUCQmKmZ9uDBiFb5ntJCwVmpGNvVr6biO0smMdy6BprqvI3uNKjNfqqZGq85pOLU1VJ0L8dJ+Mz/mopdJAfTs1EqH/jxhKOAeC8P5/+avAQRI9FXiqhTYO8I+tP0gZt+KlSDdSCC89+oHs/AghnvS0SGOJ9yXZQA=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM5PR12MB1513.namprd12.prod.outlook.com (2603:10b6:4:d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.23; Thu, 1 Jul 2021 21:32:30 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4264.026; Thu, 1 Jul 2021
 21:32:30 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Dov Murik <dovmurik@linux.ibm.com>
Subject: Re: [PATCH Part1 RFC v3 22/22] virt: Add SEV-SNP guest driver
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-23-brijesh.singh@amd.com> <YNxzJ2I3ZumTELLb@zn.tnic>
 <46499161-0106-3ae9-9688-0afd9076b28b@amd.com> <YN4DixahyShxyyCv@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <5b4d20db-3013-4411-03b9-708dd18dbe64@amd.com>
Date:   Thu, 1 Jul 2021 16:32:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YN4DixahyShxyyCv@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SA0PR11CA0206.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::31) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.130.124] (165.204.78.25) by SA0PR11CA0206.namprd11.prod.outlook.com (2603:10b6:806:1bc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 21:32:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f689bc1-73c6-4e7b-026e-08d93cd7bafc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1513C55B2C7FE8D4568E132FE5009@DM5PR12MB1513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hIa4N0XaaiNvRcz8of1xKf1JULnfGRZzzVTEQGQRGShmrNG5HjJfbrf1JvGtMsGxBFkkfzu2KlX62i9g39HbceGjViJ8QOdUUXbLISh4jy3DHQZE7/2jDIsUxVI50SNuBkehG7t0TQjbUB48FXjevglPMPh3TCi0uwBBmwKeoQN8JlcSD+ebO4ktUuAtsy85FMUG9ZviPo47Ty1toLHzNvWOUfXZhpvhC3DTYCuhyX3S7BHtZm1bp6ACqMOhUYVRoXNDbK1RjPYwFVWSRJmKO8NSzUGu1hz2vuoFTgu/UUois21eVZVKklsYrPXVRdKcVVXVDy8iMr8l7D2oV5z3dg0y9UcLeHvrzWONC9CDeC/LAiadk0fqoLkMk4sU8+BGworC+lRG5c5DR4G1vmooGc9QUAPrhAWQ5lIMOSoheei/ePI7sGhHxuk8vWKM3Bv4qKxeSQE4bVR3fsRa4c8Ohk97043UTgKPQQKNad3X87gat2Q7pPx/MDPBe+XAh0FAHDvW3Ov2yZSjOhmPkmk8zErz29FdsttC6HPFB264ZlVBULr9Vy/BSfxtW2WFCRHFVflLibE8PSLo/Iob6i0KMZ0GjO/FIDZJEu/zzOLXWMn1x2/HVbZJP/Io9BreH4heYQr9i9jUKJymHWqtJcB0Cyisz7l8P4GsyV20pkaTEDllqQibKWS+zp/s+J2Y0/tQd+n/yuFc4G7OMMHet2LOdauJqvmxV+FjpubHwXkFK/rBigZFKAPbWjtuYE2Wnny17obTqIgPw/+6RlXIFjPqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(2616005)(66556008)(956004)(7416002)(66476007)(5660300002)(6916009)(36756003)(44832011)(16526019)(38100700002)(38350700002)(478600001)(31696002)(26005)(186003)(86362001)(53546011)(4326008)(2906002)(31686004)(66946007)(52116002)(16576012)(316002)(83380400001)(6486002)(8676002)(8936002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHA2VTVZNHJBS2V2QlBrZi85cXhwc1p0QyszZm5OS3JBNlR2eXEzUDF1enFD?=
 =?utf-8?B?UDdZYXRUMGwrR0FWMHlld2c2ZzA4RURYUFpqa0ZNdGNzM0MzTWJTZ1B0WDRj?=
 =?utf-8?B?TlJBV1NWSm1ON0p2TjRTV1JBdThmWUZkUDNnOVZqNnFiOHJwOEx0cHc1L29S?=
 =?utf-8?B?OGZLcGVXcEF3bE5IdjJJdzZSdUVmV2wzcUducTExRWp1eHlXSFNSVVY0R1c2?=
 =?utf-8?B?d0RPeUNBRkdwcHhiNUlKTTZTVW55MjFSRjlLVjVxcDZLcXYzY0w3OFhmMFNO?=
 =?utf-8?B?aU5yTnFDZ0Fvc2ZGY3AvbjJCTDZMb0dIcC9ha0llaXgvTHZod2FPNTJaSkV1?=
 =?utf-8?B?QUR5dmkrVENRYVl6U1JZYk5URlVUR2wzOExiTEd0UTZJa1ZrcmdaRVk0Mmh6?=
 =?utf-8?B?ZEdjK2dkRVMxeVloWFNhdWZVRHRYb011eGU2bWZvZHdVTXdXbFhNQnpLTVBz?=
 =?utf-8?B?czc3Ky9DL0UrVk1FeTVmaXNMUFMwQTVYQmdFRkFJM2NzOUxwWnVvK0JvaHFh?=
 =?utf-8?B?NGhoWEpoQ3hpWEZneTBVWHBmTEVYYTFkY01xZkFsQ3ZjaFAwY0NXcTFYcTFr?=
 =?utf-8?B?anI5RnhQTDZJZUFVaXdLZTJYanc5a0lrdHFyMTlUanhiblVpdkR1V1drVlJV?=
 =?utf-8?B?cmFXeWlvaG5nOXlZYkp6cXZWaEFXZW53QTNoS0U3QkkyS2o0Z2ZyMFVzeGNX?=
 =?utf-8?B?eCtRbUFPUGVYWEJIQXl0MjgyTlZmTnUvM0UrYmVRVzdXVkhGY0lKdGx2dkNO?=
 =?utf-8?B?TEJzbTJ2a2pSNzRHSUplRFNvcTY3Slc1R2NqRVVSKzVVMkhiWWpyTGJ4VDFq?=
 =?utf-8?B?ank1ZVhneTNIUUV5Q1R1VGh4SGtUZkhmMHNWQ205dDRKcVZQMGdHbVczMURh?=
 =?utf-8?B?Ym00aG5uMDJ6QmowM1VuQm9hbWw3WUtQK2pQRVA1QWxDNnR5R3Eya296Z29i?=
 =?utf-8?B?d0F3aXVxa0NzUDBScDZXN3o3VGc1N3lhWGJDL3ZKbXQxZldjSElKQmpYQjBm?=
 =?utf-8?B?TU45djdieXM4UUlCcVdkL1JqYU5LRTBWWFpmNHRLaC95bjBTaThreHUrcFFq?=
 =?utf-8?B?TERFK2Z4NVhPSHpCWGRtakEydjNCb0hoTG1zdVZXN2xheEtVejkxQ3FNVW9Z?=
 =?utf-8?B?NlBHQ3pKd3F0aVk1NXhOSThLT3JRcHFtTHVWMTVWUnJqTndDaEtXSm5pelhy?=
 =?utf-8?B?Q1FuTzNabEl4R0kwK2hnRUkxRjNVMFlrMlc4UUthRGtENWNvUGtEWmhGQi9h?=
 =?utf-8?B?c0piVncrZnZHcUhEMXp0UkEzVVB5Wk9hMFNWeVpKakY4Z3dQaVRQb3hNYzZs?=
 =?utf-8?B?dXdqWG41Vk15TExZUWVtMTVqV1ZmY1ZYbkF4VWtnczZrdVRXZ2p6VmNReTdF?=
 =?utf-8?B?K2JEdDdWNlZaVGx5YWVnNE5PejBUVUsrcTZ0NE1xczhnS1FENTkvZVFqc2hL?=
 =?utf-8?B?eFg0SGxiMHZibFdjbjFTUWNHUEtrN2RROHNsaUFzVDdDNlZkc1pzbkpIdXgz?=
 =?utf-8?B?RWNlN2Q1cmhXb0tkVU5EcFpwQVAxSiswbmRyM3ExWG1lRlI3aUlERFZrUHpu?=
 =?utf-8?B?V0VUbGRMcHQwRlpXaW1xWjRndW1KaFN2ME5objR5dmZFdWZIVzJNVkNtQ2h2?=
 =?utf-8?B?QU43bVRjMitldzNNQUlLNGNHMDdySDdMRC9RR1RyUjRGL0xNcUZPZ0N0V09u?=
 =?utf-8?B?K0xpN3puTlEzck1hcEU5VjVoaW53aitOWGNYWkovK1hwRnZQY2RhNyt4dDdB?=
 =?utf-8?Q?yVLi35T6LCeSQYbPzYwUPtKevRgGfYzxU0t/MAh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f689bc1-73c6-4e7b-026e-08d93cd7bafc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 21:32:30.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2L/qNovLXFgRDvKUGuzFnBW4hEgK0jZHLDK5jK0H4cOSC66f80lxehFOszQK+LoGNo4BHRQMG/isVtRSvOjcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1513
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/1/2021 1:03 PM, Borislav Petkov wrote:
> 
> Sure, but I'd call it sevguest.c and will have it deal with both SEV and
> SNP ioctls depending on what has been detected in the hardware. Or is
> there some special reason for having snp.c and sev.c separate?
> 

I don't have any strong reason. I am okay to begin putting all the SNP
stuff in the sevguest.c.


>> I followed the naming convension you recommended during the initial SEV driver
>> developement. IIRC, the main reason for us having to add "user" in it because
>> we wanted to distinguious that this structure is not exactly same as the what
>> is defined in the SEV-SNP firmware spec.
> 
> I most definitely have forgotten about this. Can you point me to the
> details of that discussion and why there's a need to distinguish?
> 
>> Good question, I am not able to find a generic place to document it. Should we
>> create a documentation "Documentation/virt/coco/sevguest-api.rst" for it ? I am
>> open to other suggestions.
> 

The spec definition is present in include/linux/psp-sev.h but sometime we don't
expose the spec defs as-is to userspace. Several SEV/SEV-SNP does not need to
be exposed to the userspace, those which need to be expose we provide a bit
modified Linux uapi for it, and for SEV drivers we choose "_user" prefix.

e.g
a spec definition for the PEK import in include/linux/psp-sev.h is:
struct sev_data_pek_cert_import {
	u64 pdh_cert_address;  /* system physical address */
	u32 pdh_cert_len;
	u32 reserved;
	...
};

But its corresponding userspace structure def in include/uapi/linux/psp-sev.h is:
struct sev_user_data_pek_cert_import {
	__u64 pek_cert_uaddr; /* userspace address */
	__u32 pek_cert_len;
	...
};

The ioctl handling takes care of mapping from uaddr to pa and other things as required.
So, I took similar approach for the SEV-SNP guest ioctl. In this particular case the
guest request structure defined in the spec contains multiple field but many of
those fields are managed internally by the kernel (e.g seqno, IV, etc etc).

-Brijesh

-Brijesh
