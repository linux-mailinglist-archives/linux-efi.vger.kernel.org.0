Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D983C6063
	for <lists+linux-efi@lfdr.de>; Mon, 12 Jul 2021 18:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhGLQ1M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Jul 2021 12:27:12 -0400
Received: from mail-mw2nam10on2069.outbound.protection.outlook.com ([40.107.94.69]:18817
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229848AbhGLQ1K (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 12 Jul 2021 12:27:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocDQ1p01pZN3B5uzx1r2Y92BvcbYalmpJWxT6bJtEhasXr+PNJWYwzA/FiV5NINczcbJgf7StxytKC0mql7kyNpXfIfa88TQRHCpdF9p/fvZATCeLLcMvBP4LTJgK11/XGPwJsI4COXEwu3GdGr0smuxuCR/5Bxpx3MZuhNJHbA5MzISgQF/cqWoDLhUn8qtciUcCDT+Eb8GlAKNJH5OKy7SiZq3LuwAZb8y4cD6K415lKlZSJHp+ZF68XszVHT3vqLwpyRumERIy5LL/dP4sX5Oi6I6HqBcJVV4X+Wp5TwKmaVwEFjdywBVKmJiIM5FqSeLMDgmv0eUhR5qhjcEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/Ke7h9GoveYJZj8KD3FAhejeJzmaV0DDn6FFNC3vwM=;
 b=QNzS+xhQZa9q06RNkZPshVa8kYZ9JcJ2z/YSt3hbrhbHj3b8jwtOxInU4vaW9A2GbwI0WG4A92b/N4J3asWbOx5KYP9yZhbmpCp5hD8ycpaNChcaAVuoM7n0W2abpZrF2FPb+1iXsnRAAqgWgCE9ggUpuLztmhoEBiTZiaAPuJdQEPlFsEypsy2NeKMk+mKDmo53TeZcQ9C+dWnXtSFL7ViFvWBBOV2omwpI+vK+SGwqG5gStJ6mMm4b6XbcM+KaR5NZcjwVuquiuQJbc0GyyVmhr9cewPRzZHoXGTiPmAn97XorXtKI7iCswbtqd6Qv8G7oj+6/wu/mnwX89f7fhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/Ke7h9GoveYJZj8KD3FAhejeJzmaV0DDn6FFNC3vwM=;
 b=IpPuMSw9KLPgkYkPZtdEVG9DiNhEKJ1Kr9KmlS2j/40wqO/+5b5LiPRtnPYofRjG0Jftx5ojQOhHF7HlzyQtu61xPJ/u1FNkgCGkgm3wj9yt+Zq4svjnDs7BnwO7P9YdKeGYRWYgmTA4LlJsHuS+ptEfbt3xUTFSNyEE1x1BLxo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Mon, 12 Jul
 2021 16:24:18 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 16:24:18 +0000
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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
Subject: Re: [PATCH Part2 RFC v4 10/40] x86/fault: Add support to handle the
 RMP fault for user address
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-11-brijesh.singh@amd.com>
 <3c6b6fc4-05b2-8d18-2eb8-1bd1a965c632@intel.com>
 <2b4accb6-b68e-02d3-6fed-975f90558099@amd.com>
 <a249b101-87d1-2e66-d7d6-af737c045cc3@intel.com>
 <5592d8ff-e2c3-6474-4a10-96abe1962d6f@amd.com>
 <bfb857d2-8e3c-4a3b-c64e-96a16c0c6d49@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <aef6be8a-c93a-1aaa-57fe-116e70483542@amd.com>
Date:   Mon, 12 Jul 2021 11:24:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <bfb857d2-8e3c-4a3b-c64e-96a16c0c6d49@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:806:a7::27) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA9PR10CA0022.namprd10.prod.outlook.com (2603:10b6:806:a7::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 16:24:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e28969f-b22f-4db6-9e64-08d945517f85
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44310FC2B905A886066D60D8E5159@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNpHjVLFnPkZdSIV0ScRdh+o8m9O+NCIzuAExhLp2OM/rrMSLbRwqXDavVKaFLfmOVYkaIQrgoqUifY3CnobXnnDTkeYhPPT9MrGRYu27Vhjm5wgCyV5YtW3cSU1Rohk7Oi1W8bZ79Hc4recrjaLa5226SD7ahyNSLITmsFOurdXlnpcm6rR06EIhDV4scyasxnjKpl+PNXQX9oP35qFfoyJVNYJIpdfJ0U1VkJ0qp5ZbHe9Hvk+rkzxUxJDb0mSGtvm2r3ZHzrOx1SeYBQn0xQvv7Ub8P9GnOO8CLvbPumOjQ8UIawTCaupcX0oGCQeGe5ncjTcBHQVp56pURS5Z3czJFaUND7bpTb/iwfKhxIgiP5sWzijtjZpUtTQmjyGip9gdddmpOZx58d4I3BXoQXUhfyNctY8BfOwTmKMtNvK5OOqQZOxBrEqzVXEtXPuGXxY9wTrdjIu8cPFLnN3xa3z5WfOgUMDmN00vHSC7SyK3h+5mo9Z8RriN2cdf9QGuxDPhA4TZcC8w/JE/XFVyhhoLf0dZtH+hZ66bZhzSfbtnXzLnD2nva+IJbDG3XF6/JUJmkeWYIBlBEqO3SnXEpcjTa0eisFyYLUyojBofHcSTyzhdCctkFqcpodrlRlXBQTXXok2kOjBGiXbyqC8G+Kq+jJQ4nEPWMTMuw9Z9+60UOf38lzD3ySk7p7MG8Oxhrpi0i131dSQfTgjx5MR0KbmN1voR99C08Qn6+awnSpy/d2O0n6DtHVBLaFSQpgTMgq0z5ssco4p/84ayxT7NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(38350700002)(38100700002)(53546011)(6486002)(316002)(31696002)(52116002)(4326008)(26005)(7406005)(186003)(44832011)(7416002)(478600001)(86362001)(54906003)(83380400001)(31686004)(8936002)(66946007)(5660300002)(2906002)(8676002)(16576012)(66556008)(66476007)(2616005)(36756003)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG9GMExmSk9MZ0lyZkNnaCtYdHoxV0xnSlltSEtwY3BDazNxMEwvbjIwVmd3?=
 =?utf-8?B?dGV1UEZwd3FxYlpDY0RaWVV4QWpJdTBkZFIrWTZoT2lBdXkwV090SjczQ2Mw?=
 =?utf-8?B?TmcreGc1a0t1SUFQOFBSUWttOFBveUJCaW53YXVrdEVBNVpEVlc5VktISTN2?=
 =?utf-8?B?eTFxdldZM0xnc0Y0ODVzNVplSVZSdm1hc3IyM2ZQWndYSEQ4elhZdWxKWVAz?=
 =?utf-8?B?MHB2QjU4Y08wSjd5M0krUVYrejVWKzFDSTM1c2FKbUFudmtoR2R3NjJ0SFhw?=
 =?utf-8?B?U3FsNFRuak1kOHpzS3A3Q1NSMWV2eE9vVjI1RkZNS2graEZ0TnVxQWt4eW9O?=
 =?utf-8?B?WHZveTFrMXhkOCtKWGR6eUNtMDRsOHVFRmtseG1jS2IycDhYVzdHMVZUNXJk?=
 =?utf-8?B?LzVsZjBmbjRHNzhtcTFUR3gxRnRvTHB0Q1p4dFpZTXlkOGhURmJuSDlDemNz?=
 =?utf-8?B?VkFtbytVMlRHSnBGbUhqYWwwSXJSNERQczZvdCtwdGc0QStUWWo1aTJTdkxH?=
 =?utf-8?B?R2pqQVN4KzdhMWRuN2tqUU4wY0lwaTBVSjF6SkhmTDhEM0ZkSld4Um1uM2M1?=
 =?utf-8?B?bUtWTDJ0SDQzajA2MW5taC9lSHRVRjdWZWtXNVpFa3BRdmJ2aCtYWTR3S2pE?=
 =?utf-8?B?N25raS9CRzZielQ5V3ltcGZNM2FUY0U2eU9ZTTlIL2l3YVJnVXZLWUJQYnhx?=
 =?utf-8?B?cnUyZ1MrTHN2bU55eFg4SFdZYXFLeHY0TTYzSGFHTUdGT284bURXaXVyT01z?=
 =?utf-8?B?UDNEU3BBUitCRmUxUlppVXR0RnlLZ3IvT1g3ejczZ0g2djdLcUY5VU16a2F6?=
 =?utf-8?B?Z1VFcDRna1dJWEhsMlNRZW84ZEh0dFNFc3ZMK3Y4WjlYejdrUWkvTlRGeE4y?=
 =?utf-8?B?VzZyNWo3ZXZKZWhvUXJZam5qa3dtNGI3cXJZMk1BdHRPT1d1Vm9hRGdNcG9z?=
 =?utf-8?B?UTRoZm92enJ5cXBaeTRrM2xhMU9ZY3FzYXd6WTcrUEZSN1pDbDRkUGhCclBM?=
 =?utf-8?B?eDIyMTlJYk1UcGg1M2djQm9VM3ROWi9ncnhrUytTdzRWeTBPV0QzSUhSODRG?=
 =?utf-8?B?VnpoWHVZNkliREowNnV3SXdvb3p0WnpBZ0pUSEpwQUkrRWtQRWpZV1R0aUJs?=
 =?utf-8?B?bnkxaUNxQW1GQ3dQaFgvRW5sWlZYVEtRWjFlenR2ZXNNSkwvbjA3aWJwYWlQ?=
 =?utf-8?B?M20xVGFtR0ZhYTFSSWJ6L29DU3hHZFk3NzJ4SDJ2YjFDMHR4LzVybUJQT05K?=
 =?utf-8?B?dWtFTjNCZDZ3SXJRMmYyUTdHTFNCeWpmRnNTNUJxNk5FNDgzQm9GbGo0OXEw?=
 =?utf-8?B?SHQvcGUvN0UxQk55NjZSYk5WbDhzcGJjQUlPRFJQUmx4Q2JLaHRSaENwNVA1?=
 =?utf-8?B?SkNZbmZuRSt3Y3pmMDIyZ0lJdFVRVyt6dDN3ZlBwZzFBTXJ5ck96dC9uTE1S?=
 =?utf-8?B?Y1ZyU0Rjd3gwRTdQWVc4bjFKWTVyWldmQjBIV0RBU2RaNi9IL3E4NTJZU29K?=
 =?utf-8?B?bmVWV2V0ejZ0L0h3TGk3NUxZNnJ1NUhZLzFRbXZZMjFKMUZ4QXZnRG4vRUpT?=
 =?utf-8?B?U1M3YWdEMVNSTkE4SHpkcHZUNFpQbDhESHRUTDlvTnQ4eUgxU0JSTzRiMWs0?=
 =?utf-8?B?dGQ2MnpqRDE2SEpkcmttRWd6WTdsUjFVbFV1dDl6UmJZVUdDMXY1UGpGSkpV?=
 =?utf-8?B?WmF5T3lRN1hCWWlFMVRUUVVuc25zckY3dkU4VGlzYUFsV090R0F5Z2FXMkhr?=
 =?utf-8?Q?/b6g1p4qMv1ZSADmmqTzSvxwSlAHI65KFJbKrMf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e28969f-b22f-4db6-9e64-08d945517f85
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 16:24:18.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elNt02YnVp/4cXbzBUg0BtC4M6D4DK2xzAV2Pf1m5DOI2rwvyPzcSc6E1cDmB2+G+pveBXgISx2PcRNTr35Bjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/12/21 11:15 AM, Dave Hansen wrote:
> On 7/12/21 9:11 AM, Brijesh Singh wrote:
>>> Please fix this code to handle hugetlbfs along with any other non-THP
>>> source of level>0 mappings.  DAX comes to mind.  "Handle" can mean
>>> rejecting these.  You don't have to find some way to split them and make
>>> the VM work, just fail safely, ideally as early as possible.
>>>
>>> To me, this is a fundamental requirement before this code can be
>>> accepted.
>>
>> Understood, if userspace decided to use the hugetlbfs backing pages then
>> I believe earliest we can detect is when we go about adding the pages in
>> the RMP table. I'll add a check, and fail the page state change.
> 
> Really?  You had to feed the RMP entries from *some* mapping in the
> first place.  Is there a reason the originating mapping can't be checked
> at that point instead of waiting for the fault?
> 

Apologies if I was not clear in the messaging, that's exactly what I 
mean that we don't feed RMP entries during the page state change.

The sequence of the operation is:

1. Guest issues a VMGEXIT (page state change) to add a page in the RMP
2. Hyperivosr adds the page in the RMP table.

The check will be inside the hypervisor (#2), to query the backing page 
type, if the backing page is from the hugetlbfs, then don't add the page 
in the RMP, and fail the page state change VMGEXIT.

-Brijesh
