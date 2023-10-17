Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620587CCE60
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 22:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjJQUpO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjJQUpN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 16:45:13 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34F492;
        Tue, 17 Oct 2023 13:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWmCOZ47kr4bJyfREA1OHP0XTt1r8txi/a0YBt1T4fTelBjSMhefiB8kBG89TONL4xmXsv9MRAl/IIuyyfvTGq5DcbcH/tsed+GuFDUOU7BZi4sD244qU1dALmBeFIfKM2VWQ/EHxDtWrgyavgDmU9grojh5uYCWuEzQD5+EvCcBSHIw0MVYrMc0qCwWFQrNtxsiHL8Tord7FWrFSBmzz625k0BlxifnJ/jQ5l5ADX6k4DlV+uTZEZ+b4aI4fHUZMzdud096OL9g+Bcy0qbDaiWvoGfg5BNvDryinj5clI+6gMNENusyqhiZVn8tgPIw7Whnb8CCHt2iP9eSGZfY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQ8XCGN70Ch4XlqEg0m1QujRevUxYgsDCdwGit5VjrM=;
 b=nh9CmXUp7D7y0BJIJ8u8Hghv5LKGpFFSZxy2GcfzJV1jvSyGIoTveMCY6HAECIyjQ49z8y89pOxW0Tkg3QrU7E/jeNWdUkdMvSVAqqbdMUok+cE61FFa+TD3FqAnaWKBiZRuFDqfZuPo718vMUpBORc40GPMMFa+V3BMmQdDbZ4xWX/JN104+CV97a8+RRnB1RDNvcCT7TDsOYQ3ADkXXBFZs2HGoOVsNk24vPVFtnS4ftGnna5wn6KX/qZvU+mPTPNbYophScnsDL/JqubNm+jMHdQk2r98e2Cd7NxkFGCj/da6FDYYsSx0/lakWkZe2Q0B1rZIgCFBFcjsJV77Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ8XCGN70Ch4XlqEg0m1QujRevUxYgsDCdwGit5VjrM=;
 b=Nh1infQUiUn94NgZLhWct4X6ln6cfop8gD9PdOruc7VE/jM7HXOxsb86cCJKJRCNFGPVVIghbe4Xrvq/l6QtaIFJ/tc8CCSuiqKPeC+YtCgxe5AV/tkchoipMY5WYtEewZnFNns7NokwJo1H3+GTGeiiIBx19gbkIPE2aH8i9M0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 20:45:07 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2709:2c34:f842:ce33]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2709:2c34:f842:ce33%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 20:45:07 +0000
