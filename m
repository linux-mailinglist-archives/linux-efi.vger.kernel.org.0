Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A845411D7
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jun 2022 21:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356076AbiFGTnB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jun 2022 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357686AbiFGTmP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jun 2022 15:42:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351051B6073;
        Tue,  7 Jun 2022 11:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G59KHa8InL+Oor/o+GmrUBxIC4IONIIxUM+KgX1A/iljalFzs7/sXipIHVheQLQZEHrlkbOyj5FPLUcI9uYwReXJUTi6wCY/GBplYTZJpcNH2+crIyVGD42LNUin9DFLTau4Dp3ag1FqGVvOkr2BfHdHfIgwbTd/ppLeZPB4+9b+cA2eWYEFX7hyrrxhThcEVKWLGSS2oIJ80PboXVNQyUgs9KRbOsylKPhdQaPYoBCq4fwEoCyYKoRJUOp948QHF8gSEUH7zXQQLAhO2OYl8p9Deq/a8/p5RWWzbbT5fS3A9x0/L/hPidlZHaN0763E5vkgKsPh180FyjFdm3ooiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4ygYA6d4RP8CcsWZq3eiymRa0OdRNUFYX09eAlIgIQ=;
 b=KvhXyEuGUHe7vXRr6L76rzs6wri6OpiW9YyGDOulD/XZugdh6ugDGoeJaO542xQ03IG+SH4ndbXVccjqmVPD5cCSdx1TAbgvT0+SM9YKD+TeWkqiAKFm7aB9IRJgffQe0By9qhlAb62zEDXxWyd7VjdUBAemX2yjiga2UOID11NDQ5tqWU6QYyj69Xx/yF7Fgoux1E7f/fVkeRRXcHLJmp9mZiFdHbZR4IeXbUO5nXhCpUCCXi/DbYBZen2I6WF4BUXS/JdScdyuFYt3ZHD3RKOOlUKbbps+Vn3swIELi1+t0Kj+b/jffUA8SYB/2DUija0HzTR8lNOsQ7UZOTd/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4ygYA6d4RP8CcsWZq3eiymRa0OdRNUFYX09eAlIgIQ=;
 b=As2m4kRPlK5HhQiTSw7ohdgTJv7Q+ppOZ8wT0ZTMFimdHjxPn9a1YXiJz1RtMtncZrMtog/KsqegFn8B5Cx/CTj4HMenfO1S7o5eXWFo5bKaMXoZLzt4cVYL41JkBwqeKhBYg2D6yHEUtfECEtJfEw6Bx57+C5sOrE0VgMHwXWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by BYAPR12MB3591.namprd12.prod.outlook.com
 (2603:10b6:a03:dd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 18:15:44 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad%3]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 18:15:43 +0000
