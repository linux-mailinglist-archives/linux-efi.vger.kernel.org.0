Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D414A9E51
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 18:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377157AbiBDRt3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 12:49:29 -0500
Received: from mail-dm6nam12on2044.outbound.protection.outlook.com ([40.107.243.44]:59242
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241900AbiBDRt2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Feb 2022 12:49:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+u8XqLHwIZgdy7+0SNGbzaDYNIT7YbqAnFiukmPvM4g8kEWR+8D1pVheBzSXnN+Y8B71UccFsaj4n+lqyscJbwR0jn5lgfdeT246jqcKJC13/dTxt1knkF44MoDQZ81zSuqWVP/EodsA1GL8CyhOyiRjNz51MT/yngZxUYrNobNmxWjvbO+p2GwjWfwTBy6j7N5vd6d6KMsI756ib/qIJPdkN0oA00xy8xoCwas7kwUKDvY4AyCPDZaquqefaWCOFFUXEX3sMaIuElK4pDGjnFYG8SE6OkH004xZqOHCrtZLAfG/FsStKUHEqFCylPx4OdpkqHCGIcKivjRG+cw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRnAnjnHUGz91ffWoU6zpSoCpSQI1c5xMtwpfXY9KsI=;
 b=h5/zaKUCBYM04eHCXKUZcWpG37cKIxMkr9Sy4ZFI+83KuxTAB5tv43Atk3EJSoiTMOEWjJGM5HIJ3cbIIR6oTxO4a7beaBM3ZXB9krLgP7XSgnlz3/qsWFmTq9/v0p+APjc2ji/HegYcFTVoYlPjmO3HvSiKkQzTDOmkq63JnEeGXEzCIs8UH1gXAm87tqp9mGecLgY5/g0cZF2d2irrmsV9sBXSvTNkXb2Z5QG7vM8lzOoVOIGtAo53ITns8iFAzzfcF8u4UIlqjMgugX2y00cFR9nwV0SwRk4DfIfT1P9Tx/FnFx5FTiU/KO1ZMnZ+ONaYYkDVu4wcndowJPCxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRnAnjnHUGz91ffWoU6zpSoCpSQI1c5xMtwpfXY9KsI=;
 b=aJ7xEZX36JsHE2ARRx6/BRU9QgCTigvHFr1kpmu6r1UF+0Op+hGVhGz+qZVvkxVAzjFMn8Lr0HGDDrgExMp2CjQLr5brgNb31EEe2zU3pIsxlT7p+SDs6YN3zPejzY1bfmXRNfjDXVJQJ8kMdlFm2RHne/7/Dbxwe35OCCZ6WuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM5PR12MB1593.namprd12.prod.outlook.com (2603:10b6:4:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 17:49:25 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 17:49:24 +0000
Message-ID: <a77c4ede-5285-f354-6944-8fab7503d218@amd.com>
Date:   Fri, 4 Feb 2022 11:49:21 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 6/6] drivers/node: Show in sysfs node's crypto
 capabilities
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com>
 <67d2711b-200c-0894-4ff7-beb3eb304399@amd.com>
 <CAKgze5YM2+BRjj2nvb+_dnuCg5WtWvQ6FQyNYJ1c8G6Orn=aQw@mail.gmail.com>
 <5c5ffe29-d3d3-2955-cf78-ad275110f012@amd.com>
 <ec9e29a4-0d2b-1423-d92e-6f025b56f8cc@amd.com> <Yf1UO6jF91o9k4jB@zn.tnic>
 <5ee34cad-8daf-6282-f2ed-cbc92a89d013@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <5ee34cad-8daf-6282-f2ed-cbc92a89d013@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:610:b2::29) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe28ad1f-ba9a-4a52-1ab4-08d9e806ae87
