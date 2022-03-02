Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0887D4CA7F7
	for <lists+linux-efi@lfdr.de>; Wed,  2 Mar 2022 15:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbiCBO0j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Mar 2022 09:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242888AbiCBO0i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Mar 2022 09:26:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089A1C6201;
        Wed,  2 Mar 2022 06:25:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpMu1GvRxRUeK1QQ8MaMF0GNfly2aKPBryfihvmi3F+Y9MJjBhCZcXTDwPpCEOve5DMb2Edg95bWkZqk2ZhEz+iG3LYu68FknCmXzwcH1BiGGFthhnHgvGmwEBCllMm5YLIE9FR1OUxfUqxsbqa5HvS74y3Pbp1l2LITjlNYAbbigKznvzYQcK5Y/hvYeK7whqhQpzMVYAuQBk7OTCbjDkvFKr6KWy4iIdpRSZb/zZVXWkCDZjz6xpd908qNGThBMCBZ5R/wyuKHHIKD0oPJsjJdsZxQPYu/xCi5m5M+UcnQklrgEeb3+ARig4jMSOGQl6q6kj/DoiWbAQSiNPehig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X42ZLF7JiLYSyYx5OEXjpgX0SszqwwFyNKwFXJo6uBs=;
 b=BKqYhlQgXVsFJX9IoYd8F4DGeuPmeGvrVI2Ru+SQ9+qMdnZByF3IfduW+sf13qlbW964inQMKxUcNxD/fkLscClBRU4g77Usvz5N8GnHHHaig52CNtjnJKP77+pvzz/hqi/HU0T9Ww+m7ZEVCZ725Hlp5VsPi9gUYBjiskQ1cO0S7Nr80OiLBzY6HsW8mE7EmoGzah6F/kX9gRB1ASp8E1OQavC1RdZnF2bKPbtX7gcqwFuLEFfzG/2fQi6YCD/bFhohzw/XHMOWt7UQAvHza7JJ2QtmUvb1Necd3UDtOm2Cpgtp81k0hQbxQW8fOynrKc18HJkXFHsOxtjspMZiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X42ZLF7JiLYSyYx5OEXjpgX0SszqwwFyNKwFXJo6uBs=;
 b=q5tat3E/ot+uQckP+Uq/Kp+W89egbuWQSDZnl9iuMvk9cy5YIgFvHuV/osOJhubftRBBLkQqd4wnqtKazNRa40l0zv5PWCcFdWXhOafV4BBmYejiAc3XscfeE1aMhPCq0+tmS1BH6dCMIuT1eCo7apXeY2ty2dk1dJtgECSRLRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 14:25:51 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 14:25:51 +0000
Message-ID: <671a6137-0d45-3a8c-433a-32448019961f@amd.com>
Date:   Wed, 2 Mar 2022 08:25:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 29/45] x86/boot: Add Confidential Computing type to
 setup_data
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-30-brijesh.singh@amd.com>
 <Yh3r1PSx/fjqoBB3@nazgul.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <Yh3r1PSx/fjqoBB3@nazgul.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:208:2be::26) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba290aa7-c338-4baa-5505-08d9fc588d50
