Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E079A6F6081
	for <lists+linux-efi@lfdr.de>; Wed,  3 May 2023 23:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjECVXW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 May 2023 17:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECVXV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 May 2023 17:23:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B1F30EF;
        Wed,  3 May 2023 14:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdBey4uZ0iBAzkJ72nTLZqQUshigLPpOHx0y7hmXmj8BAO8AioWTenmG3UZ6/h91PkzwKShMGl+LXwRDBTjzao26nxDDtaCBLa8V1rI3O+xGLmgHUlfld9XySetG/7jsGYXFRylP8wMzr2I9miNrURsMNvLjRbptYJB8Rx+Ry3WvLgkofVBVLQDZ4sT4Qqe+12BemRtQRRmiw2HqiBHvRvXmFcLKgDOoTcHRjyj4FDu+b3wLRkgEcrqj5vMuD45D/7JPNINlvzdVrfa6NbWxReQdhhXFv8ZrSwHarUan264wMWCyvW5QBELImjoAbUATqN9/MfqlgmnW3+EqULkR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rRXri4OSFkYhx5d574gEmUy++s/VBZjSlo2zajwRzg=;
 b=LM+wDOu8t6pB0SjwlC7bHulYM3/qiOALcrDIrjDZCzTOm/Jd8QAmmOb5vAM0v3/PgMV4l++BH/1+CK8jcZMB+3E1S9XrdZ4wYZHqDfCCop1Ej7mCbeod3wdxK+3s7XNXGXArJktdjDm/B1wVo5A7wTgyEyyDBAS3Ak6J4MQd1y/Ee70+rYkYUaqzwzaprZfYK6f/1pW7dZOILG0E52DjQ7wkZoOR3VfJx4FdqLthCa9nnBJr+IiJPU5F43Lav3+KrQrO5vjejl+KoVAx4q5GYdY7EYMFMlIajtDZ7IOSMOqFe8TvbTMKPDNRIEeSQnInobjemF0DSpGD4YHxcIXNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rRXri4OSFkYhx5d574gEmUy++s/VBZjSlo2zajwRzg=;
 b=GtiRcSEKgsenDWcDhSrFrLrbrLxU4JHL+yFscZTP+d1U9zawNfqeAR2PHiZy0yc3ZTtSd811b69Bhu77dfxdBEtzkRF8nSV8cX45IH3PtUAYLHa2OHb84+LK1lF51ZiaicLrP0S6vEfSuPyhnXTXsPovAzO6zSJOxqrESCnIQ68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 21:23:17 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 21:23:16 +0000
