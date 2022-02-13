Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311B84B3BEA
	for <lists+linux-efi@lfdr.de>; Sun, 13 Feb 2022 15:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiBMOvB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Feb 2022 09:51:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiBMOvA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 13 Feb 2022 09:51:00 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A8F5AEDD;
        Sun, 13 Feb 2022 06:50:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4ynueWrCHxk1NClOtRnv/PxLmTFYoxR6qCam7jtD5/4bFERhqtRxwu3CtYRf9Wkgg6Ozf4u8Kpi1dbNVTgNxeJN+2w+7o/IY3X44Va7LlKNPrP9YUPo6Y16tBBCAS0JuxemoBq1fbPs4kM6++JyOFbqL+L1q87Yevqg3yy+eMyEr6AJvXFcUlUA+ajn6CkNu5YkoyldS0Yir3QhbNcs25UNL7tqCYnFWI5Hlv78+cjx/ia/Xnp5YWD/qtd7ATbNWOn8xrkSoqomZMyDvDzTOqJ7TzOFhMFaMDX14nAVE7iqrbIxfVEQS5y+gSl5iksoQs0E8RfLmtOsfuwH1Ae5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AsYtEPhS82/DjfMMk3+yah4EEa8YfLiFv8W/rvBeUw=;
 b=ne0a321pnNMbTos/8ndr5Walz/fMOlvfmAxzmU1qjiC/vOTe2sGMO7MK8WGRls3at72fCKus3uUcs4cCjN1vUfiGexDo/HzFdeyANP1G8tSS/+v06noObwFUotpFmbPlF97ZBti8ZI8gYY9ucDtIusNSmiOwusHi1+i/ydGUh8/8niojUSF+nbsvwxPLqQQ/f6emPaScYkSl9QdRxfwefnJXC5/jWSKsPwbIiSsMlqpIAO2gcicwBBedymB/c4adHHguP92qMjhJf+GJrSW7pTj3PdlgsHmr8cXjccA9k3L1Uvu4hekev97rf4Y71zgXJKZ77tF28p6au2c8YntqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AsYtEPhS82/DjfMMk3+yah4EEa8YfLiFv8W/rvBeUw=;
 b=fMUja8FF7MJOLOwbZZZCA5CgHrmNcziPm2xDf73Tm9G6UVoCuS7s+PxNrKUKn9yjB4tcLwPz6JbFond03c3ByoikF/wOrMfHnDlOLK2sHyY7JKkrxsGlFkWLCHw73jut/NShcSlH0qlTm+zxR/dBeaJlb3J848HhuPp1ep4wwdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Sun, 13 Feb
 2022 14:50:52 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b%7]) with mapi id 15.20.4951.019; Sun, 13 Feb 2022
 14:50:52 +0000
Message-ID: <7712e67b-f1c4-b818-ce20-b37e2a0e329b@amd.com>
Date:   Sun, 13 Feb 2022 08:50:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
 <20220209181039.1262882-22-brijesh.singh@amd.com> <YgZ427v95xcdOKSC@zn.tnic>
 <0242e383-5406-7504-ff3d-cf2e8dfaf8a3@amd.com> <Ygj2Wx6jtNEEmbh9@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v10 21/45] x86/mm: Add support to validate memory when
 changing C-bit