Message-ID: <b9dfa72e-d3c6-9471-93c9-a76baae96ba1@amd.com>
Date:   Tue, 17 Oct 2023 13:45:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] efi/cper, cxl: Decode CXL Component Events General
 Media Event Record
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-efi@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20231012230301.58500-1-Smita.KoralahalliChannabasappa@amd.com>
 <20231012230301.58500-2-Smita.KoralahalliChannabasappa@amd.com>
 <6528808cef2ba_780ef294c5@dwillia2-xfh.jf.intel.com.notmuch>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <6528808cef2ba_780ef294c5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:408:d4::31) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de12445-193e-4d56-0127-08dbcf51f26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PvKzh1Z3ZqLLOSxLp2TxZhvnE4LITDBlB1+anYVx8+XKYMizFVW8U6Y3Oq1BcxgXEehdfSIvzaIBCySw3AkznwWUqlT8thj1cv8Pa8lgCis/ZZHajx3qHVRMWaJt1Zp3GuG+lBClmej3NVRMhU9IPwWtR8VEmAjlG+5yr/Ry1bf9YMSzr9CvmhUnqkfZWlEm6XAxamrBVt2YrjmQmH8BJp2l/SoWAxRDCHvQDuq58KQheIeTPpDUqb2REKOxNWOUNC7EBcVvDF3l8apFge6OiVenCU30EmdHSucoAQHAFH9WnbuNdgjHIothA0/qSF+OWLqfzzNnd7n98aA6KI5s/tTd+4ggpsS0TGmoM/taoOZ/V3e08hLhUK4xGtTOevZozemS/MidCkdVnHxktvI3zjB+LDUg1eS2sOdeknXzHCnYIo7MHFNSSwSOQ/FJn3vPJikRzgWMb5IFzN3isfdIoVPrU7QLayNOc8OKw80HdiYkCGVwx0taoXJMdjdvK8znJpxt7RwRuN/wXKDi+VBombV+XiAl9y8jD/A/BNsRuDMzAf+rSKDJJnsKnKWQjJFRuLk4WShntILccz2mMf9Nc/flSEP/6jlqC1TQiUoLr4t2SZjMOakyDEThDCaTeQD6BM3sQnZNM7/tC2+cPdvogg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(53546011)(6486002)(6666004)(38100700002)(36756003)(6506007)(2906002)(54906003)(66476007)(66556008)(66946007)(316002)(2616005)(478600001)(31696002)(26005)(86362001)(8936002)(41300700001)(6512007)(8676002)(4326008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjZDQ2syNHRNVUh0aTRPYXA1SXlpL2NYMC9Dd0MrMm4yNmpicU9qcnNqQk5C?=
 =?utf-8?B?akJuVmo3WjN4b1lpeHJ0ZmV3ZFE4dWNXeWFnUXhrTGRrdHNjV3lOUmFIeVBW?=
 =?utf-8?B?cHRlNG1GTzZUdFNIVWs3dVd6bzV5bHRNRmdLZ1A5M2p3aE5FYm1uOURob2Zj?=
 =?utf-8?B?dUorcDFGdWxvUUxKK0NhTGlzZUN1TFU1Y256TmQ3TnRpdUVFczhpUGtxODJs?=
 =?utf-8?B?OTFQcXlrVXUwSnhSRjY5ZG93b1dmdGNFTzgrOHovQ2FNSDFibzduc3lTcjYx?=
 =?utf-8?B?VVJTSXBSM0JEQ0FlMmVVeWZqTk5rdHd0cGZ1ZTgzSktmMXAzQnpGcTNQZUQy?=
 =?utf-8?B?NDU5WmpTWG5WcDJxZHlNUzRUWEVselBGMEVUL2pvS2ZzdVRYTkwyc0Y0SmhM?=
 =?utf-8?B?TzBXVVJCQmU0QzkzU3FPVnV1ejJJNVMyT1YyaW9ZUHBDQ3YrbktrWlNwUnBP?=
 =?utf-8?B?T3FEQmgyQWh5MmtsaXdaUWxaUFZxNmdOVDdtZ2lmZ2dDelA1Y2luMVIvRENL?=
 =?utf-8?B?dFZnWnltODlOVlJaWjMzWkk4Tnc2R1BiQStLZ2Jac0grWVZyN3luQ1ZQejgz?=
 =?utf-8?B?dlY1UXBXa3dTanJhZldCSGdoTXhJMlBSV0N5ZDdXRGhWV3E5dkpBUUpBUG9E?=
 =?utf-8?B?SVQ5NTVNSXV2cTQyYzFtWTZJWDlvUGwwUEdTd3U2T2dJWUJnWGJsY0dpZlRu?=
 =?utf-8?B?aDIxN0tvYk54NDJDWmcrSkxXVHkyYmlxc0xHOXRQKzMrczRoMHF3TE96ZEts?=
 =?utf-8?B?Mm11S1FqeUNCa2luT29tSEtoM09TbEgvWWNDR21lakxnWGVKVXJidWhGdWgx?=
 =?utf-8?B?MitpQjU3N245Z3lsc0o5RTlRUFpsYTk2RXcwZnZvRnFKTG11N1JVclZkdFpt?=
 =?utf-8?B?NGlPSHM3S0FKa1phUVFFOHJnOEF1WmR0WURlL2FTZ213eDc2Q2E0aUdBbk5w?=
 =?utf-8?B?NU5mQzF6MHNWUlZVb3g0cHNYVmJNSzVMZjF1UTVwbm5ScGRiYlViT1ZDenRV?=
 =?utf-8?B?QndzTWtvQW5RY0M4UXlPVlU0aFB5cytieVloUUdrQWExb2JFYVVKQ1REZjZQ?=
 =?utf-8?B?M09wZjVncWs1dDBJOFVFdmFWcUxCYjRUTit2dHA5NTA0Y1FrUU1lUnJHSmIw?=
 =?utf-8?B?MlFmWGlaMjBydm5ZOUgyaGZRQ3RyUkJ5NTlSSjMzbjRVNDM3Vk5VdUxnTkF1?=
 =?utf-8?B?aWRqUGt5OTR4Wkd5cFd2SlplK3NVMHY4cWU3aHQwaElPVFhQdEJDb0ttOGdj?=
 =?utf-8?B?bm5EUHJwRG5OYmIvNmViY2tmbVJPcFVuYlhMUFBsQXF1MldpRkhmcTYyZCtZ?=
 =?utf-8?B?ZnBUTllOZ1NnRmxsNE1md2cvUGxGY1pUbFIwZWpEQ0JoS3RIaGJRc1hlekNZ?=
 =?utf-8?B?OUdHc0M2ZWZoTXVDK0J1eStHT3JKaUxoZFdNWEFjOXBMRlUreHQ3TlptQTBF?=
 =?utf-8?B?ZG1pR2dIbXRIZkxBSmNBVExQRFJaSFRHQ1RWUXJVUXh1dGpvZTlSSk10aGJJ?=
 =?utf-8?B?VGFUKzhUKzVyQUtleU10WHptYk83eVAvMWZremZJWWZGMitSK1VkRVluRjc3?=
 =?utf-8?B?TEpXV1R3RjcvUmh1OEQreWVNeXc5TkdNaDhHYWh2MlZhUHROaDZzcE80Rkxr?=
 =?utf-8?B?NVp6VjFRWnJYekdud2Z2d3QwN0grcHhyaytKTTBsUjR1ckxyUE5SNmNHOWtz?=
 =?utf-8?B?ZEtLMm0vSHdremtxUzN3dFhYWS9lRmcxM2FQK0lRMG1jWUwycGtLUlI2MlJH?=
 =?utf-8?B?NlNUN1pXdWV4dCtUeWRWeHl5UGtRL0lmSzNxazNmTkxsSjl0bjNMbE80V0I1?=
 =?utf-8?B?d1hrU1ZXSk5EUUY4SDVDdGVnY3NRRUJTWkMrajVkaytiUHI4QlZVcmI2bGhZ?=
 =?utf-8?B?R29ucG1XdTFNbElHZHBVbTQ5SzZFU0NMWldlUms4RDJMajFBZDAyMWlqMXlh?=
 =?utf-8?B?SDRJRjhHbmJNVlFxUndxQ3Rxcy84VldmQVVxcnErODBlbFF0OHpidWlaZ0tC?=
 =?utf-8?B?N3NBTVgxMWJteEJJOVVjTkJhUFZYalJ2WDRLd1ZhUHNaeG9nTGEyTlR4dUVR?=
 =?utf-8?B?c0dmNlM4MXpOZXFKTmZjekNvWHh4RUZVczdYVlJydEMzT1pWMklxeTQ4M2hJ?=
 =?utf-8?Q?U2Cwq4qqxfM5sgBMPNL176bS6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de12445-193e-4d56-0127-08dbcf51f26d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 20:45:07.1799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 674AalGCwDUSYtrnYf9orDrPjVDJ2G6qptxqoTOWBOgCAfVtaVNzdhIeGlTjXR5WVNOguCX7otS8KA3AdoAdSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dan,

On 10/12/2023 4:26 PM, Dan Williams wrote:
> Smita Koralahalli wrote:
>> Add support for decoding CXL Component Events General Media Event Record
>> as defined in CXL rev 3.0 section 8.2.9.2.1.1.
>>
>> All the event records as defined in Event Record Identifier field of the
>> Common Event Record Format in CXL rev 3.0 section 8.2.9.2.1 follow the
>> CPER format for representing the hardware errors if reported by a
>> platform.
>>
>> According to the CPER format, each event record including the General
>> Media is logged as a CXL Component Event as defined in UEFI 2.10
>> Section N.2.14 and is identified by a UUID as defined by Event Record
>> Identifier field in Common Event Record Format of CXL rev 3.0 section
>> 8.2.9.2.1. CXL Component Event Log field in Component Events Section
>> corresponds to the component/event specified by the section type UUID.
>>
>> Add support for decoding CXL Component Events as defined in UEFI 2.10
>> Section N.2.14 and decoding Common Event Record as defined in CXL rev 3.0
>> section 8.2.9.2.1.
> 
> So I think this is missing the rationale for the code duplication.
> 
> Specifically, who is the consumer of this parsing relative to who is the
> consumer of the event records emitted by the CXL subsystem. Given the
> CXL subsystem event parsing already exists, and unlike this
> implementation can support DPA-to-HPA translation, why should Linux
> carry 2 emitters for what is effectively the same data?
> 
> What I would like to see is the CPER code post these record payloads on
> a notifier chain for the CXL subsystem to parse, annotate with extra CXL
> subsystem information, and emit from one control point.
> 
> Otherwise if folks would like to see this printk() version of the error
> records then they also need to answer why the CXL subsystem should not
> also emit decoder error logs to printk?

I'm fine with your suggestion. I don't have any strong argument which 
proves the other way round. This was just a starting point in adding 
support for Component error logging in FW-First. I will take a look at 
Ira's patches which adds notifier chain support.

Thanks,
Smita
