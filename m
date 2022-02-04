Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EAB4A9DD8
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 18:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353288AbiBDRkp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 12:40:45 -0500
Received: from mail-mw2nam08on2044.outbound.protection.outlook.com ([40.107.101.44]:64736
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238161AbiBDRkp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Feb 2022 12:40:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHozTpqzTXot3d+MnHLc28yxlCmtwC9sr72Z6ictg7tflf0in7IQktb5kXXkVpZzJDx63c9H6P8JqcVfPPThV7bTgb6ov23ZgYlXNrPS7tIfi+EG2fCbTrqn6UzUj0Vf0Xxo/tdn5T7uZER5yrk471eXdblKZRhYGQJuxGZYH4yodIvBw7qwX6rNXUn9V7xyL5Vlri4C+5aXgV2irT+TUr0xmbpfFnG60+1xUVYlwONEO75v6g9suFTfFFVkFaX5jYxs2D6qx2Bx19lLmTfL+pZlyQ5i+x/+1d5DxMZxOulyrVUFkr8l6y8LJDXrARZdkRLZJo/sBb632xVk7ZA2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cLspwb7XI527cSbiU9Vh1Zj4E2DKBYEy6of/02eeGQ=;
 b=i/LaJU4NcudcyQU10yXQkPUOjCzhWOFuUXYo5poA3SBk4AnpYDVGnoPFCnOnSl+XRSs1z1jJLd90j1tpzr6wTFCKRus03jqrPLhBiQkLkx9Fvyvipc3X46YBdjLZOYUZ8gBiH5MnBEAXxqPMQVNTfGy/vlN1g1bvbz3HvF9uO2RyUu4WW5WO14eWIO+lwJxs8vJYOhxX6czwhDu1cxGUYjWAIQ25tgSroJOaKzVbASf8iCjcThURaLqhOdErVA2l+e1J/7N5KXlpwIASTEHtqj6lMj1vCxuXcCTLEtda4hHDS+9YbfyUzIGNM0A3GmCoU97Wcn2P814ES/CqEvXPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cLspwb7XI527cSbiU9Vh1Zj4E2DKBYEy6of/02eeGQ=;
 b=dKBtxBp3bC+oAPAyF0eZp05hcAnny/SUPPqij5ld/zZm9XgI+4mmRGH9+vzFzb2cdiVs6e9r26sZqQcqqqi450YMJ3VKOThzCOPUfOjLtf6SlaIDFO9zgRYIzvlNqrdZuBrCCQbFPoFnx4ej4v71oCwHf8ZbsUxoAvF2Sn1fQek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 17:40:42 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%4]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 17:40:42 +0000