X-MS-TrafficTypeDiagnostic: DM5PR12MB1593:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB159302AF29FEFCF0AC93CB74E2299@DM5PR12MB1593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxQfpNMSWo2rFresnSsE3EeqqYZmguO+kyigZbRZxgS9ZmGxLWKl68/qHmMQBjbDmJoO1VLb3z6aA24cw6TgXXt5ksgkEbMjb7ksGUVc235bsBYvk9L3S5Q2Tnc7nemIIVNRBVYbLdIO4tDaWPbCEP4Vl4ADsvJMGc1o/9XPqEnF+JWo6R50FIft7dPbUv6gFvbAUGtSnl2nIhR38mTdHsUSeEynsQavMNRwxEkc59vq9vXGE2Ylv/TgXwFWFK/nDMJjEoINjr1XqZp8vwRzAg6U1nnjxZ2MjJ13QZ/0yBMElWtgtANFsZwL0Mx+fnvAqEej/hQociZRH12pkLG0AnhBrtXVKHfouHXYmadOR+wz1Fyk2ANpqoSijqLS6P2OBkwGdLmtKsM/UoWMOj78mbnfXxd8bMuf/vRmYpFtXp/4QWzfyt1ssB88lLstzxjnUEApLUYu5C8nJ0Wwje25YY7PH1S7dtvmkHTYg6WHNiiBD2qgSs20/bt1qjHkOd3fArinDbOUIP97S4/lAB71BRQxsKzQ150ybcbZoky7db9ZNLTKWWySbOndgKg4NGNA/YAcSsvqke3Sj2cDDE56NPIn1oXYOhrSnjM9/Jbpkf9b04mu4ywW9NXGqWyN5LeUZGZYNRqmqMsZROXghnJ73CX5t7KS61EFqTtbBQmOYgjzgOXMKVej9AQ47B63Kpb0u97OsEcMcXzUF0Q/Pve68xwnmo83AOgC7gTzxHKKJ69HTLAhMaYYgYqlg94aihPYb3iwOwS91//eGRVtL0zP48105uaQyPexMIBkIGIQ1ZUqiVUTH7QwK9yrWThMW3CR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(36756003)(5660300002)(66476007)(2906002)(66556008)(83380400001)(4326008)(7416002)(6486002)(86362001)(38100700002)(66946007)(8936002)(31696002)(508600001)(186003)(316002)(966005)(6506007)(53546011)(2616005)(6512007)(6666004)(26005)(110136005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3pWSEE3eVBpamJuTVc1WE55dVRjc01qOGJFaGt0cHZGTTA1S1c0WmMrVzZU?=
 =?utf-8?B?NW1iYW1aR2hHTXo5ZzBGa0t6Umwvek51SzBFVExYSDZVNGVlMzVXZHJ0cmRY?=
 =?utf-8?B?ZmpBdjYrSWIxWGUzV2N0VGF3QTFxY3JkTTRPUkdXQk4vY1pWdUNWaHRkS0pG?=
 =?utf-8?B?dVZiSUIya1NGZXVhUXBYaHNEZTR0UEl5TVEyc09JK3NPTHQ4SnRucy94MFRC?=
 =?utf-8?B?UXprakphaWNnS3FUdXh5S25hMWl2UCthWWtBU0xUMGdQeE1ZNmFZQXRTWjJn?=
 =?utf-8?B?RUpiUS9GV251WkRETnRvZk1jU3hHK0Y5cDFtYzZwMENkNnpHYU5ReXB5SEhQ?=
 =?utf-8?B?WUpvY3l0UnovSENaQncvVVl3YW9tMDZldGRHMTdNWVE3UklSK1dIc0U5S0h0?=
 =?utf-8?B?bzNuWkliV2hiL0NCcWZMVlN3di9SbVRoem9FRFo3MVBsQUczaFdTcnZsbklQ?=
 =?utf-8?B?aWl4c1hPV0dUcTduekdPQW9kMUNFcnJDN3FEQ3h2Mm5oQkJWK2RGVmwzUjJM?=
 =?utf-8?B?VStnMGp3cVdPSm0xNFUrMm1CamNrQU8zaGkrS0hlUVlNTTY5M21PT1FoRHVk?=
 =?utf-8?B?TmxLYkZ5ME96clkwVUt0bEhKQlg4K2hkQy9XUTdEcUpabXlRU1R5WVM0Yll4?=
 =?utf-8?B?OFhMeEtyQ05GSDZweGtQdHBqYkt1Qzh1eEVqSHp2bFkxK2EvbmVSOERHUFVE?=
 =?utf-8?B?YXBSN0NCL0Y3UFNvd0xsSXNxc25yTDFSVXUxTlArWnlXUGo3enhqNUdqbXA2?=
 =?utf-8?B?dkxvMnBrMzBRRUcydE1pVVJzU1JsMDBuMkJJRENOVVR6NFNKTXY5S2FOSUxQ?=
 =?utf-8?B?dDgyWXZsSlBUYVFWOUZQYjJSa0tMcmJJTUZSclB0b3RMeFZrRlArUzhtOUJl?=
 =?utf-8?B?UW1WR1c0cXQwMWxuSXdCcHpqK2hjR1YyS3FyZ29MTWtWMmZCeCtWdjc5Tzhv?=
 =?utf-8?B?dGJVQjdmY0xRV1dhOVdNYjUwZHIzVWoycUtCMUpRZ09sQ0JYS3p4azM1WXRM?=
 =?utf-8?B?ekJEeXlYV1dFOS93UG1aRER3Tzg3cnhtRVh3Nk56SUlaNjVTOGNNTU9tRlRP?=
 =?utf-8?B?eVMrbDNpNUY2eElGcS9FQUR0UjZIZHY4TkZUbnArVG52d3A3bzlHWXBVN0ha?=
 =?utf-8?B?MUhDTU5nZlptTHpxT2pMUEI3WjZ1T0RiZDNBeWpYdlppaFBqSUpMODQ4Z3BJ?=
 =?utf-8?B?RXRsajZHb0hCQjRGSE9tVWY0eGFxRmc5a0FaSTNWZWYydTB3Z1oyWFF2TURv?=
 =?utf-8?B?ODU3OGltSkg0VEZzL1hQYlFoWXFqNGVSaUU4eUwyZWlrcXpCRE91NHFaNVJl?=
 =?utf-8?B?NVJyVXY3V3Y4YTNMSnZqK1R1eE1rT2YzWnk3WWtCc1BJRktqM0JkWllzbFFa?=
 =?utf-8?B?aHNqUU1DTUZ2cFkyM0prbXU1S0Nvak96a1lHSmptalFKSS83NVovY2w2YmJy?=
 =?utf-8?B?TFVSVWFqdnlVYUVNTTNXOUt2RGd5cHRwN0FEY1ROWWVIMDdSdTRQWVZPeGpp?=
 =?utf-8?B?SUczeEpZQ3JFbGd4Z1dEOGFIbkljMUJoZ3NpNUg4UDZ2Y3pqMnNsblFrMVNE?=
 =?utf-8?B?TUFSWmN4SDdrV3JGY3dTZDhNNlZDeG5kUFp4WkxWbWExNURqaVRxK1IxbDJH?=
 =?utf-8?B?OXhMWldvRnkzVmRXNjZYT0ZzWW4xVU8xSmxOTjNpNUlpSGFpZ2RYMWpjZktZ?=
 =?utf-8?B?Njdmd3MzaktVVVYwWDR1b045QWkxTmEwN0JoRjZZT1F2Y3d3Z3pVTHpCbm5l?=
 =?utf-8?B?WHRMdmo0bDlzYXZxdEp5RG5rdFR5eG9MdWptaXVHTHdYSnFhWmRVc2lHYmZo?=
 =?utf-8?B?N0dMSmJtYnFFU0ZlZkJiSmdSaTFUMy9adXNoeGtSQ3RVNjhtUEVDbXppSHRy?=
 =?utf-8?B?cS9md1RaWCtEeEpOTVRWbkFEV0ZJRHFCcFlCV0Npc3A4ZGZkZmNHZXl0MWJq?=
 =?utf-8?B?dmdacW4wYTgzQzZiTGlyQnJPVGx1dnljTFdwL0tkeE5tMFE0ekk1SDRPYTFl?=
 =?utf-8?B?bEoxNW9xbEhnV0pzb01PdGhaWmR1UEc3RExDbkF4andGSVY0MEowM2JhdDdY?=
 =?utf-8?B?c1BscW9ISUM2OWpHa3VEZzgvOEdDdG1RSVFYamtQNHF5RVkvdUxHWnR0VDJB?=
 =?utf-8?B?c2VaUDFEYktTZThYTk9PMXNTTU1QSHg1dVFhY2F0K2RHdXRuZmhETlkvY25B?=
 =?utf-8?Q?El1hMbaQnuV4xmWlgjpkXac=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe28ad1f-ba9a-4a52-1ab4-08d9e806ae87
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 17:49:24.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG4voZdzF/sQG/zRjA0nrEQ0nIWEFkkkoOrrPkkZkDd7sZXcHAQ+u4HpYRVLfOe7BzR4I7UTqh48HXFgIKHGdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1593
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/4/2022 11:12, Tom Lendacky wrote:
> On 2/4/22 10:28, Borislav Petkov wrote:
>> On Fri, Feb 04, 2022 at 10:23:22AM -0600, Limonciello, Mario wrote:
>>>>>> As there is interest in seeing these capabilities from userspace, it
>>
>> This needs to be explained in a lot more detail: why, what is going to
>> use it, how, etc.
>>
>> We don't do user-visible APIs just because.

