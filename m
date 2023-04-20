Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344BD6E9446
	for <lists+linux-efi@lfdr.de>; Thu, 20 Apr 2023 14:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjDTMaH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Apr 2023 08:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjDTM35 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Apr 2023 08:29:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DC85FE9;
        Thu, 20 Apr 2023 05:29:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8ro1/9X+/Jwk5n7Ar9ajvcq2vuTi98+E1T3TTYiAzSC5MLJnUjZIGkyXLd4if3NMpYOAO/ORlHYagUZiXvzau5ldKyofaQlOUaidTJh+jKoPPfWipO2LWaH8CR1BP1n5zWvJTlmm+hnShZ54PX+w02iCTinKw+FEM7TksSSPt9gXNP4zcpml14+E9wGilRJEQen8koJdHuqipcCpOkgoyTGvfpsfUYvzjTvt/biLwO6wjZA6TL7V2CVd6+uD6gAw3YmyCfqyw/wAnI8IlW/gDrkzTC5mqdVxoXkF6v5J6s30Whow8xKD2XMFGhgYNkYg1HhoYT7Vju5pJ/4FZzN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vamOvgRfPwoV7hnquyozYpipK2FBwEm2Vy/+4lmLy/g=;
 b=KnkgInDBGUW6Ugt0pvH5bzMmSIunE+2gnP/nj5MuBm22w+0sVs6S7fA+vEA8roH5sTL3W9713t781PV08711R5v/AN9jk6hqOr1aveTqKt0ZEemWcMS88MLVBr+rsNSX5gfFs86+oq7pRGi3duxREnfm94fx5gVGigKOXK6t19yMngI0q71AsayrioJLHDwptKJHze34ijDwaD+wK7MUP6cFEBOIPMpUhjcw/0aeb+yK+Kq8PWaBecVIMo9S767LTWNAMPuyuL1WkoB3zrtIMsfcMHEl0/3yP8Vx/m+hlwByxFm3sy9PFbV0XqPpcEQcr3Nm4LROlld51eK4erzzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vamOvgRfPwoV7hnquyozYpipK2FBwEm2Vy/+4lmLy/g=;
 b=efzZ9WsxbwNQ30u6/mnz9gYZdUwP5+nXIbrpmTkSypbpnUc5akErIByBvS00V69EVGjnRhWKucpHyWCleJq9wtFaJ5/XX3Fzkso19XjNu2Dp8dXca7w/ZVqBtaSMwL+U10BxWr5n4fHrZd+V3+Oy+kKPC1Yp5tgt81VdQWflwJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 12:29:51 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248%4]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 12:29:51 +0000
