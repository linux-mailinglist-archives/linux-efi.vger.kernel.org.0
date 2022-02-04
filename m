Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB44A9D77
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 18:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376799AbiBDRMP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 12:12:15 -0500
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:25469
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1376791AbiBDRMO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Feb 2022 12:12:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnjR7rx44pyvH7dZit1/Na8lYN6PVG9A+9jLVrxMLSjpB/RJ/p/ovDjIFT5XzBzVnwk5oPoHj2f+Hutr+9MKo4FWBqLy/If6AyEUbyDUOckLmueHQ+bbUHXnHQ9QaKTINRZ3iZfVGHbMkY+3ryrrrf0C/h6xasTrTvl2XEQRKkRPjzKI4kjDBTWyj1RhGiIb4KqFrSi6YZ0T+GJmiaIaLpkd5F9Bsja9JCFdn1BgPCM02gaVBTfWvj1m51dig4hX46aQV/CmaLEj9EZABF6XYTbdu7eyQqRvO6RuAGCb887NZOxFDf6zOfnkW84IOoiYimiUTxE0GjslHAO8efavMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ikxy9qU3s3qKQclQm4d/iduMS0vMPBumDFCHCtuAjmY=;
 b=HzqZcBxOOtSdxiy4Bz/J5jAqaVCh6AFo7LFUoZmRmAmEhvMzkq1dwrA3gx8c01SkJLZ6vH7qHKQkgHZ1B0nSeU+r8V9oI77yqP5eM4shsxpfErguzopHpICcGJNAP0eZwJWmNW4vhbSodfTLDVavBnqJSwEFeBt8fKz8k3vxfSwuDF4EqbQ8+V4PdHjgrvI5T4RoUQqeEPL/KIqiSndoSizqUT0QPmaShIcpZ7S/1z5Yrc4qJHILqzJShjGQGaRy7IMSaDaVYHbJhBx1LwIXlXD9M06y/HpmXrCqKK9WXNp+lUo8eCYpJ8NbzfjwqOKDBw45z+iNvm6aG9EzThxlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ikxy9qU3s3qKQclQm4d/iduMS0vMPBumDFCHCtuAjmY=;
 b=qT7O0YIhK0/oqAPjB8RVmHPWlYm0xF7oKOZCCi60CMlH8U1iDtbIbOFR+GhBSqDsIHahV3mGYANwzKfdkY2VrqPJJMb7Y3z9N98h7KPHSs+bDw5iE8c4AKvL+dMSMFmfAmtd3kRBxqeNWiT0xkaok/3idNAVcp42QWTa8gKqWlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 by BY5PR12MB3731.namprd12.prod.outlook.com (2603:10b6:a03:1a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 4 Feb
 2022 17:12:08 +0000
Received: from BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::b9af:8be3:36e5:1a13]) by BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::b9af:8be3:36e5:1a13%7]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 17:12:08 +0000
Message-ID: <5ee34cad-8daf-6282-f2ed-cbc92a89d013@amd.com>
Date:   Fri, 4 Feb 2022 11:12:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 6/6] drivers/node: Show in sysfs node's crypto
 capabilities
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <Yf1UO6jF91o9k4jB@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:806:6f::28) To BL1PR12MB5221.namprd12.prod.outlook.com
 (2603:10b6:208:30b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a7c3ced-b091-4d4c-b1f8-08d9e801797e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3731:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3731934E3A66D292DE93C0FFEC299@BY5PR12MB3731.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26wGtabw5TEtkBgtyOYlaGMuddzrIgvP9Ba0AWbTpVvnOqRpEHHY6vGahN9Iy8JIKTvOn4cw/xgxZb7/fNBJPz9M+ViOcG1gXJ+DBG+hHJEIO3wSu8G3rHLYcFESx/RZZ10i6Q0vY6ACqVw0FBCIbYjviVcwX/LsBFQ0k6aOhnoLc2KXlNaXiZe+Kc3xtVPCEdyrvdFChodBda1O0ai/nyTWlMgXILXbAU7FCxRTXdTBks7cimCVVvfTbnXAXVydJcTbEK5SS32rnrZQrbKRxFB4kZTNI+qUkUq+cDKg1ON0oJgmxTTDAeP6LehKM5m6L0UliZgPdacP2b5g3w6FEJ36kycZjdY9cgVVbL9jaoVGyGknimZPOxJ/JA2Vhd2eSxSjYH0DCH6nenY9RvyOe1KFSuZCDNa2x2ucn0Q7/7HnIZ6Zqg2VwkdzkZpN5krjvW3ZoO/7diuVNFIKNBW02504SLoqZR2/Lk/Jh/8fTAKcq2jjPR7R52oIx/+iNRZn8g5v9MJnqsNG3BAqhCFuooQwwqMEBeS1FVdfWPcCK4qw0fmaaCrsO+ynSofbqRq6CiuDrd8IqSdiF46AFaO1GS/VV4XY7lzFkfZ03IF114X5ON0NdTPnUDgQcaw29L6sEAruEHEkNRI7iS8U+nIC3XjyFH42S+chtm8NUj+9c9tHGAywuQEPlcAzgcI7Gz4kwlVJudzl/QcPb59nqkHrJorF2OyMohcho0hvsm1waNkejPRsq8edniMZ2OMTpQAj0fOQquGBV1YQab/Q6b2ikMvfiFCiULhbqRuLo7CQ1N/dgEYu2U2Tf3pN7+cPPw7p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5221.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(66946007)(6636002)(7416002)(110136005)(8676002)(53546011)(4326008)(66476007)(6506007)(6512007)(4744005)(31696002)(66556008)(36756003)(186003)(26005)(6666004)(2906002)(2616005)(316002)(86362001)(38100700002)(6486002)(966005)(508600001)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDR2SDVQaEl3UmNTeWhTQSs3U0l6YkxXNVB0dEcvTEZJTUpsTmpnWWtZbGZO?=
 =?utf-8?B?MzQrSmFSZnU3UzZyTWtJYnFWU3hvNWo3YUNFaG4yNUorSVovaG1ZdUl0YW9x?=
 =?utf-8?B?T0lNcDFhRzRuTWFGcWVNd29McVo1Ty9ScHpVeThaQmZ4eVM0Y3p0Y2pJc09Y?=
 =?utf-8?B?dmtWN25ISlhkZjRvRTA1cUI5WVZ2SGNEQnkxYjdVVkJCMXU3U3MzNzFsZ0VI?=
 =?utf-8?B?OWZFVm10RlVoRjFRZXhmaEU5Yzl4Y2Q1V1RGSk12OGlodFExTjgzTGNmRTJv?=
 =?utf-8?B?YUYzZnZhWTRrSWRueHJiM3BFZkxGTlJ2TllJR0x1ZlFxYTdzMVhWSHNXMzE1?=
 =?utf-8?B?VFYwMnlKSEk0UHY4Q0IrSy9zdTNHV3pCQnhCaFdZY3hDeGlDd21HV2xLaDBw?=
 =?utf-8?B?aUVuSW9DM04yTDhwandqVUxMZUFVdkErSGVwQlNnWHhMd0lKRnI0UXVjejI2?=
 =?utf-8?B?VVN2Q3I0SGdSRUFWcEMvcHFkYjJFYkJHTE5CT2RMVzdnSXh2amErRUIvNUNO?=
 =?utf-8?B?eGUrUHFUZXplUVRIRVJlM1ZydEZoWis3Y2RYT1h6dWo2VEsrbWtkc0xFUjdB?=
 =?utf-8?B?dHpRaWlhNVFwYmdSeit1MFNWcUNiM1FKcTJ1T3ZwWG5mT1BRRmRabWhHbVh1?=
 =?utf-8?B?MkJvalZnZmZrRWhXc1ptUmVqdmJVTWNMc0kzNDVKSzdQNkhFLytoZmdtWVRp?=
 =?utf-8?B?NHV1WGE4UmlBT3dFaGQrKzlWaGh1UTV1b3MwN0dERHpKbDV4QlBNK2Y5U21h?=
 =?utf-8?B?ZFBvZmNHZzhyZEd1czFyUGxSbWJmWmMzZ0l6bGxNMmxLZElyRDVjYzNZMlp4?=
 =?utf-8?B?WkZGdFBaYTQ2S0grSk9qZmxYUkUrUHNLZEx1elRhb1haTHN6Rnd4YnkveDM3?=
 =?utf-8?B?dHdXY0ZzaStLUmxmZXF1VjVBcklWWThBOFVFYzdwK2xmZXFkalJCYkV6VkEx?=
 =?utf-8?B?N09tbUVFNWJqVU1rWUcrcDlPaW1NMEk3dUtFRkQ5b052WFFRWlNXYjAvZGZi?=
 =?utf-8?B?WHFIZG8yb1JSeUxRenByYXZYalM2bE1WQ2NLRldUSHJUWmRsSlhtN1p2dmN3?=
 =?utf-8?B?UlJqaE9SQWtYeUk5Z2Uxck1QVWZqNHd5bWJrRTBXb1haczJ4WHZYN0dRcXRM?=
 =?utf-8?B?N2VxdWtSbzNNM2M3TVlDM1pXL0YwLytZTXFIcXp6OW92bUVBZGE3MXMzSjRZ?=
 =?utf-8?B?RHo2VVJxaklCaGdrQUFSYnArdHUvYXdIc3R5RFo5T1lhVkpKZVpBRk95WVhy?=
 =?utf-8?B?TmE4ZzJMRkxUSXZoRy9DT1J5SXdhMHNJc1dMV3NNUHloNTRoOTVvMnI0Qlgy?=
 =?utf-8?B?eXpIcSs5Qkl2M0paSVpBWm9TT1NmQ2REeUhCdUpxejg2a1VGTmtJK3lSV1E0?=
 =?utf-8?B?WGp1OW5NODJwbGxpZCs0NjhEeCs4L3hIcGNPWFpFM0t6Y1MrakNMN2J2SXFV?=
 =?utf-8?B?QkVQNFhKZXFVbkVtZFRpOFI4cG5RSXNValZRYXRwWjZBWTZLOE4rOCtDM1Zt?=
 =?utf-8?B?VysxSk1mU1U4WWNyRmdKU2FONUZXY2dKYTNJUENXN0RvTzBJakxyZmVhMEZi?=
 =?utf-8?B?VGlGSHA3bUJjbGJ6aGJKYjQ2ZzZIZGRsYldpU1psaEo0ak5OWkVDamY5QUx2?=
 =?utf-8?B?TXIybkxQOXRvZmtOcDc4djkvbGtZZW8rcWh0a3ltVEUyQS9kZExoTmYyeStx?=
 =?utf-8?B?bTNaV1ArSm5FUzdLaGhhT2RoWG9FSklrNzB3WTVSL3pJM2tYTk5KN1JoQS9Z?=
 =?utf-8?B?ZTRkUkswbHFCUjZFTzgwMzE5eVdHNlNPdzF6VVMzNkVEdXdrSXkzQUdhYnJp?=
 =?utf-8?B?c084TDk4WjlxQTNibzNVNVVldlRrSDdlU2Y0ZlJnOWw5YUk3bEh6MGFQVStr?=
 =?utf-8?B?Q1JwUmg1bzUvMy9ad05sbStNNk9MOUlUdlVLZ1ZjUnc5SFo3aGRrdjEwRWt6?=
 =?utf-8?B?M0VMQXd0NVRWdUlvY2NxTk0yZ2FVVzZTRU1TcktTU1dMbFVsSk1IM2hKUU5y?=
 =?utf-8?B?c3BvWFpnUWYwOGxzdTl2ZzZRSDl3S0NjSFJDUmJLeEdDdjlVZVJWNE9aZzYw?=
 =?utf-8?B?WVBpb01ONXpGRWlEeVM1L1JjTjl5YktsczFBV0J1TlJmbjg3VzZqZ2lYVmVu?=
 =?utf-8?B?MjFlWnN4aWc2UUlMelhKcWJnc3loNUVjb0N0ZTlFQ2ZWbGhwb3Njc2l2NGs4?=
 =?utf-8?Q?MahfvcQHtN6uY6PH9cG5/dA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7c3ced-b091-4d4c-b1f8-08d9e801797e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 17:12:08.2936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0QiSRosfBMsIuNi3bEA06dA6HPv94xGTBPYviLuZ8yXwTNnDaSlPxhWG6Y1BZVxJzSR2OAE+sRwkZk6qd9PVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3731
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/4/22 10:28, Borislav Petkov wrote:
> On Fri, Feb 04, 2022 at 10:23:22AM -0600, Limonciello, Mario wrote:
>>>>> As there is interest in seeing these capabilities from userspace, it
> 
> This needs to be explained in a lot more detail: why, what is going to
> use it, how, etc.
> 
> We don't do user-visible APIs just because.
> 
>> As Tom agreed in previous post, Boris is mistaken here.  I just double
>> checked on my side on a workstation that supports SME and comparing
>> /proc/cpuinfo before and after SME is enabled via mem_encrypt=on.  I
>> confirmed that nothing changed.
> 
> Then we should clear that "sme" flag if memory encryption is not
> enabled. Like we do for all other flags.

If we do that, then this will have to be re-worked:

https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/process.c#L761

Thanks,
Tom

> 
