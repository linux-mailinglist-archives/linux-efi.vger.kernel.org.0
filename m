Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83FFE16ED32
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 18:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgBYRya (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 12:54:30 -0500
Received: from mail-eopbgr680059.outbound.protection.outlook.com ([40.107.68.59]:36461
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728762AbgBYRya (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Feb 2020 12:54:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyeAsmYae6zdVV3+BMrgLwNThiKGrSa1akL0RuVn8uCzqOomk+h6WUHau9pezpTdxEtpXNC/eLSWBqURyw0nO9DOdqQ/D+14O5LL9jlJ2LjPKWyFEz6TipLuy1qE15EVo2yzxzjlEkva4vls8M+sD0CFn1dHs+igl4oAaw6eS7tNdYG++tWaM6ByoDpmC0mTanq3cYSEiNSkXq+SaqoaL6hx4kzqngjs0qb98Ibja96J5C+YSV8bqenPZNN2OYX4yQcwmKImj2pt+KZdsY+0SmUwswhdA3GNtW3qp0g6c1jftKPJxtfuXu15wZZOdpNMydTFb90yJuq2UW/a0JqjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+atiIo4WEC1umUiBavDMK/KSQyGCM9fthaYBa9/3J0=;
 b=JZQ52z9yjdqDKbF90Zz2EGta1SQZKkA6pRUgmEE5mBY2PcdV49t8ITW95XBICMlYboHYDSoCSbTVGoQW2TEe9klcb4A9wIoP2aRTykwgxiKVQWuim7RLbATJ3siotHSzr0NpX97V5Pt5EUpvRg85YzUr/Wj0XDYUWO/EdX7p3XB/6aitzYDME62ZQAz0IJBIt2wTD7D7Dc1F4ndR1YeZNZoEsiBAMZZgEXulWnGuVkSdOyrTwHLgApMu5fEP3AxdBM5Q0u0L6GzgzUIDYanv01+l62IpVmHJL+4sTGok56/wigGjMCypRoWnvjjP378p0zXfV2VK30fgwXj7sG7oGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+atiIo4WEC1umUiBavDMK/KSQyGCM9fthaYBa9/3J0=;
 b=S/dAxeaVTLnVDNH7s5kizhmrDFsIVf5c6EEHT3OTsg9x/9s/nF9vuZFSEQJRSZFcgcmBULDknZQo1ZrhMbsK3W5s5Va7g2ohDKhmfrY+98bHVS/qOYpwq987mOWV7bsSM0+eas4krQ5cG7Vx/kkoEsXZSpOsbbRwYrLsfZkETPE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB3659.namprd12.prod.outlook.com (2603:10b6:5:14a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 17:54:25 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 17:54:25 +0000
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9e16fed9-4399-5c78-cbfb-6be75c295f31@amd.com>
Date:   Tue, 25 Feb 2020 11:54:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CAKv+Gu_FJeiaY5yw9=ER4XyBZrDFZ5L4igrqxP6hhJ7Z8easpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0047.namprd02.prod.outlook.com
 (2603:10b6:803:2e::33) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.74] (165.204.77.1) by SN4PR0201CA0047.namprd02.prod.outlook.com (2603:10b6:803:2e::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Tue, 25 Feb 2020 17:54:24 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8109fc44-8eec-416e-9f3e-08d7ba1bc074
X-MS-TrafficTypeDiagnostic: DM6PR12MB3659:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3659E9C58F50AA6BEDE5B12AECED0@DM6PR12MB3659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(189003)(199004)(186003)(7416002)(53546011)(54906003)(31686004)(6486002)(26005)(316002)(16576012)(16526019)(8936002)(5660300002)(4326008)(8676002)(31696002)(6916009)(956004)(2906002)(86362001)(66946007)(478600001)(81166006)(2616005)(52116002)(66556008)(36756003)(66476007)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3659;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKUs/X6oKTv2Q9ecGZ3GtlCoV58AT5zCgX9Uihh3Kam/NdA/3CgAHYbrGEnjis5nQpm4/7RICyV7u/cKLkAgXN0GKIGkLxHRy+t5qQbEKKm6JcNOpqZHO15qTGptUlCpB8oMjY/KXm55Mcyhg/4D33a1dadNW9kJDun1EKdNHq5RQyt9qr/OpiIe5pDGlcwoyYAGc9p1dZg20KmIAC/Xuc2aeRNoBebz8rmpMJ6MKMTXxPr4w4+9Rcs5drgG62YaaFB9j21BA1PssDtGR694FIXO4OL9Fv0FJIxwvpkhJHha+oYP1Wz8ZLsqPfwMPODcZFK/E4ZM0NqdGXUoutDBaYwgK4bY3jJ7W5EUMEMMho79a3WbPIXnwK5izCJ9/Sh15n9agh+KMV5CVG10duGWWiuRBm16A7+t3falCFeu9geMf7M3EgnXMLiOBXCaFfE+
X-MS-Exchange-AntiSpam-MessageData: JBm6hUSsZnhhJG1oCK1AU4lFDhBWcGjQSRPo1WqV5jLvU22hj/v+WYu7aDBN/JRI0R0rzG26FT3V4ILZhp6cwd92VAsKAAY0pAOQiZTkf8gkF4mj0gKfSRDJydj5E3PFbGuRc4lE7UAbwx60CIzKZw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8109fc44-8eec-416e-9f3e-08d7ba1bc074
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 17:54:25.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EqCcdsMUttVEZkoi3PeoIXBt3IKJNkHpoaTqr1DlCHiy3uEhq109rkGeDVkbaj5fOxTQNewpPc/TL/TusmNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3659
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/25/20 11:45 AM, Ard Biesheuvel wrote:
> On Tue, 25 Feb 2020 at 18:41, Tom Lendacky <thomas.lendacky@amd.com> wrote:
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
>>
>> ---
>> Changes since v1:
>> - Re-spun against EFI tree
> 
> Which one? Surely not the one in the link I included?

I did a git clone of

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git

and checked out branch next. Not sure what I missed...

Thanks,
Tom

> 
>> ---
>>  arch/x86/platform/efi/efi.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>> index 43b24e149312..c6ca959e2366 100644
>> --- a/arch/x86/platform/efi/efi.c
>> +++ b/arch/x86/platform/efi/efi.c
>> @@ -88,6 +88,9 @@ static const unsigned long * const efi_tables[] = {
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
