Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B916E3A985C
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jun 2021 13:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFPLCZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Jun 2021 07:02:25 -0400
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:19808
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229456AbhFPLCX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Jun 2021 07:02:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw68J+07Sz/azohiI5GQ2eFM8O0lqjr4WQc1fJ8dnNM/v3CJf1pEv1OeFoLWCH0JQUgw1eXGMyd5ZlwCRJBDkbaFvbJ8uzrjikWHKNqfbH4dHcH6V9MGVrAVdVTszNKscCe9Y343Nl0E1UpjnCiEWRs8EeDqpbeLk2Y3pZnP67Q5686Hx/zr4GJlnq8CTP8kTVrX2u//XD7B/CF7GNUmTO8LIi6Dv9+IaIiB758MAxUmqPqtNxJeA873sFN8n7qJ6E5KW1/RAmjJ/RMUOJdhdTFw4wwFbqWZUvoWOCVNK3B957qcWSxbaD1qFdsBkIGD5Y9fzNGxI8sQ1X8l4d/clg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCuOHR8oDixBTo813T/n1IXKNoSZr5LPqqOY/IxtfCM=;
 b=JXFM/4d8T/+BJBQc7ovnOxP1HTJwzyV/M3gU4nf5l5NERbAjF68oYDvvErWEA9wF1v5u+ISoNOmfU4p3cf4vrbfkm+V1b2+bwcoyJcHJkLj6tmKpDiIs+437xeQyzjtFaHtMlPKT+T6Qvl7MfDJZ5q0VLFH2aV8VAImCCgrOSEtaRPW5WNpDz5O9T0uKwAr2sXizS11eReoKJW1Xn6zMAKU7uGSRjscj6K6MNypJznhYZI+p6vGNXosMfgBCfs6DGuKySGZHcwVF878EcmnIHZBkdzOIMIwAaiHZpFSjg3jZKyDwHcU69BUFbxq9hr4f/xgAkpPQ424Pf9xwYVINqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCuOHR8oDixBTo813T/n1IXKNoSZr5LPqqOY/IxtfCM=;
 b=ES71sNHUiI2h+qhlRnZ4rALIe6dSON1HwH08r0j5FTbTdGhE4i08hZibbUxCcpKy36i90Xs8CseGKzzdYuLcsPy58fe6CqWQlwPY4H6SRrUU34d3F15UzCNCXmV+U5S5v7Bnu4hFiqkD9+Z3PcKBfgQMDgLI6+XX0PU/CmlGXoc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM5PR1201MB0075.namprd12.prod.outlook.com (2603:10b6:4:54::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Wed, 16 Jun 2021 11:00:14 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Wed, 16 Jun 2021
 11:00:13 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 11/22] x86/sev: Add helper for validating
 pages in early enc attribute changes
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-12-brijesh.singh@amd.com> <YMI02+k2zk9eazjQ@zn.tnic>
 <d0759889-94df-73b0-4285-fa064eb187cd@amd.com> <YMen5wVqR31D/Q4z@zn.tnic>
 <70db789d-b1aa-c355-2d16-51ace4666b3f@amd.com> <YMnNYNBvEEAr5kqd@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <f7e70782-701c-13dd-43d2-67c92f8cf36f@amd.com>
