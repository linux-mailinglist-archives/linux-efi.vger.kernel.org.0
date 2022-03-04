Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8366E4CD503
	for <lists+linux-efi@lfdr.de>; Fri,  4 Mar 2022 14:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiCDNSb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Mar 2022 08:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiCDNS3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Mar 2022 08:18:29 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF84C45786;
        Fri,  4 Mar 2022 05:17:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQlwFInCtOjVg/PpRDxxxvwVxFX2GQaU/gTWqwn1JJWnhJhjRf3M7I3pjk639L4RikhrXbPL2WR+GK/LAnqSiWo4WxCEyBnHt/BHn1HpwYxUvI5cIsUGZNAUYtTQomazLtSEThRpHI1WQGwgAFIjgU4n+MZ/CmQuHnJV3RB9pHvInAEoAnNE8awLnYE2fxgIApKDCaLS/goc6dN7u0ets+5YXSWCDdsxuxoXtTnq0eglmkhXbAfhSOOV+6WsaogQqmpFzNFCIH1rgjSaIJdokWBqC99PMvzmrNNPxEu68pRA4JdI3QborR/UO/TSuTNIyHHNRZXZl9lHsQ/AG0Dv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twKKIzJUPkYkxrB1xTnr6l68Pzrm+3LpEDAHgIaCCs8=;
 b=I7XY/G4Ca37GLTIvel5TzNPRGpL9votGyJZ78U6nlQrtfGExDnVaAYVF7Vf0h/7IiJhWz2IlYVbE8+x+hyTrqpelCD2OA7fDtd0Gl3lP6W7cBc+hCVZMGGQdRVSRcAY5T69PjsXxhykK0FTDXVRA7UkFij6qvGN2A+ddH5NRZyIPn8N/aIfEmdry0eZpzJWILVPXGWU8ghxhNlAprTQk2tH8SEfot90FxLFe+h11umO6we+eYXVl5x9z2SoBmGI6cqTiFpYEE2tWB6EK0/++V4sdHO1VE85HyLGvL/Rcth37nR/Zra1GCp32WONJ0HVfDOU6jZipZptrnvheoG0Otg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twKKIzJUPkYkxrB1xTnr6l68Pzrm+3LpEDAHgIaCCs8=;
 b=Djeg/Dyc/axDWlhde1h9PoanLxlefqNkRvOFCob1q25tvDGUZvwZiv1e4ZfyIrSRpej2nwHxg9AJ1bJzZP99to/f+oPxAvhPWqW3aGG93ZaZ5ZCMMyfFMUZlXSB5jIdUmBJwntp4Bca9NATbr3vZVL0Cw8VIqnXxN4MTMhg2tCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by CH0PR12MB5249.namprd12.prod.outlook.com (2603:10b6:610:d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 13:17:37 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::88ec:de2:30df:d4de]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::88ec:de2:30df:d4de%7]) with mapi id 15.20.5038.015; Fri, 4 Mar 2022
 13:17:37 +0000
Message-ID: <9c075b36-e450-831b-0ae2-3b680686beb4@amd.com>
Date:   Fri, 4 Mar 2022 07:17:33 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 42/45] virt: Add SEV-SNP guest driver
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-43-brijesh.singh@amd.com>
 <c85259c5-996c-902b-42b6-6b812282ee25@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <c85259c5-996c-902b-42b6-6b812282ee25@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:806:126::9) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e8a7088-f709-4229-ef6e-08d9fde159d1
