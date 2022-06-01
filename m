Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336F353AA77
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jun 2022 17:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355701AbiFAPtf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jun 2022 11:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354914AbiFAPtd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jun 2022 11:49:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEA8344D9;
        Wed,  1 Jun 2022 08:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN24WELSKda6Rl2W01hswsx2Q1QOaPBxN1AMtPRKRxjfzWpP6A9kFbA3g8XUtLEUjdzclCLsJUtex3F/CrRCy+lBDMAImFk0wbBo1P9WI3/R9rZGBfltkGYMHAM4sMxg0HRKlDC6rsOmm/zFcn1XAVcnUYZxPJnI+/DB8b6nPl6pJXdMeUKfcYKf3gZ+HwSuq/fXVlvOBJiKcxgpfCPSmBQyqtt3y5CYz2w2wp0ZfpMFMlRa7dei5BSMC8QIV26fQYYRQD7b44d8z3gmJujY3H+sbwuobe7EAN7ujQ+R9+Mg0UX8EnecWiRtJK5Zc3gRFOfT9s01rsseSfZTl+Oe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjA4DXHMoCYarnygxuS2WOHQDvowBGE+B5xVym3MevI=;
 b=etD/QJ7l0cqpXhqktnAnEtZONNoynx7Hh0+/Ydcbk3HUeibds/54hcm9Q4NiG2ahA51vZ9LvdOROC2Le7hBsbnPJpZw8r75da/UZNAmSwjvJ3pJjHjTouXWCycq7K6YacNROfi1np0KsSQAXO2czk0E7DP0vxtrlu4vUB0505Ofc45ZfRIv+SidQpmGSVsWBqZKBIbduuWJxX/zHMElrq9HbUUFzUkfrkvYwCB1NDlgL2TiwGnzkOBpk6a4TglxS+Vqnw/fF2LCa6sixHtw9pRacaHdjZRYyVtY8dzw6vDAukESbCxYiJE3jufhKyTq65NTOfEjTELBQQq4O0/gROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjA4DXHMoCYarnygxuS2WOHQDvowBGE+B5xVym3MevI=;
 b=0+IrrihM2dEMpBaZu4xOidXbEVq6ja3VtihD9ilwEuPInF3owq8lGUil5HOe8GVA1RlBxjsLOpvIqG9HtVw+IuZDrdxeRv4q5Ri+BpDRzMheB/EHFXJ9ZvyPsXwFDNd2Yyp3L2+t4Ipw2F+NBDb8s/fWqLsGRXQJEdvojiNCu2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by MWHPR12MB1229.namprd12.prod.outlook.com
 (2603:10b6:300:11::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 15:49:28 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad%3]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 15:49:28 +0000
Message-ID: <0c545c5f-3540-1441-7a7d-359b6795f43a@amd.com>
Date:   Wed, 1 Jun 2022 17:49:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Xu, Min M" <min.m.xu@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <CAAH4kHbU4FJ=veYQxncdpYD837M90vq2o2saVaUCJ6=pfuNRpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0724.eurprd06.prod.outlook.com
 (2603:10a6:20b:487::12) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c3e2f12-2c14-4c94-2f22-08da43e64f16