In-Reply-To: <Ygj2Wx6jtNEEmbh9@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:806:f2::6) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e23af4d2-715f-4fe7-be20-08d9ef003afc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3238:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB323899B149A920FA61C63A13EC329@BYAPR12MB3238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RNhzZ1rkdj4pBhEvh+PLYmQzmZJnv2ssw6F0Tvobyx+VF6Fsa4IIv6JPY8jvrv7RuaRzj9qTC+qH7o7nghhpywS/jNGfHPILx/0qhDK1yPBNKJgoxyo6BgYE5iaORj6xVuZ7XVfQhcqhcc4ni9z6S2P3uewSQX++UII9HTCs+MV8StexBkcqG9299UGfPoU1J2QPGmpFPWlezqMbg6UpdTPxX3INSXFOFQQ9ODsLq7sN3M7eC8XoFH948LyugQbuBisM7Ctyg13Lzcoe5b7qJFhkZrXL3HOVTfWr+r4zSz+U9N4YJI+kCg/H42U2lJJZ22t5vLnZAx+k4F7r7/9l3Q6KHq64ISqMpLtZMf/91bkuUnuBI92ahynQ97b/nKcujb5AwTgjpad4LtU7gLgkJLdHz+SPLu8aDE9flsLUxrovkf2P4LL5lcYPGqvGcYxwW7/5oq0fqnq/+s0CeBZAGN2M1BcKDcm2VpMRonNLhpAek9ch4YJdzTx4xr3suXi4sH48NC/YP2xFva6RDxyFJeWDcQJZ740+LPTonxNPj80huG+9hSSCQQwWTIGtcnfR6gzwQNXNwoLfNigd9p3KOI3RN9UFDGmBjC5oUptDe3HTA46GGTbsAWFhrA2o0HaWUgUr9+29IkUatB0hJbNpLLHd8tD/cfBNAwmuddp8N0hX/iYGHJkIPRaz+fumMbz2oXIRzYzt773B3yhaw+P//pJ2U7l0rpCrRH9VpvvVhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(66946007)(186003)(26005)(6512007)(2616005)(6666004)(316002)(86362001)(53546011)(2906002)(6506007)(508600001)(4326008)(66476007)(38100700002)(6486002)(7416002)(7406005)(15650500001)(36756003)(8676002)(8936002)(54906003)(110136005)(66556008)(31696002)(83380400001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEhnSk82cEh4dC9NL3M0MytFajNCZjdjTVBmVU5HQ2EwY2ZxUXhvNnZybzVo?=
 =?utf-8?B?QWpSRkE1cHZWR0RYcHQ5QXdZV0M5cGhDWDhwaWdmNTMybHg0NlA0cXZ0WEZW?=
 =?utf-8?B?SVVVK3lKN1ZxandtWnpMN3ZTUW1RMkUvZnFaYjlIcjhPM200M3piaDNVdVls?=
 =?utf-8?B?M0djZjQrSkQyL1VIYnVUL1h0YUVPcVRETEJQeWdDUE92Tnh1SzRISGVFaXBj?=
 =?utf-8?B?QkV5bXZrRkxrU01pVEpEQTdvS3ZyOFhQS3dYYW9RZkhqalE5MVQzcXhLblg2?=
 =?utf-8?B?Tm15RUlZUVV3MjFIMTVzWGVFaGx1ZTMzNXVUb2NRcmsvZnBFalpsSWdsZWV6?=
 =?utf-8?B?eVlNRi9vWGpQcVdJekJESGkwOGp6Z0lwYlpWZTBWL3JXMXNhNG02NjBFRm9p?=
 =?utf-8?B?TmgzNGM5Q1ZEUFFxaERJSVcvWFpYcCtSQWlFb21CM2RzVitwZ0tXOGpTZU1p?=
 =?utf-8?B?S2s1b1Bxa2I4NG9oeVRzZEZDMGhiRGFIVXdTZW5RM0sya2dOYzQvcGlBcHFX?=
 =?utf-8?B?QkhmUnZ2YTMraExTeENqK0pPUldHMDJ6SE8vYmN2bSthNTczeTNscEhZYmhz?=
 =?utf-8?B?djE3SzV6MVU0dTdNNmFDYkZ5WGFjMFhxdUZFZnFaWU1MZW9rY1BpcXhDVmJQ?=
 =?utf-8?B?S0hRSkk1VUVGZmdaN09udlhWQ05wUml0REVkalJ4VzBlOEFIRzIveVpJaEhp?=
 =?utf-8?B?SFdZenZ3NlR1czZXQmY3R2MwM2U0UjZCZWpCK3NRKytoazNheXA3dXIzTmw1?=
 =?utf-8?B?Sm91MWtXVk9ITWFucjEvbzYzYmp4eGhpTXpTQTN5TUtaSW1Zb2FnQzU5SHAz?=
 =?utf-8?B?b1gwVU5ZekRDOTFhVmZsME9rZzNoZlBEdHNlR21FVUcrNktLdVhNelVKY3o2?=
 =?utf-8?B?eW9hRHA1bXhSODZDckJGQlU3WWhaSVVGcmJWMWhOdkxKVjVYd1NjOGFQSlBr?=
 =?utf-8?B?Vk1vcWVuc2dhN2FYUFp1T1pVejU5c1FXTi9iZHJNWHZ5Q2JKaXFTcDFGZ0ZH?=
 =?utf-8?B?bkkzT0Z2QkhiMWRKNVdZWTNoS0QvVjlBWWY3WlcyRmw4UmU2MG41TGxkR0VB?=
 =?utf-8?B?TnR6WWNYRCtqRllLN0psYW1QeklZSlQyZ0dTdERHeHQvaExnbFVDakZUd2Ur?=
 =?utf-8?B?bHoydU9US05DUTdWQnhNNEhFVUswV25ZYzlDMyszbmtsR2dxM1BVK1FvUEI2?=
 =?utf-8?B?WUtDUFIydFMvZ2pEWEdhc29OYldKRjVUWlJDc3RaQ3ZTZjdIaDJIN3UwRVBJ?=
 =?utf-8?B?eTZEWmFsSHpidGk3RmkxNjQrMGNNRjBYeGpIb3BpUWNrZFpJazVNY3VjS0JF?=
 =?utf-8?B?M00zamtLakZPRS9SYklzUDdpaHZBZXBvSGhFUUVmTkR1c1dUclB5RnhyVkts?=
 =?utf-8?B?K2RONUF4ZXprU3JieG5pYmUwWmpOd2ZVaEhrTVNjL25uSVhIbEpHVmc1OUhZ?=
 =?utf-8?B?aXJPZENaRXE3OUIvcHRKeDZMc1JibzVuSWErNnpWQmJsaC94cGNTRm5nbDN3?=
 =?utf-8?B?S3c1MkFiV0R3eTIrQXQwMU9iNU9vZUVwcUYxaUFGcjVYakEvY0xHR1V4QlFx?=
 =?utf-8?B?T012dDlpdVZhUGhBVm0yc2ZkeE1zTzNQTzRwOENOZFU4ZU04d0FNMzN3MzdL?=
 =?utf-8?B?NEM5UUVoeUE1ZUMxazlPMkNIazdsNHdEeFQxTysvckpjNHRyZy9LRWFhOVF4?=
 =?utf-8?B?MmRxWUJaZklEZndMRGxoMnF4VHA2NUhzWDhheHV2YzNUSmtKYnlCWTBwRXd2?=
 =?utf-8?B?c1dKdFhZYit2Wlo4eU8rQ1owMkxJbFh2L1BIbGlrUWF1U29JMUxVN1plNnZs?=
 =?utf-8?B?Wm56NDNHUlhQYnk4Z3Q5eU03RWVxTnU2bi8zOExJUkRndEFVWDJseUdHYVQ0?=
 =?utf-8?B?eU4xZ2QwemFBTStDWTFJV3lvNWs5UHZ0Ly9aTnNHQ3JIclJJZGdQYjlMaHQw?=
 =?utf-8?B?M2hZM2lKSEM0bGdCd0lsQXlKRzVyZGdPeCs0QVBoNjJ6Sllna3RXSFE2TEIx?=
 =?utf-8?B?eGJnY2JXYXBVNS84TFJpNEo1MTRjYzdsNkR5YUx3aDRNa1dNaDdnU1N4SzBm?=
 =?utf-8?B?WHMrTGI0SjNjMSt0WUg1djlibEsxc0lEUUQ3RndZVXNMSmJiUHIvNEI2ZTA0?=
 =?utf-8?B?elFueU12YUFGNTVJT1BlRFVuNEtEYm4waVRibCtWK093bVdiN2JVTVhrT3Rw?=
 =?utf-8?Q?06KcX7CQqyViIFFgZCln19s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23af4d2-715f-4fe7-be20-08d9ef003afc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 14:50:52.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNzNPH4EnXWa9CNVkbE7xm8YmqILuH/tjlxzC82mjGv5MvV0GVaQcyd85/xUqR6fZ5U1I3UGAWiTG+Pg2MybLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3238
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/13/22 06:15, Borislav Petkov wrote:
> On Fri, Feb 11, 2022 at 11:27:54AM -0600, Brijesh Singh wrote:
>>> Simply have them always present. They will have !0 values on the
>>> respective guest types and 0 otherwise. This should simplify a lot of
>>> code and another unconditionally present u64 won't be the end of the
>>> world.
>>>
>>> Any other aspect I'm missing?
>>
>> I think that's mostly about it. IIUC, the recommendation is to define a
>> new callback in x86_platform_op. The callback will be invoked
>> unconditionally; The default implementation for this callback is NOP;
>> The TDX and SEV will override with the platform specific implementation.
>> I think we may able to handle everything in one callback hook but having
>> pre and post will be a more desirable. Here is why I am thinking so:
>>
>> * On SNP, the page must be invalidated before clearing the _PAGE_ENC
>> from the page table attribute
>>
>> * On SNP, the page must be validated after setting the _PAGE_ENC in the
>> page table attribute.
> 
> Right, we could have a pre- and post- callback, if that would make
> things simpler/clearer.
> 
> Also, in thinking further about the encryption mask, we could make it a
> *single*, *global* variable called cc_mask which each guest type sets it
> as it wants to.
> 
> Then, it would use it in the vendor-specific encrypt/decrypt helpers
> accordingly and that would simplify a lot of code. And we can get rid of
> all the ifdeffery around it too.
> 
> So I think the way to go should be we do the common functionality, I
> queue it on the common tip:x86/cc branch and then SNP and TDX will be
> both based ontop of it.
> 
> Thoughts?

I think there were a lot of assumptions that only SME/SEV would set 
sme_me_mask and that is used, for example, in the cc_platform_has() 
routine to figure out whether we're AMD or Intel. If you go the cc_mask 
route, I think we'll need to add a cc_vendor variable that would then be 
checked in cc_platform_has(). All other uses of sme_me_mask would need to 
be audited to see whether cc_vendor would need to be checked, too.

Thanks,
Tom

> 