Message-ID: <429bf665-b8a7-2d1d-cc54-a50369e5abaf@amd.com>
Date:   Tue, 7 Jun 2022 20:15:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     "Xu, Min M" <min.m.xu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        "Gao, Jiaqi" <jiaqi.gao@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rodel, Jorg" <jroedel@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
 <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name>
 <YnpGnMoviGoK4Ucq@zn.tnic>
 <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
 <Yn4ed1gupKmNz2jn@zn.tnic>
 <20220513144515.fx2cvo3rjued3vy5@black.fi.intel.com>
 <PH0PR11MB5064B561086BE6350CC1DCDCC5CF9@PH0PR11MB5064.namprd11.prod.outlook.com>
 <CAAH4kHbU4FJ=veYQxncdpYD837M90vq2o2saVaUCJ6=pfuNRpA@mail.gmail.com>
 <0c545c5f-3540-1441-7a7d-359b6795f43a@amd.com>
 <CAAH4kHYj9WOKngeXYL=KnNb1fXa-MaFGTBGZcBX726Od858Q3A@mail.gmail.com>
 <19ac7bbc-82f1-8350-8638-163303d682b1@amd.com>
 <CAAH4kHbPyCAxwQgqPpgDQ3bEioHZ+WboUMGTHazxC9f9jEEwWg@mail.gmail.com>
 <CAAH4kHYn=pyFC8ZZ08hY0rBDL9g4XBnxbMVXtwdju4qCLMetuA@mail.gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <CAAH4kHYn=pyFC8ZZ08hY0rBDL9g4XBnxbMVXtwdju4qCLMetuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9P251CA0013.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:50f::15) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a285d2-b083-410c-698f-08da48b1bc6f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3591:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35916F698DF79D855AADC3A19BA59@BYAPR12MB3591.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BhbFVTLDN4GF2J7nj9wz4l5LAzO7qQKV39sfAPeoz+W5H98Sdza4N03FQAtksmPYlGHPfOmsOXPDjMxaEc2m1TH6fBW7p07cKoEPGPBrb/pELI5/Q6hd9iqfGMpdr4kA1WVWEDo47lHWELNOE+WiKc2VEuSb1QsJQQcpJc4jEKq4kODscAdFU/Orn2mh/jhmCmNyvwXaAx3eI/ytswtgCrBS223s74eyBh6hvr4RsMBqsBeXof/tzT96UFtCdKq7Bl9ml30yRNLVkGvKY9+Meq6fQPejy8uJ53frAGaR0M4ZlWe/rAnmyS9A6xWB8ilNYMK9KWXs7dU3mKDUIZsEOvipseIz9nv6YiVR7BtG4257jOLbkwhSXdyQY6qQESzepmP9b6TWD/TFTPGkTo/dh5Zx43WlKQdo+iTVuU6GmHpYDKYpZ9GqlYT6IZA+oDxIOOEPHv8p/Hwm33PAfsFJan6krk4ptc75r3fw6aVWCqb59zpTCzKQuWWc304gtohhk4FXICJUAy357iQVPNt9rn/+Xp8asUKef1sOVbW2x/fTA8EWb3Lexm0nTFX0zV/68vFDeyqgJnQ6V7ymJ9PxBSrzmetSbuJZuTP8ffruQrYop9PG+B0Y887DEiVnTSyGeM+B2x04mPsX7ytjY6rJMJ2+GfS/jRwN5nfAu5JpZEuTETwGVmhu8eGqdE5G3jPQlkNbuI3goERNZKzyEmwXzVGSZZqKWMj3vYAXsxeUWsE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(38100700002)(4744005)(6506007)(5660300002)(86362001)(2906002)(6666004)(2616005)(186003)(83380400001)(6512007)(7406005)(26005)(31686004)(8676002)(36756003)(6486002)(8936002)(31696002)(4326008)(66556008)(66946007)(66476007)(508600001)(6916009)(54906003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aSt2Q1pmb0M4TkRlMHBobDFuU0hPRWg5dzB3TVF3VlNnOHF1eFZXM1liRU9a?=
 =?utf-8?B?SmI1aTJJRGdKZkFJWmx5U0RLUHUzVWdqQUJ0RkZGdGFURkhWNlk2bVprRS9r?=
 =?utf-8?B?TWI0WmhKaEtNZkFYZWlLSGg3aEhCVCtCYktFR2piUG8xa0Fld3ZVT1cvK1RM?=
 =?utf-8?B?RkZTKzhBYVRvRWkxYlBXcHJmbHBPaXpIaGRlamVxWFlSVmo1bzZScWozOW1U?=
 =?utf-8?B?VTA0VHZlcDFwMGMwMXNEM3M4MTRKbUp0YmtDRTY5cmlVNlpSN1YzYmxvRzZO?=
 =?utf-8?B?eTdQVjBlRzhzRTdXSjFOT05Pa3lvNXVrbXZFeFY5MXluNlJWN0pSTE9iZXFx?=
 =?utf-8?B?MFZ6Mi80UHZseFh6aFNPOWRUTHZlWWRTaGZGV0QxWDFaTmFVMG1jYVp0TTkz?=
 =?utf-8?B?RHAxU1hnc1hqeGFPVW1mSmJ4SVlWeWV5SU1VUm13NlBNMjc4ZlVUb2hIRjQ4?=
 =?utf-8?B?TUVMeWFMWG84bXNJV2xIY2NOcnVwQXE4TVpvclpDWlliS2VVMDRFRmlkUWVR?=
 =?utf-8?B?QjJSN0UwcVRQNHhwQUhzMEpsU1pFckNwa2JwVUk3VGJ3ZjVQRHZtNnUyUHRT?=
 =?utf-8?B?UVZnZ2ZscUJMMytvVUNBY2JydDRyMmlFTVJRUkw5MlQyRkQ3RU5iMlkwdUJR?=
 =?utf-8?B?NGNobjJtSDg2b3JEeldDaVRaZm9UOTVza1hiTEpkNGpraTNSQkdKUU9wTzFQ?=
 =?utf-8?B?R2t5czd4azhHQStqQ0VJc1lpeW1OWSt1ME5LU2w5UktJUUo1a3VhSVA2bG9a?=
 =?utf-8?B?dDJ3azBxOEx1c1ZWRHI0bzlZV2VNblBoWGd6L3gzMlQvNmRoVlBaaThDY0Y0?=
 =?utf-8?B?RW1xTmZpY3JJOTdtVmo4dXN6ZUVEeW1YZElka3p5SG9yVXdaVFp4dmdMQjFv?=
 =?utf-8?B?Vy8zSWlhTXNETWk1WmdxMUNENWg4VHhOTHZkZ1BzU1pBZ2ZEYWphYU5MZUJl?=
 =?utf-8?B?K0s0THV4d3NKM3R1bjA5YnJrOWtGNkRDWVM2ajhUYmtYYjJtaUt1TFdaYTB0?=
 =?utf-8?B?L2U1UXlxOU13VzUycE8yeXNpNDN1a2lIMFg1MC9zWjFRU1FBRFNHQUlrRWRF?=
 =?utf-8?B?d2oxWFFzWUI2ZURYRzFQL1RsYStpeXRkdDNtdzVsZTdxdExTSS9yOUl2bEx1?=
 =?utf-8?B?VitvbHpKT2xuSkJmVkgxTGs1cmZpeDd1cEM5K1dESkwrRDYzU0dKOHc2WkF6?=
 =?utf-8?B?K21NUzV5VXZZMTlRMkdMNGZFSVROaExmejhXVW5HK0MvdzRmSzRDZEpVQXJN?=
 =?utf-8?B?NmZ4RzlYc0VOV3lkK0lnWW42VEVZY1JRaFkyelBQSlZJcFAvcyswSlNDZDVI?=
 =?utf-8?B?T0pjL21iemdUbmNyK1QreTZCaW5ic2ZTclk0OEhoODViUWV6S0RLemlRQU0z?=
 =?utf-8?B?UjY3a3hwUGx4THE5UExPWUJ4VHBIZHVYYXgvd2VuKzF6aVVZaVU5NGFCbktY?=
 =?utf-8?B?YTJJYmpVS3hnYTlFcUJhS1FNZFEwd2d3Q2JrRTMvNk1xeWJhYVdUQ3NDcVUw?=
 =?utf-8?B?VWJsRXM3THBXUXk5TG1sRkJpNWd3WFlVeUlicktSalNXQk8yMHdlN2Jib09v?=
 =?utf-8?B?N3RsSVNUUWpPY3BFTWpwdXhsbTIrSFFycnNSdFRKUUwxdTRtMlg1Y3BpNVNR?=
 =?utf-8?B?cDBqR1c2TzdvaVQrVkxxZmpzZ3d0ZW9MWmlKaXN1aVZGRUxrTUpVQkJ5M3Qw?=
 =?utf-8?B?Wk5tZ3hWcDk3ZWRLQ0hueVlKSVRGZzlMMTJPZnZhNjNJWTAxblNmTXhSOUMy?=
 =?utf-8?B?bXRlRjk2R1dDOEtXcCtDZUcyczNLY1E0MGozZGM0eWZhT3lNMWJPQnhoMy8y?=
 =?utf-8?B?Y2JpNWRVWVVvTFNucU00MWFqRk9MTXc5RGJrUTM1UTJCK1kwRUNXYWFCQ0Nh?=
 =?utf-8?B?Q2JOY2FLUEV1cDEySlZiQnNxcFFvSjhTN0JtU0hibmtrTDFKbkU2THl0OGtE?=
 =?utf-8?B?c1ZZU0JBbmphNzFTUjA0NTM5WGlRRWxDREM3RUw4dTcxSSthU0hPYkpSNGJ5?=
 =?utf-8?B?emhPRFdFN0ozY3VwNElKaG80LzVaVWVSZ2xja1VUUm9jSWFiRDBsZXpPdU5v?=
 =?utf-8?B?WTlJMTVXV3NCaWxMS1RnR09KOFRTUTY5OEdYQnk3aVRudGZOQzRIQ2FjTzN2?=
 =?utf-8?B?NDhMbWtFRG82K0hoeWtXUkdFbEFjZit5TG90WUxXK2E5U3RrZ3pNcHA3YSs5?=
 =?utf-8?B?eWY1QjJyMi9xU0VaaFc3MnUyNTY0T3lFTmhuQTJWUVVpUDBaU01xQittczhF?=
 =?utf-8?B?NFJBT0hkUXQ1Rk1mQXFKZ3l0SHEvRXFXUUNwK21qSDNzdlBmczlFbDZHSlZD?=
 =?utf-8?B?UkxLczBEeGNGSzBmTnNZYXJ5Q2hUbWgvVzJVMTNxdDZCRG9mOXpSZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a285d2-b083-410c-698f-08da48b1bc6f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 18:15:43.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omIdRxvflcwFuXXc7/ubSOuoNxrTbatjoVEJprV0BL8emzoVVOHbZkhcwU+NWQkvWPTMb/YOuHjl36Adt15W/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3591
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


> Testing error on my part. Was using an adaptation of an old patch set.
> With Brijesh's SEV-SNP support adapted to this version on top of
> SEV-SNP guest patch series v12, I have no trouble with passing our
> memtouch test.

Ah Guest unaccepted memory validate patch was missing. Good to know it 
worked for you. Thank you for sharing the result.

Best regards,
Pankaj


