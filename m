Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387934509F3
	for <lists+linux-efi@lfdr.de>; Mon, 15 Nov 2021 17:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhKOQt3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 11:49:29 -0500
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:13525
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231330AbhKOQsw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Nov 2021 11:48:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJneCCHOG5X42JgQnWX9XClsjqSDINZWkXh0jPU4rJNqscoNb5ZRgo8CB+AApyfqA6zZVtuXdxz/E1/kSma2zXOVREQ78h+ILcxscWvlg3QeKDiiwY2zLTWrHRoIXIAB+8oxcSG8Upu0fgsfxDn0xIn9kk2nbGTU2j6QovFPk/BZbflcX0q3+P7l5Au2y4FbVZfzC8gxzakMmFy/RZ06SPl8c2vJ2bnYp0fbSxj6PjfwxvkcA4d2DfIbhxcIYNq+tWUYW4phLnpmc5IryzZIiF03P/gb2b0HDCXKE4fnhk7CTQTdpZJ8T/Ztk2hVvTvos5uM87dkV5QyWvfS0q5cTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDnLllwP8R9GLSffCin0SnZJ/NpEo5qmP7BY6RxcIA4=;
 b=OUEOM3RWt9N8DLNiXlzBB6ulh6hiJdz51iubt99x8/S67m2yBh57qnsMF0YqGIE6TstOEHg3JlfJ8WzTWZ4K7c/0hTy+o4YTXnBD38+9XSzCiiZBrz4wlkXsHbOQ1fZeIEfSPGAiVzISI105QV0HOP5dbMTlzIjyptw5rgyuXlrhOwbzMB8kkOGtkZK641fesG2Z2L14gqg5tXWTQ6ppofr4CQrLBA8zcciFqVmb5MfwECeFb+cFBIaI8X4DmedMS2VOuWIxHh9AVF/LwnY84soJykJ4PiKGZbkIRnHmQ53PlHKY9UBH48lr0yB6HaMAD+FGS3eKY9SqTzfhKHqNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDnLllwP8R9GLSffCin0SnZJ/NpEo5qmP7BY6RxcIA4=;
 b=cqZYZhCvhD3ZmZUDPKC1RxSmPOqClvXrWZCfnmj8DWWdyPaM5poRdYSMx4O5F+L9pMVz4RDCdSFIvrmdVq9ZT5Ut0qgbXlnH17CNMQlNQnr0O/m7Q+H4IC75uIBpFuHKen0+lagsvSQA8Op3S1JcSiwIdBdU9XXbsLZX3DennBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 16:45:54 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 16:45:54 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 00/45] Add AMD Secure Nested Paging (SEV-SNP) Guest
 Support
To:     Venu Busireddy <venu.busireddy@oracle.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <YZKDGKOgHKNWq8s2@dt> <a631d02a-c99e-a0d6-444a-3574609c7a25@amd.com>
 <YZKMvjEIGarn8RrR@dt>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <88aa149c-5fbe-b5c4-5979-6b01d4e79bee@amd.com>