Message-ID: <12b945a0-b18c-7f2a-52c7-5e22a944d7f5@amd.com>
Date:   Fri, 4 Feb 2022 11:41:18 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 29/43] x86/boot: Add Confidential Computing type to
 setup_data
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-30-brijesh.singh@amd.com> <Yf1Sn4AdPgIzpih9@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <Yf1Sn4AdPgIzpih9@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::18) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf3c28c-fc77-4e23-2e4b-08d9e8057721
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52070DCFEA2222D1F2CFF017E5299@BL1PR12MB5207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4OrFwgRwB/mpoQt7T1EZiMTUa8B4tG0Yhh8Bd6xOezz3Y/bN6O6a43/mzagY8irXxdTGW64e+tCu7can/yQGwdnkL0bKHb6xNybrzXuBArBPGCi0fWObp7U8HRPZDnszOGVU1OecYSAiNJal1VkDlD6vGL40V6D9SG0jEvxV6ga8KFsuII1HMC0+aOR0SpzuEPf9z91Pyv3LjKUMUyXlxlbyPpssNBgtSctvkizylQwWUqeMAtFhHfEkb+NH5I/3owUEohS0CpqTK++rU2FCBSFHOxQEBrTEPH0F7qWCIWw2eMGpdcU8Ns9i96/ctWXCDt2LSbfIxuPyH4ZPk22rGUz3o3CDI3pHoZ5ECuWKJXPC1FpTOP2r/DtlWMMhYUpVGHp3SA43mBfHT/rfzIt2nvnjx37tOhhiycs6h/li8S8h668Y6tz/Erv8y7PYm2lvAfl3cs6hDI8TcTG7RPtKBmt0+QcwIB7NFh6t6mh/3SEt5QbA2hJAyM+LwumQb68d6PU+WcSZbyQymILOT6GgtrhQJXKSaFoZkKyQJ0ARinEPlI3fxOMfw7pCdcg89/Fck6UR0Jz8OgEvZjDAYc1Fb5w6ZuYgR/kLwpRvy/9rDYyPNX2VAQuXwQ+JOa9U2L/u0gG7NhNEZC+al7ICrt19ujiTPg1p4fa3P9acK1kjtPpzzfzqHBu648aZKHG77NDkezzsMPc1w0kde6TM2k+gVje6gE5EjeErSfUZH3Nkk0CHPxH+Shx3lcmsivBuZ+LdIR/OEJwcq221BCfozVSMm5oIKcOzzLX/FJuJVXOaKQiAm+d0CjQkVrYyTdIVfcw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7406005)(7416002)(53546011)(6666004)(66556008)(66476007)(6506007)(6512007)(66946007)(6916009)(54906003)(316002)(508600001)(31686004)(966005)(2616005)(45080400002)(26005)(186003)(36756003)(6486002)(2906002)(38100700002)(31696002)(5660300002)(4326008)(8936002)(44832011)(8676002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azlydCswL3hVWkZsejlRcXpUcnh1ay8zM2tJcFE0L2ppMmVzbDlqaExqRGQ2?=
 =?utf-8?B?YTJlU3I0c0k5QVZ5SFA3N2ZIRjRMdVFidVlFOFZwdk5NSTZLSFVxTGo5Nksv?=
 =?utf-8?B?c0M5TVpmSjB6ZHhwT2tyWlUzNHoxajlXZHkzTjQ0QlRLdC9iSjg0THU1ajJ1?=
 =?utf-8?B?bmVYRVJ3TGs4TE8wZHh3L0RoMDMyamdmblRvREhWNDhiSG94TGYwR2tyQ0Jp?=
 =?utf-8?B?RlNwUndwMU1Hdjkrck42Umk2NWFhekRoTndFSE8yUkovSURNNG1aWFU4eFpa?=
 =?utf-8?B?YytQek5ubE5JR1J3eGwxUnBueDh5TnNVcWlEenZzNi8zc3hYTG55WVg3NWM4?=
 =?utf-8?B?eU9Dczh4Rk9nSVhzaWF6LzJ4S2FycjJXVC9qZU9zQkxNd3NoOVNMdUk3cktS?=
 =?utf-8?B?RHFQWGNxWGlBcDloeFIwL3RqSUtyZXIxbVhXLzc1WW13d09wb0Z3UCsvdGw2?=
 =?utf-8?B?dXBNTkx2N0E4MXRPRkRxdExKOGU2eDBIZmNDbW1HN0wwSWVDSGJSajlBMlUr?=
 =?utf-8?B?alNUeENndVRrRG5CUDQ0cXdDRU5udTJQNWJUL0tobE56Zjk5dm9DRHRaMjk3?=
 =?utf-8?B?c2hKU2VheitjdC9QVjhzbzZhSE8yazlXNkpoS1ZFdjUwYTFZcFZrU09wT1FW?=
 =?utf-8?B?Z2FMcGkzVzlwSVlsWWtJcGhNK3drQVRrQTJLK0tuRmh0Smg3ejF0RDc1ZVVx?=
 =?utf-8?B?bTJHcmpQNG5SUmEvMVJ0UFB2QVdJTTJKYlFGdUFmL3VtcFQzeDlreFU3OU94?=
 =?utf-8?B?eGNEeFJ1eGdaY0ZjN3MzQTQwWU1DeW5qSDdXMkxWb050alNtVkZ4STMxalpY?=
 =?utf-8?B?Q09VbHZ1OXlkM2xoMTR6ZFdqbW9XMHJTWk9jOHltK2F6bTVGaFMxSDdLS3Vs?=
 =?utf-8?B?N0pIQUl6QmFiWDA4dDNpUGdZWURZMXZORWFhODJWMU5YbkpHYXp5ekNXZmMz?=
 =?utf-8?B?MmtpaXMxR3piTEwwTnE5S3pWTms5a2hGSXZhdndZYWtXcG83M3podjlSZktV?=
 =?utf-8?B?UXorVDVzclptTjZIUkdrSm1ZUHN5U0dyOUNEdkhucFFUcGx6MDRjSHlwamJQ?=
 =?utf-8?B?czdzWVdUZDVEelZMNXBrZ1V5c2tDLzlZMWFrYlQ5Qkw1ZG53R1YwYTgrZENL?=
 =?utf-8?B?VWtHVk10OS9STlhSL2gzOVFzemJwMFNVUDRDdHRpdnprcVdickVGWGNCcTFs?=
 =?utf-8?B?eWYyb2poYlM2Vks0TWtMbzJ2WWdaZUZWTDRPU0dWR0h0bThZaGlOSVNVVXd1?=
 =?utf-8?B?d3VEcVdUN2x0NTFjTE9uenl5Rk12bndiU2FRQzRjV1VMbnZ2ZFdnQTBpOTAr?=
 =?utf-8?B?QXZBYitQRlB6NGovTE9uS1MxK0FlVWw0RU5NNmRzL2Q4MkloYlpZSHBPNEJr?=
 =?utf-8?B?L2xpbUFCbm55c0ZzcWxIY2x0M0JPSFkvSk54QkFlMElCQVNiSENxVnRGSlNs?=
 =?utf-8?B?OHBTVmdzcEFVK0pJSEV2RWY4WUIwTEVlZHpaOWdHVzJOLzIyeUZCRi9lMTZa?=
 =?utf-8?B?TkhJNU9kL0IyMnhuZGFlaTBZejFWZHNYRUZoUmlrVnNod1dwMU5yRnVNMEVO?=
 =?utf-8?B?RmFXeTh3RDhIU1dzMUplMzBQZ000cWJVRGtHZlcyRHJhN3VVNXAwNXA5M3hk?=
 =?utf-8?B?ek1DRW5LQXZuc1JOTUoxbFBVbkhrOWFhZ09SZHkxUTMwa1ovWEJydXl2cmI4?=
 =?utf-8?B?MHlZUFNjUFJYQ3FnTUVpcXJCY3Fxd0xDM0tZOHRKWlBIUFk1dWpXbzhRRFpW?=
 =?utf-8?B?Q0xibFBma29NVEdZL2JsbDBuSVdBWDg3OG9hSk5YWlExUTg4UllZOXNLVGJE?=
 =?utf-8?B?dkRwdkN2bVJiYlhaL0o4NEwwZUZLeU05SVljeEwxU05LQnJBOVhzZ2NHQjRv?=
 =?utf-8?B?TmFhQnpPUVh5eHFWQllEanJlaXZ4eW95bDNIUkpZT0JzV0hJMXBheWU3K1hZ?=
 =?utf-8?B?YkZJM0F5SzA0bGpReVJDeUtveGVlR3F2b2VlYS9HdkE3b3Nic1JCMkVXK1J5?=
 =?utf-8?B?dFZMRDZwd21zenN6OUJuamdMcFZoblVpa3ZZOFlIQVcyci9UYS9Ub0dpTC9G?=
 =?utf-8?B?SExxTTNlZUc3aXRRd3crUjJoWGljN3hMOC9ZY3JxWXFHdTh5K2VyYmVrVHZa?=
 =?utf-8?B?djVmRWxSZnpNRk00Qzc1eUVaazNwQTFud0h1b1pOMU9yNXFRbU5IWDhXNzgr?=
 =?utf-8?Q?TtsEnJa+h1bClsXRnobaykw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf3c28c-fc77-4e23-2e4b-08d9e8057721
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 17:40:42.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggNw0smJBBj0yA1aTyHOAyUsgbFfZ4niNhh/la6aULDJFocGU94N1ZyUwrXcR+859KU0Xt9PXi7WOg97jjULzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2/4/22 10:21 AM, Borislav Petkov wrote:
> On Fri, Jan 28, 2022 at 11:17:50AM -0600, Brijesh Singh wrote:
>> +/*
>> + * AMD SEV Confidential computing blob structure. The structure is
>> + * defined in OVMF UEFI firmware header:
>> + * https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Ftianocore%2Fedk2%2Fblob%2Fmaster%2FOvmfPkg%2FInclude%2FGuid%2FConfidentialComputingSevSnpBlob.h&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C334b7454d7a541f3497d08d9e7fa796c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637795885258984697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=XNPvA7re7WHpAgzeuOC%2Buu0ql18P6KOIbP5ZriFsxEY%3D&amp;reserved=0
> So looking at that typedef struct CONFIDENTIAL_COMPUTING_SNP_BLOB_LOCATION there:
>
> typedef struct {
>   UINT32    Header;
>   UINT16    Version;
>   UINT16    Reserved1;
>   UINT64    SecretsPhysicalAddress;
>   UINT32    SecretsSize;
>   UINT64    CpuidPhysicalAddress;
>   UINT32    CpuidLSize;
> } CONFIDENTIAL_COMPUTING_SNP_BLOB_LOCATION;
>
>> + */
>> +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
>> +struct cc_blob_sev_info {
>> +	u32 magic;
> That's called "Header" there.

I will rename it to keep it consistent with OVMF header.


>> +	u16 version;
>> +	u16 reserved;
>> +	u64 secrets_phys;
>> +	u32 secrets_len;
>> +	u32 rsvd1;
> You've added that member for padding but the fw blob one doesn't have
> it.
>
> But if we get a blob from the firmware and the structure layout differs,
> how is this supposed to even work?
>
>> +	u64 cpuid_phys;
>> +	u32 cpuid_len;
>> +	u32 rsvd2;
> That one too.
>
> Or are you going to change the blob layout in ovmf too, to match?

Yes, that's the plan. I have tested my OVMF with v9 and everything looks
good at the runtime. Will send OVMF patch to match the blob layout.