X-MS-TrafficTypeDiagnostic: MWHPR12MB1229:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1229AE928BF953256D7517909BDF9@MWHPR12MB1229.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jpbgl9oxzxB7RDlFN1qiDgtSLNIjX13MXc4iTXHbqSq0tT38PYGrdF2q8g0BkzhrKklpsv49+fx15PjB9CKDF/KmYx6PRDBTAmLHaWPb00WsAEurRPJVhMwqGBOPrdgLSibUo9mFzntoeDjmPbqCBH5fYFmg/EAPhD7HmVtD5KthOnpGVfD302Qk9J9YRTG1J9JEYOBJQfrDWFXRyglUiaqyKUZ2CiuloauzstPYXzSZtKjcBrd1JpCB+Q3tDC6yQNo2rwK++CaQmf06Yyh9CBjLLBSj7k8Zkumi3qjKTZKGPKXO0jOAUwyurjwg1+3gw/TP0tpE+9MTcD5CbM90kH8SRuAX28rF/wj+NJMb7UF+3XPVGLq27JkV7gjnRvzytCma5PPZYFzQ3HjH1QHtzolNFpv93keo8mkL8GLAt8WBqkD0f8LSE5m15IKX4IMd+kyEh+skAEAeWXZx8Xi2qcdpIFCeCozwfxHHSfNJpohDG8ll/qNBp7Y/13jLGREEp2loqc9F9dtEDUflUmFhL6Wk+PQ2G1H10WAZW//fv0UyiZeUZm9KwGX9WLCTuZVB7hMj1l4UX/xwr29CegzoWcVceS/a4zsOBpnNCGZwwl+kEdoYpGYiSznLRXdZ9SfB5CVgPfUzyWJuqpcQeCKk0FUBb/XtofSZNicWb/baKK48+/osGXq+qyG103TIwTB0fUIveU+Gx4011PKLTUbs0EF9ASKpa4IPmEaVretWD2xyIcdnwgSCS6yFD9RlOcqGJ5ICRDVYsBP2cJmzP18wRMbDcdap9y/UVlgPYn0fYo+2N3IGpGYPPJJKvhnfVkpYbNPY3bdWdKHMRtWfurVKtjqP+K7LjZdzBBGF8zH4rus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6506007)(31686004)(316002)(2906002)(110136005)(53546011)(6512007)(36756003)(83380400001)(4326008)(7416002)(66946007)(38100700002)(2616005)(5660300002)(86362001)(7406005)(66556008)(66476007)(8676002)(31696002)(8936002)(508600001)(45080400002)(6486002)(966005)(186003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmFFc0JmTGpsMitEdEE5d1EvUzZVaU5BdzlaYytRMUFrZm05TW9iZTA5N1hh?=
 =?utf-8?B?ZC9LV3ZiY1k2cCtJZm10MFVrYWNDK252R3l4RlNuakxmWkJCdlJrMmxZOEpX?=
 =?utf-8?B?eHE5aTNKNVBUS3EzcTgvQzc4UnpDMzhyd0FhVFc2QzFtQUl1ZUEyRm52S1cx?=
 =?utf-8?B?OW5WU3NEK21QNGt4QzJNaDVGOWpZRjVuZ0xRS0I2OC8vc2ZicTBqRXIrdEdt?=
 =?utf-8?B?bjgrd2ZRazcwRVhkUEFSNHc3WUZLNGl2ai9RWlhmUGpUQldpVysvWkJDS2tL?=
 =?utf-8?B?MVo3alBiTWdTRTYrbHRIWEN4YUptekFnZTk2MUlnUm5ueVdTcmY1YVhJQ1lL?=
 =?utf-8?B?bmpNTmc4VDNOMlYyR2lrYmpvK0Q2K1hrbU9DU0R5cDk5WDV2V1JjR3hnUldL?=
 =?utf-8?B?MS9MWkxVSlg2dVo3YjZaOUh2Qy8ydm10QitVT1VJcFVySCtVUExtS0h1TkxL?=
 =?utf-8?B?ajFWdFdTdW1GUGtxQm1MWlVXOHRQaEVKQTdaalpjQWVLT0ZDd0xHcGVBYlZw?=
 =?utf-8?B?R3Q3N2RxN293ZDhVVVpWV20xSVZGclY2UHhrcXV5b2VFVzZiUUlIcG82bkZp?=
 =?utf-8?B?c1l2bHNqeXpaVXdvSlNmbHpQSWF1NG5OcVhKWk9TZ0UvbmxUWG96azQ1ODlT?=
 =?utf-8?B?RFArR2tPRWpxeEE4N0ZET0Y2MzZiRkV6bWlOZXNRRE5JZFZyODRSUU8rN0FZ?=
 =?utf-8?B?SEFXWWhoTGtwcmlybVlJM21CeGxjbzg3b1M3OW53c3pjZnFONmQ0T2RZaktC?=
 =?utf-8?B?bUVkdW5WeTg5RU50eGpLWVNJNXppTjQ0bThKUlV6TjlPRzV0MW4zRnBLYUJS?=
 =?utf-8?B?Lzg3NDV4T1RDa0trM0hQcG1NeFU1UnYrcDZzNXU1YkhZbkxCMFBqNkNhUEpV?=
 =?utf-8?B?OHV5QzgyelNsMFNZbmtIMVBuUlo4ZGJoTThZVHNRL0dXa2lnYStGQjZSZDR3?=
 =?utf-8?B?VUhMU0Jqc0xqejZoRDV1U0tDWFpWY3ZNM2NWVlNjV0tsN0svcUhCRTQ0Nld5?=
 =?utf-8?B?bmpUUmY0Uit0b25HU3BQeDFvR0VTRitRQ0VDMy9KWE9heUdGZkhTbU92emow?=
 =?utf-8?B?cmV2RnZadmVodW1hZGxxcTZIMVBrZlRUNWNqcUEwcngxL0JSUGxNSjJraURB?=
 =?utf-8?B?UjlvdlFNbTBzb1ZCZ1NmcnNZdGJ0WW5ZRXV1TWE2WTUyempmQ1RBVUp1Y25M?=
 =?utf-8?B?MEUyUjJvSDMxNDJheGFIQ0NSOEVQREJSUUVIODBTYWlrUitFQkxjNCt2Wjha?=
 =?utf-8?B?cDR2MXJqV0ltTlUyaTF4UDhlWTA2eWgxMXBQZHVJZVpjcDdMZEdSQVFUYUky?=
 =?utf-8?B?K1AySGloRVdyRFVKbGpVaUVhd2x3REZyY0s0TFltLzV6bkp3NkJoUFdYcnhW?=
 =?utf-8?B?ZjRGaHNSWFpicTFqVU9hMDNzT2FTM0tmeFl0ZjUzaElra05ueWYraGkwYnVD?=
 =?utf-8?B?OFdJWklWZXJPdnhEazVPclF4dE5xeHZ4UVBud2xZNUhlUmp4Sk1oK1MxUzdN?=
 =?utf-8?B?ZnlNZVIvYkR4eVl6M09panJ6YjA0SDNRSEdPMnZ4M3UvUWNUMC9tL05VWEdI?=
 =?utf-8?B?R1k4MmtiYi9aTDhyTnFKYm1Oc3V6blhTaXoxTHI5djVlS0llWkpObmNVTDlX?=
 =?utf-8?B?NFR1OS91dEpFUE1uMjh0K1p4elRYV0ZJeThsZzhsek9iTmlBUzZWVVFtQURH?=
 =?utf-8?B?dTRVNXAxU2ZoOG1xVWdoSkR0VERYNlJDK28vRXgrbkJYN3F0MUh0c0NWUmZP?=
 =?utf-8?B?OVBZak1Id1k4TzhFMURjanBHM3N0RnZrRFNSOVRCcGJ1Smg2TjVlME5lVFJH?=
 =?utf-8?B?K0Rya1A5UFNDVUdKa0w2MW5zc1VNRDcwWTE5SGpxL0t6eXF6a0ZDZDZNbmh0?=
 =?utf-8?B?YWQ5Tzk1eDJXaDR2WDhYOUZIa2F1NTY3L1lZenY5Z1FmTjh6V0VqdTA2cjg5?=
 =?utf-8?B?VlJlcEsxd09kOXpJNWhoeDh1UXE0c0lnSmRWMlpLNG91YzlDdSt5K2xGSFV4?=
 =?utf-8?B?OXVpQ0NOV2pobHh5MVd5blBYTWU2MkxwazlkZHl1Zm90cG1ZbFF3NmlxeHZY?=
 =?utf-8?B?cUU2SGgzbnRDaFR1cFVacFBpei9hTGRNaUpQWlNvL3B0MlR4U0dadUdHNThF?=
 =?utf-8?B?c2VFeEVxcnhpNnk3UmtWY3ltbG9lM3BZWTlyREpIZ3lUcDdMQ0xiRk9rQTVF?=
 =?utf-8?B?bmMyb1JLUWVYMWNIdzlKWnJrZmZhQ3E3TU92eWUyVUVBbFdsUWNPejVhZmhi?=
 =?utf-8?B?UXhSTW01dWVVY2FsTUhYRncxYkpvUHllR1M5V3pVdVR1MnAvUXVLNFBYTWdS?=
 =?utf-8?B?WkZiYkoxcGttbjZWWEN0WFRjblFOblYwY2ZVRWNsOXVKcWx0ZEc2WElGV3N3?=
 =?utf-8?Q?Hn60LPDWUuATtxWm26d7vtC+XAdpAYHutdiTlyPPX4QvB?=
