Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4403C74B494
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjGGPrI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jul 2023 11:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGGPrH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jul 2023 11:47:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0031213B;
        Fri,  7 Jul 2023 08:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IANjMsmcpYxFTevLE5RPZx9/JRYwETqFHb7iOyLRQCsbmMK+TLTRu+Sd+hCv8sRnVd4lzMMzRkr5H8BY6j8j2l5ycPIcb6+P2Xi/ijyWX8wssT6m/miKsVZnv8xSswplT6Al/IjRtE8J5ot2opurUu18cYv1YsgRWWJSglaMkTjw0wneRUOjT+kXlmWDLb858auy9xaYolnWy8pCDkEu1oEldDnuGIoZ+UapdJwryNi0JidvniAxDux+EW+8HlJ0SlzWKYuYNyqdt6fTQ5LC39ivf9LskS8MMbQK5aJ39l+yl8xmOy7b9aA1j3jqnM45YmkI/kgDTh9OHPeOcyRdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ8Z6dZ1pk5mUN1/IqFlNH9X+2Vbbg8DmVUvwh7woE0=;
 b=ZxhQD/irF35EjV+u1kr/AEA8fQqmplGbyuoSb+QsHhRPOShLh0xlVzocrM/S6RxCwGBVxW/BHOLpG9/3YdKnGUl5kvd+m+RMTfRt93XhpPyr6MzUdvXHXOfEMdaymktJ+p1HklZ18WandCzZJqUU64y0hx1OxZhBzX/6pdTiWAq6dnJsY/oRBO7jlI25oSTR7akpwJAvKyJsMTj9WbUQj2RGffH80IaVfgY5QMWBjEUyc20cxs9uzc3EOyuqo8xs2Z27wal2x1ZGOp+WWvNqKrqjXdZtpzvx3C+dcV0RH8V81PXSKz6vG5VEHTJWhDXjTpeXTVuhbbbpuq5QaLJlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ8Z6dZ1pk5mUN1/IqFlNH9X+2Vbbg8DmVUvwh7woE0=;
 b=osLFHAtuO4yIEi2cLgTW5sjID+t3kJ1Ep5e8zQiKReGPTvUuosbC+nAxt8Spsy2nwDJl4UV4uPYW/QlAcfJysNyQSAc0386cSzpkkylqp85C4pMQA8WoxCXkTL48S8gNimUJCpK1a/spKNQ6k5vX/fv/ZFKw69hMfahnwq8n0YA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ0PR12MB5456.namprd12.prod.outlook.com (2603:10b6:a03:3ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:47:02 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f%7]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 15:47:02 +0000
