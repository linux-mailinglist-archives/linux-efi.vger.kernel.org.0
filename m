Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7162153B03A
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jun 2022 00:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiFAVUW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jun 2022 17:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiFAVUD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jun 2022 17:20:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF819A76E7;
        Wed,  1 Jun 2022 14:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9RPfHq6buKsW5hAl7WL+BWroiXM3URFZFFeW5nHDk0MwGgLnOhDNMFPN+znDJF1gJX5PFdfS4Nw7oZIeIGp7P4q1bN2AvZXQgHl6+NlRkdPGlPVdaeKDoHIpDq+pacPJWcYgw4DILzvPKbrcbSDjvxQIVgjY8qUKY6JrSCDF1+tz2Lo+TeulRYP2xuBnxD1DWVBKf/S8S0GsjhzO0Oj83d6L+AugM2tOtFlBe/oVGpVkVxuyI2psraUtvRPxvxyWRmgRRN7cfL8+Qqf+6whXjp7U7UeFymM7Q35copLVEMoe9OP0hT8Z5UcSkSS1fr6mW3KAyz5iM0kaWs6ApP0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xrit1VVwkylOrRq3lugmKuj9E/kZ8uKdpjO4dElwmHA=;
 b=mG940FyppRB/pFO/q9yWFaZDUn5umQDvTsg5EEOXxmYjOAYiNXZWDNmZ/Sqs5eFR0xDHPW4R4TIPPvz0GryJbPnDmdlJ707uoKqtpCoP98Yxz16zLHwXSGSKtDAVQhdjV1jmwWqCOogZj65ev11el1j3+OV8defwk0dlkI8EI0mKfMBr8rMDwJEazkXZiWZdk7hmZwlRhxfwkLPbzSM+UhIC98jvXAToFkGCAcEdmSj09qjVNQkoRGMc3PykQc8gVmEtVAtWUkvzsccMDHGu7sOy67upRyKimwx72YJtonJKmQ8AwTC9bWNpbgnOlnIx+264YJQL2cGuGW66VZ3z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xrit1VVwkylOrRq3lugmKuj9E/kZ8uKdpjO4dElwmHA=;
 b=2TufTSMZntu3uOgtkVyt3ay3qeFWPH0VANhMbBVv9C0w1dEhD11Hz+aLxcXWhXlNM7CAd+hmtWra7j+GNTaRwAYAFnid2O3JdyOxkQXrfpYtSne9JjzgcoUh5BmlgZjuVrkITzStoVSjq6Ec6RlPWwjPDQoEyiTibi1YuR7l/1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by BYAPR12MB2887.namprd12.prod.outlook.com
 (2603:10b6:a03:12e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 21:19:59 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad%3]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 21:19:59 +0000