X-MS-TrafficTypeDiagnostic: CH0PR12MB5249:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB52492A19FAC82376A3618592E5059@CH0PR12MB5249.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96jgIg0HysvT2jBLfSQrPqIzuz+B4nfCCoTQC8989U2aqNDU0UV8ja1AP1owYOThtWKFx3zMFkrtacVqgTPdyrHwNev+YKq7ia01wLELnwbT09k5OPJT121r8dRZJCjJS1R2cyy2u1xrJfvpGlZXPV9pKqh4Wm/13RMj2NDN3yM7UngXZk+9jwtVQa8sPIhbPVoYanEs77Z+lzugivBkmK3GDIKfYDJQt1MVBlOliz5w6uZFYtM+0tciBXdPhHJ7b1gjnMbEYU8OTGJGZrw4XIjTd6BvukROnH6dIp66K+h0mQM/kMCc3szZAKU8uF70pz2nHisuFNBxgWKhgylYSIv/QjHNW15GOXwqtw9tumbY3jzo8QkS37gdv1AobjwgLwtRZArsVG5lA+0GESyWnxkDzh2QVf1F3E5ZO8+NBGYDs22tkiRfUFqyeB2jtxfaE87JGnrZJp6vVULFgpfn7orlGs+LW2TC4dLrRD8sfj3WyQ1fGJ5WSVPiIKQbCf1mFNB89AX90z29vvNleQy9sdkaQC2gjI+PtaJm1rZopxEvI7lNXKCmidN9TFQBaMeSYLYsRwxhMVw5W3aOI9MveH5MKYwicrUPZe9C0AwNqV9c3RAf/VrgTsMD/DFIZZ/LptXusiftwlnMjNZIY/C5MJE6RgXkNCRk6dJyVdJtMALVn4ib09E6V9/FMpySNkCKr24FU3WuudnL6sn3fMohxhY4vBFqzOWW/KtNZrxVjq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(31686004)(44832011)(54906003)(2616005)(6512007)(66476007)(66556008)(316002)(36756003)(186003)(26005)(6666004)(7406005)(7416002)(5660300002)(66946007)(38100700002)(6506007)(53546011)(83380400001)(2906002)(8676002)(4326008)(6486002)(508600001)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGpnZzZ2Ni9nRmY2dGNjNnVHNVZ2N2UxTDdINTQyaTRZaXpoWTUweXlPVVBr?=
 =?utf-8?B?SGFYT1diZExydmxhRFNnTHl0QkhNNmxLZFhMczlqUnkwbkphYjFrMWV1NUJ6?=
 =?utf-8?B?ZHBPZm9GSktKQjQrQkw0VmJpa0hvZmpIQ0JYNzBjVTl4aEtLOWV2L2hYTGNT?=
 =?utf-8?B?WkhCSFBDZ0R6SzF0TTVxMUM1RkxwZUdMZUZpNlNGWUorQ3ZuY0RGZTA0RnJh?=
 =?utf-8?B?bjVyS0t3OVJUa1V3OVZYTG5uOUNsWXd2ZDFaQ0lRdDVFcHBaTDhoOUpYYWRx?=
 =?utf-8?B?ZnVoc1ZDQ3dpaWE1MXlnYUx6QkFCSWdQQlBXT2NPTFVTc0p5SWN1dVozbUJC?=
 =?utf-8?B?NGswSnhZNU5jKzI0VUhYa2pPN2VlaTJZYlhhT0NWVXNLQXkvc3kveE1XTVd3?=
 =?utf-8?B?T2dqb2l0NTlGYUZ5T1NIWWtGUGRqK3RBR0ZCU3RPL0plZWRFNUh5cG8xMEhL?=
 =?utf-8?B?THArMnFTRWUzbUszcWtvVlRJRVRkYkFmbm9pTDVUY0ZOWEg2ajVXUGpYT0RE?=
 =?utf-8?B?bWR0cUdrOWJOQmllRnJoSXlxYXRzcm5pVWNlRFdzNUp1ZDM1c3hSVUlTdWdM?=
 =?utf-8?B?RzdZMWloa20ycGkveE1EWXN2MG1CTk1VeEVVWnlhTWVhaTU5TnhrMDJObU9M?=
 =?utf-8?B?UlJ0cHZIRDl5OFFCVkI0WnRFNUE3eDh4eTgwWDFCbHBJb2VvaFFKaFEwNVkz?=
 =?utf-8?B?NFZLa3N4S0o1NDBVQXNuTkNRTEdKZlozZDNKUTU0VWJvWlFNYnowUlI4eU41?=
 =?utf-8?B?Y3lGWGpwVzRra0NIcC9URjF4c0dWRXVEa1pxYVh4ZllpcWNTNit5TW1LbHMz?=
 =?utf-8?B?Y2cvenBnRXI4cXFEdGdVb3BaaG5wZ3ppMEhHVHRUZGtpelBrNGpnMGVDa0RN?=
 =?utf-8?B?ZHg5ZTdzSURjLzFyOXpyRE5FUGFaVC80aFFOZEdpNW5aOHpsTy8xRThFdnhu?=
 =?utf-8?B?M1hDRkYzUWhUc0tHaGtUY0xEZXlVakJoRHNRNWFoY0JrdS9Cd25vWDM1a0Fi?=
 =?utf-8?B?b2REYnRtdFZZQjBrTXArQlN3d0NLOGQvSHVuVDVhVnNwYVFHOEJMYi9ZV3RS?=
 =?utf-8?B?aUxBV1ErVWpFb2NrcVVVWnl1TTBsWm1hRFd3TnV3cXdSQWZlSTVMSExsRlZz?=
 =?utf-8?B?K1lpZmUraDE5eTZFdjdsTkJnMHMvc1o3MmlGMXJEMWhvTUY2emlmSmpOeVB0?=
 =?utf-8?B?VnUrbWNmbXF3TG1qWFZCVS9qVEtEYkhMd3dqRTR3Z1QyUGRXQ1hhTjZ3N283?=
 =?utf-8?B?aTFqY1VERW9tVGRwWGpMckFjZlhrUm5uTStWQWZ0RU5PNHpXeHplYjdsd3Mz?=
 =?utf-8?B?OC8rUktIQ2gwbGM1K0pESjliejRDT0tMQWtRWnlGakF5VEdEN2dTc0NLL2Ri?=
 =?utf-8?B?Q01tUUxidzJwZXQwN1Jhc2lGK2kwZitZNTlPWWxjREQzeVFTMTNlY0h3amtV?=
 =?utf-8?B?QWtnZHhwcTNsbmU0WEx5NDY4ekVZM1NiNm5jNyt2NG5UdFJXcUp2SVZvVTl3?=
 =?utf-8?B?U051YlM5bEFrSGhUTXpxMnUwN05teTVYU05EZlZHalpLOGt6dFcxYUw3VzA4?=
 =?utf-8?B?dnRqTGhEazl5YVNUUm9STUJPb0o0Z3BnVm5kdGpEQ29FN1NNRkZId0xyRW9y?=
 =?utf-8?B?V2QvSm5NOUlMQlNsYTYzQy9PWVhlUjlRZGtQbzJ2a1dwbWQvVFMvU1FCOTFr?=
 =?utf-8?B?c3llQWxpbHZ3SDAyUllpRm55OThTbmw2SWxzTXZBVzc5V3ovU09HMkYzRkph?=
 =?utf-8?B?N3BlQ3ptYmxBUFBmclhoRlE4Yll1Y1lGdS92OFdOZFEzYTloZjBreHhqOXNJ?=
 =?utf-8?B?SXVnRUlaK0pHSlpCaDhTVWpDSmx4a2kvbGdIdElWdllWVGJ3cGpTU2RjYWE1?=
 =?utf-8?B?RDVlSjN2SDU0MEtaTFhFUTFicFJDQjZNUHIra3hFM043c3RrbzdUckNhSGhE?=
 =?utf-8?B?ekpkMndQcjVMaWZHNFRrVEE2ZVVsREk2R2ZBS212VjBYNVZydlFRc2EyUGdZ?=
 =?utf-8?B?czhwSnpuNGVXMlVnN1RxY09Td09VMWxOZkg5Wlk4SEptaE84eGdoUWVJSWhT?=
 =?utf-8?B?L1l3MmdiYXlzSFdiRDJieGxqTVpKcmNtKzVmemJBNFNLalhFWTY2TXRRQThC?=
 =?utf-8?B?Kzl3dFh0aE5LeFZYUm01SkwvazlTYi9wamtiWTN0MzZiS2Y0NFpjaEFMRzlu?=
 =?utf-8?Q?z7Fyy2gHdLRcZvzp6w+2obo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8a7088-f709-4229-ef6e-08d9fde159d1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 13:17:36.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Rw651DkrEqPLH5OCgZ5O+Y4OAvgLWwF0BKs+VcNX/L/wWMmJ9C23fPW9G2jVN6sAgkARyKH3Fu0KarUsvVabw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 3/3/22 11:33 AM, Dave Hansen wrote:

