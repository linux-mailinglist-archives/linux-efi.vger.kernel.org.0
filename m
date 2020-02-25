Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217AB16ED89
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 19:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgBYSLB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 13:11:01 -0500
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:12192
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728476AbgBYSLB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Feb 2020 13:11:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZsrHueagQO1oSHbzoaIgXIDXqTfXG2vai1CHajiwKwJzlMIwsXvBJ9m6rXDo8Xi0NhouIwUIGISiv7/LiTxlZADetDJyIxMGGZmQs7kgxfosFTWpDaXnezqpSsLBVsFb462HbF+DIvMo+6u14sezmAg76dJQ1U/lEWIKEFgdrutLY89LYdRcWIjQ9PN/8NIRW6ui1Vf7FbkHa2ghVYEGQXjKlolkHuUQgtCdDXrmTJTcWbx1W8eqoXSiN52x10Qy13IlP8+g+bnQ9k8wrob3Ojcl08GS3CBMT4cSPbNh4qRifXIrt9Ye5UVZszpWv5xKaM603yXyLZHTRT5Mq/A+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id1TivdIgF4Ow6UYWGDEyfkzolFJ+fs9GVbfBRqjdlM=;
 b=YtC7jES0FMeCI0T2Xvmv0UtJZl0VC+QG5i4OLVKHdeohkn7gOebO+PJYJ0QfIPxWvjZDK+22KGLWTA8VkWJ1cVFHls2jwP1WLNSauWfYiVzZUzAkffo/XzdwsxzaEtykNRx/FY99g2tvr1oeKqLx2t8wHzo0FzPqwjHql3vU9nqD9MxVo2JMsbvq6cJpHx1aIoGX/kOVtmEa+zYs8q1MvEjaE/LhjlHkuv4Nqlo0bVlrLIXBz2o7BUMWQ7LbPYQCB3QIA2m0q/z+V3cd+CBYj+ue8J34zTJ3MIi0qIOvHVtTrQlzjHeOYbhY2o5BO0hLyPG8O9kaDGVDyDlEGBv/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id1TivdIgF4Ow6UYWGDEyfkzolFJ+fs9GVbfBRqjdlM=;
 b=fEiroSLoRh2c79Ak7cDBSaH/O5V8oh2+ICTWTQdSKv4o/vLFEt8eqnM7Lfw2UMaFzwADFCcayNSa2RDhWwLqviUGK5qxGuirhJjDKZfIq/ONy2xxn+vXvVtFVMeX/EUzKYQORUFcHkSNkiQhyUftj27VIj2UXCz4HOMcGOkt7P4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB2697.namprd12.prod.outlook.com (2603:10b6:5:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Tue, 25 Feb
 2020 18:10:55 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 18:10:55 +0000
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <96417897-8bf0-e60c-6285-7286673ecd01@amd.com>
Date:   Tue, 25 Feb 2020 12:10:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CAKv+Gu_0LUY67DwSLU1tyijuF+0mKPpvq1j3RSMy5HBxYE-3qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:5:bc::44) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.74] (165.204.77.1) by DM6PR13CA0031.namprd13.prod.outlook.com (2603:10b6:5:bc::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.10 via Frontend Transport; Tue, 25 Feb 2020 18:10:54 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cddd4c6e-de94-417d-66c4-08d7ba1e0eac
X-MS-TrafficTypeDiagnostic: DM6PR12MB2697:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2697225AEB545ADB820C0715ECED0@DM6PR12MB2697.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(189003)(199004)(26005)(2906002)(8676002)(186003)(16526019)(5660300002)(31696002)(8936002)(81166006)(86362001)(52116002)(6916009)(53546011)(81156014)(2616005)(4326008)(16576012)(316002)(66946007)(66476007)(956004)(66556008)(7416002)(36756003)(478600001)(6486002)(31686004)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2697;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SA5Y2FuHGEshJDMpmXqybsV2rGgMBkW4iReVzUlafZ/DxRfnLjGjOTOKr8bcf6Y67ktB2AP0Gt/kd6/C39tcaAh/d9R0Ldf6ZgXasI4tfJUnhjR7KCPGNE34C3RNhHNxvP6IANOsw/rIxtO085++YaUESwPGK5fKPr18fZ8mV/zkPgLwAv+pAJczsb09YaCoZqpJnuNzWPfCCroFfwpaDWN6T1CRr5nYxBlghcrG08Q4yIHweSDOokTpuHgsBzH1j1ffEg0ol6tmpmoYb1nUwYBrtTOGJk65bPdflNHj44XXPzsQWK9S5YTER5uFtckbalbKPK2zvJ4H5ngxaJUoux+WnFGCK78yxe1p2z6oBxqixN1YhJGHTQoMGd4bSdLwGsu/4KHGh51w0lAcwMbW4v/SxfSkNEsNuRrCgkHlsZnYrAmF3kixIHIGr2+9V4r
X-MS-Exchange-AntiSpam-MessageData: zyeZX/TTirVuAOhimOBAQpjviGFJa/BvEUhSBjrcaNddoja9pYVTo/NgbAgWAYYhDg8BHyUreVuAiDtj8BN9WdIr9n24LMI8oBpZBDd8stX7nP+us6+RNmU/zQQlG3VoB1s4xFoXArIIYykm7jCDTQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd4c6e-de94-417d-66c4-08d7ba1e0eac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 18:10:55.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rg0l/In6sAITorwsl2Bx8d9N29zhAprTU2r+F9lwH3ReR5ge0KfSMmeXF9YjBfSaPZXHdEv20D2heM8b1R2EGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2697
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/25/20 11:58 AM, Ard Biesheuvel wrote:
> On Tue, 25 Feb 2020 at 18:54, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 2/25/20 11:45 AM, Ard Biesheuvel wrote:
>>> On Tue, 25 Feb 2020 at 18:41, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>
>>>> When booting with SME active, EFI tables must be mapped unencrypted since
>>>> they were built by UEFI in unencrypted memory. Update the list of tables
>>>> to be checked during early_memremap() processing to account for new EFI
>>>> tables.
>>>>
>>>> This fixes a bug where an EFI TPM log table has been created by UEFI, but
>>>> it lives in memory that has been marked as usable rather than reserved.
>>>>
>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>>>
>>>> ---
>>>> Changes since v1:
>>>> - Re-spun against EFI tree
>>>
>>> Which one? Surely not the one in the link I included?
>>
>> I did a git clone of
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
>>
>> and checked out branch next. Not sure what I missed...
>>
> 
> Weird. Do you see commit 5d288dbd88606d8f215c7138b10649115d79cadd on
> that branch? It removes rng_seed from struct efi, hence my request to
> rebase your patch.

I had just assumed you wanted a cleaner version and didn't realize that
rng_seed was removed from struct efi. My bad for not building.

> 
> IMO, best is to simply drop the 'static' from rng_seed, rename it to
> efi_rng_seed, and drop an extern declaration in linux/efi.h so it is
> accessible from your code. I'm reluctant to put it back in struct efi.

Ok, I'll re-work the patch.

Thanks,
Tom

> 
