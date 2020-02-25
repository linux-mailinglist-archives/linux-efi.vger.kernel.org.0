Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26D816ECCD
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 18:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgBYRkq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 12:40:46 -0500
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:42880
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728499AbgBYRkp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Feb 2020 12:40:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAxE57r833vQ0zhE3dkIWUAWY0Z8iFqGKdC43RvIQ8dfIPDJSBrUJVVPreB6voEVfM/JQU+d3Q24ev886uXE76XVpZfKavZRLNIDl4Nn/k4pulLdgpdC1qXvpiuUTjwr+gEXdsC9AL+2AX7vGxI5r1ZduNCzGgeXPuwG9AEko8+mm1bC/MSCqF6b2IBDmtwwYckvYhgxjXQajkGw2nm60xMI6knYfqDfXPoHNaXXuotRoTl0sixLQwK5Sa0rY/0EoTTeOqzuT3H9YOPWUP8ojgd0LIbN0uz3bOiZs3j/TFP1I/r6DwxvLDgQe+6AbKd1mLSvrcFMfRVLaL1O73ESuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc+8h9U8YP1iNNCgOikwS0Iorzlwdlo6gxZqsHHUS/I=;
 b=Qa1mOY340CLNevSbbTGSJWWmaPOijsBVVkUtLuybPHdXCK0xkfejXr6JSaInL/V6MAIPOpmV+JVT3OQbr7JlogIy65V/1B9XMbSMFpTkQP+KvHipax9v3lD7Xlp2dQf8wc5lIlNQSOUxhjGG+weDCO5sL72vbajsN6QU4sHOiW/YDnajkpF3PfH83pt1l0BSttjcxsDTFnUkHP2ihWwZfe8GsRvIZrrWMf9Jnd+s7eD6c9rhXtWTsZhuy2DlslcjHrF80myDF6RhR6U9BXPEuQNo/rp8OSD//XDWaBOs5ShAV38Vd3rJFSIHH3PU1VP4jeWRswrCmk5Z1+cZftAkyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc+8h9U8YP1iNNCgOikwS0Iorzlwdlo6gxZqsHHUS/I=;
 b=F7Ulhku79OmuVbOSjXTv8PRmsg38Akbh0mekEg8BxGgFSNDdSKGRKJWMsh1dw4+miutsuGXrx6cWbcZeyGlU4f7bdHShOxfkMb5jI+DSvHxejflvG5InoEf+BQfyGyI2TquSoRwtr2eSxnnO/0zL+eyBhvInOgSN9lN1hJdG9C0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 17:40:43 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 17:40:43 +0000
Subject: Re: [PATCH] x86/efi: Add additional efi tables for unencrypted
 mapping checks
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <9b52495a2d8adfc8f2d731a0236c945196143ef4.1582644865.git.thomas.lendacky@amd.com>
 <CAKv+Gu_3=u1S1dgmjMH+0-7GhD+v3YvgQvqEUx7QSDjPMW1HVw@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <5705e8ab-c8f1-77c3-0bda-4687a53a73ea@amd.com>
Date:   Tue, 25 Feb 2020 11:40:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CAKv+Gu_3=u1S1dgmjMH+0-7GhD+v3YvgQvqEUx7QSDjPMW1HVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:5:15b::23) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.74] (165.204.77.1) by DM6PR18CA0010.namprd18.prod.outlook.com (2603:10b6:5:15b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 17:40:41 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86e174cb-df03-40ee-8a6c-08d7ba19d628
X-MS-TrafficTypeDiagnostic: DM6PR12MB4203:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42031BB3632E94E20C1DE9FCECED0@DM6PR12MB4203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(199004)(189003)(26005)(316002)(2616005)(6486002)(81156014)(478600001)(54906003)(31686004)(8676002)(53546011)(2906002)(81166006)(52116002)(966005)(66476007)(16526019)(186003)(6916009)(16576012)(36756003)(86362001)(4326008)(31696002)(956004)(66556008)(5660300002)(8936002)(66946007)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4203;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0//x57gejIhjO6Bl2qtHzi8CnavJvdimg258V/zru1np8/UOmRpjZFiPPbfRnrDznBDT6O5Y+CL9FQ7QRyM0VR/BY22TPqn/Zl/Xy0wOefbpyrCO6e9jMfZGkfPrVwHbbMKTLyRrKNZwAQ0q7CSZABInA877pmPfDlq5bIEhu+tGrBCz5hxtNT7me3q7NsS4JXZNM2F1ETk3KB4FPdhuYjYPfjSj1kmheXVjsrqN3BAGdSArjtHOncAewrA5a3jjVA6bHulpA8vdDtQRW/oQeTQTFkC2Kzh2yLVcB89gwqWHaqmoWI2iMa45uuvXRCg1B+VkYEsYg5p04MS8dc2mbOlod7icBj5IxUAlURiSKH7xgE9BV3YJHhiyhuGVBgwNO8bftNCxydUF1LdXBeOeGitIfj7cLkSCAluVy3grKCkk5q8VvkmGSjMzW8xltKRPw/zAA5woKFzvDZ1LzPASo3U+3EpkG+ooz5CiEGDG/G4/frH6sxR5ni/YsrLURAkJan72EJydvAXG389NW2gAAw==
X-MS-Exchange-AntiSpam-MessageData: 69Lzp4oTbRAsgG6jbpk0tX+RoN0SffwIAvBwMX9UH/kQ7ukxzxxgBSHiBgfHdddttCgUymryBe17ZOnSawPMpQGr8aupIi/TDio8OdqYNj1PdD+wIt5B/jD80z/bEyfxTa228csQP6fESn4Mz6hndw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e174cb-df03-40ee-8a6c-08d7ba19d628
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 17:40:42.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tII79NeNlVBsoIqmIaQBjq1CXH9BXZnmH8Uj8rVZ3X1moDdxCrZFZLVg7PnmS4CWejrZ9L5YFWCCW/Dj1Sikfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/25/20 10:09 AM, Ard Biesheuvel wrote:
> On Tue, 25 Feb 2020 at 16:34, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> When booting with SME active, EFI tables must be mapped unencrypted since
>> they were built by UEFI in unencrypted memory. Update the list of tables
>> to be checked during early_memremap() processing to account for new EFI
>> tables.
>>
>> This fixes a bug where an EFI TPM log table has been created by UEFI, but
>> it lives in memory that has been marked as usable rather than reserved.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Thanks Tom
> 
> Mind respinning this on top of efi/next?

Sure, no problem, v2 on the way. I wasn't sure if this would go through
the x86 tree or the efi tree (though this should apply cleanly to efi/next
with just a few lines of offset).

Thanks,
Tom

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/>
> Thanks,
> 
> 
>> ---
>>  arch/x86/platform/efi/efi.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>> index ae923ee8e2b4..eba5038c7a44 100644
>> --- a/arch/x86/platform/efi/efi.c
>> +++ b/arch/x86/platform/efi/efi.c
>> @@ -85,6 +85,9 @@ static const unsigned long * const efi_tables[] = {
>>  #ifdef CONFIG_EFI_RCI2_TABLE
>>         &rci2_table_phys,
>>  #endif
>> +       &efi.rng_seed,
>> +       &efi.tpm_log,
>> +       &efi.tpm_final_log,
>>  };
>>
>>  u64 efi_setup;         /* efi setup_data physical address */
>> --
>> 2.17.1
>>