X-MS-Exchange-AntiSpam-MessageData-1: frcWypq84+jrFQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3e2f12-2c14-4c94-2f22-08da43e64f16
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 15:49:27.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPawk9nd37uWWh1l+2OfvSMkYERRRGdWvEyQMxGCtuFjm9UZigMWej5wMNh/w2laXeBUXsjbnA4ursT/9DSbKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1229
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


> Hi y'all, I've made minimal changes to OVMF to prevalidate only up to
> 4GB and leave the rest unaccepted, as Thomas Lendacky recommended
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FAMDESE%2Fovmf%2Fpull%2F4%23issuecomment-1138606275&amp;data=05%7C01%7Cpankaj.gupta%40amd.com%7Cde8fd09ad93f4420bd7408da43568f68%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637896336342540814%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=K93%2F1FrPOo4bIWcssHoisM8vDkOBjWh69bUWosT%2Bt0E%3D&amp;reserved=0 and ran
> a memtouch test to see if this change behaves as expected. One thing
> that struck me is that an 8GB machine reports 2044MB free with this
> change (free -k) whereas without it, I see 7089MB free. I think that
> unaccepted memory should be classified as free in meminfo, no? I'm not
> familiar enough with that code to say what specific change needs to be
> made.
> 

Is it memory accounting issue when accepting all the memory at boot time
compared to 4GB:4GB preboot_acceptance:use_time_acceptance split?

