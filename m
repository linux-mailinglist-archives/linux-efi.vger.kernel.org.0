Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6844E3CEE83
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349371AbhGSVDC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 17:03:02 -0400
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:5026
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1388359AbhGSUyX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Jul 2021 16:54:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvrKggBdPD80lZTsqNtz/MCc/zKLFiaxDPKkmgNQWzGGomiO70w+qhDA/s/wTRvYCaw66ETqVBoFBEJQVbgrmOwdssQDZ63mGw4RCq20SMLy2TCwFzxbbjeQtg7br5jMsEEvmS8D0xg9NEmlsbQ+q8ljyXENLg8KGLx8q/ogNk42A1CO4HCLOlWYaTAMvY21RO05T7+rbWEhT9iyusDBtZDsDQmvHSitVUSmncOHIVYPZtUQ73annMaG594qg3KfU8HTspdNFbpk0PLiT6CICAF2fJQ5WQAFdGJJtzarPEduiaeUNdkxze9lpi47lQJwd51Do0C2+3hFpMqvfRDoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JoeORAA/fqGx16l534blhrvPxVCpfHSUxf23zzZX50=;
 b=XDVUuGqqZK7hpyvWsORwoQUrY1qtwDtH73xQpCK+pdtojVP1AwXrFQIjwnJWm6ti4MvMrHFmrNq2zDJMSJ2mdjQ/Q7APBWxxyYh9WZwaUb30ArxEdtAtiq4XyoVM4AhmovUc2qF2R73AkQNJ5/n57wGIA5qa+xfJgMMrTyH0/AnRfIkY77PBM9wL3JN+s9jWrH57p2xFiJAUPzh5szlyFodoQtNsf2/T4zpmkDqzOLXtcBoJySmg4ANXE8n0wnJrz8ySbRPAPHaNdeWkJ25JMi+CiWNKiG0CrLqVF2aLLNC/7X/1aFtBXKeGPBNJHtMiHzo0GHXE6wk3yVhXkemAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JoeORAA/fqGx16l534blhrvPxVCpfHSUxf23zzZX50=;
 b=RSyixSLm8RM+jE/XcuY//mvaNUmnXHYoT4fWR8zCCFQYt8vhHnVkUZdZumsh7GWRmwMVT+KoCqY48WMtEsNQlZLjKsFqlTMDeQnV5vsBN0nwe5rEdDR/zx1ReoG5VWc2PyOM1F3vcc6hlrkAgqctoE8f2u/Px+8Eiw15jGv/RKU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Mon, 19 Jul
 2021 21:34:51 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 21:34:51 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 24/40] KVM: SVM: Add
 KVM_SEV_SNP_LAUNCH_UPDATE command
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-25-brijesh.singh@amd.com> <YPHlt4VCm6b2MZMs@google.com>
 <a574de6d-f810-004f-dad2-33e3f389482b@amd.com> <YPXl7sVBx7lDLx/U@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4af1b784-2744-5f9e-59f6-dd8b9de2ec4d@amd.com>