The fwupd daemon has a feature that measures various security aspects of 
the system hardware, software and firmware and reflects it out to 
consumers (fwupd clients) in an easily consumable format, in some cases 
with actionable notes.

In this case the information would be used to make a check about memory 
encryption support and enablement.  If a sysfs file was made then it 
could be something like this:

1) fwupd checks /sys/security/memory_encryption
1: You're encrypted, here's a gold star.
0: keep checking

2) fwupd checks does /proc/cpuinfo have sme, sev_es, or mktme?
No: Your hardware doesn't support encryption, tell the user.
Yes: keep going.
3)AMD?
    Check /proc/cmdline, Did user set mem_encrypt=off on explicitly? 
That's why. Tell user they can enable it with mem_encrypt=on or 
CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
    mem_encrypt=on/CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT?
    We've got a kernel or hardware problem.

4) Intel?
    Document Intel's path to turn it on.

>>
>>> As Tom agreed in previous post, Boris is mistaken here.  I just double
>>> checked on my side on a workstation that supports SME and comparing
>>> /proc/cpuinfo before and after SME is enabled via mem_encrypt=on.  I
>>> confirmed that nothing changed.
>>
>> Then we should clear that "sme" flag if memory encryption is not
>> enabled. Like we do for all other flags.
> 
> If we do that, then this will have to be re-worked:
> 
> https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/process.c#L761 
> 

I guess if sme/sev/sev_es "are" torn out of cpuinfo when encryption is 
turned off then that "could" instead do the MSR read perhaps?

> 
> Thanks,
> Tom
> 
>>

