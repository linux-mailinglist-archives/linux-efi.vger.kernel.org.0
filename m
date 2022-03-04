Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CFF4CD82D
	for <lists+linux-efi@lfdr.de>; Fri,  4 Mar 2022 16:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiCDPoi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Mar 2022 10:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbiCDPoh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Mar 2022 10:44:37 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E666D965;
        Fri,  4 Mar 2022 07:43:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkBvZU+WBHucaeYygub8570DU4rl7EaOcUf3Uts1Wh9JhLA4ZUqed5Q0G4O93UhN0BUEiqhJiHH72aHwnm/EY91rhh3Mff4WBKjcUJ/bHwpA3x6q5rzg55jPbPuG4hVsoSUcOzzflOS2lle5eJp9iSV3tBiC+bMaItq9bsCCls3iUKRw2vFYMUZTV8sbPI9wKcJ5z/qaCZLAe5FhyEJLp+/ColOYSSPE722BLDmASx75ecY5UQ5IE8w7dToGdjbOtjRE1G9Hcd7TMt7hKfXkV6qvn9HRMAUHeiSYgQQtoEnnDN9xUZfB1X0LDPPgNdpQCebQ1S9uDT0V0VV0riY7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QQf/XatgYheSBBA3OxQYJAaGJrKG0oDIzt2XbRZOrE=;
 b=TlVo7y946DcGemuzp09jxJ/T1f5hqz4HazLwsyjW0M361R88aNWXedTAFOZ0zhapZKDNQVKlRIPPNHcwvZ8eZGT2GD0IhlZyhVNfqz4z/6P9Ms9a6AfaOM7q335mhLETFuOaOp6TRs+y52Ljv1PREnGQK0ZCezDtTJXShVzPFlpPLpBsjYYR+3XuD/PpgsizmhY0IhfXoqLL7C1SGur25E6Z5a7/P5AGzSkqHwiS3NdOGHcI98wwiAZMP0nIgzP6s65vQWx0XL11T1fsR/TtoXFEAlbsLtv4yfRr6I/N/48rRUfCPPiwWRyORHQ+6zHZ1/QSmR1yLq0HjNTvfXGn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QQf/XatgYheSBBA3OxQYJAaGJrKG0oDIzt2XbRZOrE=;
 b=Dy93q+Eoff8QyWHvVNDh7jx2PhXC6SxJgC0VwcwTz5TaRxaahzY71aPG5wU2P0Hwoj8BwJEFo1W3m/GCTLLdTSppcmCZ4P9IL2s4goN94hq8WYElkNTvN3athMDDbo1zy3tX5KsihA7EIG3X+NY4bTdzdMQHy5PlcZ2rtU6hUOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by BN7PR12MB2674.namprd12.prod.outlook.com (2603:10b6:408:29::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 15:43:46 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::88ec:de2:30df:d4de]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::88ec:de2:30df:d4de%7]) with mapi id 15.20.5038.015; Fri, 4 Mar 2022
 15:43:46 +0000
Message-ID: <2632b2e2-2224-9f6a-2ca0-cdaef3a24cf4@amd.com>
Date:   Fri, 4 Mar 2022 09:43:39 -0600
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
 <9c075b36-e450-831b-0ae2-3b680686beb4@amd.com>
 <bd52a9ed-c44f-989f-60a0-f15dd4260e09@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <bd52a9ed-c44f-989f-60a0-f15dd4260e09@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::20) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fd659b7-c27a-4854-8dc2-08d9fdf5c4ff