Message-ID: <3c7bc679-6366-ab7f-7001-7b5ab71fa364@amd.com>
Date:   Fri, 7 Jul 2023 10:46:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Content-Language: en-US
To:     Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>
Cc:     Tao Liu <ltao@redhat.com>, Borislav Petkov <bp@alien8.de>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        michael.roth@amd.com
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv> <ZKfLYG_4DANc_i5r@suse.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <ZKfLYG_4DANc_i5r@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0111.namprd05.prod.outlook.com
 (2603:10b6:803:42::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ0PR12MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: 15995680-c66d-4ffc-3eea-08db7f01681e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/ikJ0Mi32AlgDOLx1tSILVAWJsc/RFILYEx8ZhOs1u6TqshdRmPWVVZhMdu+s8lQDOj9mErmopuu72G5nlZQVAaOnL6X0hdTIyuC9NM4zO3ynXotguqRLT2cu1Ym5sqP8NNxxsqI6G77N1kHfQ8Y1su7JcgtevoNdRkm8mr0z5VEi1SK8Li8Y4eTPOgp+lETZjP17Li/9XEzl0u/RViGuq0tP+OtAClUWN0B4W6SXgHQYyDlDSC9Sy8N1AgMNb99Xie5Gv1+XyPWIubwxev9HaTDEplFUFuk+uDMRyJ7/XB7KCGtS//OYqXcwvyGa67Z7pfi0ktNKvsY5ghn71hSQ5VmboDKH82P6eejJs+uXv7Ex2iuWUZmk607yIJYIlYBiFIAfrrXJVOIwEpY+d7tvCsWm+HwbVGqS+rgGdfYjOy0Y+hCnpGknJGaHQEywRpLuUPzFt7WYX4Xpm/XSbG/5yJRVf8Ss0cQN/UiiPdLt6CXaN5tnxKeA4u+vuQJJMdrLdo1K/9/1ypyS1o/CatM7x9aFQLpZbhCzfgCEVhp1DCCl3tneZUtgEa/LvRQ62fFW6Whi3yu0n3k2OFOgybfmpjYgCLGQUyNwYpsoOkOfx4p9MIr2Al3p2pTNM7nGEM3+jwhXiDGS6qgpZIYgPn9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(6666004)(478600001)(6486002)(110136005)(54906003)(53546011)(6506007)(26005)(186003)(6512007)(2906002)(41300700001)(316002)(4326008)(66556008)(66946007)(5660300002)(7416002)(8936002)(8676002)(66476007)(38100700002)(86362001)(31696002)(36756003)(83380400001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzNMNGNmci9YMjU2ODU2QnlGcTZkUU9abXd2TGcyRVhPNXorN2JndnM5NGlt?=
 =?utf-8?B?Vy9FMlVCUGJSMU9QNGRzR3BsQXpmd09KbFVxMXhaMG1QcFlQdS8zT0crYlI0?=
 =?utf-8?B?Q2dWRWU4aGpUY1pWQXBFZ1crQmpSdmRYVlZFM3JsOUtsNkg2MzdNVmdpNHRh?=
 =?utf-8?B?NGlvZSt2S2UwQmhRZHdseDZCb3BOaGQ1TkczTy8wa25uSytOY3gycGdJQ2tT?=
 =?utf-8?B?RVBnamxQUTJmZ1J0ek00cndjNnVxbnMwd2dWQ3dZNVYyUENUeDNKUDZ3aTJo?=
 =?utf-8?B?N1RTNjI5Wk9YYVZ3U3BFa0s5Y1VucDVPNDdwcUNxYXB4R3FIaEFocXZpY1I4?=
 =?utf-8?B?KzkveUpUZ2FSdHIzZnRkdTNNMG1vUUpXZk1uQnpKdy9rV2hxdHJsYmhEa0Jj?=
 =?utf-8?B?eHhRd0hXY2FyQnVTVFlVNGZZNGVOM092QlhBZFdzVjZrTGdPenI3TFE2ZHV1?=
 =?utf-8?B?aUpuaDBBVnhzMGZWY1pObGp1RUVZYnhKaHNzdmt2L0dkcitRL0R6U3QvOUtr?=
 =?utf-8?B?cll2WDI2QVUzVThTdkZIN1RReWxMYW5HMFNmSlo0MytRQ2ZxYTZTbE9hVG8r?=
 =?utf-8?B?N0ptSmMrRjY3cit1SHJFOHMrWlE1S01KZUNHVWZVZ3pJeE4yd0VlTkZzcFFq?=
 =?utf-8?B?blRORDdvcDN1ekdtRXI5bkdHNEpFaGk1QnNCdVl5djY2N1hBTVUvVjF6cEp1?=
 =?utf-8?B?RE9ndnlHYVNMeTgzK1NMdmRKUjhKdHdLcnp2VXVQZG50MzJyOGxMc1FFKzFM?=
 =?utf-8?B?ZXJWYTJjZVlRSWxZUnloWUpSU0hhMjdDUmpFZzk1VnpubWdhVEc2N0pDQmpn?=
 =?utf-8?B?R3BISHIyR2V2cERCV3ZPOXMraTB6VXFPUGlJQlRVdzJnVGZESUZGSFBNc2J0?=
 =?utf-8?B?cGdIVUdzVXNnZ3d5MFhsVE9xVnB5MG1CN1o0azczTkdwRGhHclQ3YkpCYTFa?=
 =?utf-8?B?RzArMThnMktxMWZHaDRTemlUVE5EWlN5ZTdVc0lKZnFJRXgyaGp1emhsbXZz?=
 =?utf-8?B?N1E2SGFEbUs3N0VnMndVOVpJQy9MRXYyMnhsL3ZVV1hRRHF3OWh1TUVGUDlj?=
 =?utf-8?B?eVpxZE0rVS9tUjRnOEt0VmtoWE0wSEZvSUUxb3U5dmRUMkwvSk1rK3R2ZWFo?=
 =?utf-8?B?ZHJkWFBGWjRDb2lSNXd4OU1WelhKcldSTUFTRmxyaW9uYjBzcDFxSUJRSHVH?=
 =?utf-8?B?cFhGNjRRY1FxL1pucVdOSnl2TE9qZTB3S0lhUWk4bmM2QmxtNDFNT1NNSjZI?=
 =?utf-8?B?dng4VTZqQmhjVDR1V05sK09PUXYvSERYZ1FhZFB4enQxR2FMWE55UjY3R0M4?=
 =?utf-8?B?M1lrL3czZVFYZlFFR09od1RkOEplOWpidG0yNGNTMU4yYWFSeVUyTlgwam95?=
 =?utf-8?B?dGtRMEwvbmNNcy9NL2EwNTE5LzhrNWdwMDZoYk5ZaXp6Y254MktxdzdSYlpK?=
 =?utf-8?B?elZsTnA1aEJFQ2pTTTdjdXhzUGFkM0JIb2JKZUJsS3ZsaXBHbHVHOVNHOVVl?=
 =?utf-8?B?K0VMdmp2ME94bGM0cjRVeTJzL2UwaERGNi9vRFd3OHZ6NkE0ZnNtdXJ6SXFp?=
 =?utf-8?B?azJmZWJFeWNuVXdDdWpDb0YyQ1EydFVwOUh6L1RvQ1RRbnBqSXZiOHdCZ2h3?=
 =?utf-8?B?T0Zxd2lQS1FTY1ZaaGs2dDY5MVNGMjBHMHl3K3JSNDQvbW1HT0VMb1g2bTdv?=
 =?utf-8?B?d2l0ZitUdnBxQ3NWdGQvVXJaZ0VGWVdWUjFha20vZy9hUDFkTUtPZExrbktt?=
 =?utf-8?B?S01aQWY1cnJQNFU0NWZ5bHl1NFhzbE5MQzBsMDc5VnpjOHlFdk1LbHAvZmt5?=
 =?utf-8?B?R1RGRm5qei9pblV4WW1oUlNxYXh6MVcvRUROSzBTS3lab016SXV4RU9PQUxM?=
 =?utf-8?B?VFVKYU9aOTY0NWRWUVpjNjdmanR1Q1ZyRUU3NUNqZGFZanhkdnhuMDVHRFly?=
 =?utf-8?B?bXB4ZjNiYnZobGlVM05iYk0vTEcxVEo4eDBMTitUekdWV2hQQTJxVzE2cTIw?=
 =?utf-8?B?SkNsY01IVVVYeWI4K2Z1RUI5TmxHWlE2aHk0Tk9QSzZVMnhGQTY2QUhvSmFJ?=
 =?utf-8?B?LzArT0U4eXpTOG5yRWN0NTBJanF3SlBidG9yWkdrWVcwNjNFL1Fra0svMVlC?=
 =?utf-8?Q?r8WXiNHM8xiPgjbukn74wvvKX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15995680-c66d-4ffc-3eea-08db7f01681e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:47:02.3536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Bg+O/jamDU1hP0RXv9/fOCGWGGNJz6FsTZak4V4ytuzUvU0Dd137IFN62F12OGlOVCdVJdsyYUNY5Y/cEa/PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5456
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/7/23 03:22, Joerg Roedel wrote:
> On Fri, Jul 07, 2023 at 12:23:59PM +0800, Baoquan He wrote:
>> I am wondering why we don't detect the cpu type and return early inside
>> sev_enable() if it's Intel cpu.
>>
>> We can't rely on CONFIG_AMD_MEM_ENCRYPT to decide if the code need be
>> executed or not because we usually enable them all in distros.
> 
> Looking at the code in head_64.S, by the time sev_enable() runs the SEV
> bit should already be set in sev_status. Maybe use that to detect
> whether SEV is enabled and bail out early?

I think that is only if you enter on the 32-bit path. If invoked from EFI 
in 64-bit, efi64_stub_entry(), then I don't believe that sev_status will 
be set yet.

Before it can be determined if it is a non-AMD platform, the EFI config 
table has to be searched in order to find the CC blob table. Once that is 
found (or not found), then the checks for the platform are performed and 
sev_enable() will exit if not on an AMD platform.

I think it was an oversight to not add support for identity mapping the 
EFI config tables for kexec. Any features in the future that need to 
search for an EFI config table early like this will need the same.

Thanks,
Tom

> 
> Regards,
> 