X-MS-TrafficTypeDiagnostic: PH0PR12MB5482:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54823C62E33CD6CB37EBFAF9E5039@PH0PR12MB5482.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAIEnKc2p9Occq+k58GKHgKgwPR+ooHEjvNrUKtUqZ3chXk6lv7yzpHOGhNC3nLZvuvvpTaETQYGHLcVIhhhLqT3l/8Tcg5Zz9ydFjFsgsGEWrkbC+eYD/HBzzLc9qKiSXzUnGqCFMCBhr+R6QpYne9p2kjzHrNzT/RjxrfDGvZJK1LVxbuKmJCDO/sCtUG+keXbY8ZsCnd/BL9mBJC0Fx6rHjh654W6U7rgl9L/S5pO6apZUtkGXrsRrwTlvWSXK+DVhnZ1GcjJcInqJA3q+Y/HqMvwRraEl/USS/WnsiEndDttG6Du4WFNkISLtJ2YPL+JhyFp22otekIMkmoxx7zocD/a2uQHGVFWp3y8BM5jCqZul8Y4ZJI1y9YpSM9M9lJISo+LDqj7ViKruzxdkK3VmFBt4c4D/8rVYhLjGo8BveKL1U4o1QHl1q9YcCvCdEZAjdUg8+oW1685tpBICwOpm+18rInk2s+XyG4q71/RDvfSAXttK+DGGL79d4Fg1gQrMgA9+heneLhfCeEuxAWRF5qc8xrU5g9yi4zzB9mM45wxUi8Kl7zE69L0WtuEwgDvcl5lEWk9YYjwyFCLAXY5mpVHKjahMbY19RWs+VCSh3+Jor7uPr4SkDxlgB4WsTtC5QQXrOiPcbuGT4FjJ+oq2U0cazsrU3bbHUP5XoVt+w+qYw/NkLuWnjnxh1pfi7uWQ4i547NW9hDL6iSd9GbeJMMXep13O8kx14ms0v0+cbFx556sKPyjEc/HKxpk5Bic2byOLu/kquAaiD8m0nQnLaegv4XWcWAa6i5AF+C7hTHrPWaKagiNkZ8HuYOpAvRJYln2a7Dci2k9sxOYiFRIqH52bmNuQDnczLf/Tuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(7406005)(6506007)(38100700002)(6666004)(36756003)(54906003)(6916009)(186003)(44832011)(5660300002)(2906002)(6512007)(26005)(53546011)(8936002)(2616005)(31686004)(45080400002)(316002)(508600001)(6486002)(966005)(4326008)(86362001)(8676002)(66946007)(31696002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1NGeTRLMHRDV29yb1RLTVVzK0JmbjE4UW9kVjNnZjFDVXUxRzBoTXczc0Ji?=
 =?utf-8?B?dDM4OTVsbks1bzhXS2ZGMmEwOVRkbE5LZWpGZGZkUWUrQWNrTlhkaXFNbEpm?=
 =?utf-8?B?YXlST0I4bU8wSkJZbzlLeU9iU2hZa0RoNVlUUzZ3Q2hlRFdmTUREK1hJUlVU?=
 =?utf-8?B?Z1V2eCtzN2hTcnFnQUttVWltQS9IOTFoa3ZiWXoyMXhJd1M5Z21ZSEYvd09I?=
 =?utf-8?B?N0UwdkpaMjdHMkUrWTJhZDkvdVlHaHQvWlBrNlErS3VqRmIxV2tMUERMVDgy?=
 =?utf-8?B?ZTNxZDJtc1hYeDFXWFdYcW9YQ3Nsalh4ZUtPRHN4cm93SnlldWZQY1htNlhM?=
 =?utf-8?B?VG16Ylk4OTlkKzVJcHJBQ3RxMFd2aFFnTnVkeEZlaDRkczd1TW0rbGdPMWdo?=
 =?utf-8?B?UWFaSGkwOHVyMlNCNDlwaCt5SThYd0szcUhkWmM4TUE5RmNCWnh5YWtjUVZD?=
 =?utf-8?B?dlZySnVFdDhQNkRnakF0cXRMUmt5a1VydUZYa05LUFVUQ3RKd2VoWWwvQ0ow?=
 =?utf-8?B?SDFmVnoyQm0rYnZRVENSZ0tidk10bENFZUgyZzY4WDVqRVJoYkg4NVJTOHg2?=
 =?utf-8?B?b0NGaWo4R2RJZ09jZmhmaDRCTnZxVzlHQ1VVTklzRjVJYjBZNVVsTmdsSnJi?=
 =?utf-8?B?QUFwRElFdTNEbEpMUllQS1JKclp3Q0xWRzFxcml1N0lOcmxLYW9pVW8wcVVl?=
 =?utf-8?B?Q0JjNEgyZWJFNHdxUXpjMWl3RWc5WWh1SWZ3WEwyRElqcUMrWEc4OFFRWnZR?=
 =?utf-8?B?L3hjcHZRQklTVStaY0E2QzlLWnMwRitrZEhGVklVdHdPYmVRcGFCczZKbjlv?=
 =?utf-8?B?TEpBeTNsTDA4bHBQUy9Ua3g3cFNoRXlhZWJaNHAvemFJUm83c2RPK1E2NEh5?=
 =?utf-8?B?b3Y4SlRrVVZvMXJlamZqMzQzVXMydXpTUW81SWpwT2RJMjVDR1BwY1VSNVV0?=
 =?utf-8?B?MzlabzRIdTdzTC8xUlQzQ2hVQU1zcFdOOWJFaG1uV1laSnZrRzBHOEM3VFNS?=
 =?utf-8?B?TDVVSU1CcUVGWnFuTU5uMTNpMTZhbEM2M01jSERGTGhiSU0rbDZweDkybFNE?=
 =?utf-8?B?aUVXaDFWQ24vSkhyaUhLL1k5TVY1WkVRNWZoaGlYZ3ZhcmI5OVRkelIvT3I1?=
 =?utf-8?B?Z2dxZXlXZWJPY295N2JtUDBxeDhDcWtFazBMaUNrYUJPSUd0TlVoYlFPOVI2?=
 =?utf-8?B?TmZuSi9QcDRrRjRhZUhnRjFDeVl3MnZTKzNSQ1hEYWFyQ2xGbXhhdDRHWmRq?=
 =?utf-8?B?aW5CNSt6Qy9WemxtRDYwNEhtTjluRG1USVVPWTdyYXQvdkMxdnhmaGRrQnFp?=
 =?utf-8?B?dVJabW1vL3YvdnBmbjhVelJxaXM5d0NTSkdEdTkwRjIyK0JvUmQwWStwcE1n?=
 =?utf-8?B?UFlKQm1MUTEvQTNJam5UTm9PZ1RHQXFuR2JUNCtVY1poa2pEaGp5UHAvUzZY?=
 =?utf-8?B?VjdneEdyN3dSbElURk5mWXh0cEZ6eHNGa2FBeWlOVFFPRk9LR2hEcXYvRFZ6?=
 =?utf-8?B?V25vV2NhRzNSSmdnUGxPQ2tjRi9mZFkxQzFXallpWUtBZHJQZVlnWDFtdGxH?=
 =?utf-8?B?eWFXQk9EQkxIMERBcVM0UFJCS1BpY3Y5bU9PaTBmdmlsNlFzUDJubEhjOVNx?=
 =?utf-8?B?RWdPeHlFWFFzdWNFTTJwKzZvSnRhQkRQWmFJb0xDT2lZKzkrbVExWkJYM3pP?=
 =?utf-8?B?b3FXa05MNE4wRDIvWjk1MThHMnpSMUdJdHpEeTFyS1RQTExFWTMxZFJkeG11?=
 =?utf-8?B?Q080dzNuQjRSSVk4NE9CNk0wMXgrS09keUhCbGg2ak9RcWxYT2IwYkI5VVVY?=
 =?utf-8?B?TW5HVmJKRWhFZzM3MlF1djhJU3dVLzR6Qzc5YnRqeEhRU2NLMkRlbm5xNmc0?=
 =?utf-8?B?R1pwYUM2TVlWVTVic09oeUFZalpLekUybWdSaWNVWktoLzZUYWIvdlBINCtD?=
 =?utf-8?B?K0ZTRlY1V0l0SklKd0IxdmVsMjZxNkdqd3Zha2VENG0zZFNteTlVTXVKdExW?=
 =?utf-8?B?Qk9xWUhRRXIwNXcvKytIT3plV0F2M2g0aENmU1NldnNaYVpMWi9TOXkxTlV0?=
 =?utf-8?B?SFlaUlQ1MjJ4QmF2ZmNPUmxHNFJLVTNxUHpFL25tSVE5UldXdTBqbEMyS1Zr?=
 =?utf-8?B?eGRibmI1WE1vYkxHd29GSXhaam1TeDNFMkhvZUQzeWZsWWlZYkRxbGtxUUJR?=
 =?utf-8?Q?Md9nYpE6BRGimIly4awDLqY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba290aa7-c338-4baa-5505-08d9fc588d50
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 14:25:51.1090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCTs8McSHR8txq9SL/OjR0n0PnzM50UrHpX9NtlvBXDCnwETp6emiqtVSYpwWYXMlI7cVWbIjS6iUgzyDkl0mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 3/1/22 03:48, Borislav Petkov wrote:
> On Thu, Feb 24, 2022 at 10:56:09AM -0600, Brijesh Singh wrote:
>> +/*
>> + * AMD SEV Confidential computing blob structure. The structure is
>> + * defined in OVMF UEFI firmware header:
>> + * https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Ftianocore%2Fedk2%2Fblob%2Fmaster%2FOvmfPkg%2FInclude%2FGuid%2FConfidentialComputingSevSnpBlob.h&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C72edb78e27f546ef783b08d9fb689fe6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637817249053086231%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=9rP%2FF18D4bR3Cku%2FIcXV0qJvC336y54sqYYkq9RAdAE%3D&amp;reserved=0
>> + */
>> +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
>> +struct cc_blob_sev_info {
>> +	u32 magic;
> 	^^^^^^^^^^^^
> 
> You said you wanted to rename this:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F12b945a0-b18c-7f2a-52c7-5e22a944d7f5%40amd.com%2F&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C72edb78e27f546ef783b08d9fb689fe6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637817249053086231%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=biu1Pdk%2BO%2FIVaF5iE47aInOqGF36uAAVx%2BTSBLBxC9w%3D&amp;reserved=0
> 
> and further code is checking magic so I'm guessing you wanna rename the
> OVMF definition to "Magic" too?
> 

Yep, I am waiting for Linux patches to finalize and then sync OVMF with 
it. I will rename the field to magic in OVMF to keep both of them in sync.

-Brijesh
