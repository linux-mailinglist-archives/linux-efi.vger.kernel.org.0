Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEFD485941
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jan 2022 20:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbiAETfD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 14:35:03 -0500
Received: from mail-bn8nam11on2072.outbound.protection.outlook.com ([40.107.236.72]:55712
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243587AbiAETe6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 5 Jan 2022 14:34:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ly4V5WAMtkx+ETS8Z95OQgPFNtiONptPT8r1tuRhQXYz7TJVlh+VakJpFhHlw8Fu2BB4LIpfpVOajya/NDgUO13FiCBaJi0iavJRdda660dRZlrxtqmxdSNfPMJJH4YIoCvs1R8lD/3YJfiZSRtLmq/5vej2Oq4fsVyVJz6t86tNmrwtIMLtJVkdzfVBYgW6Jn+5VaEEWfsN7k5W+szhxs3cSx/GY+XB2FBm3ngDGU/NJXZIFrP5XwnKjqYQSt1h4uPlMxAUxx8ejoT4JSOLf/+u6ZrUoxYPArZD/pWuKDdl+k6sBWJnkNgonytAdXS4PArgaBftze5OS0ZcqV0zhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+NL92ue60FuiqbNYwFSdNxnxsX9/8oaD6m0LhThpO4=;
 b=h1jsudh2tgsgbxLVrqWM9LrYiECBLatgJdssbEu3i8OvEpDRYLRJxw1JlwJQhom9ENirzX1qBEHdPNc5QZZJIi5n9j3SbO/R9xKlnVWeEW+JXNS79CJ8FH/ENi3WXbs6T/WQainpAW/cpT5EYZbWwKz9GPqIZyOC4ROnr4SuPAVNreGXNd5BpxjTc+v4yJjT6Y3xhKERtFsRxJ8f0gixB1VARl0qs+0kGSwFGHhYJsq8d8jVjquG6UgoF83Fbvs99bAZMPL8uosJ6E+mbxG+7DDJ84eltar7Z1FmAOvUOBjEzWRX3+v50Vm0GQ1B7U0ULa0BOydZUOyN63C+YeCLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+NL92ue60FuiqbNYwFSdNxnxsX9/8oaD6m0LhThpO4=;
 b=1olfo7KgtJ2cXQRhmlb5YGTJRfkAAi1YxVcKf1aBpYftkGglNqfDJVfUzLojUaKWcLoGVtDGQJtwv3Uv+OsfPFFuTtDJ1tLaWHEKKzDgnwb0XmF21UtGkGi39wLAmrx/GWFZB2BX6X+F2+IPB2aWGkE8tlo/ADo0pu5EXgkSYss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 19:34:54 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4844.017; Wed, 5 Jan 2022
 19:34:54 +0000
Cc:     brijesh.singh@amd.com, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME features
 earlier in boot
To:     Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>
References: <YbjYZtXlbRdUznUO@dt> <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt> <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
 <20211215174934.tgn3c7c4s3toelbq@amd.com> <YboxSPFGF0Cqo5Fh@dt>
 <Ybo1C6kpcPJBzMGq@zn.tnic> <20211215201734.glq5gsle6crj25sf@amd.com>
 <YbpSX4/WGsXpX6n0@zn.tnic> <20211215212257.r4xisg2tyiwdeleh@amd.com>
 <YdNKIOg+9LAaDDF6@dt>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <5913c603-2505-7865-4f8e-2cbceba8bd12@amd.com>
Date:   Wed, 5 Jan 2022 13:34:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YdNKIOg+9LAaDDF6@dt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:610:b0::35) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 714a1803-1af1-408b-da29-08d9d08271e6
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4382A9DFD1CA55EE47DA6309E54B9@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpbCHUj+ujJg9AdVDaUWdnBGF46YyaPho0dEt7IvprkqutMRGCytnFNt6A87rk87dquBp1cJnGesxx3klAVoyDlX55VWuh9hsdQQfeotflC0kkc5bNnbqL6Nhovz6lgAHIBqVLX9ZbeANh0TSsM9E7wY1dm4j+Ea73v86hjipaSK2K9QELFtCIKKGzRRWQNjOCKnQOHj5Z+Nv1+RKS2Umr/lfNShxMejDSm+wdwXCmwtq+KHDF/UgbAReFnkx7TW3ZuyIcmqppU2EoMD8GFKO22hH/rCCsjsioZG00J/cVs2Ca62/5z7uMi8JLHfA4mLI9l10aCkEzqtNSXRB9xEeayXWdoOeCJe7HpWXpCY3PQ6DDOTxT16YDR+4TJc4RJx0yLFhLqtLFyNh1g7JRhUPQ+sFouaIO+22pCN9MHkZ9NNV/cfSXx54WzkGDGgqz5+ZeoFhvl+W4LvI21KQyFQBEuV11F0hcU8sl5dYQ3Jf181AbNMeXFexULiFqIApmsWltnRQcNVYmz9KHZFrCwtEmJKodcB1O6m/HTRinFOrGLnaJCYnRDVEG13UcBt3TXaNMOZ6c2Y3cQsYyOE6suCFWFiPTZpifxCn/bdkfqJzi1FzmrqFr9YjfzdbQ5VHEGsN166KF/KTvQIDFlfoLRQt5mkZB6cZjX3mjcfSBcTFQXO2dpQBFtpTb8XbnEp1Fq43ArzZxS6VmKPDAW+OF9UZHfIrxJ2hJI8H82X5tZv37BYPYZ7AIICla9qDPKo1Ciw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(26005)(4326008)(6506007)(66946007)(6512007)(2616005)(186003)(6486002)(66476007)(66556008)(7416002)(7406005)(83380400001)(36756003)(31686004)(31696002)(6666004)(54906003)(508600001)(2906002)(5660300002)(110136005)(8676002)(8936002)(38100700002)(86362001)(316002)(4001150100001)(53546011)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVRYQndlbU9Nb3NoUzRJd1F5a3c3R3JWdC9xblpxbEd2RTMrbzhwU0lKT0hq?=
 =?utf-8?B?SkU5Uk1pMEg0TENFZ2J6QlJEcUR1b3BUSmhoUEVrcTFDQ2VUWkIvbmxmRW9P?=
 =?utf-8?B?VFE0NW50WDhrVTFtZysvU0NCQTQ5akR0RTh2V3hYSi8yNytIMm9xUFk2OGtM?=
 =?utf-8?B?dXlaalFCaDkwdUNNb1owRXBQekNTQXJrY29nMUVlVGpIejhRLzdCL3dyeHFK?=
 =?utf-8?B?aG9jY1Z0ZlJMTzN6WXNSdjhjT0l5MzF0MFBjYUx5QnhRTUNPWktQZ1pwWlZO?=
 =?utf-8?B?ZEFpclZ1eXM5NjljUEpYcy9MNzhqUFJRWDAxb2E4elhZbWhmdGo0aW5yRWRO?=
 =?utf-8?B?MnNzM1ZtNHVQZUhzaEhWZkFBR1NKWVZRVnFWRm02dm1ESW53RW1YN3UzYnRO?=
 =?utf-8?B?cVBQQkVGQzkrcWwreDA5b2I0bTNNeE5RZTExRzdZYlN2VVZBNVdqVTEzNkRV?=
 =?utf-8?B?MFZYNDlFcUlhcUptSjZ5UW12aHE2Y2dZd3VmSERUSGl4YlVsTEQvV25heXRv?=
 =?utf-8?B?dDRnVTcvazE5MHpjUHhOb0tMbGNEc2ZiWTBhNUgrbVNqdjI4MjdvQ1lHOThY?=
 =?utf-8?B?NkhQRG9FdS9CbUhRdWt0bkhLd3Qra2VOLytGV2JOQ0pXMnlxRlYzdGU4T1Fy?=
 =?utf-8?B?UXB1NStXSzdHeHVueW10dlphMnhZaEtwbm41YlNBbFMxdXUwaU5HWWV6cHQ3?=
 =?utf-8?B?WnRzZFMzejV0dFhnV3dGZjArZXdIMERVdjViTzVxVXI4ZVlXNzl0RkVqNk5w?=
 =?utf-8?B?TFV5SHppdFVLSG80T01ocnRHTVJ5MkdKRVRDRmR0SE0zVHhCWktaRVBYUUtk?=
 =?utf-8?B?dkdoVmZQVWR3YlNMSGJ1cU11bXZDRG5sbWlyYWlRem5pSEVmTmwzWjZjYmRl?=
 =?utf-8?B?ZFZvNjRDemM4TFkreHhrSmtiMGRodEhGWDU0VUZpNmJlYkdZa3RXcVJReGQ0?=
 =?utf-8?B?N3V4L3NsQ0JjamdscFkyL3E0aE45VXBPMndBZDNxR0RHYVZYRHh2VmVPNjBU?=
 =?utf-8?B?ejhVOXBqVXZLMkg0OXhlRWZhb0pGQ21sK3BDaVJFSWY0bXFxTTdOMUZKbWF1?=
 =?utf-8?B?L0E4SkYxYm1oWWhuZmNKT3lDVDBUNzBRNmpSUTNLYnZsYmwrbGtpdW43c3BJ?=
 =?utf-8?B?eHlpYnRtbmhETFFlUjJzcmNSTWxoUm1pUWR4VWEzbHNyWmZQM3p5SE9oTEVS?=
 =?utf-8?B?R01jcU51UFNONU5CbmxlTEpPSnpjUzZMcHBLRjM1MGYxeVBHL3BSUHFKOHZr?=
 =?utf-8?B?emx3cWlRSnEzMkgyZi9QQWxLc2duRzhhNitHVnRlNnNTL0RlUWJFOC90Q0R4?=
 =?utf-8?B?MUNFSGNXZlRNRy9PdEpTdk1NYmVLeU84ajBCK25ET2JXMWJBbjR2TXdnQjJs?=
 =?utf-8?B?WWNwVmVQL21zenc3bEpid0tFWWoxVlllVHpaNFhqZXBXVWkrK2NWUk03bGt2?=
 =?utf-8?B?M3o3bUZ2QWtXYmdqY0NFckRwaXNJVEF2ZmxXTUt6SWRSTHZWUzRGQjNkenlU?=
 =?utf-8?B?ZHRBVFlKVTY5TE95Q3Q1SDd0Mk5DQmlzK3NmVTNnSW5XWnBTY3oyNzZnRUoy?=
 =?utf-8?B?MTZGeTZzRjVBQkJhK0lPd2J3ZVNFMjlJRC9IREZnZjlDeTN4dG4yL1h6NVls?=
 =?utf-8?B?RXBsSlhzZUk2UEdWZVcxZVJxZVVjUEdvdlhiQXZ2UUQ1aEp3SGs1UlZFY3ZN?=
 =?utf-8?B?dzdPR0VzWHBqdkFlYThWR3pIVlByblFRT3A0R20vMUlLT3JFTCtlZDVsVjkx?=
 =?utf-8?B?Q29LSjFDZm01dVhmNVRiaVI5aGtPVHFLSDIwVjNIYlZCdHpTYnkzMWcyMWcv?=
 =?utf-8?B?c0dxcWxzMGV2VGRQZHRMYklLSjl4SnVrc0NPdkNESlZqWlZlTjFQZ2ViTTVQ?=
 =?utf-8?B?VWFtMjVTQUFLRkNSZ0FuWVQvSlFhdUZjL0dyRGVTajFXYzg1Rk0xV2ZLam95?=
 =?utf-8?B?cEVkMTZyN3I5MFRWbm1Ga2M0OENVNnIrdjNKRWJwdEVMWitTTUszZmxtZmpQ?=
 =?utf-8?B?VFFtdnVZQlhRRVRjMVRZUkVtb09mV3ZOdDNmVWNaWGIvQjE0UUFQNVJ2VDdQ?=
 =?utf-8?B?T0ZhaSt0cTdPWmtVamFlUXZqcHVZNzcrdUZlUW5mWmNUZ2s4RXE3eFZqa2RP?=
 =?utf-8?B?dDNCeWpkM2ZERnQvM0lrWnlpa1JRSHVxdWxDRXFqREFhRUdLWk1UYlhlNzJy?=
 =?utf-8?Q?E1DvPXaGAKMDAM92LcBeK+U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714a1803-1af1-408b-da29-08d9d08271e6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:34:54.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCxFTxZJ1pwNMtI3eI8NTIqaXCPGYmkYJVt/N78t//UWhin0ahN/UaI/iU8R6IaSUntu1s42YM69TKHS7bmJcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 1/3/22 1:10 PM, Venu Busireddy wrote:
> On 2021-12-15 15:22:57 -0600, Michael Roth wrote:
>> On Wed, Dec 15, 2021 at 09:38:55PM +0100, Borislav Petkov wrote:
>>>
>>> But it is hard to discuss anything without patches so we can continue
>>> the topic with concrete patches. But this unification is not
>>> super-pressing so it can go ontop of the SNP pile.
>>
>> Yah, it's all theoretical at this point. Didn't mean to derail things
>> though. I mainly brought it up to suggest that Venu's original approach of
>> returning the encryption bit via a pointer argument might make it easier to
>> expand it for other purposes in the future, and that naming it for that
>> future purpose might encourage future developers to focus their efforts
>> there instead of potentially re-introducing duplicate code.
>>
>> But either way it's simple enough to rework things when we actually
>> cross that bridge. So totally fine with saving all of this as a future
>> follow-up, or picking up either of Venu's patches for now if you'd still
>> prefer.
> 
> So, what is the consensus? Do you want me to submit a patch after the
> SNP changes go upstream? Or, do you want to roll in one of the patches
> that I posted earlier?
> 

Will incorporate your changes in v9. And will see what others say about it.

-Brijesh
