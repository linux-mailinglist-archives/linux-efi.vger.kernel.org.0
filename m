Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FF54F8246
	for <lists+linux-efi@lfdr.de>; Thu,  7 Apr 2022 16:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344359AbiDGO7f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Apr 2022 10:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbiDGO7d (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Apr 2022 10:59:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (unknown [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A27D1EF5F9;
        Thu,  7 Apr 2022 07:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDWRjJaRTBFnel5loemcx6IHnFblgVIe7385CfjMgrGzEWH04nePIw5H2i1/pdQKMPyUmks8Tj0LzmmMTTJ/VGchUx54lsYacc7SmZGhdSpNdXogL0sHsJhq+Uh/mmXkjA75oiWgKJmC7yqziNssJKB6qGoCeYn9TUw8khD/aFMPblVmS0YyqKAgS/yMnK5rwGlj2H+9mbNvdb2GSAjO9p8xVvQFQtzGuSmE9qxH8QKPv87aW2+AStMLqaQUATce+V0R6bOTyqMUj/UAyESdG/mh0T/I4og55PAf0ABN4rsrpaRe9VO9pt1UV+KgzdIkwirCucj1dxPum7vPnakE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2P+OLgVp3XnlsPW6YnpOujLSjKXqCG3omraTih1D38=;
 b=ZVbTVV7GWsWngbPcxIfCOHl2bBkvIjESCPO0HQ9CO+4IOZGQJcEW6E1joIZ4LV2//tSUoS4pbmMnW90JeH8CZ7fTIeK1/hMwDot+nLvpGtx0bytkXV8KVi36XCKTI1PPHa5YU91AszO3i/+syA+yXpblaqYFcZogjHyZPY6NiQfdPAYJ7FfcpNhSMfZaWkbvUI7in3SaYmsbLD/MZZ3Rg14TTgzmree9Unv7l/GbyHzUPYHT6IhYrZQ0SVw8GXrXBpENc1N/YarR2m062HOBFrE8zGT9r1x2p0QCCleT7UqrkCSPQbP2nQNdF9+0mGfmdvk/ERXXUIP/1Ye6XxorjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2P+OLgVp3XnlsPW6YnpOujLSjKXqCG3omraTih1D38=;
 b=zEY4JmE4ToAE/zEmYN/Km74uwe/27zsezEVFueR2GJDce7yDHDCV1UNwFmXBc5u0aw1wnrF1gN9ys1Kf5GPK8FiaBZllSc+uYGdNtaDVzLedDHkG+Avvy94QgLTsEAudpiLiZj4u+lwJ42Vc4skuxFpXl6Dr9K3lcZS0Vm1d7Yc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 14:57:29 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::d957:4025:eebd:5107]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::d957:4025:eebd:5107%3]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 14:57:27 +0000
Message-ID: <91ed3c18-6cff-c6d4-a628-81f1f71b21dc@amd.com>
Date:   Thu, 7 Apr 2022 09:57:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     brijesh.singh@amd.com, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v12 29/46] x86/boot: Add Confidential Computing type to
 setup_data
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-30-brijesh.singh@amd.com> <87v8vlzz8x.ffs@tglx>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <87v8vlzz8x.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0418.namprd03.prod.outlook.com
 (2603:10b6:610:11b::19) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9462e515-0a71-44fa-f611-08da18a6ee8a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5230:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB523091F1D1EE1BC50D9418A7E5E69@DM4PR12MB5230.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKsl20Rah8j7emqSzGVQEmZ9yCT/gJeC/sNfwm3cgKXmSennqIaBLgUp7JGh9coKdBh0h8fg/8Lptk+iY0NXlfz9kFOpUxI3zvmB8/Rt0PJDD00Ox1H6GYbRqY2PuxJvQk+eOfivoSihqQ5oSAXFKs0eD0bc0g+rgQaqQ4wVWgOas4Vp7E9i4e1TPyhRfmWh2MymQ2ZzRh7bt70WLXuLBQSujlYiYDzXAQeXRGIr4SzXIOInMmVjaonpcHYhgUsP2z6G4bybYaMrveAxMe4XWvSoOVEn1R5zPnyqLbiq1hFFv2sIgQeJWYD1r8dptj2X4jkJgrbz147t/DkI3ZULmzGuPa0Ew6c/ugFSpTw/5O1mdXeOE6/o4aSNEVgbgBZcwRNEx0uGL+mmlEewSnFQdF2dKcA9Fn1ldNdu3vpEa21NBsOrnw7nvP0yoMhdK+oRQ34obUFVococxSloalBHmj8Xsl3qb5SrQzvsSnvI1D05j/z/UFwQqImMulwTwEX0/VL8RJKl9/lD8VwZ30u9y6oER4f1T+bXbVZizuYYSGChCM0v+koA5WxliqhMFldrLk/aNkD51MOn8G8TJc/TvuQ7Hfb1NKGVs0s2JXulgm4epBX++23H5DsckO7sTPuzX6ticUmTvapcMtn/5lAa5d+aN8s5RbXHvQUbhdhbwEanb7ypLIf0wrpCf2lcgEsYNbmjITA54CKUPSB+DkAY89aglbj1FtdKfNFUqIsfXQHI39WCLA6uvcRrs4qN1yCEfdaEbN2yfZfT4aSx8eeTndFkb7J7zf+qeVmem2bDlQpzHi4bxOAcJQGmoLsqiK8H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(186003)(508600001)(966005)(4744005)(54906003)(8936002)(6666004)(44832011)(26005)(7406005)(7416002)(2616005)(31686004)(6486002)(2906002)(66946007)(66556008)(66476007)(5660300002)(4326008)(8676002)(38100700002)(6506007)(316002)(6512007)(86362001)(31696002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWpGdE5HMUo5T3pUSDc2R1BINDdFUVJ0a2xyTWFCSFVld05xNlEyTmJVTVNC?=
 =?utf-8?B?SzVuc0hWM0t1Q2lqL0paN0RNTE5kT2FMNm00NjZPKzgvYWUzSFEzNUZVMHFF?=
 =?utf-8?B?bHEyd200RmVRam4yZU9HSjIxTWt3bWJMTXdHcmJGVXhGYm5hdHdnOTVSZ2Ju?=
 =?utf-8?B?RW50eTdPQzJCd1RXTTlJMytra0dmUml5Y2pPZ3B6TzMzYWJCaTJUUVNST0pn?=
 =?utf-8?B?aGhLN2l3VGJnQXYwQm5FbUZuclk0Wm9aVmRHNHVLSU4vS3Foa0pyZE5oUkxP?=
 =?utf-8?B?bnNCczNsbHlKZGQvWDcvRUJpT1FWT0QwSzluNGp0R2RJUS92eTMrcVhhMzYy?=
 =?utf-8?B?VlNlZk5Lbk9TbzB1OW8wdFJOUnY2WHZGRzY4MHZQckl4SnZObjVTWkxHVkRl?=
 =?utf-8?B?ZE9MNkxrVTNYOVdIVlFWbUsrRUtSVjdqOEFiZDAxSGJ6ejNNK1lhS3hTSGlx?=
 =?utf-8?B?WGtJRGc2ZlBrU2VmUHM1ZGh4NG96UE1ndjBaTHo5ZHlkVU1VVVdBVkhCd21t?=
 =?utf-8?B?WDZMWkt5VnFLN3V0aGpDSmdwaGxVU2hiR0ZqWUluWDRGSHNWaVpmNnJ2dXMr?=
 =?utf-8?B?UEtCOFhuZ3VTU1lKNGRPbmgxb2JwWWxZWGtBRVAvbnM1YjFyUTRUbkNlaFEv?=
 =?utf-8?B?cEgvNGMyd09xVnVzejBKVS9BRU16RHp4M2JpN0p4TEt6RzAveUdiRlB3bEhk?=
 =?utf-8?B?MkFIUXFXcXlUK2ExWm8wbUsxdi9PUE4raHhxTUFzbStCU011VU1BOGpDTFlv?=
 =?utf-8?B?R2xzVXNjS3RiK1hnYXFhdS9VQzc5cXF6UDl5b0kxTXdON2JubEdRSW4vY2VS?=
 =?utf-8?B?Wjk0c1FScFozT1lFall6NkJiVGVXWVJ3Qi96R1pDNE1tVTlKamRCb3NjdVMv?=
 =?utf-8?B?aVQvSlJackdhdmxKWjlqQ1FZQTZsMURRL2Q0UDRUVnl5Mk1mWjgwWGVBNzNr?=
 =?utf-8?B?S0JteTQyY3FCOTg2YnpTV3gzTVdUcjZRQ2NnQmVXZXRScE03eFNSRXhRV2ww?=
 =?utf-8?B?VjZ4STZuSEsyRVB5RVROT1hya2RTSkVlQVBsWHh2bEg0TjRSUkxpdGlTZDJ4?=
 =?utf-8?B?Zk5aU3c4TEkxalpWd0xrbXVZblFhUnY3Ry9QQldlVWliS0JPdXd3Q21lV1ow?=
 =?utf-8?B?YUFQc2RaY3gvNkZNOWVQYmhxai9MdVZwV0NjOGZuL3RNQXNIckVBalBHK1FS?=
 =?utf-8?B?VDRaUWZhS2dnNDhERGlTQVBzNDNhOU5GbE5teUMzeThRV2Z6K0FqNTFQM05E?=
 =?utf-8?B?WFFIMmYydW5KdkN0azUvdGJtMi9RaTlxUFNLcU56YnhLZVBMK3NGSXVoUmxK?=
 =?utf-8?B?Y0dxbG1VR3V3Z1kxZXVKMVpIRERta3BZOVVHWTQwcS9VWU1hYmMzVUwxQ2Rz?=
 =?utf-8?B?eldhMnQzNGh5MTIreXlBM3RLU1NJVTNSVUF6bGZ4SzlhaStPelBQa2NaVTF0?=
 =?utf-8?B?TjVsVkFWOEFHQXVFVGRPMDVqWGtuVUxFNW91amRrMFV2QjhQQ1pMaXBsOGdm?=
 =?utf-8?B?Z1RlbXUvTlV0WXI2V1RxSnZoSmhUZHJXN014UkNpbi84aElhamlMZHcxWE1B?=
 =?utf-8?B?NENnOGQvUkhwVVk5ZXdQU21DaENEcGtBVE5iVHBlS0pjZmNKUGl2T05vNXVB?=
 =?utf-8?B?UGRnWDlTMU1SR1FrcWQwRnlzNmVzcVdJWXoxckFRdDRvL0dFWkhwYzdmdDFW?=
 =?utf-8?B?ZDFYdWRVSWYveUFTNzkybUlnWGg1YzYwS1pRVFc0c1lZVmNBRFZxY2lVRXAy?=
 =?utf-8?B?bW5hU1dOTm9OSlNIV3YyVVh6NFpoQ29DczJBbW9LLzliMElFbktBQUNzNlgw?=
 =?utf-8?B?MzZBWllPMW03R01iRFYrMkg5eVdiVVVKdllYZExDZ2ZmV0NmNWFnYkNaVmEr?=
 =?utf-8?B?TTJsOVVTbjFvMGZQREdVWjdnbVFGTkxZZVFpWDVNK1daSGtmNnAxRkJYN2pM?=
 =?utf-8?B?VzB6dW5Rem9KOGt3Z0VpTXJSUFlQY2JsMEd0bWgyQVVaMGZsQ3FuR0I4Mmpx?=
 =?utf-8?B?UVZQVlJzemplSWJobkRGVVhaL3NraUlrbkNFVTRzUGFsdUZ1RTNRcVFGN3RZ?=
 =?utf-8?B?bWwwQmdreTB1YzVVbk50NHU0VU5VZHV2dnpKMmZUUFhyVDE0K2F6T1dEVVd6?=
 =?utf-8?B?QUM3NGFjeVZtSzFQR2l5RERsdlFycm51cGtlR3NGWmV5SnBmSGVvVXVuTkpX?=
 =?utf-8?B?NGFPUTUxVnlVemdrNi9pV0Z6VjlidTFYY2RFcGFaWWtSSmNnQU5JQTg0VDRh?=
 =?utf-8?B?WHdydzlpTmgyREtpQ2J5WStHUlBwNkc2dDd6bHpGZ25Ja2dDVmR6WXRwVEla?=
 =?utf-8?B?QmV6SitrMlNicTBCcGdMdlBMcEFVelhMTkNDZ05BM0lZMUxhOGhidz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9462e515-0a71-44fa-f611-08da18a6ee8a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 14:57:27.4412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9wgeYsQsh5n04T2pRtOqrPYxLsJIWfzAamT8NVDRl++28INLDZqsBZSS+0VkSBb7O5+9bPukQ/YdKAXCgaT6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5230
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 4/6/22 16:19, Thomas Gleixner wrote:
> On Mon, Mar 07 2022 at 15:33, Brijesh Singh wrote:
>>   
>> +/*
>> + * AMD SEV Confidential computing blob structure. The structure is
>> + * defined in OVMF UEFI firmware header:
>> + * https://github.com/tianocore/edk2/blob/master/OvmfPkg/Include/Guid/ConfidentialComputingSevSnpBlob.h
>> + */
>> +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
>> +struct cc_blob_sev_info {
>> +	u32 magic;
>> +	u16 version;
>> +	u16 reserved;
>> +	u64 secrets_phys;
>> +	u32 secrets_len;
>> +	u32 rsvd1;
>> +	u64 cpuid_phys;
>> +	u32 cpuid_len;
>> +	u32 rsvd2;
>> +};
> 
> Shouldn't this be packed?
> 

Yep, to avoid any additional compiler alignment we should pack it.

thanks
