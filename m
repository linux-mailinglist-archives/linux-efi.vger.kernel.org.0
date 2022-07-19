Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0762C57A9A4
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jul 2022 00:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbiGSWIp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Jul 2022 18:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbiGSWIn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Jul 2022 18:08:43 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189973AB23;
        Tue, 19 Jul 2022 15:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuOfeCcReBCUtZFQLhUYOD/uumkqs/r7tdgE9/UXN5d7RqhfjvKhrnRotQFn6c/+PSMXe7B8dWxezHyO5v7U8D61gABKjRBFBImErTXRJzp16zBAgeORBJ1AIJmvCngKounhE6bvcyu1/fi0uarWYKGl2jb5a1tTr/ikRC2WA6ZgY5H6TU7LfxTf+LRW8t/vi/jjOg5QAUKlzbjTvSI2c+kZ0DwfLW6t/zBCgSJvt8cHl5MPECqzhYuIREe2FsA83xhAxojNSafwiRcDWVkmz0sIf3BuoeApd6t2TpiMDh5H3AOXez6otE4sawlxqfxP1upeak7THhR/Oc5Jnw8RmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx7ncwPdDVIvtJTHX2+WJJn+IkPY93oFYRUbzZX41js=;
 b=FigDQIqPTcKFxsOXcdc+2TC6Ru09ZQ4BnRX+LrxYIAW8gAkRAZ8kpAQmMfkr83+gwU3OPAwYyXALghZGeSpbbSzRvtAglVw1Q9OTg62+pSA7wXMTR4BBhngkgnBPulVMKvVKs5aBuF4RGjlHUMb3O7cRvK/upUl9hFKmyU2Sl2T2iGek43jhO6GsoheIyYr/iquZEQfgYmhKo5zsNBW40H2uwXWRT5C9kywqbE8qr4ZXPFOQdb1y+Yl24FFVbW2KC0sHV3jQNcLJeNvw9G9n4dMjDPDpszjRwJ/r/oJ6+elPyiJ4PAsvEm9njcZwMeLjvqovkJIdRwHDWK241S6NOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx7ncwPdDVIvtJTHX2+WJJn+IkPY93oFYRUbzZX41js=;
 b=x/QTyv3doRBr3q/+oku9J1ijaHimjDCJbFQsWChmlwUsRPGxnObA7Zkj53hCnixRetcbRMGnM91s7YYCOgmGYv0s2dUSIErynNg3iuye3sPcXXz0N8R/b93SNhDguEJHh9Et+1HE7SFarXdYH5rjQOGpJg+Y6QEEiXm7NSmGOW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH2PR12MB4954.namprd12.prod.outlook.com (2603:10b6:610:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 22:08:40 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 22:08:40 +0000
Message-ID: <990d8c5c-1995-3ebf-e583-0e3f264ada0e@amd.com>
Date:   Tue, 19 Jul 2022 17:08:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Gonda <pgonda@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yao, Jiewen" <jiewen.yao@intel.com>
References: <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com>
 <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
 <20220718172159.4vwjzrfthelovcty@black.fi.intel.com>
 <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
 <CAAH4kHaHJo4NUb72tHeica4a34hq5u_QP6d6Vuzngf6EqTJ8Aw@mail.gmail.com>
 <CAAH4kHaB2tL+sAn0NAciu5DQeX5hpNkDees=n=f83S=Ph9Y6tw@mail.gmail.com>
 <YtcCWfCQuEsVhH6W@zn.tnic>
 <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
 <YtcgxxMyFTReuuRw@zn.tnic> <bb7479df-7871-9861-600d-c2fed783b659@intel.com>
 <YtcnQbiRgZPtR+rQ@zn.tnic> <22d54786-bc12-ecc5-2b37-cbaa56090aa8@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <22d54786-bc12-ecc5-2b37-cbaa56090aa8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:207:3c::25) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22ac99c6-3ca4-4f6b-626a-08da69d33c75