Message-ID: <5b1c7eb9-fea6-1cf5-8faf-93fec3a7e57e@amd.com>
Date:   Thu, 20 Apr 2023 07:29:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 0/3] efi: Implement generic zboot support
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230416120729.2470762-1-ardb@kernel.org>
 <jwvybt4sro56aiqvddn6jxdjpdelasdhl747c25kzv4vbjr7ph@fbtheokrtxce>
 <CAMj1kXE4xF9RJbaR0H6uuFxxroUJxQFo8WThb=SUa7H0OpDxUg@mail.gmail.com>
 <3zm36sbx4enlqaumxxz2gp3f6etwzhlfotqrqxsus2r6xulwvm@saqniauxenmi>
 <CAMj1kXF1eaORsUPk=8Mam8OCQbfcMEBca=Lr2tdN=nihiDqb=Q@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAMj1kXF1eaORsUPk=8Mam8OCQbfcMEBca=Lr2tdN=nihiDqb=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0116.namprd07.prod.outlook.com
 (2603:10b6:4:ae::45) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ee658c-c913-408a-e18f-08db419af05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60nMOeyirl3Cb4l+d+IykKLpaclgSlu3yWMX3ZJD3nHHbxJpg1ehYiJy3O4yP82lMY/+mdUQ+DLURsURIVHCxuhdIuGORHYclu93zC01stvQKSXQOsuCyG2AE7aXbQBSDzpYpdj3v5yd5L3mPNBvuunLfEF0isFDA+q5NAxba75jaL9BOwzwp2Uzw2OMODYcYEwoMLK89mHc/PQCbKFs7CctO90XUauQPVsvxCOTiVz1FSStXw2NZnk6SpgPYwbI+BEHJY+HsY+9eX7xCMXN6MsVUyWKW5bxjkaEUMQdUAS2Z2ghHjRP2423LKmpJRn06ZJuABPfjdLmzHt0vAN3H/c2qfyBGFgCBh4caV5mGbVUYkmxttla7acFjF1j2VZ/ezCg4UW6hr0qv08yUd/0UT+QG3h2pkoAqtQicPsMJdNCzS2T5sZkZyP8+J74KjnqjtPizwohBbc0igkOxrIFIC569Pp7fweWOdCqEaoMSTu3PuOUszDq1E4D2vtR+NfaylIeuF1kdFDwPrnudI9tqsVf7vIz+Cb7no9mOg2JpG4EF9ttgzP5aCLGapDF8CfHTXwQuMehf9XJNeQh0rexAOOkr00DUlGxBTTZzMsP0oEBCkBZn0zLcR4Nso6aHG2sbROrlDcrMn0PXGfIKcwfR/uWNBibPTF6l8FT+SmRyfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(36756003)(186003)(4326008)(110136005)(54906003)(316002)(66556008)(966005)(66476007)(66946007)(6486002)(478600001)(8936002)(8676002)(5660300002)(41300700001)(7416002)(44832011)(86362001)(2906002)(38100700002)(2616005)(6512007)(53546011)(6506007)(31696002)(31686004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGd6cG1mdEhLbkk5TTZINmpmTVZnbE9lWllDdkJOZ2ErdThCTG5sa0FlWGpy?=
 =?utf-8?B?Vm5IU3M0M2g0d2U2eXM5c0JQcS9zY1BSWm1odWV0RTV5MHFkcytodDVFazc1?=
 =?utf-8?B?RDNweDlYWFo4Z3hLQkZVYUtwbytrdGZPMW9ZQ3NHMjFPUHJCL2srTFZSUzcy?=
 =?utf-8?B?alRSdW0zbWFBbzI1bEkvSkx5Z09IaGVidEJ1Z1FzN09mMHpBVnY1emZzMHN4?=
 =?utf-8?B?NVRDOHpoTFhJbEx0ZFlLb1F0ajRmT3diYnY3QXFLK2hEaCtlK1F1L0JFUGF1?=
 =?utf-8?B?QnY0Rzc5TW5sc1QzTkxHeTlBOUdoQUtKcXRYQjdCZGwxUW40RTJNeE5IeWNR?=
 =?utf-8?B?M3F6c0hJd2ZVUElZc2Vna0lLdmVyZzVMczNXam05Y3g5VXNTR0V5S3lrS2Fs?=
 =?utf-8?B?MGs0S3cveHMyR1Z4UzZ2dXpEdFViY2h5LzV5ZGFUN0p3REZIN0M3RStYcVFs?=
 =?utf-8?B?WldCYXR6OHB5eERpVS9SRCtKMnVtR2tEUUZGWE5PYWZpTmh5bElEK1RXc2Jm?=
 =?utf-8?B?NmxMRlFlZzhUakVzdTAzRUsrcnA4QmJKNXZTZXRLMExrZUxvcTlOdUhDT2JU?=
 =?utf-8?B?dnMrVlVJU2JpVU5QaisxNjFiVzhjRmxnRldOclVBM1ZjQkMvbHB5Sm90c1JG?=
 =?utf-8?B?M2Rpbkc3c1UwcUJhd0l3MHJmRzBxMnhMZXUrMnArblptdmgyak5jSDd2QWtB?=
 =?utf-8?B?N2tPczBIYmYvRGVhT25PSVRrYmtNQXBHbVFLNS9ROGV4dVNCZWRYWW5WZG5Q?=
 =?utf-8?B?VmN3Z2xmL29jWHZlaFNVSzc1L0hzV0VUeHBjblprMC9pN3lESUw3S2RmbWpY?=
 =?utf-8?B?UGVDTDhNazJ5NTJxTWpOeVRIVW5mK2ZEcEt2TmM0ZzROdlhqSG5CeXQ1TjU4?=
 =?utf-8?B?SGdhR3psclhEUHFJY0FjNFI1MmY4K2g4UFhjM0ZTZlc4U3JoeXlQZGJ0SFRD?=
 =?utf-8?B?MzhxQjZpR0kxWVpoZk1PZkh3ZVI3Wm0xUGwySmZMSjhNRW5mYXowNGJtakxG?=
 =?utf-8?B?MXIrNWVxVUYrbXluclBNKy9hRHBOcUVLRE9rbVV4N21IbEpHMmdhcUxRY3Va?=
 =?utf-8?B?SWR2MTJuN3hJQWsrcUJOY3pwZmk4MWxpdjdSYUkrN1Y5VTBYTDduTUpKMk9X?=
 =?utf-8?B?aWMxMWxqSlVWNys5TGpCd3lyK2lrZWtuNUxvbEpvTXcrNmlJdVRQbG5RZnV5?=
 =?utf-8?B?aFgwdEsydWJxT2VJcEF1L2xrK2E4ZjFINzFRYklYRzMvang1K2l0S0xjM3Yx?=
 =?utf-8?B?emN4UzRPTldob1BqYU95TFdWNkNVbE1TMDU0V1JzQlJ2L09qb25KZUxsYWU0?=
 =?utf-8?B?aW4vL3hoS25IQXpNUElpYS9hemt4Qlk4TUNLU3FuWE9EdXNNUGQwT2N6NGRw?=
 =?utf-8?B?RG5acEdiU1lZL2phaGJpTjBOTjlFeWtuMlhNTDBMcGN4WVgvekEwMGdvVldk?=
 =?utf-8?B?S0ZJODdsRFZXWks2elNYNU5INXJXT0N4NWJRS0wwOW1XVDlZMmtnMVVrd0V5?=
 =?utf-8?B?cVFKN0NkdE9WM09hUGRPNEpTOS9WUi8zR2gxc3JmOTBCQUE0eE1oR3doSm1S?=
 =?utf-8?B?ZEloY000QnF2Q3FhdkFkQUxvYi9ROFhreWZCc0t3U2hBUGtZTCtqMDY4YXFn?=
 =?utf-8?B?RCtwNUJOOVQ0cFJ0bXdRZE0vVEhUajc1RVo2Z3ljOHlQYXRuaU9HeFEzVmNo?=
 =?utf-8?B?VDMxU1djQXExYWFVUG9qVmZYdllXN2ZJZkRKa20ycm1CKzBRTUZmcVZTNnZL?=
 =?utf-8?B?UW8zM0lucFZNSmFqQXg4QU5VTEtrd2htMnV5Z1BEVTd2bkptL0JXOTU3RGpz?=
 =?utf-8?B?VjZNV1lZZkFSTXFadng2LzQ0U3FzclR6WVJlTlJYV0Q1OHJscmN6VjJpUVZs?=
 =?utf-8?B?dTljelV3UWNLQ210ZUtTSW5JdHFyZjVmWDdqTnlUVHAyd2k0VGEreTd4cTlK?=
 =?utf-8?B?a3V1Rzd2MDNxKzYrbTJMTGNKbmN5WnJTcTgxOU5TemZxV2dUaDZDczAvY1ZG?=
 =?utf-8?B?RWZsVHpQUzJxRzZRZ3hQaW1jdlVQUERKN1dkZHRnRHFiYlp2Wkk5enJaSVp0?=
 =?utf-8?B?SzFHUnVPbElxQnZHSi8yaisvZkhSSW42UHZLeXlabURPc2dxOFh3VXpWTUZQ?=
 =?utf-8?B?NG9SMDhaaC8wSjExNDYzUnk4aGpXYW82bXVqZjlpeEJYbWdqR29GRzRzcVF2?=
 =?utf-8?Q?oAzNeUNsWRTxSkx3BoiV6xbDw0oMUcISL/KzRdhtEZe4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ee658c-c913-408a-e18f-08db419af05e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 12:29:51.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vf84aAQXd8aZAidZ5I+sl7ddkyXdJhbmw0StiB35qcL2yEzGh+o2qXNvLiK7ES+XwCBoCc6OI+0pDr/4BKckOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 4/20/23 02:54, Ard Biesheuvel wrote:
> On Thu, 20 Apr 2023 at 08:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>    Hi,
>>
>>>> Realistically, the second option is unlikely to ever be used on x86,
>>>>
>>>> What would be needed to do so?  Teach kexec-tools and grub2 parse and
>>>> load zboot kernels I guess?
>>> I already implemented this for mach-virt here, so we can load Fedora
>>> kernels without firmware:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/commit/ff11422804cd03494cc98691eecd3909ea09ab6f
>>>
>>> On arm64, this is probably more straight-forward, as the bare metal
>>> image is already intended to be booted directly like that. However,
>>> the x86 uncompressed image requires surprisingly little from all the
>>> boot_params/setup_header cruft to actually boot, so perhaps there it
>>> is easy too.
>> For existing boot loaders like grub I'd expect it being easy
>> to code up, all the setup header code exists already, grub also
>> has support for uncompressing stuff, so it should really be only
>> zboot header parsing and some plumbing to get things going (i.e.
>> have grub boot efi zboot kernels in bios mode).
>>
>> Disclaimer: didn't actually check grub source code.
>>
> I have :-(
>
>> I suspect the bigger problem wrt. grub is that getting patches merged
>> upstream is extremely slow and every distro carries a huge stack of
>> patches ...
>>
> Yeah, Daniel has been asking me about LoadFile2 initrd loading support
> for x86, so I think getting things merged is not going to be a problem
> (although it will still take some time) - I can just implement it and
> send it out at the same time.
If zboot ends up being the way to go there would be quite a bit
of pressure to land the GRUB stuff in distros because of the NX
requirements being pushed into the EFI ecosystem.

They wouldn't be able to work on a system that enforces NX which
is anticipated to balloon.

>
> But hacking/building/running GRUB is a rather painful experience, so I
> have been kicking this can down the road.
