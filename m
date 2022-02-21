Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59C44BEB63
	for <lists+linux-efi@lfdr.de>; Mon, 21 Feb 2022 20:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiBUTyf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Feb 2022 14:54:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiBUTye (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Feb 2022 14:54:34 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC56022524;
        Mon, 21 Feb 2022 11:54:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7FsS8JCPanBZByTJwyCD712o3Z+/pIzJWEgbPWnXf0dRdGR248JW69Mmp3YwpIadmlBXzdJ4YL5TOdic+0kD6lvruy26edkdBTeWdD7KDxuCjl0RQzDByejhnnr0SSYac3fd/YxmvPvWbhzN47vs/VJeUWs2hVstmj9J+SUzp7ZzSWm52PRUoBgBzFszRhYZ47mD9rU6h9LByYYPFG2QO7TJxuY1uPT+DDxK/n5ooQEGRzoy/wDdVWiNk8d558nI+pK5rR1AhYmNhY4h+AzfzuYp6z9ptlD17WAlcLumAp/X8dAum1pv8vxhER1MDUFmTLrZz3GSr2bjT6d5xzeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2EniEHghmrEk4kd34UZxbshY1la/IJWPg6zZySPxbg=;
 b=kxa0ZMPu+m7GDgmMRXtfj7bvS540chtwNSwi0SC0R63bFQ5AFKoTcGYRpW5XiaxO94VSV9Zc+BiWdmZ+f4uO+SZE+EhNscW8g09PetGwj/aBheXZnRkeRJI+mgu5eF8eDHimfCseHlMZUr7dsPoczYhWBh3MAcw7S0Q6zVtWqxp56560CzK04dGPIaOMVjBQCRWkQo5L/4ssLIH9kexY84gv9ezl1i/IMPQmGpvMclSaBRYdPZGGkvfR/o5BXCFKTF8RxtpPygWrYhiPnTAyZWrvNOiH6jOLr64RPxHDRL74rfusSYKoKWP25gy2Ql7WOh/SQCQu/JZYVd9hhAdN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2EniEHghmrEk4kd34UZxbshY1la/IJWPg6zZySPxbg=;
 b=DxEBLp17QTsr4hX2RXRIdNgr9YEvRtBgjjFFJhmMzpEiWJccCIRlcOfZBSQuGQ72JBfI2Noo2wihFPCZGAi/xEvLTPIPKW+9oh8G2zZnRsAybtnhggK9eGkhUBBBmBlstU5S3BaZEstOtL7oqeLknZulUxitpFHUkRMZmlSxvTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by BN6PR12MB1857.namprd12.prod.outlook.com (2603:10b6:404:102::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 19:54:08 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 19:54:08 +0000
Message-ID: <1e27feca-9f48-5a14-be5c-abc12d2651b8@amd.com>
Date:   Mon, 21 Feb 2022 13:54:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     brijesh.singh@amd.com, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v10 21/45] x86/mm: Add support to validate memory when
 changing C-bit
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
References: <Ygz88uacbwuTTNat@zn.tnic.mbx>
 <20220216160457.1748381-1-brijesh.singh@amd.com>
 <20220221174121.ceeplpoaz63q72kv@box>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <20220221174121.ceeplpoaz63q72kv@box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:610:11a::18) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c0a10fc-c34e-4b37-40c6-08d9f573ec2c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1857:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1857B9E3AA69D8059942EA01E53A9@BN6PR12MB1857.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJx6XsUnX3dMR4Cx8l5wjcSvmQXCNrRoSbLbkB8vCMU+U4ZmjBjrn3A+AUW3Yv22ITIgwSsl0cb0Q+S++86YwV+prAkQKxXDrFqmui6dv1O4mBGCNPNU0pVl04rdJ5XHTqojiF++1UA2/uPqo63pk4X77h1CewF2PzxqMJcGgvCXZEHr0ZPqkUnpl0P6aCvZaYXbRrYLVq7/gu7yPPFDoLAcF5KOXcg8FDEqiZv8OTaxao2A/VOReYGygajN4tNllSzLOKOYp67gVz9OYTNIxdqYFzhdmEeoqv50QrHWStq/vdwo7mfuBlFY3IBBmND8R9dyM33g5iBvL8RkPXa2+4UcYZBbSoam8M80akd0EvlYgXNWkTSFJN5s+bcf9nJLKysqiB2UteVyhcWqPDKu1PT3BqYO1hX1xKMqbYelItkyYqNBGLj7jHLkVi4HdoISFqAp00KGbvPTVClciBocomRxEggbnD5e7O22ehUkPeeL7OJFvhSSUFXLIkZS64txNGYBpchOOf83g4zL4Ji40lHqikBfWOAxvBU7wRvLx2nEyi0MyK6wPZtj04CN4ypd3z6xGA0ycWG/HL7mND9m2tK2BMmL5PjgWXVJKS2p9JOPkjajUtbLW0KNMrGW46bTny1SGPtP0yQWiTZj2qWpeIJjwOWI97jh//HUMvqokMGRVz7AKn2WAjbpLP1BtBVgC96SQ6NAkiBDVkx2T4wLIw0I7EXS9xPGSAuX2JSSgZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(66476007)(36756003)(44832011)(186003)(26005)(31686004)(2906002)(5660300002)(7406005)(6916009)(54906003)(86362001)(31696002)(2616005)(6506007)(38100700002)(8936002)(7416002)(8676002)(4326008)(6666004)(53546011)(6486002)(508600001)(316002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm0vM3p4TmlML0pFbzVaNTFHRTQyNnJTT3R2LzVMVm1VSXFpOE1zUmxac0hl?=
 =?utf-8?B?U1BPMGdvRlZvTVgrOENlMmJ4YVlYWnBXRy9yVU5WbU1iWTNvQmJkS1hCdXlq?=
 =?utf-8?B?cldRMDBqSUlLL0dQc3cyT011U1Y4OVZmQzNOL2liKzVJR3JEYUdHUjArMURa?=
 =?utf-8?B?Qm9wNzZlNHMrSnRnTkZQU3JwQko1Z2ZoazkvcDdDOG1BcGFmaTZEV2hCWHpW?=
 =?utf-8?B?TzdVdmxNQWtlMU4vVU14RFBnTFRLQ20xdUg2UEdXaU9QaWgzYTRqQVprTm9Q?=
 =?utf-8?B?MzZSU2xpakpjYzk2bXVxTjRrOE5oaDBrcFc0WVhSUGpQT1h3ajJrZ2ErSXNu?=
 =?utf-8?B?bVpYOWtUWllNWlhKTS8xa1pRVTAvKzZLbFJ6YlNwODgvV1pDcjZBdUk5SnlL?=
 =?utf-8?B?ZlErbC9sN3BBbXIvS2dFbURyVGxWS240aHZqSGJoL3hyTGlPQ1dQMXpVclVO?=
 =?utf-8?B?MVR6Yk1OQVpESWFBM2Z0NHVDUWJWSnVrTXlaM1ZQNjd4SDB0SUw1MG1kakRG?=
 =?utf-8?B?T1htMUZNcm5KdTE4SlIweDNodVhTQ3V4cFNiZ3krWTNncS9uYU5KRCtZYXRM?=
 =?utf-8?B?Z1RQY2Fac1psSnJJaFNkTGtjOE9uZVFnVGM5enhFaHNuejVpTFNvQ2g4TnQ1?=
 =?utf-8?B?b2tuLyswNDVrSmhBbmw5YzBDdTlUdll1N1JvakFXQWJFUGcxaU9PblJ0Tk9w?=
 =?utf-8?B?VjN4NXdTTWZvaCs3OGFZbG1zZFZjM0NMQkVwanh0Sk9MWm1odEhtMVJrWEd0?=
 =?utf-8?B?SVJmeWgyWm51N0pWcGhIZDZuSzA1VExNT1hxdGJRSmptbU1qRVd4dmkrTzRQ?=
 =?utf-8?B?ZkFoQjdOamZJcm1NWFhJLzd0QzltTzlyaUF0bDVMd2E3NHNDWUE5RE1FTGNI?=
 =?utf-8?B?M3lHSFNIUGR2ay9abG9pMzBISUN2ME9lZWpmL25nY1RqdTgvZzRISHZGZSt2?=
 =?utf-8?B?OUN4a3ExRG5kalhUTU9KVkd0NnJVUi9MRUVYKzh3SGN4dnBjaW5WeWR3TE1I?=
 =?utf-8?B?RkJOTWZwVXpJcVhpM0Z6UW83K0hiMEJpTFRWc2M4eFE5UUJPUUlZaDB1NFho?=
 =?utf-8?B?enRua3NucVZ6M1I0N1NoZTJvVUgyNWgvOXVoUzV3VVpHL2FwWHRNUEpsb3BS?=
 =?utf-8?B?QlBWcUZrN2pzTDI4TjdvOGN1cTJjK3gvT25DMWtKSG5BL0xVbjBibjBFaTU1?=
 =?utf-8?B?aUF3WU02cTE0SW1TOGZuVGo5NXBqQzJ1ZHNYNHZGdXRndDJ2eGVrTDI4MWx4?=
 =?utf-8?B?SE9HVlVFTmRHT29OaXBpOGtUSjB0UVFTRlpuTVVFRDNFTkRvMEM1bzhDTFJ5?=
 =?utf-8?B?S2t2djIxMThCdllScFY0MjJKVERFUUJadDdSSGdMUTczMS9uTjRQbkFERmpq?=
 =?utf-8?B?WmhjMGZYTlF3QUQ5aDZ6QXBCUGNtUjBJeGRHdVc2V0dmUVBEVGg2YWQ5Y3FD?=
 =?utf-8?B?YWF3dWppYUc4b0JVVzgwbjc5dkk0OWp2b0RhUlRnQVlzMEhsUjRsd1JWRUVB?=
 =?utf-8?B?M1grc1h0ZzBKNSsweUNRcXl0TGFCaVh5eE1YVGZTUHV3MEo1cFNqMnhnbU4y?=
 =?utf-8?B?VC9uQ3hpeVhnUzhWZW1BRlM2dm4rS1hpeFlXWmZqRHpoc1VnQkxYaDg0WEgy?=
 =?utf-8?B?R1RzbjhSM3ZURnUzc0M4aWNIckpCTzFBZjVuL2psTHNhU1ZCaUZoTzNZdHBj?=
 =?utf-8?B?a2ZnU2xOUlBnQmNUdUhIdzdtbzA1b1ExRms5QWVXb2F2TkRqS2YzTTJXeThw?=
 =?utf-8?B?bXg2U3hSU2swR2hOR3pLZnNpYS9NeGhjaWJldHYrTjk5ZDRzOHlWUWFPa1Qy?=
 =?utf-8?B?RGxLeXhRdWVnUkMzRjVqMFNiSWJ2Q2I2YzlQYmxtM0Jrci9BYUxCZ3FLWjlw?=
 =?utf-8?B?Y3Nvczc4Z0dWczFxUFFaV1VhUlgzTEdESys4emJPVFc3ZzBhUFRuTjJpQUJI?=
 =?utf-8?B?Q3J0bjhERk5ZbmFIUi9peUc4QTNNK29xT3ovMXpIWFRWVjJWODZKbUJSNTFD?=
 =?utf-8?B?RU1FbU1xTlJVNmg5ZG1yODN0d2FZaExPR2c1NHExbTREcERweXdkWERXYXZJ?=
 =?utf-8?B?aHNQNFZrZ2ovRnVsODVNV0Jja0lINlUxbmxaS3NmS014djhkdW9pMmZ2ajNs?=
 =?utf-8?B?a2V5ZXZkMFR4T08rZ2ZIN0lVZXBZSmpkcm5KMWp0TUJxb3VqSFR6NGxSM2Vz?=
 =?utf-8?Q?9B+5MVXQItm/lvABXDEcVSs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0a10fc-c34e-4b37-40c6-08d9f573ec2c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 19:54:08.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlfCHt1fdUYD5ED2v9zYlcMOEASmf4mOvA9SMGT627t0u1vCzShgHQrJ1KaTUh47JhV7+ITOKHMolmiTcaOC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1857
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2/21/22 11:41, Kirill A. Shutemov wrote:
> On Wed, Feb 16, 2022 at 10:04:57AM -0600, Brijesh Singh wrote:
>> @@ -287,6 +301,7 @@ struct x86_platform_ops {
>>   	struct x86_legacy_features legacy;
>>   	void (*set_legacy_features)(void);
>>   	struct x86_hyper_runtime hyper;
>> +	struct x86_guest guest;
>>   };
> 
> I used 'cc' instead of 'guest'. 'guest' looks too generic.