Date:   Wed, 16 Jun 2021 06:00:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YMnNYNBvEEAr5kqd@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN4PR0501CA0147.namprd05.prod.outlook.com
 (2603:10b6:803:2c::25) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN4PR0501CA0147.namprd05.prod.outlook.com (2603:10b6:803:2c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 11:00:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e88b7db-87fb-4c27-ca3e-08d930b5eaad
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0075D1EBE028413966630EE3E50F9@DM5PR1201MB0075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yn5NUX7F8G/FM/20bDXyFKbyiQN3xYSPfrWEkb6wxgSwCXZWPJ4wudMBRLJq92Bmj1AanPeF5m8gWPkO5JQxQBLRH4rziHUFqbLo6u1Z2TYdkGLrPSOZ6SXqrqnLvNmsw02gvSlTqMjHN8xOtj0BtaVLbQt0S7LqHglk1ErB63e7TyMa7i+6HFiG5taSsy5mQiQAP9Lf8haMe9UmpSFzQ/VODaBLmYYezvSnLIn+ZAEob4O/GEzNCSFJc+EwCtZIOwJRK7aF7nWkP6zt8/l1kZc84bfcynw5d6VkugChP30ndbhr2ZIepSOKyrn3F+FmHG0fed1TqojJjDT8gdZOrFx5sHBdeZb5H79YzD3eze2nHWPKjxsR4FMydKKBuoFrCqd+5Hk7qaS4hOxhgV77eKN6BLZCTndDfArYfu0/siA7XGbskYsfliC+E63jSow9YdtY+bFLn7o9KcSLDBYw0Y5mdOpZSqfWBQ4eYqWeeIrHu2mHOym3+pDcTSC33WVeTYkLUO7LvY/UEescpQF1Ez7DZHn5mwqAjlkctSkuNcWvR7pe81RVbcvVC0LHmXBzSrM23cVXtN++HOokSOP/ya4GcjdXCSnsFNTdsE5E5BnJzjnaN28Zwze1j/5SSrAEnxB0g0VyxlyR3Vf6qMo50zXQ0zxIiNbLaBVytmWEAraagy86lEMunXd9ZyfJJQ/mot/SIt6I+qJ1ftarQnJewAMfnBjiHg5rewHCcgwK1AgdQwuTz+RYgQXHJuBlzxI0fC2ZDy1ubibZHWK77dqByJqb7N0qRVe31QKCNwopNHrsGOgVQVt6QT+SvkxQDumr2b3dpOc4jvxfotMwLTdgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(31696002)(53546011)(6916009)(54906003)(478600001)(186003)(86362001)(6512007)(52116002)(26005)(16526019)(316002)(38100700002)(6486002)(38350700002)(966005)(4326008)(8676002)(6506007)(36756003)(8936002)(44832011)(7416002)(2906002)(66556008)(66946007)(956004)(2616005)(31686004)(66476007)(83380400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG90d0EzemZ4OHkydExjWndoelgzbzhsc20zalo3Z3V1eThjRitkTzVsd20r?=
 =?utf-8?B?Y2c4MzE1VHZwS1dwQXdNREdxazJNRGdvQ0g0WWw0aEJBQlJDV2tkRFBVaWVm?=
 =?utf-8?B?enB6TlZkbEo5TnFFbFlwMHJ0a0hMVUdqNnRCdC9WeDgzZmVqNjFRcFBnc1Rl?=
 =?utf-8?B?OUpsN1lndSt1VHIreTNHT3Iwdkl6WVZGTDZaR1BBa0xIWTdQak1HR21OR3k5?=
 =?utf-8?B?b0xSalAvb3VRUkd0ajNJY01jUVRNOUxITmJQRFBORmZnVW1ZbDhQV0lRWWJh?=
 =?utf-8?B?ZS9ZbFBCcGZHeG5PTitRWXBqL0FpVzgwK3B2ZEtnbkdGVkFDRTJ6OThNZDlD?=
 =?utf-8?B?VjFZYSswQnk0elBsTFdOQ1prOUFsYmFPRjdUcTEvUmtNemtVVmlGVUdyZERT?=
 =?utf-8?B?RHQxcWNaR3hiL2VaTThlelBNTE0rUjFoUG5SWE9SWjFydk9JMDZUYnlRVU1W?=
 =?utf-8?B?Z01ZMWE1QnFjSHpTc1FocFRaSTdYY21lRjB4d3lKVzhYWmFSKzlnZXNYbVNz?=
 =?utf-8?B?QWRZa3hLT3h3Z05DVlhxVVFodmVhcDZJVUQzMW0wYlg0WGV6L0QycEJqcFNY?=
 =?utf-8?B?cTJIbUFyRTRINUZZbjFqUFN2WnhPVzRUSkxQOFErQXhWYSs5VnFrZ0wzc2Jo?=
 =?utf-8?B?ZDgyQ0VNS1BUdkpEaTZiQzBOZzZhU0UyMkpUWmpCbzJFUHVoZ05HeWFwVEJU?=
 =?utf-8?B?TGQ2SndHWFFuYlZlTG0rL3NOSm5lcmlLMXlmNXUrVTA2emdWdjVjRHNCM09l?=
 =?utf-8?B?Mi9mREI1bEJoWDBkSDBoUFZGclgxTGVSWHE5K0hsZmk5WVg2L3pEblRRRE5I?=
 =?utf-8?B?NnpMSGxJWmtJZDZQN05xNzdybkZodW92aUpkSk54a2V1V0RiL1VEaFdHRStt?=
 =?utf-8?B?ZnVOWnEvMytOcVdyMXFxUnVURnNrTnlva2Q1OXc0UkFrM3JueG9NUU1QRWlk?=
 =?utf-8?B?aWdWV3BMRnZiYU1LZzNTdTEraW9TVVdWanZTRVZDZ0VYbUdFTWc1dlpjSVdv?=
 =?utf-8?B?K281bXljZmJ6QjZaUXUxd25GYmcxSHBsQUZsWks5ZTA4M0xZbTBGbTZnWWF0?=
 =?utf-8?B?d1lMRy9UVnJKNjAvMlliQTA2UDExNE1BTUpuSHZVMDd0T3ZoUDI4dGc4YXFJ?=
 =?utf-8?B?VUpZZHZUZVZxdHFiT0VLa2IwSkdYWVcwNFpTbWZ3NCtPcno4dGJUeWROZnd4?=
 =?utf-8?B?ZDFnRnhtUnRnZytQMXZkZE1uUi9ULzBiSU9uU1B5d0hEb1FybEluOHR3dFlM?=
 =?utf-8?B?UXFOUkFXMU40NDQ1WUlaMFk5ZmRGSkJ3WDRHTmJ6bC9qOWZ1N2NxUGtqY1VQ?=
 =?utf-8?B?Y0kwb0NnbFpDVXIvc1p0V2VBa2dPVThIR1J6MVNoMVovYUNGS25FNktPUkFO?=
 =?utf-8?B?bjJjWkpqYXZhV2NYcXlJNjNmZTNBMHJPT2JOelptMFdzSzJ5TVdXTElBdVU1?=
 =?utf-8?B?SlkvMnk1b2ZvUGYxRHdWcTRtdjZsMTBmekVheHgrQ3JHTWU3WWFacGM0M2tW?=
 =?utf-8?B?dkZDQ0UvcXpDZjhaelVQYmh0Nzl2YzBHV2FDUE5RcHF6YzNHNmp2aEZzOXB1?=
 =?utf-8?B?RTYwcVh5ZlFLWmNtSWNYaGJpMy8xQnUvR29Eb2p2ODIxVVdFVll4VTdseHRV?=
 =?utf-8?B?Y29qWnVNaXN5bkxFRlBlNllyRGxjTVdIUGtQMmdMSmdqRjhNdmhOYWhYUTlz?=
 =?utf-8?B?MkUrNkJtbEd6OXloNG1KeTZLZURxS1lhTmliUWVvZzNUWWdIZXZYZFlLa25p?=
 =?utf-8?Q?lVCMQ5Z9EDmg9ougCql019WVLBb8xzpP26EuEE/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e88b7db-87fb-4c27-ca3e-08d930b5eaad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 11:00:13.7325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJRw/YBw9vXzc1YhXqZ4kuagQcTgJ92e3yXVgWG92ZrQtQlVv4qLO4vXL6r1nqmZoQ+dIoxDAM/SaIHvPvgyUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0075
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/16/21 5:07 AM, Borislav Petkov wrote:
> On Mon, Jun 14, 2021 at 04:01:44PM -0500, Brijesh Singh wrote:
>> Now that we have to defined a Linux specific reason set, we could
>> potentially define a new error code "Invalid response code" and return
> I don't understand - you have a WARN for the following check:
>
>                 if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
>                          "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",


This WARN indicates that command execution failed but it does not mean
that hypervisor violated the GHCB protocol.


>
> what's wrong with doing:
>
>                 if (WARN(GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP,
>                          "Wrong PSC response code: 0x%x\n",
>                          (unsigned int)GHCB_RESP_CODE(val)))
>                         goto e_term;

There are around 6 MSR based VMGEXITs and every VMEXIT are paired with
request and response. Guest uses the request code while submitting the
command, and hypervisor provides result through the response code. If
the guest sees hypervisor didn't use the response code (i.e violates the
GHCB protocol) then it terminates the guest with reason code set to
"General termination".  e.g look at the do_vc_no_ghcb()

https://elixir.bootlin.com/linux/v5.13-rc6/source/arch/x86/kernel/sev-shared.c#L157

I am trying to be consistent with previous VMGEXIT implementations. If
the command itself failed then use the command specific error code to
tell hypervisor why we terminated but if the hypervisor violated the
GHCB specification then use the "general request termination".


>
> above it too?
>