Message-ID: <6639dd3c-edf4-c4a0-cfd6-9e0a13c7738b@amd.com>
Date:   Wed, 3 May 2023 16:23:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230424165726.2245548-1-ardb@kernel.org>
 <ecbcc066-3636-9620-8db9-2c066d16e717@amd.com>
 <CAMj1kXG8ZrdEUNTiSCet+aT+1ZyrbguFsGtNhVV+XgCssZgj9w@mail.gmail.com>
 <a6846282-95c8-274a-accc-ffa54205489c@amd.com>
 <8f85787a-1fa5-8f59-6047-b3a791291bfd@amd.com>
 <CAMj1kXFfHJDXW2xWTjT5xy_-8MdeS9HhcMh3=DKFZ3+vhaUFcA@mail.gmail.com>
 <d06086cf-3bb7-0ed1-b877-c94b5ef89fc2@amd.com>
 <CAMj1kXGwF39ZjggsZ+fhac8w-LHaa++YbRT+cQM25QRKurg2Rw@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXGwF39ZjggsZ+fhac8w-LHaa++YbRT+cQM25QRKurg2Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:207:3d::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: b83bb2a8-0366-4c52-61e6-08db4c1c9c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dg233Z39LOGMt4+AyfNUGhb4iL2w0gQSdlmE9ZVQX49psB+HCFFUMKeetMreSBHCLRi3jU+K/It8sZeg817byZGMPBEZZoiVAIbp0peL6nwde6ljsxbx45ojtruf5PMKX8fmkCO/srSk63JQeIbCU9mtLvOYnxlS3TZTgg9PAk8ct6Xc6G5dG7f6nsc1iH4sHPfeI0nG8t0e1ZrD59iDbmhzlmxxyY1KE5d1JznKhzQ+wM12W/44MQiuVqM2yKn+zjQWuUvdf5xK4X5HdTonaydak8qWwAR5RcSlyRMZtrV2w3BebOJlijhgUgwJ1dx5xMqr8E3VOcKRe9XxcoYP/i2FgFCssn928/jc2IQ1GR1Z/7OjF/EGkQdxmJaYkA7MgDE/SPFXlAkiZxC3zmJD5yIKqE6q/SysfNFxOgNIEpJxyzLmSKOd5qeuydu35ym97TYQRJe4pcVQvtKTzc1adFdwm0oMRZSvuJ5IekGL7zCXP2WTT8vM7vV5LPiakDZwVQrhoISryoqRMYsZ7EBKog94/8lxcALiZ12+PvizRTqM4ltQLYY8uy/apTgyHuZgKfkARn2obLA2zJVnF/HOdK9hd56ws8hq4NB5Sb7ZgX/WfNJRtgkbSmLypqgtwu0Trp8YzGz55AEIctQA788Gpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(6512007)(6506007)(53546011)(26005)(7416002)(31686004)(186003)(2616005)(2906002)(5660300002)(83380400001)(8936002)(8676002)(6486002)(31696002)(6666004)(36756003)(41300700001)(478600001)(54906003)(38100700002)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TC9hN2N0dmlWV2dJc3lPMTErQjV4clFXcHR3d0l3Q3NmUVNsbEhrNE1WQitS?=
 =?utf-8?B?eHlFdFVhbm9UZW43K1JhbUFMdmJ4bHI0c3cwRkpib1hETjR4NUR0ZjUrMG5w?=
 =?utf-8?B?NW9KWU1IWk9LWmh1TUJldDVnd2RvTjlHbkhZbHRPWFhwV3J1eGpyNFdld2o5?=
 =?utf-8?B?ZC9INVNQY1QzOUs5Q2pWaitrbTBpRW1PaURwSE51TDJpWXRsL3NNbUViZGZ2?=
 =?utf-8?B?aHV4Y1M1M01qa0xDOW9RcHFlYmdVSmp5OXRuUVB5ZVY3Wll5VkhzMS9tVHBY?=
 =?utf-8?B?TE1uazFSbDY0OXo2VFgxbzYzaHAzSnl2bmIzYzlYZkhqUDYwWE5xbXZMNGsw?=
 =?utf-8?B?U3pwMkd0UXV5dzF4cWFtNVBzSjJmVXhubXpQSm9KMUFodUVrdXQ0dEFIZzk4?=
 =?utf-8?B?bWVaQmxyWjE1M3lvam8vbU9MSFJFQkxFbWhjaDR0RXNXL2laUE1uN0VDSWlE?=
 =?utf-8?B?anpJYW04NldSM3dzeFFPV21TTmdiM0ZrWitzRDg0Qll3OGt2R2Jwd1F1Uzkz?=
 =?utf-8?B?VUJlMDRoOXc1MmZHTlQ4b1ErTWdDS1psdHV6eDRWWVNtQ3pyaXpuZGlNS1BP?=
 =?utf-8?B?ajM2WlRPeWF1SEFNbDhjZHlLQ1dHUkpPQWc1LzN4bTBKb0Y3K3FPQzk1aWgx?=
 =?utf-8?B?Q211VVpEVm5pdkhybzM2K2dJcmFxL09GcE1tYXZRV2poRDVoYUMvaXMyTERk?=
 =?utf-8?B?L1A2WXNZVG80WXFPcnlrK0h3aDhCR1VDR2FMblQ1VG5PbDJNVk9aOVFTQ0Nw?=
 =?utf-8?B?WnNORUhuU1Y3dC9Qb2t5a2c5YmlDNnRPeTJTVHVDajBHbld6dGkyNm9LeFZU?=
 =?utf-8?B?anNVdGNGdnV1NlUyNXBjRkhzL1dLci9OaG1SbVFOZjRMdDduMGtzODVWbU9i?=
 =?utf-8?B?a0RUemdSSHdGOHV6RFdyQlYzNE04OVF6anJheFdDWE5PYWJHRzRxK1ZPTTdR?=
 =?utf-8?B?akFvWWdGeUplZXBVOVRqaGV5ZmNKTnc5VTYwbjh4VDBzSGhPMm1VNzlnQnFH?=
 =?utf-8?B?Uy94Z1YzTzd2T2xBSFlxT3pCaGtWaXFnWmJmYjBRWXJscjUydFZJRjA4NkNE?=
 =?utf-8?B?OG92MEZ5T0pjb3F0UVRyYVFZd0dTbjI0WEdUUHEwNXBEVmh3b0I1VlVEZG8z?=
 =?utf-8?B?amxIWjZaMy9xYTZRbWk3S2t6eW83MDJ1cmFWY044bkUya3FUbW1sbHVWUEVE?=
 =?utf-8?B?bkxOeDZGUm9WeWRpaVY2OGNHT1FmSjZKdEZEL0RxOHFaTldFUlpjOFA5dlRD?=
 =?utf-8?B?VmkvMXhwcWhLNGpTZ1YvTmlTUk1hb00vZm1ucTBjRUpTTlArcGR6bU1ZME9J?=
 =?utf-8?B?LzhXYittNlVJWEFjRFgwckowV1FHeHhibjNRYWMwSG92RnVTVTlhbDhGRXZT?=
 =?utf-8?B?RzJaMHV4MHh0SVlXM2Z1QmNaWk8vc0RzQ3MrL3NEUmR5V3VJOWY1NkdXMGJ3?=
 =?utf-8?B?U1ZyQzZoK1FSU2l5ejF2UHJrNDZoQStYdCtKQ2t5b2xZcFQ5VUg2cGVNVnB1?=
 =?utf-8?B?bDZMOEQwVDlBMkR5WVQzcVlicndDYW1rWUhnK1h5RitvenhkT3Y1T2RyWklC?=
 =?utf-8?B?cU8wUjY1Y2dHWVVkN0EyN3NjVTVhWTgzNit4T0hZZERBUURkUXptbG04dDZn?=
 =?utf-8?B?Tk1FWENzYm9SSllQRm9KL2M5Uy9DdzF0aHNoTVRIYkZ3L2NJVXZ3SUtZZjNo?=
 =?utf-8?B?SE13cVZUUkFWNkxFRTdUeWpBaXVRMWM3WG9CQVE5VVdjb0E4TkFVelFoSE1O?=
 =?utf-8?B?VURWRFYrc2lLR1JibGxYMHB3OWg1ZWZibWZ4Uk5NYXhVZkU5QU8rWDBiL3Z1?=
 =?utf-8?B?Nzl0emN5aUVGOXF3THZGbXo0cXpsV1AySk42MnZVcSticmRrMXJkSFAvUE9r?=
 =?utf-8?B?WXZFRlQ5NHFjcEJ3MDZTTkFLYWVqdlgwVllPd2FLT1F1aVFmRFJ5M3hJNHpW?=
 =?utf-8?B?Y1ZDZmxUdEJZOURONXBMNVlFTVdRbnVzTjlrT2hIV1pML2xoWFBmSHpFZ2Jv?=
 =?utf-8?B?RW95SGVvR2FHa0lIWUJnMHJMZjNnK1dMNUZ5c0cwZ0FnZXkvOFZLd0pHWmZa?=
 =?utf-8?B?VW5tUTREMUFOYUhFWFlQeGVMYUlWc0xvV3drbTJqWlNlTGMxQmI2Ums1NjF0?=
 =?utf-8?Q?8lqLeIHhnRtiZECF0YxLl5PTF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83bb2a8-0366-4c52-61e6-08db4c1c9c16
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 21:23:16.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1HDHf7IYKiJIZJCjKUTeWqK1bgQJYi2oFlP1JLW71vQrhTYrQ/2c5m6jS3UAJNegnv/W65P4KVakcahdnXP5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/3/23 13:59, Ard Biesheuvel wrote:
> On Wed, 3 May 2023 at 20:49, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 5/3/23 13:17, Ard Biesheuvel wrote:
>>> On Wed, 3 May 2023 at 19:58, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>
>>>> On 5/2/23 11:08, Tom Lendacky wrote:
>>>>> On 5/2/23 08:39, Ard Biesheuvel wrote:
>>>>>> On Tue, 2 May 2023 at 15:37, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>>>>
>>>>>>> On 4/24/23 11:57, Ard Biesheuvel wrote:
>>>>>>>> This series is conceptually a combination of Evgeny's series [0] and
>>>>>>>> mine [1], both of which attempt to make the early decompressor code more
>>>>>>>> amenable to executing in the EFI environment with stricter handling of
>>>>>>>> memory permissions.
>>>>>>>>
>>>>>>>> My series [1] implemented zboot for x86, by getting rid of the entire
>>>>>>>> x86 decompressor, and replacing it with existing EFI code that does the
>>>>>>>> same but in a generic way. The downside of this is that only EFI boot is
>>>>>>>> supported, making it unviable for distros, which need to support BIOS
>>>>>>>> boot and hybrid EFI boot modes that omit the EFI stub.
>>>>>>>>
>>>>>>>> Evgeny's series [0] adapted the entire decompressor code flow to allow
>>>>>>>> it to execute in the EFI context as well as the bare metal context, and
>>>>>>>> this involves changes to the 1:1 mapping code and the page fault
>>>>>>>> handlers etc, none of which are really needed when doing EFI boot in the
>>>>>>>> first place.
>>>>>>>>
>>>>>>>> So this series attempts to occupy the middle ground here: it makes
>>>>>>>> minimal changes to the existing decompressor so some of it can be called
>>>>>>>> from the EFI stub. Then, it reimplements the EFI boot flow to decompress
>>>>>>>> the kernel and boot it directly, without relying on the trampoline code,
>>>>>>>> page table code or page fault handling code. This allows us to get rid
>>>>>>>> of quite a bit of unsavory EFI stub code, and replace it with two clear
>>>>>>>> invocations of the EFI firmware APIs to clear NX restrictions from
>>>>>>>> allocations that have been populated with executable code.
>>>>>>>>
>>>>>>>> The only code that is being reused is the decompression library itself,
>>>>>>>> along with the minimal ELF parsing that is required to copy the ELF
>>>>>>>> segments in place, and the relocation processing that fixes up absolute
>>>>>>>> symbol references to refer to the correct virtual addresses.
>>>>>>>>
>>>>>>>> Note that some of Evgeny's changes to clean up the PE/COFF header
>>>>>>>> generation will still be needed, but I've omitted those here for
>>>>>>>> brevity.
>>>>>>>
>>>>>>> I tried booting an SEV and an SEV-ES guest using this and both failed
>>>>>>> to boot:
>>>>>>>
>>>>>>> EFI stub: WARNING: Decompression failed: Out of memory while allocating
>>>>>>> z_stream
>>>>>>>
>>>>>>> I'll have to take a closer look as to why, but it might be a couple of
>>>>>>> days before I can get to it.
>>>>>>>
>>>>>>
>>>>>> Thanks Tom.
>>>>>>
>>>>>> The internal malloc() seems to be failing, which is often caused by
>>>>>> BSS clearing problems. Could you elaborate a little bit on the boot
>>>>>> environment you are using here?
>>>>>
>>>>> I'm using Qemu v7.2.1 as my VMM, Linux 6.3 with your series applied for my
>>>>> host/hypervisor and guest kernel and the current OVMF tree built using
>>>>> OvmfPkgX64.dsc.
>>>>>
>>>>> I was originally using the current merge window Linux, but moved to the
>>>>> release version just to . With the release version SEV and SEV-ES still
>>>>> fail to
>>>>> boot, but SEV actually #GPs now. And some of the register contents look
>>>>> like encrypted data:
>>>>>
>>>>> ConvertPages: range 1000000 - 4FA1FFF covers multiple entries
>>>>> !!!! X64 Exception Type - 0D(#GP - General Protection)  CPU Apic ID -
>>>>> 00000000 !!!!
>>>>> ExceptionData - 0000000000000000
>>>>> RIP  - 00000000597E71C1, CS  - 0000000000000038, RFLAGS - 0000000000210206
>>>>> RAX  - 1FBA02A45943B920, RCX - 0000000000AF7009, RDX - A9DAE761B64A1F1B
>>>>> RBX  - 1FBA02A45943B8C0, RSP - 000000007FD97320, RBP - 0000000002000000
>>>>> RSI  - 0000000001000000, RDI - 1FBA02A45943DE68
>>>>> R8   - 0000000003EF3C94, R9  - 0000000000000000, R10 - 000000007D7C6018
>>>>> R11  - 0000000000000000, R12 - 0000000001000000, R13 - 00000000597EDD98
>>>>> R14  - 0000000001000000, R15 - 000000007E0A5198
>>>>> DS   - 0000000000000030, ES  - 0000000000000030, FS  - 0000000000000030
>>>>> GS   - 0000000000000030, SS  - 0000000000000030
>>>>> CR0  - 0000000080010033, CR2 - 0000000000000000, CR3 - 000000007FA01000
>>>>> CR4  - 0000000000000668, CR8 - 0000000000000000
>>>>> DR0  - 0000000000000000, DR1 - 0000000000000000, DR2 - 0000000000000000
>>>>> DR3  - 0000000000000000, DR6 - 00000000FFFF0FF0, DR7 - 0000000000000400
>>>>> GDTR - 000000007F7DC000 0000000000000047, LDTR - 0000000000000000
>>>>> IDTR - 000000007F34C018 0000000000000FFF,   TR - 0000000000000000
>>>>> FXSAVE_STATE - 000000007FD96F80
>>>>> !!!! Find image based on IP(0x597E71C1)
>>>>> /root/kernels/ovmf-build-X64/Build/OvmfX64/DEBUG_GCC5/X64/MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe/DEBUG/Variable
>>>>> RuntimeDxe.dll (ImageBase=0000000000D4792C, EntryPoint=0000000000D50CC3) !!!!
>>>>>
>>>>> So, yes, probably an area of memory that was zeroes when mapped
>>>>> unencrypted, but wasn't cleared after changing the mapping to
>>>>> encrypted.
>>>>
>>>> Yes, looks like a bss clearing issue. If I add __section(".data") to
>>>> free_mem_ptr and free_mem_end_ptr in arch/x86/boot/compressed/misc.c and
>>>> to malloc_ptr and malloc_cnt in include/linux/decompress/mm.h, then I can
>>>> boot an SEV guest.
>>>>
>>>> However, an SEV-ES guest is triple faulting. This looks to be because
>>>> we're still on the EFI CS of 0x38 after switching GDTs in
>>>> arch/x86/kernel/head_64.S by calling startup_64_setup_env(). Before
>>>> switching to the kernel CS, we take a #VC (from CPUID calls in sme_enable)
>>>> and things blow up on the iretq. Moving the block headed by the comment
>>>> "Now switch to __KERNEL_CS so IRET works reliably" to just after calling
>>>> startup_64_setup_env() fixes it and an SEV-ES guest can boot.
>>>>
>>>> This worked before because I believe we switched off the EFI CS as part of
>>>> the kernel decompressor support and so this bug wasn't exposed. But this
>>>> needs to be fixed regardless of this series.
>>>>
>>>
>>> Very interesting. I was under the assumption that everything that goes
>>> on in sev_enable() in the decompressor would be rather indispensable
>>> to boot in SEV mode (which I only spotted today) so I am quite
>>> surprised that things just appear to work. (There is some 32-bit SEV
>>> code in the decompressor as well that obviously never gets called when
>>> booting in long mode, but I hadn't quite grasped how much other SEV
>>> code there actually is)
>>
>> The sev_enable() function for SEV and SEV-ES is more for ensuring a proper
>> environment (ensuring the proper CPUID bits are present for the guest,
>> checking the GHCB protocol level, properly preparing pagetables, etc.).
>> Since we're still in EFI and using the EFI #VC handler and pagetables, we
>> don't require some of that stuff, but some of the it would need to be
>> performed at some point (I wasn't trying to be a malicious hypervisor).
>>
> 
> OK, good to know.
> 
>> I haven't tested SEV-SNP yet because the hypervisor support is not
>> upstream, yet, and I haven't applied your series to an SNP hypervisor
>> tree, yet. There is a lot of support in sev_enable() for SNP that may
>> likely cause a problem compared to SEV and SEV-ES.
>>
>> SEV-SNP has a lot more checking and validation going on and it ensures it
>> gets the confidential computing blob from EFI into the boot parameters.
>> I'm not sure when I'll be able to test SNP, since I'm off next week and
>> trying to wrap up a bunch of stuff before I leave.
>>
> 
> Would it make sense, given the apparent direct dependency on EFI, to
> move that stuff into the EFI stub instead of doing it from the
> decompressor?

We tried to make the support for SNP not be reliant on EFI. If EFI is 
present, then get the confidential computing blob from it. Otherwise, the 
cc blob can be supplied as part of the setup data in the Linux boot 
protocol (see find_cc_block() in arch/x86/boot/compressed/sev.c).

So I guess some of it could be moved, but I'm not sure how much.

> 
> Thanks for giving this a spin - I can wait for more testing until you
> get back, and hopefully, we'll have converged a bit more by that time
> and there will be a new revision of the series available for testing.
> 
> BTW any clue whether your boot path is relying on the EFI handover
> protocol? I.e., QemuStartLegacyImage() in OVMF? Evgeny mentioned that

I don't believe it is. It's using the Grub EFI bootloader to load and boot 
Linux.

> BSS needs clearing in that case, and I was wondering if that is the
> case you are hitting.
> (If you have a DEBUG OVMF boot log you could share, I can go through it myself)

Sure, I'll send you a copy in a separate email.

Thanks,
Tom

