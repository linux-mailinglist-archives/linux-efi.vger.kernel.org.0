Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3E66D1E1
	for <lists+linux-efi@lfdr.de>; Mon, 16 Jan 2023 23:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjAPWqo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Jan 2023 17:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjAPWqj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Jan 2023 17:46:39 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E4A24494;
        Mon, 16 Jan 2023 14:46:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCMI6IQYBU5f/+bpIWFtoWQlTL0bj/vE6UOMybrdLAAUUUMlS+sjsE3lQTz0TaCCbb3C30gvK7E8EXw1cTvEeg0e51m60ps7rkqsg4ckdL8MQd2url4WAM1fX9uHGpXortqBrdN6Zto1aU1xEYJicWHycU+BZmXVP5//2fMJyAEEVWTlCW4xZ/wgrAQ8w28db7APVbKR3d41CUrPau7otavkRAQ6U5yEV/c0Zu18XvHyScaAhAenkzQFaZjC0FmExvJgszWY9B+ITRuJXmClBx0imaCj9CWlR1WeIf9jXWNJxTEEjWG9YiJVsDMO38RTgVSwoOPSOVZ9zx8NVN/Ahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlhEnk5AsbSQkhg23r57HJC2tYTaZMAtg3hLutUdTIc=;
 b=d45+iQGhCYPSGnrWyEwVQrZn7tRTNZ1xMoRo9Cj8gOecfDBaT7//E6WBryJN3vQHP8A/KZIbWWjTO97MJqooWVOZGysU/hAAbrChjoaES/DBDbnNwn5zOTjQQb6rZQIUjqGjHZOw/87iKQhLQbRBxL++4Q6UjsGFagcaod4WupV17/CPBR1U64vwTIufRBJwQDZnI9gU3Ki7Uo5ZD2y4H/SJNsdIDFLmNTwBkfg5HUXkoIs/ImMD/Mbuh1zzgcF2D2FsKwpddWILp6qQjEqxgGwIi9kd7SbVI4Ot9arssTW040vWWUdK7ZrpMdILdl9xeSG7Kb6SOt/x6aDsG+IhNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlhEnk5AsbSQkhg23r57HJC2tYTaZMAtg3hLutUdTIc=;
 b=a6njIGUslAwQq2RFrN2JdtFzhfSPdh8qDX3U4l2l2OfAU1SrtK/mto8ms1fxsPvzKFKq9lAqGhHcaedVJ8WVM9VX5h7CEbmmtlcHaVzjcJTRGj8X7PXpRymKZb5etlZchD9XtmK49UMVlgPNmthx95zBq71FTGSFI/fI3/y0Rjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 22:46:35 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 22:46:35 +0000
