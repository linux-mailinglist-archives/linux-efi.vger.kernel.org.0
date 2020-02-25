Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034EB16EF20
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 20:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgBYTgE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 14:36:04 -0500
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com ([40.107.94.42]:11681
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728146AbgBYTgE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Feb 2020 14:36:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMd09N4olYPyDHm8xl4Oh53XsO3BthlCW581RfU61vn8umYMb2kyqQhiqqZOte2EwFYrMRrQMQXfp7DfphGbTXGl5ZnIh6e5LGlwLSUAEB/q1U1pXtTSJRPJf5qsN5U0NEktDEIZ9y5egK5GhQFLLW1M1c+CYo+hmc4b79pYOJ/4ZwyR5Vv6OsfaDX1egrykFk2rsW6poEeLJMNUIMgF39/Clv3PT1tdPiiM/2pTLm0iKmTk3StiwaZ/nop5szxyyTLyTFLB9f415+K6jB+4XUWqezhk6sepRelWY+dMHXah2F4gxWHTiTsrncKnu4nFwtlwzAwRyHuPVx9pWNb72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlgVn6QYCOVLsl+Rn2qJslCl7d1klt5M045bXNO/BmM=;
 b=BmkT/UXFtb583iRlqKJdbFdY2ax4HQjmXSWSvRoTKhjGVLM1HSIb8UFts4JNU9qT0H55Mo/nxHTgUCtGshg0OYru8XoKtCHl1E4ZGEai+geKo+MlvF9iDtMiRbM1V/ZqEIVUQCwX0AbSbL4dowkfUXgZw79oOI++6fboOcs8eGBDK6z21SA0VoygO1D4SBjUKhM4mmxS/Hg5ndvYA149h5hI9dd9tMRzHiHbEPD9wmRmEtknZJTbP0NM6Z/PIcVFYIXbIPwxJk39PEBgPmiZf6sevXlkdhmaD88Y1kmYk7bqN33lm3LcxFrLLpySoFSMrRg3uC/ID+jU322yUjFEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlgVn6QYCOVLsl+Rn2qJslCl7d1klt5M045bXNO/BmM=;
 b=zmL044VIS7oRNCckUkxv9cW1imahpgdJBqIuUf9nHGpAUtj0StJwFtMQzs2/DKgHnb80gZB156AeehSqCR6on96zv6wHeDxzLqHqF62qifSk7ukOqjN2bxzdYLs1DhSDrTs0+fz/eR/8FrMVoFrsXNnt1dQwEhzImgrKWHh2vWk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB2731.namprd12.prod.outlook.com (2603:10b6:5:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Tue, 25 Feb
 2020 19:36:01 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 19:36:01 +0000
Subject: Re: [PATCH v2] x86/efi: Add additional efi tables for unencrypted
 mapping checks
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <261ea8108c6290e95962be2638bd204f90787c1c.1582652466.git.thomas.lendacky@amd.com>
 <CAKv+Gu_FJeiaY5yw9=ER4XyBZrDFZ5L4igrqxP6hhJ7Z8easpw@mail.gmail.com>
 <9e16fed9-4399-5c78-cbfb-6be75c295f31@amd.com>
 <CAKv+Gu_0LUY67DwSLU1tyijuF+0mKPpvq1j3RSMy5HBxYE-3qw@mail.gmail.com>
 <96417897-8bf0-e60c-6285-7286673ecd01@amd.com>
 <CAKv+Gu-5=5bKBdO_r=Z3bAqCM36vfH=vLcCcaFtKcwYpe=AP7g@mail.gmail.com>
 <b2374776-6499-0b99-9df0-b17a4d84b0e4@amd.com>
 <CAKv+Gu8M5LMjA+JnJ57+BU4jmpgz0OqLyt1W9LXj_UDH=5DgjQ@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <48d68a64-fc23-a59e-4f07-4913075eaf5b@amd.com>
Date:   Tue, 25 Feb 2020 13:35:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CAKv+Gu8M5LMjA+JnJ57+BU4jmpgz0OqLyt1W9LXj_UDH=5DgjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0015.namprd05.prod.outlook.com
 (2603:10b6:803:40::28) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.74] (165.204.77.1) by SN4PR0501CA0015.namprd05.prod.outlook.com (2603:10b6:803:40::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.10 via Frontend Transport; Tue, 25 Feb 2020 19:36:00 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41f046d2-e197-4c28-de55-08d7ba29f1b4
X-MS-TrafficTypeDiagnostic: DM6PR12MB2731:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2731D4E1424BA80C293D5FFCECED0@DM6PR12MB2731.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(199004)(189003)(54906003)(8676002)(316002)(8936002)(81156014)(6486002)(36756003)(956004)(2616005)(7416002)(2906002)(31686004)(81166006)(16576012)(66476007)(31696002)(86362001)(6916009)(66946007)(53546011)(5660300002)(16526019)(4326008)(26005)(66556008)(478600001)(52116002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2731;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TM0R9+G6j+rluv1qPN5Gwz8X55b5HR/4i9lGjCEkexg+44Jc/b6Vk4AK5ndm8OYUTC600n29Aq3AEBuq9LWe1Y84Fcf0D1vFmoWej3Y1qYbudBrcLu4wroY8UwNF2B6LzXyID6UjK1Au+7I7FbRViPOs4m1kBWYyOh8IlsyKBI++fPzNWq6etthZ/J2jDXRY0202iFl9zF2GE6czUKIfs52PkXHnRetBc2Gq8DKlVYsgM3BtLW/q9fSG55OssE4/x1hEH5nwAzDL76YbaNm853MZoKJ93ic1ij0YgRla/evan2BhZklClWCp7yUcoaUc8ii0Bca3lr5tzBIRUteAezlP2Zulo1mYS0wOv4wFUnVcp6OK5fY98Kd5/4cTDi1Bk5HcnwFNtSGmpBwBtYTLuNlMjTUzb9H2PTVgsStu6mdeiDV+c/UhrhGw2NE+sct0
X-MS-Exchange-AntiSpam-MessageData: cs65LHp2wOElEsF4VQyEBtAXVgPuKfp+FICKEe3+JuqM9pi25mAu5dOfXsK8KAMkJZ7IlIGV6+vKgTv4N0YlFzs+GOZT35q1IAiMCeuu0d3QzvM/I0L2xBn2eZ77vkwkMhLMI/QMIlVHnkrRcrfcbQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f046d2-e197-4c28-de55-08d7ba29f1b4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 19:36:00.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jt3XLgHxw/OlfH3VB1FP1b9isFRjoPRwbUEW9l+rd+npRWwOOWAd99Ky+v0Jti/wc4b4OSeJzksD+uxZ3lSPqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2731
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/25/20 1:28 PM, Ard Biesheuvel wrote:
> On Tue, 25 Feb 2020 at 20:21, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 2/25/20 12:12 PM, Ard Biesheuvel wrote:
>>> On Tue, 25 Feb 2020 at 19:10, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>
>>>> On 2/25/20 11:58 AM, Ard Biesheuvel wrote:
>>>>> On Tue, 25 Feb 2020 at 18:54, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>>>
>>>>>> On 2/25/20 11:45 AM, Ard Biesheuvel wrote:
>>>>>>> On Tue, 25 Feb 2020 at 18:41, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>>>>>
>>>>>>>> When booting with SME active, EFI tables must be mapped unencrypted since
>>>>>>>> they were built by UEFI in unencrypted memory. Update the list of tables
>>>>>>>> to be checked during early_memremap() processing to account for new EFI
>>>>>>>> tables.
>>>>>>>>
>>>>>>>> This fixes a bug where an EFI TPM log table has been created by UEFI, but
>>>>>>>> it lives in memory that has been marked as usable rather than reserved.
>>>>>>>>
>>>>>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>>>>>>>
>>>>>>>> ---
>>>>>>>> Changes since v1:
>>>>>>>> - Re-spun against EFI tree
>>>>>>>
>>>>>>> Which one? Surely not the one in the link I included?
>>>>>>
>>>>>> I did a git clone of
>>>>>>
>>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
>>>>>>
>>>>>> and checked out branch next. Not sure what I missed...
>>>>>>
>>>>>
>>>>> Weird. Do you see commit 5d288dbd88606d8f215c7138b10649115d79cadd on
>>>>> that branch? It removes rng_seed from struct efi, hence my request to
>>>>> rebase your patch.
>>>>
>>>> I had just assumed you wanted a cleaner version and didn't realize that
>>>> rng_seed was removed from struct efi. My bad for not building.
>>>>
>>>>>
>>>>> IMO, best is to simply drop the 'static' from rng_seed, rename it to
>>>>> efi_rng_seed, and drop an extern declaration in linux/efi.h so it is
>>>>> accessible from your code. I'm reluctant to put it back in struct efi.
>>>>
>>>> Ok, I'll re-work the patch.
>>>>
>>>
>>> OK
>>>
>>> Btw if you want the TPM part of the fix to go to -stable, better to
>>> split them in two (and I'll put a cc:stable on the tpm one)
>>
>> I had thought about stable, but the fix gets tricky since the two tables
>> were added at different times (4.16 and 5.3) and the efi_tables array was
>> moved from drivers/firmware/efi/efi.c to arch/x86/platform/efi/efi.c in 5.4.
>>
>> I could do the two TPM tables each as their own patch and add an
>> appropriate Cc: stable # v4.16.x-, etc., if you don't think that's
>> overkill. The array move shouldn't be too hard to adjust for in stable.
>> Thoughts?
>>
> 
> So v5.4/v5.5 seems straight-forward then, no? Once that one is in, we
> can do one specially for v4.19

Works for me.

Thanks,
Tom

> 