Date:   Mon, 19 Jul 2021 16:34:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPXl7sVBx7lDLx/U@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:806:f2::18) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN7PR04CA0013.namprd04.prod.outlook.com (2603:10b6:806:f2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 21:34:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44bc5843-bfe4-41fc-012f-08d94afd0a3f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44153A5CF2E53B595C5437D9E5E19@SA0PR12MB4415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dU1IvWuqvgIyy5b7KTAaBL4qsZgzUXXPqhoxJFY/nawmRfODAx1e21jsXpi4GakAz5TA48RydQdrwIzjYncXEsIJ+B7ycSRwymPRvuNoqIFXj2OkfE7Xx3/dEUMhnRTkfbLbcyF9tSW0WQthicmcsBgLiO1d7kl+jDUpxbpCQynSnQaP+Vpg0wGmAqV875WB1Q1lYHunZJJ+PjOSN2XfUau+Wx9FHdlzcjDisNlslO8DJtqX3J3bowM7O0X4tNLXCDJkfFNuqvKww91aE8KSyCRiXOBCeogLDE0EjFA8rZLUOGWX30609wgsZTMB5ZTx4/eGAqvEATejAdAgJnttSxgq9/yR9wF64/sm6SXBZcOQaeihQEQnVhc0NNGWBrdMoPf9tZSH/IhlgCd8etA3zBrSfCgK+5IX3vrVSQRvBmW8n4hea1wDSOraBRVSUsIW390tnl0FHrpHtqweGapG+hV2SxYc07WBaHncLvPhbxGasOehlr8ytkOvV0fQ74a8g/QVv8eRqV5DxPcrW48/d31yJpQWw7KbP3G592oPuansRxYmzyEDa8kB9tyR5Mc8HZ2BjaSgk45jx0YT83DrHgF2TXXgDFxFTGB0U3NordEX0JIBb+xYQyh9lMeOjBPkeWH8r/AHrqY0m8E7EhXzkHaefIraOWyccxmhq7Pt7lB9pCV+cOfa3f59zqEyoawK8wX2/XbsQe/FHoXPsts5M0tUsqtFHuBxAVJwKo3fX9b+QuxG+NHD/aBHUs4HZBQCff80RhUCBfTvQY3JAqopKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(316002)(66556008)(66476007)(36756003)(4326008)(66946007)(16576012)(54906003)(186003)(53546011)(86362001)(52116002)(7416002)(31696002)(478600001)(7406005)(6916009)(956004)(2616005)(8936002)(5660300002)(8676002)(44832011)(38350700002)(38100700002)(83380400001)(2906002)(6486002)(31686004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFhkMTlkMFJ2M29GVDNLNVlkOFUxWENQS2VUVG4vcHFxTkwxU1RXNkR4SW8w?=
 =?utf-8?B?b2FCYmx2Q056Z3p6SDlobzdhQVlaajRQMHF4dEI2akZpR3YwNjdJem9ObmU0?=
 =?utf-8?B?U0c1OTJlT0RTSGZMcE5HZWFjRFdkczlqWmhyY3FPZ25QUHQvSFRoVXB6dGo0?=
 =?utf-8?B?RExWTlJCUy9aZlZaWDAzSllZZVJGSHRqc3l2bDMwZWowYUp3THdNWHQzMVBY?=
 =?utf-8?B?YXEreFRPRmlieTQwRVFNRzJzaHRuemRmbGMvc3MzUGp3dWZ6WUpqeFE0OWpi?=
 =?utf-8?B?ckRMbUw5K0tKS2pzaXgwNHNTQ0hZWE9KQjdOTGNmQmRlR0MwNFlPOWxhNUxC?=
 =?utf-8?B?L0pscmVjUi9EcTRuNTcyakEveFZDNkZzZitEYmxINXEvdGVMeFdIVDJ1NzBF?=
 =?utf-8?B?ckFoZXFhYnRZQ3JjcDltUzN5ZXBJZGFxSkcxYjdOaXRnM0w0czFUQjQxN2NY?=
 =?utf-8?B?VGFUamFjblZIT1lJTHY5NzB2RHhLL3F1M3dEOFhITzJZcW03czg1L0U0cTJm?=
 =?utf-8?B?RGI0SHpEVlE0Wm92SUFwRVFTUCtBZnNpSnVjWWoybDRiT2hGa3p6WkFvNUlM?=
 =?utf-8?B?a3lXaC9KMmllQkhCcGhqSEFMNzViQlJXalBja1FUNFZoUE55aUpQU2k4WDMv?=
 =?utf-8?B?a0lRSWh6UDhMVm13emdmNGVycUVVV2tSTDlWMENaSEhabXFVdm53OENNK1B4?=
 =?utf-8?B?MEVFaEtRUUtvdWhhMmpxL2o3SkpmY1BUY0tsN0NRSUdlTVBZUmFqMlh1ZGtk?=
 =?utf-8?B?QTBQOWczNkc0UEdEQ3RoSGZDWEZ4MWdHTUdFWE8vQkhTVE1DVVM0TmFraXlr?=
 =?utf-8?B?QnVLc2hYTjJhWWQwLzlqRHhSZ1ZWcnlRbTlTZlpUNi9qc0h5SW9NUHR2aFJy?=
 =?utf-8?B?czlxWEp5OXgxekRqVkRrK2JKNGZFeEZTdmVTbFlNNVFIdWRZRk1keFFDTXJO?=
 =?utf-8?B?QXFTVm94RDBiZmpCekZ6aWpKMjZGcDJ5TE15SjJMS1YrVFQ5TG1RSVg2dmlR?=
 =?utf-8?B?ZjVLWTBVd2dIN2tiVnBncm9zeGFPWEV3TUwrRnNDTWVqSDlZTUZjak10RlRq?=
 =?utf-8?B?NHNkWnE2eUtJbEE1NGttUTZtejMxRzg2L3VBUk82SGNwaTFvOERXMGRIQ3hD?=
 =?utf-8?B?emNVNjF2OTRzOUlEcWhucTJBektnTm9pRkx1WHRBUXZXYjkyWERTQnVkdEt1?=
 =?utf-8?B?R1c1SDdXUzZBMzl5cnhLNlBMNGkrUjFEQWRvS0tsSmxjZm1DblRibWZhMXBm?=
 =?utf-8?B?YktmT0VzUU1qWlpMSlY1SWR2SHA2WkI3TlpxaDNsaFpSdEdKTWduaUpGR3oy?=
 =?utf-8?B?djJ0c0t4eUdzUUpxRWphWFpLNi80b1Q3eFRhblQ0aEg2TE9aNkorQlF5MUNP?=
 =?utf-8?B?OEVEZEJ6ZGdSc2krQWIrSjB3MWIwcUlKd20xcERPRlVlcEVodTBpNnpFb1hp?=
 =?utf-8?B?aG8wQVl2R2luTXRUbkJPWHBGdnQ0cFZhTUs5MHNXZ283ckcxc2xycnJuNmlV?=
 =?utf-8?B?VGQ2YmpiR213STVyTzlaTFpnUjlVR0FqejRyUjNlbDB0M29RUHcxamRCdWcv?=
 =?utf-8?B?dkFVdVRjZkxrWEgyR1hZZDBvbDR3OWl4alhKd1J3VVc4TklvN25WejZzYlBU?=
 =?utf-8?B?RGo3ZndHeDF4ejdmamwzcE9TN0l4NzhLRXZEeHRoaGhOUHlDZ054VzR5L3Bq?=
 =?utf-8?B?RkMyVFRnSzVZZGZNc29NcGptbnhGeGZoRUtPbVhweFBraFZVNCtNRWpiUThI?=
 =?utf-8?Q?BpZW/MqZdEUovmvqYz+SXKqyANwNfzVy0FGoDYn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bc5843-bfe4-41fc-012f-08d94afd0a3f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 21:34:51.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWmFeoOKDET11WKs4AFBf8c2xE/NbrpQmWVDYpeuPL8PRMF5SMTyGmtgnO9i3TWrTKUKUP6sMKURODEBgliYzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/19/21 3:51 PM, Sean Christopherson wrote:
> 
> Hmm, and there's no indication on success that the previous entry was assigned?
> Adding a tracepoint in rmpupdate() to allow tracking transitions is probably a
> good idea, otherwise debugging RMP violations and/or unexpected #VC is going to
> be painful.
> 

Absolutely agree. It's in my TODO list for v5. I have been using my 
private debug patches with all those trace debug and will try to pull 
some of those in v5.

> And/or if the kernel/KVM behavior is to never reassign directly and reading an RMP
> entry isn't prohibitively expensive, then we could add a sanity check that the RMP
> is unassigned and reject rmpupdate() if the page is already assigned.  Probably
> not worth it if the overhead is noticeable, but it could be nice to have if things
> go sideways.
> 

In later patches you see that during the page-state change, I do try to 
read RMP entry to detect some of these condition and warn user about 
them. The GHCB specification lets the hypervisor choose how it wants to 
handle the case in guest wanting to add the previously validated page.

> 
> To be clear, it's not just an optimization.  Pages that haven't yet been touched
> may be already owned by a different VM (or even this VM).  I.e. "reverting" those
> pages would actually result in a form of corruption.  It's somewhat of a moot point
> because assigning a single page to multiple guests is going to be fatal anyways,
> but potentially making a bug worse by introducing even more noise/confusion is not
> good.
> 

As you said, if a process is assigning the same page to multiple VMs 
then its fatal but I agree that we should do the right thing from the 
kernel ioctl handling. I will just clear the RMP entry for the pages 
which we touched.

thanks
