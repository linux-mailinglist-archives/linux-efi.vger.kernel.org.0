Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80EE3A9DAF
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jun 2021 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhFPOin (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Jun 2021 10:38:43 -0400
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:1856
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234062AbhFPOif (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Jun 2021 10:38:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNZZTdE8QeT7rdcVEcti6IEeV1WABD7Qw2HL88m/esnAPkjspvRZN9qZqKTzoF/hrvbpb7Y3K06jCP9rzcffjXOMv8CyxanaLvGaomfHMF5ouU+yOL0eiKLnQaWodopjSj8SYT+bamWFUfksolqP4x9j9ajtPEhRmPhJiDy3PaPi8vLbZ9ZZ1GTOHbyKAvP3F6XMbC1OWxe9hRfxnqCcjJheijJJ2NgMhk17E7jZ3rBnBeoaxNDvUogZ0LR9mX8gxJONJS9hjwvWMShQMwZrI7MN9SKTyC2hJitcLOcxkeFOuzObcCX9vusOiX5WeGUJqGWHWfIczcPE5W/Qs3G8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISD85P0fZ+Xcqkqd+wNnv0ZEBY+LALe0q4HAaFd9PjM=;
 b=Ee8fXYJPyRL4rb9IkxLZv76xATSAtnrqx9RRorcAMCkgFY9AZbp/SLVdo1wHysB49AXC8taxe7gC9WYfvGjpjoiIQxQ5LmsubVqALEuMqD7DT8lGn44smKhNXaFfPxB+MaHqFOKDKuNoQ9A11xQU3ZcATMObMgQCI3/t/lLsA8kha8aiSwnI1uxlujwLDaI0cislEuXQt+pl7RZxee06JzbT46VJIu9vACD5xnBT0CboAlNVGXt92JzL8yD7IFOpBUO7EjCKEfWcVG4wtBmgQxoA/Xk00lGH2yAsViMCL+YVABKfPgexjB7FBALe8jEi2KSBoIwvCCVH+PQk3lviOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISD85P0fZ+Xcqkqd+wNnv0ZEBY+LALe0q4HAaFd9PjM=;
 b=FazOZ8SBtqC0bjXYswaIx/jEks7+YzVDH7yCSrbJWJP7f5alITY4QqRL4vafq8qMcFTSmsO406AMbfq3iAq4C1xRBILBYO7aT9BIgkdw4UmGHalWxDS4VrMIkgxbAEEy1plYLQBgDvdSCSqhC0tcGX1wfR5dBTHsxKNzCJOx9Bk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Wed, 16 Jun 2021 14:36:25 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Wed, 16 Jun 2021
 14:36:25 +0000
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
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 11/22] x86/sev: Add helper for validating
 pages in early enc attribute changes
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-12-brijesh.singh@amd.com> <YMI02+k2zk9eazjQ@zn.tnic>
 <d0759889-94df-73b0-4285-fa064eb187cd@amd.com> <YMen5wVqR31D/Q4z@zn.tnic>
 <70db789d-b1aa-c355-2d16-51ace4666b3f@amd.com> <YMnNYNBvEEAr5kqd@zn.tnic>
 <f7e70782-701c-13dd-43d2-67c92f8cf36f@amd.com> <YMnoeRcuMfAqX5Vf@zn.tnic>
 <9f012bcb-4756-600d-6fe8-b1db9b972f17@amd.com> <YMn2aiMSEVUuWW8B@zn.tnic>
 <91db9dfc-068a-3709-925b-9e249fbe8f6f@amd.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c3a4419e-4b05-cf4d-2fe7-0d046cb36484@amd.com>
Date:   Wed, 16 Jun 2021 09:36:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <91db9dfc-068a-3709-925b-9e249fbe8f6f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN6PR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:805:66::46) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.11.236] (165.204.77.11) by SN6PR08CA0033.namprd08.prod.outlook.com (2603:10b6:805:66::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Wed, 16 Jun 2021 14:36:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71d3403f-e088-4a51-9e59-08d930d41e45
X-MS-TrafficTypeDiagnostic: DM6PR12MB4370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43702A32C07BC4C3EF92C643E50F9@DM6PR12MB4370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AN33fWJ2IQNGNWWRVtNRIRH5+lfZPcJmUIO0F4uA0zu+sOPNEeoAYEODbDmb9Dn60mHdILbg86cIHEQCweyBdrNYYrxRbkWNfgBL5cf7X6FfrWvsPBse1b6PAVeL2kwysH94NeMEQ0gfPI32isJjRlzIi2P65GP6gJNasgcl6Jl8fO9mnFxsp/S8gWN68eM6H/n9vBwg+rBkyvH7YQZ5xGF4JmHigThyJnnmKExj80SX8nFS2ryz7cYOBedZNw2sK1q4IgxUmCfzQLcIlTbUudO7KRbqlIPQt+aBQebFQYZN32NDdSIppZYDQD1HLfea61aZvq/qw7Gdbz/yTiWlV7NshEdX/CMy/InJHwJEzBY7RQanLA1C6BT53WmugFzABt9AK6qNjFuf2jZQcWERahF1SlrFh47quJBX8DTJtVWV3bwzn8l/W6G4lXtOlvDYqPIAxGvjEqPJc5snyySQHPA0aaamIjGMWjGCVLHpbYaZgwqkoRSZyrKdMPiIV64XovUH+LqVdG8WCJx4QSWLiAlDXEk6/f/gCU4uEW7EPC/pH0ZMzx9tt87s5TD/uCIRMdwjr0YV+Z6dysQX47F2l36X2uKnlIJ4UbBndi7L7EpwRcGu+nbriDZZtmJN9VYdYwlmuBIJZVlEtoG7R7mb2dhYXv4XdEkn1ega99tEcRl4lR+uamlIRiU3VzPzpCzBIBO3Sec7cML//ZIDZOqDIoB9kZmTE/ThJyS5ywMSSp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(38100700002)(38350700002)(7416002)(83380400001)(36756003)(31686004)(6916009)(6486002)(52116002)(2616005)(956004)(44832011)(53546011)(478600001)(186003)(5660300002)(2906002)(31696002)(8936002)(86362001)(16576012)(54906003)(66556008)(66476007)(66946007)(8676002)(316002)(26005)(4326008)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUpxdTM3NTAzSVd2TjdaZDM0ZlFxYTdWRjdOMzdsS3pBM0tTNEJwOEFhZGVs?=
 =?utf-8?B?UjJ6aTVEbUYxZ01JZC80QTUzY0taNWo3c0dqT09xR1l6b21xYjhUM1RKSk5D?=
 =?utf-8?B?WlJYbkxtcHJleFNtSmk4ZDNqLzlWaDZIM3lBUUtqbWxMald0SUdvRHBMVVhO?=
 =?utf-8?B?bkVJeFZCc3lBQk9OL0h1VzhPZlNqZFNBb29CWjFUeXFZM0haWkF3M0E5eUp3?=
 =?utf-8?B?cVdYVExHTEtkNndoenhWMnBpRzg4QVorNWtkVW5yVUFIQWg1WHZ2eENZWU0y?=
 =?utf-8?B?VFZqdTJMNE41ek83MkhRWGhIb1ltQmJXZCswc3NjNE5hVXFVcHlDZ010Q004?=
 =?utf-8?B?bzZCRWRBV2l2TnpVdHlQRGN1N1Rxb3dnQ2RLNGFueEpjRDNVc3VGckFOYlR2?=
 =?utf-8?B?eExZTXVoNE0xalFBaWJzWU5NT0pOeFJWSThjd1p2b3M5T1FITDVqdzR6d0pR?=
 =?utf-8?B?dWZCZmNzZFppOU5nTE9CUGVScXZTQlpvekpFcW9YMlhhSDFzb2ZGYlRiU0M3?=
 =?utf-8?B?dkVndjY1c0ppVElqTjFObTBkQmZJUG5UcW9WYTA4UzhhNUFSYm0wQ1Q3K1k1?=
 =?utf-8?B?cy9ORC9zQ0lSNlUxODhWQ0dvN2NMbURXY2ovMU91Z2FYRTRkNkNRckZhTUR0?=
 =?utf-8?B?WEpMWmZGMElVSUtsN1pxWlE0d1lDbzIrV2p2SE0yS3VmM1dzSzFMemVMZHdV?=
 =?utf-8?B?MnZpc2hBdUFWbUF4R1N6MlpkRmtLZy9QMGhZMlV3YmFyRWhBQnRtbzFIbmQ2?=
 =?utf-8?B?S0JreHIrNHVLbkNMRTRoNithMUFaTEZTODQ1ZTRJMHJGV0YvQlRMYStBRDFN?=
 =?utf-8?B?M0FFZFowcTdwVTVUSFdNZW5uUmttbmMraDUva25OM0QzQzFXWHpRYXVNVGpq?=
 =?utf-8?B?enNIV1MrQUEvWnFKK1QxUUxHbGRMRStXSlpjTkd0NWdyUzRlSnhUdDQvNDdm?=
 =?utf-8?B?N3ZVVmlEM1prT2VOUjMrZVM2c2pRR3oyaFVMVHl6blB5OFlSa3J5RmhXWkNK?=
 =?utf-8?B?Vk0xelB5WkZGQWo5aGc3Q2U1YWF6SEZocmU3YlV3VWR6bFpEd3NZU3RkTXZo?=
 =?utf-8?B?ZTN3czdmMk5Gck1CTEFoMUdvUkZRd1YxZkN4WDRIRmZaMkVLSTVWVkFKL0NS?=
 =?utf-8?B?VnI4aytmelpDc2tRR1NTY0o0VDVSaHhSZ1E5VkM2U3YvcUhBYnlKS1BGZXRU?=
 =?utf-8?B?dFpYUXdpRmFpNHBwZXp0MWVMQTZWSXdweVk5U1ZRbTdpYitPQUhGSUorQVRp?=
 =?utf-8?B?bU5ocGFDSDZBVDlpM3ZKTUUySW9iYVY0OTFGWitFaEc3MDFHTU85eVZ4RXNM?=
 =?utf-8?B?d2owSkdSNzJwV0xrZ1JSSzJwMzJqVkEyeEtSN0NMVmJmb0VJVGtxcC9uNXZN?=
 =?utf-8?B?ZHlXU282b09QaEFEY1NseUlVSXE3WFVyblFsWEZIQklBQnd2d2MyeW5WOUVz?=
 =?utf-8?B?UnJ2YlVnalQ0d0k5bXppUWZVU1BWVVR4d3lWTXdPTGtpa2EySng3NmJyOGZp?=
 =?utf-8?B?MzhJNmVGVldEN05xYm1tQmYxVDR6K05MNi8zUy9VMWZUSFluZUcwM3E3aENH?=
 =?utf-8?B?YzZROCsvM2orSzRibHJ5ZXNidzlsQWFjUTRrNU8yVUJiWjN1Q0dkL1VlSmhF?=
 =?utf-8?B?SHAwVFVFeVJaVmRGZ1EwZnRSMGtDUCtQcnlJMm9LYW91WDIzNnd0ekZCVXFu?=
 =?utf-8?B?MHFVY25UdlhpQXdWMXBKelJyb2ZHa01LOUtMdUs5S3VQVVIvU1ZQVjBjZkE4?=
 =?utf-8?Q?ivp8p9eDk6EUeU1TXaAn9LPib6+RT/SX5XbIiXb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d3403f-e088-4a51-9e59-08d930d41e45
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 14:36:25.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HIKrTBJ5wJ0ilUtNJBB9pnGQ/wIhqv0L+PHNMvklBER3j9wco4NSw7TgwTi/ycQc8MJvya64AJeAxFP8CzQRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 6/16/2021 8:10 AM, Brijesh Singh wrote:
> 
> On 6/16/21 8:02 AM, Borislav Petkov wrote:
>> On Wed, Jun 16, 2021 at 07:49:25AM -0500, Brijesh Singh wrote:
>>> If you still think ...
>> I think you should answer my question first:
>>
>>> Imagine you're a guest owner and you haven't written the SNP code and
>>> you don't know how it works.
>>>
>>> You start a guest in the public cloud and it fails because the
>>> hypervisor violates the GHCB protocol and all that guest prints before
>>> it dies is
>>>
>>> "general request termination"
>>>
>>> How are you - the guest owner - going to find out what exactly happened?
>>>
>>> Call support?
>> And let me paraphrase it again: if the error condition with which the
>> guest terminates is not uniquely identifiable but simply a "general
>> request", how are such conditions going to be debugged?
> > I thought I said it somewhere in our previous conversation, I would look
> at the KVM trace log, each vmgexit entry and exit are logged. The log
> contains full GHCB MSR value, and in it you can see both the request and
> response code and decode the failure reason.
> 

I now realized that in this case we may not have the trace's. It's
a production environment and my development machine :(. I will go ahead and
add the error message when guest sees an invalid response code before
terminating it. Will do the similar error message in the decompression
path.

-Brijesh