Message-ID: <0e0533ab-cbb4-b8da-66cf-e838d9ed9ea3@amd.com>
Date:   Wed, 1 Jun 2022 23:19:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     "Xu, Min M" <min.m.xu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        "Gao, Jiaqi" <jiaqi.gao@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rodel, Jorg" <jroedel@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
 <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name>
 <YnpGnMoviGoK4Ucq@zn.tnic>
 <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
 <Yn4ed1gupKmNz2jn@zn.tnic>
 <20220513144515.fx2cvo3rjued3vy5@black.fi.intel.com>
 <PH0PR11MB5064B561086BE6350CC1DCDCC5CF9@PH0PR11MB5064.namprd11.prod.outlook.com>
 <CAAH4kHbU4FJ=veYQxncdpYD837M90vq2o2saVaUCJ6=pfuNRpA@mail.gmail.com>
 <0c545c5f-3540-1441-7a7d-359b6795f43a@amd.com>
 <CAAH4kHYj9WOKngeXYL=KnNb1fXa-MaFGTBGZcBX726Od858Q3A@mail.gmail.com>
 <fa512bb1-bf3d-fbf3-69da-1796653ec5bf@infradead.org>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <fa512bb1-bf3d-fbf3-69da-1796653ec5bf@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR02CA0007.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::17) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddebe80d-3fcd-476b-ef71-08da44147bb9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2887:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2887F0E6C9BF3DDA8CCF674D9BDF9@BYAPR12MB2887.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAXeASN2EXYi9TM6mi+Xn1i45Cq85Odv9UImmQfSPyNZJOHiG/1A+y7WJIM5RzevoSW9+0C51SwLmqG7RDqqeq7sREStJOPqw38jCOAGd6PG6jf99rl+vYdZzMAhSYwpRgSyaDLS3Zau018nUgz5QGACKXRC0ovFAuMtoQrvBBAJKsOpojlvCkzmSOFnSMNuGIdyWfViyEv/UY4NY5r3tuPcG21nZX6t/ckIeiVoYplHCEBARVZVlq5t49LaAdmNyZltGnd5X/9PRQFIW0/XpLpeVJh7unD54zAPzHPXaOWthshjbviSXDZ8sbx5nKv3VVq0wfLtCcReZBWujy1/prDiUXIRkh2ogOBkUzR9yzUR14509msGgpcsnagOhMYbsNdTwtVmpMUIgIUouXAxUPpUfFoFInUGIp4qukypCn5it5Sdt9wpMDfCDtm+YTvgaUSMHouQUSJXqtL/1YfKbGM/udbVb8RGq0WvbadWPmSWpAOjz3Dv+rBZwt5Q4CAjyGc96ewwHoHLKJIWygGS75wdRZ8etCsfiCGjeOkDyTaZgQloPt8Hl+fkAfrPnznLQdxElx6HVb03GIxn/uyD0Q+DwrF+gYFvVbxRHEfqlm8NgnAAG3YJzEnoUFUb/5wLUJ09HGIF/LNpiCy2e08HocrlhxaNFwWCkBrKylxoe1e+hm7e+1A/3ljVGLdVodDAt39V6usyCHq1yyQHc4NBlkjnYdss9O/Dnl2WkiACTULmuVhVMUqqRsdjt2p9b+wy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(316002)(7406005)(508600001)(36756003)(186003)(2616005)(110136005)(86362001)(54906003)(8676002)(31696002)(26005)(8936002)(7416002)(83380400001)(6506007)(5660300002)(4326008)(6666004)(6512007)(66556008)(66946007)(66476007)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjdoNVVUOTdXRDhva0d6U1ZIdHROS1IzaHhUREkzeXZyWitCNUkrNmJBeGFP?=
 =?utf-8?B?VkZMYmZaQjBzRHE5b1pvWHZVb2J2bUJMSzY2UTA4YWhtWWdwSDczZ3cxazZG?=
 =?utf-8?B?MmRVUW9CM0k1UEc0TzBEaC9wWm11ZzQwT3NTRHIreGdneGg3SkxZV1BrL3Vp?=
 =?utf-8?B?bHZ6ZW1zZCsranMzTVFYUW5yYXVrR3VUTFlOWlc2dll2RU9laXAwMUk2YjZi?=
 =?utf-8?B?K1V1clZZem92SnM3ZFV2Zlh2TEdmV2c5eVJ5OTh1Qi9yZ3hCeFRLZzdaWWpV?=
 =?utf-8?B?RlN1ampqSEc3dzZGZ0xZS0wzRFNmd0VvL3FRSXo0Tjk0UzV4Y2V3WjNmSlJh?=
 =?utf-8?B?WWpXdVZSN21KTHZTZ3RYQWV6Q1lNL3BqZGw4RzMzYWQrSGRhOUlJNE5vbk82?=
 =?utf-8?B?YXhzbk8rWEVMaFBpd0gzMXdqY01UanozOVlWZEgxZUowQ0M5MWh5M1lQQkdJ?=
 =?utf-8?B?djN1VUxZdHlMSm1lRXUxTldVV1l1Qk9FbTFOazRPZUtlc0RsdnQzVmtWbjV4?=
 =?utf-8?B?S3ZFdEltcGhlTzdtd3NWaTdJR0plZDQ4RU1SSGlyenZvTGFHclBQZWlPL21w?=
 =?utf-8?B?N1hYV1NJTktYK1QvajYzRWFDUVhzZVRZK2NaemFWNDVxa0hXUDJTK3lUNyt3?=
 =?utf-8?B?SHpwTjU1Ny85OXBYRnZpaitlUTd6ZGlOd216UDJMczZKWllQUjVQaXp1SHBz?=
 =?utf-8?B?YnhuNXNsSlZ3TytKLzd4YkNESVBGa1YyK2lWRU1MRWppZVBYN3hkQzZjQUlo?=
 =?utf-8?B?bXR5Q3lFUEFRVWtaRjFkK2JSTVBFcFFZQTliYm93VTJaL2Q3VEptWVlYVXZ3?=
 =?utf-8?B?OWRVQ2U4SW1Db2dxaXlSekEvWENsclFLQllVdWEvYmFtL3F1cEs5eVkzWXNE?=
 =?utf-8?B?RzlFYWlRdWlTZjNCS1pteitCOGprUFc0L0NiTU5DaU9RWWdhM0tJQ25vSkpN?=
 =?utf-8?B?ZFkrc3pwdmdCTDRLcVNwZWRPVmo5alhxaW1VeGhaTGhXTkhFNVdIbzNIWjA5?=
 =?utf-8?B?d05ZNXFRYmVKZEJhUlJqanJHVWd6Wko3NTFNSjdxc2k1Zk5CcG4vUWl6WEtM?=
 =?utf-8?B?Z3pDTHRyVXJLdmlIUlFBcVdQSEYvY2VRaEJaYXRBSm1rMng4V25IWUsrM1dQ?=
 =?utf-8?B?NDlURXp4eFZtQTJQKzFZOVpRRWtQVCtValZuSEtpRjJkZENieDBVdXUwcFhl?=
 =?utf-8?B?VktyRFlzUCszb2Rnay9wOFh6V1paNDdrLytCOE53QjYvamx1djlyTDJUNmo4?=
 =?utf-8?B?c2RSQnRIV3JGVk1vY2ZkOUVxTllvOUdXUmdVajJQbjFtQmRYSGZoUlZjcjZx?=
 =?utf-8?B?YVlaQ3E4NDNnaDVNbDJQMTBJcDY4Ym44YWVyU20zbjN5N0FoTWdpVEgyNFR4?=
 =?utf-8?B?bHRubjdBRkhONFl2M0h5RFhuSDdFNEFKcWlVZW5DdHNMcDRKU0g1LzRQQnIr?=
 =?utf-8?B?WkU3TmQwSHlUQm5qdnFVR2dQaThYN0VRQXBRUVpMRTlUUy9iVXdEMFlDcHA2?=
 =?utf-8?B?bVlVbmU0bmFWS1hMbXNoV1RGV1VMUldLTkwwdTVMNE93b2RTSWtobnQvcmty?=
 =?utf-8?B?WlB5VStFaTM5dmZUclNvdTRJME5LRWRlcTBUd1psREVQNmFLcXVoZytTejMr?=
 =?utf-8?B?LzUyNFpWaU41WGszQzRZWEVVNlUvNE1Md2RORmpXSVpVVHE3QWpRd21wRUQz?=
 =?utf-8?B?THpqZVNINzRBY3YyMmpIbXhmYy9kSzg0MkVqVTEyVnJ1eVA1ZEZGdE56RlJp?=
 =?utf-8?B?a0xBUEQvbmJpZTBERi9BR0I0T3grbHhJdXJVWERyb3JrNnB1VEhiVnRmbU5y?=
 =?utf-8?B?b01lanpRT1hDZkFMNkxiSmxYVGZlN24xL08xWHZtOGdOVE5QUzVzL2hjN3M3?=
 =?utf-8?B?QktnNzJxYVI1TWo5TUpkYTBzV3VGT00rV1dRdm1jblJWWTZBQ3N4YjJtZTNY?=
 =?utf-8?B?Ym1NdXVtOENjN2QxWVlLN2Q5RHRLSE5kb2FxaVQ5R0hpeG9QVVFDZ1c0dWxU?=
 =?utf-8?B?MUxvUVVJUEFCa0pXd2ZjeVVXSmQ1WG5KdEtzS2xWcm9sbENNWkJaMCtuQ1Y3?=
 =?utf-8?B?Y3dzZE5OTnZxTUhnVVpXWnBOT2JuaDMxRVUwaWh0ejM0N2FNY29nRlFNdFlt?=
 =?utf-8?B?UTYvR3BtQmd1cVU4QVlYTTlMeGlqMjlhdlFUa3Z6eXFOT3loYmNsZnd4TUZj?=
 =?utf-8?B?TVhzNFNrYU0zOXloUGpuQ1BHMXZZamNTYmNFRUlRZ2dTbE5XcDAzNXlUc2RR?=
 =?utf-8?B?djFBaGtmckoyWGhtYTRYWDR6Um5nTHQzSm93WmtMZlpVVzFkVzAxZXdLMGJO?=
 =?utf-8?B?djg3Wk1Icng4OVhYc3pGbWhIMFhVR2FJYlBXeEQwSGY5S09YWGJRdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddebe80d-3fcd-476b-ef71-08da44147bb9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 21:19:59.5445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gb/mSuWEc7aTzU/l2bT6XKGQrbTovmbcnmK15jWXsA1hWAxPsksJQoS1+O79cKRJKHQ37cUz/dhKhQ3Su0PA1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2887
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