Date:   Mon, 15 Nov 2021 10:45:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YZKMvjEIGarn8RrR@dt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::19) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by BL1PR13CA0134.namprd13.prod.outlook.com (2603:10b6:208:2bb::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend Transport; Mon, 15 Nov 2021 16:45:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14001cfc-76b8-4698-ec57-08d9a85763fa
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2446109720316B16796389A0E5989@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:245;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIRKbsnAwdr0wjFw6EfSlSbwVeKVHk6wCE9y0u4pGiLrDdC6aqLX6MRMPjWOigfXxLFhMPBc/YYMqAohFeZdJq04QfxvbvCNiCTF+izQGxD0KsI2RpKVK1//Cbr5Iv8CCp997B67aj34T5JsTWrak54KKCn0vmPqUzXRpdNBFiboefWdCkgELD0tzvjXOslPvSC8xqYK+D4HogmNjGKSt3pRyAQhwNrJ93KdXx1ipdbmEsmfAWzVaztO5paUmCuNqEagWrNPiu/m6zCU8F4VXUMpngQlM+MJrb6U2crSjEiGbFRQHeKe+TQrtO2UMW3QQoRVJhl5c/APmGoMEzGu5eRDIQZWXNoJbnWawjL1RJyX8AyjdyrD2Z1KRdEZMFMn6e5eu+FzXciyDwI9kJv1BaIX/ZxOZoDkg9KkZPlN7bg8SICs4g6Ju7jc+CA6j95GBcKeiaECQGui/E9BHp4gdvBC6hG6saB16blnPYLCz8gT0LYfKq7VMZjBcsemgeJeeRHwfUEJx+7ckF7kd7+IvivGhv1S9J6ANnnKHj6PWnsDcHY/GM3XUricuXUDd22DeJIKYcNOfET37hVih7aPQPJaZtfM2y4Y+L9JuJW/enRo+bBQWaXkbGUMJmJG0tJkM3jDA4IAIuV6E3vDnDCo30kY+0bKTF+L0/cDONhJ+xdoEuyBo9JxzbvlVUy86NCLfKgF12pR4kSuBpN63jYX5FfgY3ZdxLDANutkbuRdVELVxzS3FtAdCHJzZ01hnLlrwjcptrTFt32wkoBYIELuXzxcgRWWCLExPw/BMQ4IBYxXZK1ndqJV8mlxnMy385fo5IgyGy7lM6mdYKd8AWDUTbvlQHSIVu1SxR74IC847/JVkSfpscgfrILP/GSjmQBY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(38100700002)(6916009)(83380400001)(66946007)(66556008)(26005)(31696002)(86362001)(8676002)(186003)(31686004)(966005)(4001150100001)(4326008)(5660300002)(2616005)(66476007)(956004)(53546011)(7406005)(7416002)(2906002)(44832011)(45080400002)(16576012)(36756003)(316002)(54906003)(6486002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVErUkxCRXV0RURGMHRxYW9mbGJFVnNIZ3J5YU5RTXc0dHltckU1K1I1YTN5?=
 =?utf-8?B?UVVKclZJT01nUGdMVE5ITVl2QXV5a0ZPelVsZFBlMC9DWitXZ0JHYXpUSGdJ?=
 =?utf-8?B?d3ptcXlmWWRvMzdCL0w0NDUvYlVjZEl0MlBNa3BTK3ZFVVI1dXZuMVA3bmlU?=
 =?utf-8?B?OHlQTENUdmxzRVlDRmZjY1BzdCs5dmdEbXNTWFRudW5WUHNHZUV3QjNnN2xu?=
 =?utf-8?B?NFAxcit5TE9MSURnT25iYmMwWGI1QmpMWFpORTBtQUZodXdnN2pBQUFYVmhv?=
 =?utf-8?B?ci84T0VjTmVCM1VPTElRU0VtU1BRc3FIM3dITmJ3SU42MEV6M2NDanZPTGNv?=
 =?utf-8?B?ZWtXWXNPczM1THI2ZW1KRHdxcXBHL2Z2eE9OTllKZ3dqei9WRGxYREtPNnYw?=
 =?utf-8?B?dTdiRDNzclUreEpwbEpBNDhONk55dzNMUjBOdjFxdU5WdjNHZTF3Q1c2clFR?=
 =?utf-8?B?azJpelVMcG1RYXRGWW9GQzBabUlEL2lCM2R1WEZEQ2dXbUN4NzRtOGkvVmVh?=
 =?utf-8?B?cmt5eEttTXlLS2IyNEpKS25Tclp5Tml5SFNiUGdFSXJvZkMveWlLTEJzOHdR?=
 =?utf-8?B?WmUzZ1FXMTUwUFp6VzFvUDdXMDhHYlBMdERFQVh2M2locGR4eEp1RTZ3N1Qz?=
 =?utf-8?B?R1JxVUJNU29GYUpRZGdBRnBiMUlDWFo2OVVXbHlrL2JZNjFLZ0gxQnZWMjFM?=
 =?utf-8?B?OVo2TU1EelZiTmdES1YwemM5VnAwbTJCaVE3RTAyM3c5Z3YwWThFT1NUdDZP?=
 =?utf-8?B?Y0RBdzBpeHFpY3FqbUczbVA3Ump3aldOLzZSMksyMVJ0eGhRclNib0w5ZDFI?=
 =?utf-8?B?TnpkUVREU0NQYWRXMDBXNmNwZWlQYzJ5by9vKzl0UDdMenY1ZDFjTDVLUHlw?=
 =?utf-8?B?ZGEzL25XK1JieVY1S2ZFNVVQRkUvWGZJcWphM2RKT292OXVTVkNtczFKRFNH?=
 =?utf-8?B?ZVl1d2lscjJCUWh6V3hHdjV5TStwMjIyU21ieFRxV2U1MXB6SE9zVkhGUVNq?=
 =?utf-8?B?V3NwM1pkUWEwNjFDMnBkL2Z1V09YWFl2eVc5WHd5blhXMzZmNG52YVRuK0tP?=
 =?utf-8?B?SG1yV2o4b0dVeWs5UDd2ZmNINXM4UnlvT0ZCNTVadllUc3Z0RTBoY3pXWHBx?=
 =?utf-8?B?aG5KYzFUaml3R1NQZzZkQXlLRndyLzl4R3pndlNEWm9ib0lIMnNlb1crYlgw?=
 =?utf-8?B?b0NGQnU1Q0R0ZE8xZ0tNb2VwalVFRWZFT3VKZy9UeXZlZVJUY1lWYUp2ck5U?=
 =?utf-8?B?WWdFM2wrUzJydmlVeWVFcmNGQUNJNlBJbFdTQ2haaENTNXB4enkyanpiM0N0?=
 =?utf-8?B?MjZGYTJka1Z4NkZKQ1h2aXIwMDR5L2RiWm80Z2ltVitwQWZDRkVaMThwc2xx?=
 =?utf-8?B?dFVMNVk0bDJkb0NqSE5yVjg4UnVTWHlhRlA4dXlBNmtYU0hoMjgzbEFzY0NL?=
 =?utf-8?B?U04rZGZYS1ZEbVBtNWZLKzFFNnU2SXdZQ0hEeEVhK0lReDNINXJQN0IrR3Bn?=
 =?utf-8?B?dWRybjlHdXUvYTZKL1FnSlQ3QzkvSzFwQ01STjAzb0thTWxUMGx0RjBJekRm?=
 =?utf-8?B?T2NLRllQTGFVTEJVTjhlOVlUZFdhVTVpWlJTc0RnWmc2OC9xS0JmSFBhSmVP?=
 =?utf-8?B?SVlhY2hWS1U1TWUzTzFCM2RPTXdQRFlQTlpES3NWa2dCSWsxbCtpVkxvcno5?=
 =?utf-8?B?eU1YZFdsajFoRTBxVWZtR2E1R3hrL3daSXBzb2c3bE9mbDVOa2RPMFlsMk8r?=
 =?utf-8?B?UHVjYkVNRUxFY1czNTRKWTRaazkxeFdzUDk2SE0rdlNsOTM0cEROTkVZQ2ly?=
 =?utf-8?B?NzdVUnU1cFFHalFTUTB2SEtuUE1oN3ZvWWZHZ0ZuNjVzSDF6YjJLVVlKYlhK?=
 =?utf-8?B?SnBLUkxhQWpTV2w5K0tUclk5TlpxZE00RHBLcGFsb1M3ZEp1OTFBU2t1MEl5?=
 =?utf-8?B?SjdwTC8zZFNPS2RPMUVobS9lSEJKM0JJK0JFWEZlOFZ2eGdRemdqQW9WZ2Fu?=
 =?utf-8?B?RzltMHdXU1djdjJMdXVyc2M1dXRkWGpldTgzak5ZSVlobG1TY1RnZWc5bVA1?=
 =?utf-8?B?TDlEc2hwTlNhUnNDMDdsbzhOWFFZTkcvb3RmaURWK1Q1Sy9xMTRmdU1xUjJi?=
 =?utf-8?B?RTdhb0ljR1MwREtXeU5BZTlOTG5lWUR4SkRYcHIvaGlDZTdMY1lodVJ1MzVk?=
 =?utf-8?Q?1PckDvI+GH7mD6IaW7leWk8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14001cfc-76b8-4698-ec57-08d9a85763fa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 16:45:54.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQ1izpKQ6dMSppgNsVK+DbSop6fSHOWeu2CmhLHi0oDJLbO0EgJ7Y3sHQ8My/cXkYzFIfGq2H4lPSXiTs3AEjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/15/21 10:37 AM, Venu Busireddy wrote:
> On 2021-11-15 10:02:24 -0600, Brijesh Singh wrote:
>>
>>
>> On 11/15/21 9:56 AM, Venu Busireddy wrote:
>> ...
>>
>>>> The series is based on tip/master
>>>>     ea79c24a30aa (origin/master, origin/HEAD, master) Merge branch 'timers/urgent'
>>>
>>> I am looking at
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C566cca1a4ceb44dac52f08d9a85639fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725911063489322%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=CT%2BZ6Nm6pnvVGY%2B%2FmzK4gG1zxlMNQ1fn7ie6K%2FYueTQ%3D&amp;reserved=0,
>>> and I cannot find the commit ea79c24a30aa there. Am I looking at the
>>> wrong tree?
>>>
>>
>> Yes.
>>
>> You should use the tip [1] tree .
>>
>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git%2F&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C566cca1a4ceb44dac52f08d9a85639fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725911063499319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=XnWIcW62nTrAcDLCkHFpOPv5%2BClg11wfyh0pJ9Dug2c%3D&amp;reserved=0
> 
> Same problem with tip.git too.
> 
> bash-4.2$ git remote -v
> origin  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C566cca1a4ceb44dac52f08d9a85639fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725911063499319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=W%2BA8qZwPicXo7OSslFPqL8s8QRxzW9n68TX1B7MXFYQ%3D&amp;reserved=0 (fetch)
> origin  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C566cca1a4ceb44dac52f08d9a85639fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725911063499319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=W%2BA8qZwPicXo7OSslFPqL8s8QRxzW9n68TX1B7MXFYQ%3D&amp;reserved=0 (push)
> bash-4.2$ git branch
> * master
> bash-4.2$ git log --oneline | grep ea79c24a30aa
> bash-4.2$
> 
> Still missing something?
> 

I can see the base commit on my local clone and also on web interface

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ea79c24a30aa27ccc4aac26be33f8b73f3f1f59c

thanks