Message-ID: <1818a72f-31ef-07b0-d1b4-6a8904636db2@amd.com>
Date:   Mon, 16 Jan 2023 16:46:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name>
 <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
 <def9b0b5-b880-be99-fa95-b05d76a91824@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <def9b0b5-b880-be99-fa95-b05d76a91824@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:610:54::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa8ad91-1992-4f60-2798-08daf8138528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seuwxg0jUHV5tCkObWg8MZMEKzQNSccNfQMd5KuDcwDVgDtyZcj0AwscH6wum8cuXFbCWiaOkGQ+am9brL6bo/XSve1Tc72TKlm3sCa5wCi4AosDHR1zRpKiD60dVVx8e3xwIQ1EMp3j9/qrjLZoaNYl5cCENj+TF5wQww74pI0GTy3Oab90SD0PMBdnPjy/nANwHhWTCqN6X63sBAT/4ISHdru7DelbsGwDOAMrSUygY8rOnI5MGfnOSXrEito43ByRmajWjMzDFnlrStdjJr7AJW2Eu2hsKEEjFdRVrd7MW+xEchapxwcCP3JFjkt7buLHoXvDBipK5IrMjuvDGATfLatMZOa/P7EBUqJ/tSQ5bEOnnv4q5fBRXljrBWsA1PVuUmrsq0kUYkfDPjbOGYDrxegJRtIWEZhQTi58v3zeG8n13F7sDxkLvafXwGiH9AQHNlNvGFIpo4J2DkArK6ktUQl+7aEd83Ln3eCCsEqkFqgCRDzvU2syY+vUcLqdccBduUCE8q3R6vI25dJMvXST9T5PkY152nxIZLw2yXSW7FB1Jze3DOtVB8wr9XPbjbWdxycV8+aluYovUzm6fq0WG/YTrrVySnC2hr3pcbA5O9/Q8U6x1vSsUqb6Ndi2FOgSS+Fo8B8DVk1jWl2/tmDy1iPWpfH7aG0ymPMlv/UEW6nvfwmx8A1Tz97lDGcAOXJ7tJ6dmS+hc5P0BTYJCne8+6lNf350vfEDxRD4YRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199015)(31686004)(2616005)(316002)(83380400001)(41300700001)(6506007)(8936002)(6666004)(8676002)(4326008)(66556008)(66476007)(7416002)(5660300002)(53546011)(2906002)(66946007)(38100700002)(6486002)(186003)(54906003)(110136005)(31696002)(36756003)(26005)(478600001)(6512007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWU5d2pia3RybTFhSGZUQnV4MXd6aElpalBIQ0ZvZ3B6RzI5amQrTHcvL0xX?=
 =?utf-8?B?OGY0YUZBeER1ak9DNGQ0a0hSSFZWS3RUR0hGY0VRczRQZmpiaDR2OE92TVQ2?=
 =?utf-8?B?K3FJbU5CWDhmS3kyMkQ2eVBWT2hiZkxQcUtzSUI5bWYxTytwUHk2YlgyRjk5?=
 =?utf-8?B?YnN3WUVNRmtTWWErRFhDY1ZGNkZwQ0QyUFVWUnZ3Y2tLZDZMZ25lOFA2SUNQ?=
 =?utf-8?B?Tkx5aVRHdjJKWmZHWHNNaU00S1dRWlFrY2QwS2I0bUpKQ3ZhSzA4MTJpL0Fm?=
 =?utf-8?B?SzgwVWZwNHJnN0UrZVRkLzlPMld5U1lYNmt3d0NMUWpQSmpMdlBaNU5lcVAr?=
 =?utf-8?B?ajhuUFhTMFA1V3N6cW5OclNhQW0rUWNIK09qczFzb1ljSVN3SEtkRmRqWjFC?=
 =?utf-8?B?NGx5QjN1ckYzMW1oU3BqZmk2bmdMQ2ZlMGhEQVREWVdzaFVnRU8zcHl1VHNy?=
 =?utf-8?B?d3ZnWHYwS0Q2b3pJcWJtTm4vOVhKRnpBSGVKK0pJWEU4WWczVzF6MlNJL3F1?=
 =?utf-8?B?bm1WeEhxTkpKVGY1VHpvQ1FiSnlsdWhjZGV3ekxuTE8xR2ZKMkJLdEU1cGZP?=
 =?utf-8?B?eWxBZ3BFN01VTS9BeEluMk9qajBscDYzZG1RdjhzdmtTTk5NUHVsWjM1OW1v?=
 =?utf-8?B?VkJELytET0pQbE1SbmFwRVpYakdDQVJ4SXkrRlB0WG1Ha2R6ZjI4WHlwZ1hu?=
 =?utf-8?B?UzhnOUtIN1daOUhJRXpRQmZscG1taGFXUFFQVHhmQXJ5Ny9ZQVh1N1BINnRw?=
 =?utf-8?B?eGZPRlBnZy9IcWtJSWdrVGVkemdJaXpaVXdUVDVaNWxTa1Z0UTRVTHJ5dzhy?=
 =?utf-8?B?SG1jQjVZdEFmdi8rbENlSkJnWmZKOHRPazIwY2R3U0FlbmFvQVNOU3Z1aHY1?=
 =?utf-8?B?OGIrOS9ZZEpnYzhLV0xhem5abWpoWCthbFBna1dzd0lFamhtTGFyQk5EdTRO?=
 =?utf-8?B?QjJrL3E5eURGNTRxSUU4L2E0bWx6Njc1dnNHa09maWJnWXFGNlZDR3R0Q21F?=
 =?utf-8?B?Y3R2aW5kdXVMYnNOell2cWEzYlZrVEtoV3g3ZTBrR2FxRTlUaXlnVWhndnNE?=
 =?utf-8?B?WDZlU01iZWxJcFcxRndOdXlOcnNSN0hxamIwWFNwUWo0NjhRc21QSVJ6aUlr?=
 =?utf-8?B?cW9iZExSMm1XSXIvK3oyUU9JYjFKaktuK0N3K2ZxR0ltY0FSOWFIUnFVaytH?=
 =?utf-8?B?S1Q2Si85dGZoYUxlUmFLN0NCU3hNSzFIZjNTV0d3Vlovazdra0RCNzhSMVJQ?=
 =?utf-8?B?eEFjTHNRTnFaY2NsYmtqTXFCSTVTb3IyNzdxdWkyaEhzdW1lcWtoUjlwMWJO?=
 =?utf-8?B?RlpzZ0dpRE12SjRWcllLN095UVhtYkN0VFI4WVlvdHlqcXY3V0gzR21MdVV1?=
 =?utf-8?B?cDV3QkdVcGk5My9SOEdIL1ZRSWJ3WlI5L0tvREY3dFBMSk9SaHFJd2Y3cFEz?=
 =?utf-8?B?a0dUQUJSQjBqVkFpNWhLU2dYRkVpUWJwMUdDNElFSkNDcFNMVjlmR3BsTkJP?=
 =?utf-8?B?WkliMXRkWk9xbU95dnBoNElGUWNTVm5taSsyMHdZakxaKzkraG50VDJ5THlv?=
 =?utf-8?B?VmlLdzRveG1teVJLQ3BubzJpcUJZckMrQUl2M2d5Sml6cWRLRmY0Nk1ZRkN2?=
 =?utf-8?B?dnlHMGRGS0ljN1A5cGE0bXJBSHBHK0QxT1FWWFY2QkFDMkZwQkpBQ3JmOWpm?=
 =?utf-8?B?N2lBRUpudnpPcW5ua2pxZCtlZmZOR0JiTUxGUXFob1RzTExzSTJjK2x4V2wy?=
 =?utf-8?B?ck96YlZoM2xoV1Q1Y1dzV2c2MFZmREhnNStNVG93OEdhbWZ4RWNpZUx6L1E0?=
 =?utf-8?B?UDdKSEo1ZTlVbExYa1BHWEZ4cmR1RytqNnU2V1pkSms1NnVINWlIL3NVUnBZ?=
 =?utf-8?B?amVaOEF2QjVTU1poSDkvTHRSU1hHVWNMSlJFS3dRdVFzcTBHRWxSTVYwZk0v?=
 =?utf-8?B?VWM5dWtzR1lvR21tY2NvVWlTd3o0amhCaXRHTjBaU1U1RFJ6a3ljaktrbmJQ?=
 =?utf-8?B?V05vOUh6U1ZlSlBaRGtBYTM0TnpybWhlS3F2UEUvamE4bGdkWkoxRDlZSXJM?=
 =?utf-8?B?U2FQVkUyQ3hmOEdQS1FpSUE1dUt3SUZTMkw5alBRelQ0MDhwSWZoYk5rZ1Ro?=
 =?utf-8?Q?0NdAkwHA6SafDdqkXThcFZ6gm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa8ad91-1992-4f60-2798-08daf8138528
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 22:46:35.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM/61Gl6btBt5V8H5sJuPNJPD27RlE+IWtEP6Kcv7e+t+nRClxLZkQCwBTNldvLlSmHLMy0I3AZq1JE+kHkZ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/16/23 15:22, Dave Hansen wrote:
> On 1/16/23 02:56, Gerd Hoffmann wrote:
>>> And we add this protocol to address very temporary problem: once
>>> unaccepted memory support get upstream it is just a dead weight.
>> Maybe, maybe not.  unaccepted memory support has a Kconfig switch after
>> all.  If we figure in 3-5 years that all distros have enabled it anyway
>> we can drop it again.  For the transition period it will surely be
>> useful.
> 
> I agree with Kirill here.
> 
> Having unaccepted memory *AND* this firmware-driven feature really is
> just implementing the same thing twice.

I'm not sure I follow you. This feature merely tells the firmware whether 
or not the OS supports unaccepted memory, which then tells the firmware 
whether it needs to accept the memory or whether the kernel can.

We have had SNP guest support since 5.19 without support for unaccepted 
memory. Imagine now using a newer OVMF that can support unaccepted memory. 
How does the firmware know whether it must accept all the memory or 
whether it can advertise unaccepted memory. By having the kernel call this 
boot service protocol once support for unaccepted memory is in place, the 
firmware now knows that it need not accept all the memory.

Thanks,
Tom

> 
> I'd much rather have the Kconfig option forced on for all guests that
> *might* need unaccepted memory support than carry redundant implementations.
> 
> Also, _if_ we allow folks to turn the Kconfig off and get access to all
> their memory, they might get used to that.  Removing this firmware
> interface from the kernel in a few years could be viewed as a
> regression.  Then, we'll be stuck with this forever.
> 
> In any case, the firmware side of things didn't seem like _that_ much
> code.  So, I'm not protesting *that* strongly.  But, I also don't
> believe for a second that this is going to be removed in 3-5 years.