X-MS-TrafficTypeDiagnostic: CH2PR12MB4954:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0jV8ustxVfArM22H2r5d9vfqpgMfWVEjhRN8vkhvXsosoiiLR7jWz9z13Vra6oNiBwDJPbtkIdHzyTanevs4yhs5W72UC/235m+ubD2Xid3jVHYFxufhOXjXPbfxFQFQRdDb7M9qFaXZ4KKGLm1FGaFZhkNSrIB4q63+E9+nncGDD54HjUqNlMfDs3aZQ93noiGVdI1SjnD5yoWs6oK94pCKWn5u141g/60rV++ToR2BjcMjfSarno6nYTvwhgZJ+Yd+hFBsAwe4dSxY69qMFzU0up1WvCu2GKDJc3WehbXksSVQxwr81hOiNNAxPTCVwCsyTfz+z7a+ACIUlD6ejqAf1rpSxugI6Qa4fzc2SIMOV8fikCb0lBCkNAQUIsjxcKtpxsP1ZD/EVrcUOxl9vla50Oc5kXbYkTZaD88nHeBvYLbes4L/bFlglEUh/mJiWqv6NrUP6Ihuqtz+dOq0JPsGZ5OvWoFDt/MiVNIXRtWmOOdKNVWCX+EUcppfDvhU26rgbOUNDD7OCeMHEid9NNaEqJnZB6Dyb6MF+ZEoo6kE0R5Nk7kohaYMH4XxTkejkLzOGoSpw40uhzo+7oz7cG9ucBWrYpfMGuEFZ6ZIYLYGBlG0L6r1fjygU8ioPVTM280EFucaB15mGWXTLwaShNAUMss2J9rnI/qtiPmgWd9Wq3JxSK7c/MLokJK89JCk5B04DZ55Wh1OmNKg7qIP1ZZlRZT9G1o+C1Vba1I9AMXkgE2hrAE65dtfHUzpBg8dzm9GrbipO3AaayUs9Lav85UuzJfbuvrX7YdR2RO71UV0BCgNvWK7TdeWMzln10Agi8nyPeL7DHPzxgYAFsqUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(26005)(6512007)(31686004)(2616005)(41300700001)(66476007)(36756003)(6486002)(54906003)(478600001)(110136005)(8676002)(2906002)(186003)(316002)(6506007)(6666004)(53546011)(66946007)(86362001)(31696002)(38100700002)(7406005)(4326008)(7416002)(4744005)(66556008)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eElyWVhKbGRudnJZeVdMWnZEWWZyVGtEUHluTlZnTmFnMkdKak5hL3ZqQlUv?=
 =?utf-8?B?ekpsL2J2VHhiOFIxV01DZE1Zb1FoV3pkbllpTXlQTlVWaEhCelJpandqVSt5?=
 =?utf-8?B?cTBmSjd5c0l1WWovcVVsd3ZISzJhTm1INjMyWDZLc2pzUUIwYjNDRmh5djNZ?=
 =?utf-8?B?M0NwL0JYN2ZJRzJTUmVmeFIyWG54Nng3eUhNVlJRTGRuZjc3eTRscittRzNo?=
 =?utf-8?B?T1Q3ZjdmUElpLzAxYkZLUXA0NlhvMStPSVFEeVQrMjNMYUxLNFdlV3FHdGJR?=
 =?utf-8?B?QWVtSG9ZQW9WVzlXZ0d6by9NNGMrZ0tIcW51TUoxOE5rM0JmaVhqQnkxdG1m?=
 =?utf-8?B?dCs1TjRFajlEa253UTM4NTcyK1NHT1V3ZnZsLzdsUkc4MUhMTTI4VEtmaUpp?=
 =?utf-8?B?TGdRcGtJOVNQNjErdGdBb3FIbXRTNHh5UHgvd2dJQ0VzL0NHUko4ejhRUHdT?=
 =?utf-8?B?a3k4ZXNnQXFVTzI2N0dJOEQyN01rR2Z3STRKQlY2cXpJcHBQd2xCdjlPcDJP?=
 =?utf-8?B?T3FqMGJENTZ4bFRzbjNvVnBhMXVPUExQMWhmdUhhR2ZhbHR1S3B1YXE4dE56?=
 =?utf-8?B?ZUhpMzR5alVVN0tudVZnd2VwUEFOL1dhb3NlSVVJYUUrSlI1Uk12UTVsT0Rs?=
 =?utf-8?B?dzBMbjBYek9TU1ovT1lxWkdnaldMQnNOQlZ3K0x0eGlqdHpTTUlJaDZTZUhW?=
 =?utf-8?B?WEdhUUQ4bWdZb0lrTHdaVmgwbmpFbkN3UzR6dGRIK0RWdmNxd0l5MzdKbHRP?=
 =?utf-8?B?S2QzZjFkTVJWdzNYTmRrUHA2YmN2UGNSV1BJNXlMZFN2N25OTzU1MGhwT21o?=
 =?utf-8?B?cFh5RlVnRXdlQmdwTXFDSGpUeWtWc21ES3ZNaUR1YUJtbVR3NzhsNUtvNUxW?=
 =?utf-8?B?eE1RUUJUREJ2YzRLVHcvbWxqOTRZWkgwSyt3TU5IVUhsMWRoeXZNdU93Wnpw?=
 =?utf-8?B?OGdyN2hiL1R5dE1mYjU4cVA4ZExGazkyN3lPQ2ZOOXczenlrYnpFSVZ6VFds?=
 =?utf-8?B?TnJ1bFdRM1V6NnNuUE14YWhwajZFTkoxVTgwSzl2RzBZWCs4dG5OSUFPRWVn?=
 =?utf-8?B?cGZBRXVuSFA4Tk9ZbjlkS0hBZHVxZEVwSXdEaGNpanlDamxnckI5RXBWM2xW?=
 =?utf-8?B?c1hQbzY2RUd1MnRIYVVlejhjc1dzT0d4TGcwbU1OK2JkVElrV1Y2MjlGREFU?=
 =?utf-8?B?bTJIR1ZFY3RSVW0wZ2hzd3hZYkZZTHJabXlJNUdDQTNVdjBMaXlWdXl5QkNv?=
 =?utf-8?B?MlhKZDc0emR0aUNtR0Z1Qnp1RlhhZDdyMGFOL2U4SStXeXRXVHowSW5BamJp?=
 =?utf-8?B?c1owRWxvY2hyblpMSUJkcjhyckUyb3pXS056N1h6akRtRnZKL243SlNqNlB5?=
 =?utf-8?B?MmNkeWdraGkxNGI0cUtmWjZtbzJZeVJSeENORDRPdUNjbzNIZkdJZG5XY0hJ?=
 =?utf-8?B?NU92WjJVcmNJa25ncUlLTGNpb1dsZkJ3QXB2NzBDdnAzeG9EUVlkdExwa1dR?=
 =?utf-8?B?blJkRTNWWTZCdTUrUCt2ZVl5MEFiamczMDczcmg5NEdJRUhwZ04reis3U29h?=
 =?utf-8?B?UzVnamNsYkZvUnVidktyTHB5QUgvT2hzVGtOVTZJbGhlZEdnU24vNVVSTjRV?=
 =?utf-8?B?dWNsT0ZjZGdadDBLZHZHOC96TThDNU9xNklaZzFvc00vRkdVRUhNL1dWUklQ?=
 =?utf-8?B?eEZPeUVvYXNYQlIrMzdvL20xQVloQXo1Rk1KTE95YW1lUTRqdWhOSmpaTU9t?=
 =?utf-8?B?ckxacGtxekNRM0h5amZrV2hOcEhXTXJVMCtWQ21lMTVDMisyV3FmNmFRKzFI?=
 =?utf-8?B?U3hCU2kyYkF4OEhXZlJaWGo2QUY3M0x1cGpuK2xuR3M0dDU1eldxRktocE84?=
 =?utf-8?B?WFJ5VEkzNjVrRkRqV1NnT0NyMUJNbDd2UzhqN2lsQ2ttYUJWK2JjbmY4cWl0?=
 =?utf-8?B?U3R2OE14TEtJekNXU09ZVzhlK0laaXQ5TUhoYWpTL1NLamlqaklZZDliWXli?=
 =?utf-8?B?M3MwQUM1SUtpM1lES3RKNzJUZkZrNnhrWit1NDA4U2VSTmtZSjI4cFVPUTZz?=
 =?utf-8?B?Q3NLcDdIY25CenpZRjhuaDVWQlFFekJIak1ucmJWTWEvcTVoazNuK2t0c0Rs?=
 =?utf-8?Q?27QV1fIhjKiPLXkirjqDuQA/d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ac99c6-3ca4-4f6b-626a-08da69d33c75
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 22:08:40.3581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ajbe8bKthiCBFfI6mPO8LxZaCnb1nFPXxEaq7UKy2tLrdNQCxeK9DhwjRjjrzO9Lg8vAE/cwfkVsXSdtwxG8bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4954
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/19/22 17:02, Dave Hansen wrote:
> On 7/19/22 14:50, Borislav Petkov wrote:
>> On Tue, Jul 19, 2022 at 02:35:45PM -0700, Dave Hansen wrote:
>>> They're trying to design something that can (forever) handle guests that
>>> might not be able to accept memory.
>> Wait, what?
>>
>> If you can't modify those guests to teach them to accept memory, how do
>> you add TDX or SNP guest support to them?
> 
> Mainline today, for instance, doesn't have unaccepted memory support for
> TDX or SEV-SNP guests.  But, they both still boot fine because folks
> either configure it on the host side not to *have* any unaccepted
> memory.  Or, they just live with the small (4GB??) amount of
> pre-accepted memory, which is fine for testing things.

Today, for SEV-SNP, OVMF accepts all of the memory in advance of booting 
the kernel.

Thanks,
Tom

> 