You said you ran memtouch (don't know how it works, assuming it uses 
memory)? Doesn't that mean most of the memory used and hence accepted? 
So, free memory reduced?

Just trying to understand the issue.

Thanks,
Pankaj
> 
> 
> On Sun, May 15, 2022 at 11:47 PM Xu, Min M <min.m.xu@intel.com> wrote:
>>
>> On May 13, 2022 10:45 PM, Kirill A. Shutemov wrote:
>>> On Fri, May 13, 2022 at 11:01:43AM +0200, Borislav Petkov wrote:
>>>> + mroth
>>>> - brijesh
>>>>
>>>> On Thu, May 12, 2022 at 10:34:02PM -0700, Dionna Amalie Glaze wrote:
>>>>> Kirill, I've been tracking these changes to see if we can handle the
>>>>> unaccepted memory type for SEV-SNP, but testing has been an issue.
>>>>> The proposed patch in Ovmf to introduce unaccepted memory seems to
>>>>> have stalled out last September
>>>>> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.mail-archive.com%2Fdevel%40edk2.groups.io%2Fmsg35842.html&amp;data=05%7C01%7Cpankaj.gupta%40amd.com%7Cde8fd09ad93f4420bd7408da43568f68%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637896336342540814%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Hku8nQJGOg%2FdQqypHxw2eLFG0e%2FE6HoF5VXSIhMpmx0%3D&amp;reserved=0)
>>>>> and is particularly difficult to adapt to SEV-SNP since it doesn't
>>>>> follow the TDVF way of initializing all memory. Is there a different
>>>>> development I might have missed so that we might test these cases?
>>>>> Without the UEFI introducing EFI_UNACCEPTED_MEMORY type, any
>>> kernel
>>>>> uses are essentially dead code.
>>>
>>> + Min, Jiaqi.
>>>
>>> I don't follow firmware development. Min, Jiaqi, could you comment?
>>>
>> We have prepared the patch for unaccepted memory and it is now working in our internal release.
>> But there is an obstacle to upstream it to edk2 master branch.
>> The patch-set depends on the definition of UEFI_RESOURCE_MEMORY_UNACCEPTED in PI spec. This is proposed in https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmicrosoft%2Fmu_basecore%2Fpull%2F66%2Ffiles%23diff-b20a11152d1ce9249c691be5690b4baf52069efadf2e2546cdd2eb663d80c9e4R237&amp;data=05%7C01%7Cpankaj.gupta%40amd.com%7Cde8fd09ad93f4420bd7408da43568f68%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637896336342540814%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=v7s68GZWXJfaXB7vfvXjAlTD2KLOSghk%2Bj3GXF3FTVg%3D&amp;reserved=0, according to UEFI-Code-First. The proposal was approved in 2021 in UEFI Mantis, and will be added to the new PI.next specification. (Till now it has not been added in the latest PI spec.)
>> So UEFI_RESOURCE_MEMORY_UNACCEPTED cannot be added in MdePkg which make it difficult to submit the patch to edk2 community for review. See this link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fedk2.groups.io%2Fg%2Fdevel%2Fmessage%2F87558&amp;data=05%7C01%7Cpankaj.gupta%40amd.com%7Cde8fd09ad93f4420bd7408da43568f68%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637896336342540814%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WVIJ2yRRd2URwIF85Dp0WD4ovibZlsobijIGbN6MWZQ%3D&amp;reserved=0
>>
>> Please be noted: UEFI_RESOURCE_MEMORY_UNACCEPTED (defined in PI spec) is different from EFI_UNACCEPTED_MEMORY (defined in UEFI spec)
>>
>> I will submit the patch-set once the new definition is added in the new PI.next spec.
>>
>> Thanks
>> Min
> 
> 
> 