I am fine with either of them.

> 
> Also, I'm not sure why not to use pointer to ops struct instead of stroing
> them directly in x86_platform. Yes, it is consistent with 'hyper', but I
> don't see it as a strong argument.
> 
>>   
>> index b4072115c8ef..a55477a6e578 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -2012,8 +2012,15 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>>   	 */
>>   	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
>>   
>> +	/* Notify HV that we are about to set/clr encryption attribute. */
>> +	x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
>> +
>>   	ret = __change_page_attr_set_clr(&cpa, 1);
> 
> This doesn't cover difference in flushing requirements. Can we get it too?
> 

Yes, we can work to include that too.

>>   
>> +	/* Notify HV that we have succesfully set/clr encryption attribute. */
>> +	if (!ret)
>> +		x86_platform.guest.enc_status_change_finish(addr, numpages, enc);
>> +
> 
> Any particular reason you moved it above cpa_flush()? I don't think it
> makes a difference for TDX, but still.
> 

It does not make any difference for the SNP as well. We can keep it 
where it was.


>>   	/*
>>   	 * After changing the encryption attribute, we need to flush TLBs again
>>   	 * in case any speculative TLB caching occurred (but no need to flush
>> @@ -2023,12 +2030,6 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>>   	 */
>>   	cpa_flush(&cpa, 0);
>>   
>> -	/*
>> -	 * Notify hypervisor that a given memory range is mapped encrypted
>> -	 * or decrypted.
>> -	 */
>> -	notify_range_enc_status_changed(addr, numpages, enc);
>> -
>>   	return ret;
>>   }
>>   
>> -- 
>> 2.25.1
>>
> 