X-MS-TrafficTypeDiagnostic: BN7PR12MB2674:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB267416119AD352B26174B188E5059@BN7PR12MB2674.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxvFSLnxDG1qHGncVYilV+OeDHRkPZKGoZiIjQEjo8MXhNyKpFMz4+rKvTroDp0W9p8tTyY21t6iAjqtOgD+5ASfK1+W1mfoFhVyY44paYewzoKTinaPu6FK4YIeYoovnFfgEIVFGRiuFCOA4uEDSXQlF+miqeRFeELrQsHQ231LIjZfe/C7O5yAYHRdz/uHhJQMki7PCESSwzhTHaVEVhMHaNk+CmQx3aA52EwYEMhVoE+EfiZ1b26RHksx2fx1ON4eGlym7xvpeuKPPzKHOVaLETqLUP2cj/t36gB5jhBncK9ZveaBCtlZPU2sJQMF7Z2EwB+gm4uPAfCjWCut3TXj08/gPvzN0QjEWCQunIBoMU4A1qs4NSBHnMDi272A+7zJCmwcttgbZaaDM2gYh9DKpGPV1Suk/VH6TLwNl2qvybx8H77DSJ1eWpdHSF6Om85nqD2R66SAEdA5lf1pmclmepMyXMzSnIZbQMTCrRnr8w0oPrJjJQ3iQFLX0IM+pIqT1gsTkdCQySNd9hiQwBg85CFKlEAR0QIyOMj6DbaFxc6j71DVcpM8AZZeDrVFWTKB5eCcROExYjL6nauZLCdOwdNe2t5AYLVNf/+B/6xtbHa1N8HoNQfY9TgI1JXhKgrOk9LxzdwHEeg9CN+RAvHZ/PoWTjsGwujZ9n+peFNBOuT604zHTKUsGn/AFrtsiiWrZ+51m0E+XA/ZMe3tZeguDJ25cJoIvkgs+y05eAdPAkhPpfWTdinQwmzNfiYw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(36756003)(31686004)(2616005)(7406005)(186003)(316002)(26005)(31696002)(6512007)(83380400001)(508600001)(6486002)(53546011)(54906003)(6666004)(8936002)(66476007)(8676002)(86362001)(66946007)(66556008)(4326008)(6506007)(7416002)(44832011)(38100700002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnVGL1BnRWlXeTNlSTVKTDAxckl6dGVRb0lENDRuOGg4blg0ZStaeU5FbWpr?=
 =?utf-8?B?TjhMY096Smp2ZjMrOHU4RkE3dFA2M0g1SHBjMFBJbzZDM0FZYnVrMWhMRFFL?=
 =?utf-8?B?UFRIYXlnSU1vM2QzaXpDSWRLc21PcWphcUczNVZPdG13ZTYvWW1kZWYyMUVi?=
 =?utf-8?B?S3Y4N3VsWStHZHYrZ3h3R084NFRLZ1J2VnJIRU9aQ0pnWmh2a29vM1dZTmN4?=
 =?utf-8?B?eVVjOWVhSzArOUJiUzU0Z2M0SzhqRmVxVkVyYkxYclViRUhlbmNkSHZkRWt4?=
 =?utf-8?B?ZHFicU5lQTB4SEE0WkxQYkUrZjd0dFN0RFJYb25IcC8vU0V4eUVtOHJkMHBL?=
 =?utf-8?B?enU2am5FaGEyUUR1NmgxcDlqV013bk1wazh2NFRNT3hDOTNHdXk3dDFXb09O?=
 =?utf-8?B?dG1xRUVld01Tc2pvTzU3WmNabzdvRm8xV1E4RUdCeUZBREg4dm5KeDVNQU8v?=
 =?utf-8?B?VTVxRnNTa0hGZERxbU5RVkovYWwyNi9idWRGWjR5TFZ3RmhwS3R3dG9iSDRK?=
 =?utf-8?B?YlhKVFZGVG9RYmNxZDJ2NnZiYUlWNERHVjNsQ2s5eW9aeGxycVRYRkkxS2dy?=
 =?utf-8?B?aHFha25abHN0RkNJYlBpcVVaZnAvaEVWZTBhcXRUVlpsdllHbFVKemhwQzR1?=
 =?utf-8?B?MnF1NFBqbm8zZVpPSWZWdWEvWlF1eXJyL2gyNXZSWTBOU01nbk5TYldDcCtI?=
 =?utf-8?B?ZFN3Qm9GdUNwY3dvSkI1UE0xc3liY3pFWm13M3crZkJWOEtpYUg4SWovYWd5?=
 =?utf-8?B?a2NPQkozYnFpQjNHWmh4Q3FPMFYwbXAyZ0VOQ3VNVUlLUHdwclBzb3NneTQw?=
 =?utf-8?B?ZU5Yd1Z6TDJOdGNNMEpsVEh4dUlSQjlPNUhOZHpqWGRTTENlWlBTSUx6Y0tT?=
 =?utf-8?B?NTRzY2ZPS0h6aU12aHVPSGRVMmJUNk1rVXMzUXVDRTVzKzlaYUxqRFBteGxv?=
 =?utf-8?B?dE5uV1h5Ymx2ZVhxQ3VLOExXYnBuZ1ExTU5sdVJBV21DTDNkcFo3dEI5d1Ri?=
 =?utf-8?B?ZkVEOC9JZU1iMVphYTVINjFqSmhDSE9IMDVxZE9EdHVJQ2YyT0FQbnRPQ01R?=
 =?utf-8?B?MzFrZkF2emRiZjY5YmlMZzIrRms1S3doSzNwb1hLakNRZXFMNzYyaUh4Z01S?=
 =?utf-8?B?S3BMd2UxTDJMNXBraFQvTWVMRkhhRlRkc2ZlMjhtMnRQK0ttSitxQTFMK0Ix?=
 =?utf-8?B?Sk11bldReWoxTHVuNU1nOGJJZ1NMR3VSOTZmRmYxZ0NnYWJ0dXRzTnlZZEJU?=
 =?utf-8?B?MFZtTEliZ0Y1QkZPbThXMXlLbWNGUkpNUjRsTWo0OUJoWm5ZbFhwOFZoWkdt?=
 =?utf-8?B?M1VLbDhzUW1tMWlkR3NTa1RmamRpU2tiNEpmaHU0YUdRYkVUWE94NTQrRWN1?=
 =?utf-8?B?dThqMFFjSFpUVEp6NnFGVno2bXBKNEd0Z3pHVjByRGgzd1ZPNkxsRzE5YTYv?=
 =?utf-8?B?UkJOWjJVZnpIVGhublFMVjdZT1ZObkJERnpHRUt5c1JPWHM2QjV4YkRXR0hW?=
 =?utf-8?B?andBSW1DTHkzRitBc2tJaTNJbHAwQ21xdnV3cnQ4d0ZzTHZlNGpodWd3M1pW?=
 =?utf-8?B?b1BlVU5ndytrelRLalZVVXFBWlp0dWZrZ05Wekt5c2tNM2RHTnArMTB2dnM0?=
 =?utf-8?B?SndEaDlnalZnSmkyUG9MTkRrK0JxanY0aWJjUWtyMGJZSjFMVFoyaGt0d1RJ?=
 =?utf-8?B?aXQ4THJSM0pvMnFHRWM3ZDFybUw5Qmt3b21Na2I2TXVtYmNOclRaS0Y2c1Fv?=
 =?utf-8?B?bXJkNlUwaGNZOG1qQzh6cXgwa2FiUzc1Y0RrU3NsYTJaczhmWkg5Z1JrWUht?=
 =?utf-8?B?Y3FOQkxFdnJhMXJoK0VwMWFYRkdCZkVoMFlEbVh4SGNaRUx6NExtaVRzYlB0?=
 =?utf-8?B?Umk0RmRyb0YxcEpiS3p3NGxYdHRJTGUvVjBFM2MyUWNRdzQzdXRIeVlNWE9Y?=
 =?utf-8?B?ZjdKR0xwbXoyb0Y4aThvUXMweHVDbVZBb082KzNaOGNhR2pFdmlDTlJOT1dU?=
 =?utf-8?B?Q2FZWWovb3pLeW1WZ3dsaC91OEFGbnJVbEpqbmtSRVc0VUpMYmhyQ1JvbG1B?=
 =?utf-8?B?ZDJyVjRYSVF1MTlGNHBTRjhuZmdLRUxFekpNZmJuWXBMSjZoUnY2Wlg1K2pR?=
 =?utf-8?B?MVpucEptekdJbFpOUExXcElybkJPOVNzWUc2ZmsxREQwTEV1ekVaNDB2MmRE?=
 =?utf-8?Q?JelZl5nhPgDaiK3D7bkX8Fg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd659b7-c27a-4854-8dc2-08d9fdf5c4ff
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 15:43:46.4470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WE6NHfpZY1JHgiEE3Ewg6QI7mCS523BUHVoyqkG+OeRbpxaYx/kadvh2Ppn+FhB2oHKt87iKbRW6ZS1dPCsgOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2674
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 3/4/22 9:23 AM, Dave Hansen wrote:
> On 3/4/22 05:17, Brijesh Singh wrote:
>>> BTW, this look like a generic allocator thingy.  But it's only ever used
>>> to allocate a 'struct snp_guest_msg'.  Why all the trouble to allocate
>>> and free one fixed-size structure?  The changelog and comments don't
>>> shed any light.
>> The GHCB specification says that a guest must use shared memory for
>> request, response, and certificate blob. In this patch, you are seeing
>> that {alloc,free}_shared_pages() used only to alloc/free the request and
>> response page. In the last patch, we used the same generic function to
>> allocate the certificate blob with a different size (~16K) than 'struct
>> snp_guest_msg.'
> It sounds like it's worth a sentence or two in the changelog to explain
> this new "allocator" and its future uses.

Will do.