...


>> +	 */
>> +	if (count >= UINT_MAX) {
>> +		pr_err_ratelimited("request message sequence counter overflow\n");
>> +		return 0;
>> +	}
>> +
>> +	return count;
>> +}
> I didn't see a pr_fmt defined anywhere.  But, for a "driver", should
> this be a dev_err()?


Okay, I can switch to dev_err() and will define pr_fmt.

> ...
>> +static void free_shared_pages(void *buf, size_t sz)
>> +{
>> +	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
>> +
>> +	if (!buf)
>> +		return;
>> +
>> +	if (WARN_ONCE(set_memory_encrypted((unsigned long)buf, npages),
>> +		      "failed to restore encryption mask (leak it)\n"))
>> +		return;
>> +
>> +	__free_pages(virt_to_page(buf), get_order(sz));
>> +}
> Nit: It's a bad practice to do important things inside a WARN_ON() _or_
> and if().  This should be:
>
> 	int ret;
>
> 	...
>
> 	ret = set_memory_encrypted((unsigned long)buf, npages));
>
> 	if (ret) {
> 		WARN_ONCE(...);
> 		return;
> 	}
> 	
> BTW, this look like a generic allocator thingy.  But it's only ever used
> to allocate a 'struct snp_guest_msg'.  Why all the trouble to allocate
> and free one fixed-size structure?  The changelog and comments don't
> shed any light.

The GHCB specification says that a guest must use shared memory for
request, response, and certificate blob. In this patch, you are seeing
that {alloc,free}_shared_pages() used only to alloc/free the request and
response page. In the last patch, we used the same generic function to
allocate the certificate blob with a different size (~16K) than 'struct
snp_guest_msg.'


thanks