>> The memory accounting in Linux is probably the issue. Both times I ran
>> the test were from a freshly booted VM. The test parses the output of
>> $(free -k) to determine the amount of free memory it should allocate
>> and write/read from, with a given stride of pages to skip before
>> touching the next page.
>>
>> We grab the third column of numbers from the Mem output that looks like this
>>
>>                 total        used        free      shared  buff/cache   available
>> Mem:        65856604     4128688    48558952       11208    13168964    60942928
>> Swap:        1953788      118124     1835664
>>
>> So my workstation has 48558952 free bytes. We take that, give it to
>> memtouch to allocate that much anonymous memory rounded down to the
>> nearest MB with mmap and randomly read/write the buffer.
>>
>> For an 8GB machine, the UEFI will have the initial 0-0xA000 memory and
>> 0x10_0000 to 0xC00_0000 (beginning of mmio hole) prevalidated. The
>> next 5GB is classified as the UEFI v2.9 memory type
>> EFI_RESOURCE_MEMORY_UNACCEPTED, 0x1_4000_000 to 0x2_0000_0000.
>> The Linux e820 map should see that range as unaccepted rather than
>> EFI_CONVENTIONAL_MEMORY (i.e., EDK2's EFI_RESOURCE_SYSTEM_MEMORY), but
>> I think it needs to be accounted as free conventional memory.
>>
>> So when I see 2044MB free vs 7089MB free in my VMs, the two are
>> roughly 5GB different.
> 
> Please see/read/use
...

Apologies, some problem in my email client (appending long characters to 
links), will find and correct.

Thank you for pointing.

Best regards,
Pankaj


