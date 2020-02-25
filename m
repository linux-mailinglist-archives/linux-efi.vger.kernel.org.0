Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3591816EEE8
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 20:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgBYTWQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 14:22:16 -0500
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com ([40.107.243.81]:23168
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727298AbgBYTWQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Feb 2020 14:22:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7sY7iDMZjI7iPAxm3gfX9ZVZOOz9VjuZQU4Z7q9BtrKbtp3L7T8jJMmQnDatqrJnDoYbObPjXVEQDKK2q6aYYcw7stlLnYjd9Vrawmy7r5xmB1R0VkEkP9ZQEUtS6bzcslaLQOzjjWzfDXzPWG7i05exN44zIXubcZ5R+GI7nMGGaYG+GxSHHqNGPAviOOXf5ZP7MxPhIEWgyzPukD9OuptHSdk78hP8BVpc1HYuyHNsHhjXa9Y2g11xBbOwTFJm3mUqMryLGEecr1IW/XLzBCrQjLFeOOwohsrttcTz2OjglKSBcRUarG63/iP0WaXAruFMf4M0Fc93TegRW77CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baqxe1LeNxynqBiGV2vsOWx6/EJnWWa6j59Dwz6S9yU=;
 b=FKqT+maDUpetef/vlrq1PmLnF11mmVtYN44+kP+Dw0OOlXrnPoyUaOqMDxZjillGDWpz+QkWY0PbPa1ivtpCNKGm226JCg8xnf9DSizKUGVwjSkrlUClxsPdd0E2YZBY0VOGbpxFazxxhW97mwNQnIqG64TPipD4RD/6DGnFligpjNLUPXalxXxSoxjw6ReIYWbToFOl6/YxanZjefZERura/M3B+bLJYu/c5t8AptgEKTyHvHDV2rB6+ZV6ZIKY3BxYaIBPUzX/FAt0Ha68ZMr9a1qXgfv/vj5ozu+CVaWoY2TwnNYA1SMSwC/rN0P8iTtPIT6DDzt/VxNiftJbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baqxe1LeNxynqBiGV2vsOWx6/EJnWWa6j59Dwz6S9yU=;
 b=1zAFic2eJbYwF79RrbQq8lcwYeHKXpQKaiQGAOSB6gk11zP7yG4YPuGKov675vUKHbCzG0EiiuIPnhIeGep2OMndbK3Ix5DmPcUJ4wM9WLX53pk+lr7U/rNnCv25qyVuNudAW54Eiq7WlKC1eTH7dJzlfCMClk+893o1IP8Zs2E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB3338.namprd12.prod.outlook.com (2603:10b6:5:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 19:21:37 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 19:21:37 +0000
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <b2374776-6499-0b99-9df0-b17a4d84b0e4@amd.com>
Date:   Tue, 25 Feb 2020 13:21:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CAKv+Gu-5=5bKBdO_r=Z3bAqCM36vfH=vLcCcaFtKcwYpe=AP7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:5:bc::27) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.74] (165.204.77.1) by DM6PR13CA0014.namprd13.prod.outlook.com (2603:10b6:5:bc::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.11 via Frontend Transport; Tue, 25 Feb 2020 19:21:36 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c221746-49ed-48cb-8f1f-08d7ba27ef2e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3338:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3338942CE309D5DCC1FC069DECED0@DM6PR12MB3338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(199004)(189003)(5660300002)(6916009)(66946007)(36756003)(66556008)(54906003)(478600001)(66476007)(31686004)(316002)(16576012)(2906002)(52116002)(956004)(53546011)(86362001)(8936002)(2616005)(26005)(16526019)(6486002)(81166006)(81156014)(186003)(8676002)(4326008)(31696002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3338;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mat/SupaNS5NzoF16Q/96oW9C5DgKLoDatQ3qJzT3RXrip8tetAEPFhGwzsXmUZC0h63txuGQj7DvTfh/cxTOpde80RsWNnu2RsQatj07AZpHmwW2r06wRuq6ld0pRVokcwcPhJnucHu0hX2h+gOtUZC23OapnG5vzMMM3VBFYTto2nkgIDUW/Y0ewrFzJHNdBLqfrkAYNsoqhyIMEciTHdK5qiPUvDaqi12tlRc7P1pqVXkPgQf4bMU+beG219wJMmjrFvUEgl/+CSNjZz09gVSjSIHZdzlw6xuL76W2fDA7Na4b/4RaYYLhhGeaQtvoReWVOqThvmle+2wcjFW7FYiNYAUKswBNbGCwHEt+fQY4wd8QLMiq/GNPlSnLfqnHxe3urif1MMRfTib5ip0j9AWPdH4u18V3eSBhWa3m7BhUhfFwGAI3ZuBxsU8NEj4
X-MS-Exchange-AntiSpam-MessageData: Hd3kB+UxW2DpyVGOxb22RN7khNRtg9xAIg1dkuMYFRotCHAYux3mTzUJ19P4DtoWBhsjQFKCN2ApOKhrXBDfIdxJEpXiHy6nN4NqzTVeHwRERxYMfTorQnWCQXJyEUwnKOmCFB14F1JUO1tm2GlQvw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c221746-49ed-48cb-8f1f-08d7ba27ef2e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 19:21:37.7979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9LZ4R/8X3jsaNgEEnCw/JO1bVN8SPUc56ezbfMHYIZpj9Mhv8FjKuW/3s/2YpwNUCxgnW0NsjSVBw7+Zj5c3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3338
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/25/20 12:12 PM, Ard Biesheuvel wrote:
> On Tue, 25 Feb 2020 at 19:10, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 2/25/20 11:58 AM, Ard Biesheuvel wrote:
>>> On Tue, 25 Feb 2020 at 18:54, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>
>>>> On 2/25/20 11:45 AM, Ard Biesheuvel wrote:
>>>>> On Tue, 25 Feb 2020 at 18:41, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>>>
>>>>>> When booting with SME active, EFI tables must be mapped unencrypted since
>>>>>> they were built by UEFI in unencrypted memory. Update the list of tables
>>>>>> to be checked during early_memremap() processing to account for new EFI
>>>>>> tables.
>>>>>>
>>>>>> This fixes a bug where an EFI TPM log table has been created by UEFI, but
>>>>>> it lives in memory that has been marked as usable rather than reserved.
>>>>>>
>>>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>>>>>
>>>>>> ---
>>>>>> Changes since v1:
>>>>>> - Re-spun against EFI tree
>>>>>
>>>>> Which one? Surely not the one in the link I included?
>>>>
>>>> I did a git clone of
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
>>>>
>>>> and checked out branch next. Not sure what I missed...
>>>>
>>>
>>> Weird. Do you see commit 5d288dbd88606d8f215c7138b10649115d79cadd on
>>> that branch? It removes rng_seed from struct efi, hence my request to
>>> rebase your patch.
>>
>> I had just assumed you wanted a cleaner version and didn't realize that
>> rng_seed was removed from struct efi. My bad for not building.
>>
>>>
>>> IMO, best is to simply drop the 'static' from rng_seed, rename it to
>>> efi_rng_seed, and drop an extern declaration in linux/efi.h so it is
>>> accessible from your code. I'm reluctant to put it back in struct efi.
>>
>> Ok, I'll re-work the patch.
>>
> 
> OK
> 
> Btw if you want the TPM part of the fix to go to -stable, better to
> split them in two (and I'll put a cc:stable on the tpm one)

I had thought about stable, but the fix gets tricky since the two tables
were added at different times (4.16 and 5.3) and the efi_tables array was
moved from drivers/firmware/efi/efi.c to arch/x86/platform/efi/efi.c in 5.4.

I could do the two TPM tables each as their own patch and add an
appropriate Cc: stable # v4.16.x-, etc., if you don't think that's
overkill. The array move shouldn't be too hard to adjust for in stable.
Thoughts?

Thanks,
Tom

> 
