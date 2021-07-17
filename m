Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69583CC02E
	for <lists+linux-efi@lfdr.de>; Sat, 17 Jul 2021 02:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhGQAhi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 20:37:38 -0400
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:50209
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229578AbhGQAhh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 20:37:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpW6Pes960qV7if849CtANrkIgiZiGlxD7gTbaXvAzvT5gFrI/dQZjS924v2oMMvxLHVL8qrzJfP13o/YBb14W0X+nm3MCl1WnS4V/i1OhS2aMQKtlJFC1BLJOQe5fDI19yJt7LS6HNwuQOT1GtYQIWHEOUOFnUhUxFeaPzfFFzE5+q1SRocoS2FgoZEfuPB+8VLOJIvTNPHp+g61sLhQ8DzCDz1fF6gPrLHcw/jsfwZt5My97p2b3GfHXr9E3bqYd3PiIKXOqZ04BI7b79HXwUCaGT7d4MNxsmeLfuoZfkdzJs/7HN2Fw4RWDQwS/Ff02J0tO9Ad3jUOUG6XoZEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD3+nIttIhQ22FM88Y6fgZ9Caf2hrD4jJK2Jfl0W8L4=;
 b=lgN9B4PHBz0kAW3+60DP+dqJwkMMwB7esTl48vzl/fUe/UO2njjt04zp3IDhQgqEIrTE3XRef/6LgE/4DR+mKoLgs/d2jj3uPq1cJUfsgdm36LFi9VfmjWV/ZHINmZDG84mKN3wI/i9mRh+ESteOoUYXvJtzZ2j6L7Ddkm8Bxl/0PvW+f9nBCXVnN7/Cz4ZFazcMDOg9HjgJyrgOpk06C8YL7WmthR8PtgZIojb/mm1JOV53VxrMrfq5teZBp+12N5Zro0GsLtNfaYJ70SOqJnRlaGes5EaC5iRC04NfC2M6zmOQ4bUDRHutynWg7yfcEvlwR7uerguUghVsKpG6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD3+nIttIhQ22FM88Y6fgZ9Caf2hrD4jJK2Jfl0W8L4=;
 b=s6asUY42XQAAJB6hHpNtJL8JEfTLMKDRykEKVqFuCemtJbPAGcqFcKMMNXb5ociY6ALtSpr7CVAGye36NktR49sW1u+96c72NcqmRIvL8FWywsfQKURhC1aa5Wo8XHT8+3w9J0YT4+o7Hz/gytCf2V/3EjCh5yNxVOZ1LooE1Pg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB4672.namprd12.prod.outlook.com (2603:10b6:805:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Sat, 17 Jul
 2021 00:34:39 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Sat, 17 Jul 2021
 00:34:38 +0000
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
Subject: Re: [PATCH Part2 RFC v4 30/40] KVM: X86: Define new RMP check related
 #NPF error bits
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-31-brijesh.singh@amd.com> <YPHqo+KefHLrAclx@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <68ce337d-bdba-ea42-03f4-ea7a30da91c5@amd.com>
Date:   Fri, 16 Jul 2021 19:34:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPHqo+KefHLrAclx@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN6PR2101CA0022.namprd21.prod.outlook.com (2603:10b6:805:106::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.4 via Frontend Transport; Sat, 17 Jul 2021 00:34:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c99d3527-08ea-413f-5b61-08d948baa8cf
X-MS-TrafficTypeDiagnostic: SN6PR12MB4672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB46726E535A7C3630E7AB4647E5109@SN6PR12MB4672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctuBUKz/u7BMIzEGpb/UMKfxYB133SoZT79N7qePB5J/agmR156HlcHDhr1PbRaRXzIS16iYntS0HpasWdt0nZZVRp0EZlhry8VO+JtfUOouPU9TT2HAeCBwjiSwCAoknfWcKFJmX+TQ8Wdvj3rR49mRhHst6UWV9JDZosx0KBv2O8fljTVscfiBygFSdYtmLAJYytxIsLePcduIjjSWAZEWr3tPdsUujesZo3lRx5ZgqCPPXk3FCpr0KxgWQahnWrRUQOJiBmksgsx1yVCb7EsMIlXwDz5E5wvX4IRcv6fo5ch5OBWqwTMd0lO1/PTxK5SNoNr6rM0YGVuTpAAOhByMuBavTcqpm4VX0+EfgrPT00pJmVJok7Z5mpWRvyaGIb9kPpGqnHfaNHIEMmeMhN1A8WmWctcgnqHiV8UyQWBppHgfiHQpD0xF9vgXzLC0FrNp27SiY6vu/AJcwk+g1dyRhOQnTub3mD1nT/yGSuAYf/HH1is2jWVRh534W5n1azb9zqEcvglWgK5SJL5O1yjfUvFSsiUiODu5ChwzM8hFRlhMvCeVzrVqLzEAT9G507zla4Y2Dn/xgBc+O0Lfp5LehL2hJ9x1A1KGpZnTOIQmZrrLSVsoi0kd+91Eo7Qfg/osymCL+i+SSNKnTzVMwIgGlsOIABboDcnqf3OUVbfqunH664Vjnc77FDI3G+bJhPsQyzPUH+w584xxaW7zMqMDndVKTZPHWUJj3lgxRYlRHI2/VhxIs8NEOS84NPOCVQJKNj+0OtewTTpzrBMLog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(7406005)(7416002)(83380400001)(8676002)(4326008)(2616005)(31686004)(6916009)(956004)(186003)(66476007)(66946007)(44832011)(66556008)(26005)(31696002)(478600001)(5660300002)(8936002)(38100700002)(38350700002)(6486002)(316002)(2906002)(36756003)(52116002)(54906003)(4744005)(86362001)(6506007)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnpvSzFrNTl4WGI1SHd2VUVzZzJHL21GK2M5UWk3Vjc2eWdnZE5qWnRtdWlK?=
 =?utf-8?B?SW9nQU94R3Qrd3ZjUmhWQVNGOWY0eTlRT1hKeE9sYnVEZjlOWXVBYk5KdG9M?=
 =?utf-8?B?SnQrVTUxczNQeFBhdEEveHhwaldId25hdmgvL0lUeG8zcnIrZ1paMm56NGM1?=
 =?utf-8?B?aHI4djNYWlhZdlRJKzVRUDlTRWtLSC9keTFSWDFnU3BYWTNtSzhMV2N1TzZG?=
 =?utf-8?B?emFLS3MrR0ZyaGtRdkNDYld2K2tiNUhZcVRLZzFEZ0tsSHRqZ2xGU09VZEh0?=
 =?utf-8?B?KzhEeS9uWXVYd3ZGa05udlpDQUp4emR6RXBJOC9LS0VrZ2o3d0ZNVS93bnVI?=
 =?utf-8?B?NVVQUHZDb3V2aUVZbGdNY0MrdXFDdU0zdG1mbFRaNXUzcWpCR2VIaDlocll2?=
 =?utf-8?B?K3RXTlMrOHhDSklGQ1JrZ1V1Q2lKQXIraXlTLzFROFhzckxZbENuSkRpTmdJ?=
 =?utf-8?B?ZXlWeU9paEdkaXdDR1RiVXJJM2V5UE5nZ2pCRDFHQ3c2VFhNUFFPejdzQVNE?=
 =?utf-8?B?bkRyMURFeFlobTRwRVhNZE5YMGl5TmtaaGxMS2hFUnhqVy81QVBiRWw1UUVD?=
 =?utf-8?B?TnFoNlE1a3NkcnQxdmhyMnVNN09KQUJYd1pCZ2xxTWVUTEVUWHdsTXlOQVY4?=
 =?utf-8?B?ZnBUR1RLcVZXbUpNQzcrUDc1cmlBTDNhYndJb1p3NGFuT01YVk5RaUFhVmxy?=
 =?utf-8?B?N3dzMlZta2Y2N1NXemFBcnIrNTFydkZGWFRoSzFkUjR2d1JwS28vQXY3SFcr?=
 =?utf-8?B?V3A0SlhIcGdUby9QcStWSkVVc05LY2dJNjA2eUFqLytzVnVoVVNNbGZDNC94?=
 =?utf-8?B?b0l0Mm5OcHpYMVg5VzZtZG9oSENSWk1QSk9tY3BCMXBERks5K2VoeVp2RXRF?=
 =?utf-8?B?TEhCd2JZZ3kxeG5rb01icUJVQjlsLzMzbit5MVNtTFZxR2VJK2FKKzR6U0NO?=
 =?utf-8?B?alhBS3pVY2VjRmoreU1YYXpQRlh4QjZzWnFXMzV3OUdOdHhuTVBYNGcrdVZw?=
 =?utf-8?B?S1U3S1d5U090NG5FSGdOMWx3ZEc2LzBJOHJ2VG15Y0hVZjRtSFd6WC9acHVO?=
 =?utf-8?B?a0Y5TDBpL20wYlhWZU5oOERKUm1qRzFZZmdHcURodHNhekU4QVQ0NUNOOXZ6?=
 =?utf-8?B?RkpqSU44VEw1K3RDc1J0R3hIOGdnT2kxU2ZVSVlHbk1pMUhiMEhPQTJUK2pl?=
 =?utf-8?B?TUtzWVpiaUlKMExJZjRhNFJNSTRFL3VLbTJkR0RlYlpsbVBLSHBYMkp3c1Nr?=
 =?utf-8?B?REloRmZWVGdqZXJjWmlRWGZ0Sy9sQnBaQnZMRzV2VTJDM3RVZGVDNHk1d3F1?=
 =?utf-8?B?Wi92QjlJamJIQVdEcE9MSUh6d0JjMHBxd1lUTVdOWnRMTG55NEFOcGdlaW5W?=
 =?utf-8?B?OVVmYXRtSEpmQUdjeVFBQmgwOTVFNkl3N1NwZ0x6am8zdjl6YnpGOXVibmJQ?=
 =?utf-8?B?TVBSNW5ucDB4em5BTmRUOEZ2cEJjRkVWdEpLMEUyWnBSd2daNTgrTHlranlu?=
 =?utf-8?B?WXkzTkQ1UFNhY0RjNUUzL25EUllvKy9IM0h6aFl4THpjRHhRYjVSdEpIbGc2?=
 =?utf-8?B?OFc3NW52dStTbG4xSFFxVVdHNXh1dXBYUldyRTR1N2ovakhJVFNEdk0ycVlL?=
 =?utf-8?B?amx0S0cxYW9LaXcyNDhUaUZxY2creWthVGpEOHRHNGpxWlk5NGFZVTM2R0py?=
 =?utf-8?B?OXJLZzR0MHE2dkQ0SFNsTWwyVFdORkhaWUcrRkFyQUVIU3NWZFBNSUpZZlFn?=
 =?utf-8?Q?gcJpBbWgXkKrZIBY2fO4NCrTVgE/GXdZYOLMauQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99d3527-08ea-413f-5b61-08d948baa8cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 00:34:38.7151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQ98VnQIRADX4Qq1iyJPdavJjvvfs2QgeVPJJkrOG+IAklEJm8B6l7fFjjMONfNSK/oLH8188I0odjtUC12jTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4672
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 3:22 PM, Sean Christopherson wrote:
> Nit, please use "KVM: x86:" for the shortlogs.  And ubernit, the "new" part is
> redundant and/or misleading, e.g. implies that more error code bits are being
> added to existing SNP/RMP checks.  E.g.
>
>   KVM: x86: Define RMP page fault error code bits for #NPT

Noted.


> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> When SEV-SNP is enabled globally, the hardware places restrictions on all
>> memory accesses based on the RMP entry, whether the hyperviso or a VM,
> Another typo.

Noted. thanks


