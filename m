Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7013D5F4FAB
	for <lists+linux-efi@lfdr.de>; Wed,  5 Oct 2022 08:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJEGPR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Oct 2022 02:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJEGPQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Oct 2022 02:15:16 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E0363F18;
        Tue,  4 Oct 2022 23:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXP9lYxsmpdTgO3rr/vm4vGzNyUAddXFrZyUejpfne0Zu8buOZkr5uDg48bt0kfSjTaCazWnBzPd76vjqwoqqD3t5f1coTGmUTuGyJjs13mGNnVA0xjq2jrp7QccKnONhzW9tHlIScy6/JZJ27mr9I68+QXQ3cWrMcVnpfrHeYnJWfzNVvxAEcmJhJpFCPKBmrdQlxhetOcr0LAcrsoXNXTr7l9d5kNET7Yp9cFo/BjJcqjP6Jpqp/WCPucL5MwMXWADkD8sBPv9NMn0BP0rVocjnXj5W7XoEDzPQiOC/WJiAAG3hZYtBDJ3dTkpZLsTIA1MEF7yEpumR09HQPmXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SXlFQl4ElpS1x8Q77iosu7H/vrhFX98uDhyfXvAEh8=;
 b=WWpbK2bCGpaPfEQGBL7HZWLEuGr4TgHQG8MVDHUFX6zxJll2wde/Civlb4nQsZ8jd84nSgxnCGxBL4GmoSMB+MZPCrfkRbxIcfRgQPWcFl0KAnuTuHKichJEJZYupTiyWbThjFbdvA6/kkR8Y/ERthXSUHmji6oWe4RlAD9f5/W//P8Xs25CGfQZvTQEMfQ1MjqqLx+yFKc13D4oou4mswhPGSuS4JKSrdFZS3r3h2X2CdDR7Dk60EIKucTqA+Gz7NuvCbjU+sZVPJU4hEhE9M8KZykStRfSzwV9f+aITh+g/r6Ib0vnHK2lW0JSmVYju0EOwb/vJ46Wvg/xcidWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SXlFQl4ElpS1x8Q77iosu7H/vrhFX98uDhyfXvAEh8=;
 b=FaJ3Oqr8E2l3LARB18Kd9WKGRP4bktG83QxCSDe5oM0M3MRRxok8KbIV/KI8CclYO65TNM8X91yxuwTsAR8UBjg7tPrDGoSgvWzSZNNmlBKuNXEYVsbucvF/CjGWVeQvykzALdhJlpmAgGCNy1wBq0RIeapFB1TqmEzH04SPG0uyNzfKzblpcIOzxjWIlsplRjV/kNKO9l3Q5UDidDW52DN48/nWK0YRy3z01GvOKh2+6Z2kamMDrW5HBDTiDXqOBN4zMpfONWrd9b+Fw+fd0Kx9v8D28kuAPcbQVOXMQ0RH4lcjFbOKsWmh5Fy687IezCBYSBPB8urOgu4aGfiRUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DU0PR04MB9393.eurprd04.prod.outlook.com (2603:10a6:10:358::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 06:15:09 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a%7]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 06:15:09 +0000
Message-ID: <a0dc1158-01b1-4272-b86e-52f4996f0747@suse.com>
Date:   Wed, 5 Oct 2022 08:15:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
Content-Language: en-US
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, Ard Biesheuvel <ardb@kernel.org>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
 <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
 <CAMj1kXFQNqsW5RfHGac-eGbosJHBybu6+-Fap_bi_kVxWNpGeg@mail.gmail.com>
 <YzcjeiOW8+i2Zxsd@itl-email>
 <CAMj1kXHBBbCNV3CLesqZi7ttmmi8y4tZ1KO5vievy_CJrU2o3Q@mail.gmail.com>
 <YzeaKjmls1YI/3ox@itl-email> <01d22092-8292-8ed7-ece7-9ca32d15bbce@suse.com>
 <YzxxXuovwQt3NskE@itl-email>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <YzxxXuovwQt3NskE@itl-email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P192CA0068.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::45) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|DU0PR04MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: 0835cd15-f700-4106-9e1c-08daa698f466
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vo1HzMyv/qinf7IyNE/3yk9T9AlOH22Rq+caV4MfitWCvdf+WIYxEmLIvB2c1TSwEQhZpyP5T3SM8vHKPZ9nTPfGCGk3qpToWNixO+9cKVwFRCrSsvSZW3Xz1TmV5zZt7IurwGb/qVAS19Qn+y139OhcozyhxKnhyV9lQxTzTyO0n4sbvdSDLcQyYk1Bb9rXbyC7LNx0BCtOq/TGMZT8jCgk2oMHn9mZ0nrOPgy9o8Ai18rojxU29dEh5XjSqBh/M0rf6/UspSVAr2ECWcPCqx8/LkyKchvPFg6hwOqPEtog4qaTgGfRxdXno/JM6LdFCSCT8i3xYjjxurxfdEiZ7sgex4KyIRJLQAr2dmdxaMatoB8uB7/DaUtXX3Ecft07ne4ELZohRQDOwShftO6yDbTPMNyNMZLjI4V7y/d736mZHUQ69Dxj2ybR8ZJy0BtTr7hnelpO+3s801KdjSut2Ekm/5DY4cfKJKfuSW3+dreIHKV/lSIEOdxcgseNpNO91VNiVYAVQ8TvxvMiDN7/0IEtrhtojORhNZ7Jb+UfffApUMQDZiG8ra6TSRSj4M3+2XbZ9qGxZWXvnePm/2Pm2CdecILrIn/YI+WqDdIhVm6CYuZnieAzd4hn2eL8EpCBzcigjjLbWuec50MzRtUzVGEH5iYyPv1Gmr7HA0hAd4h34groecgl6LIdEOw6XUkdUEKYJcKyVMm/nqfHSAeCJOhTQ++VquTn3BO6/zHqiOPcjjO+aJut0Bl3ZTzEEMVBu5to+90XV4IEJZnxcRhpU72suLaHU7w0uyR2xoUgi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(6486002)(66946007)(66556008)(8676002)(66476007)(4326008)(2616005)(38100700002)(2906002)(36756003)(41300700001)(478600001)(186003)(53546011)(6506007)(26005)(6512007)(31696002)(86362001)(316002)(6916009)(54906003)(31686004)(5660300002)(8936002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU9oUktpZFJ4enkvZy96MmZ1ZlBHTE5YYlFWa3l3MXJOb01YdnM0aGFyTE5y?=
 =?utf-8?B?TVhndmlMM3lOK1VqTlBqck1CR2prMkRqRWphU0VWU0c0TU41czlwS1FJV1k2?=
 =?utf-8?B?NUhRMEk0a0czWjJxSWxrTzY2YklKZVJqR0RpMW9iSm9wMmN0NDl6cCt1NHlT?=
 =?utf-8?B?THBqaWRaQnlTUkIyM3VnOE04YndxRVdwekp2Y3Y2aWk0ZGpuQlc5aWJZelZW?=
 =?utf-8?B?eW5EMHFnNmNLSVQwTEtoNXpKR3lQTVFyNzhxa0pDcHppZFZsRjYrTEtMNGl2?=
 =?utf-8?B?QXdFeDRUeHZwd1NLY0R6TmdxdmFFWlllTnhEaVpDZ3JwbHpncGlDWXFUMTlB?=
 =?utf-8?B?SVpVeWlHQlp5SkZXOG9GdTRPakc4YjVGaC9ZdE50T3BmSlRUUUZ4aUdOWXVj?=
 =?utf-8?B?SUJXYnVBTGZwd1U5Y1RiWDBIQkYveWQ0V1h0c055akpxdUJSa2xrdldvV3Qz?=
 =?utf-8?B?YWNXRkZ2WXFtNkhiN3hPazRZaE9uVkFzdFA1VW1sYzNnc3NzdFNEVkV1NWJr?=
 =?utf-8?B?WlBFVlFoaU4zZzdseE9HT0E2MXRTR0UwQ2RTL3FOb2xGTVR2Z214L3ZZRXps?=
 =?utf-8?B?UHhKSHc0b1dXdEZ0bHVsYWNlY0wvWTFtSlB3Q2hlSkRPd3VyYmFKV29iWlFD?=
 =?utf-8?B?RzNoZmp4WEpCTGZjdHFlRkluSkVZYXpxOWZtWjdJenZEL3VJclR6Wk5xbmY5?=
 =?utf-8?B?bkY1T09aZC9rWm0wdk9Nc1BtYnhQcU5xdGdXTzBDRmFvV0RHeVRqeUNrd3BD?=
 =?utf-8?B?bUx4eU9wSUVqZzIwU05HUVBVbExlcVhpU2FGMlBhRUlVTDdoY2ROM2lSWG5H?=
 =?utf-8?B?c2pXcjdnZ1F6K2o3c3djRVpiMHY4dDhYcFlnSW9HUXp5Z1BWV09HRHBEbllk?=
 =?utf-8?B?WklEbDcrN25Zb0E5Y0JhcnZ2SUJEb3k2YnBGRzJUYzhCZkJSeTZSM3o4a3Rx?=
 =?utf-8?B?alZtckVZQ3dBb25VaXNHYXl6blRqS2JBOFVWQ2tDNEh1NGdab243bm9VdENs?=
 =?utf-8?B?WWRkeWd0U2NXT1E5WE41cDZrZ25OWUlvdkRMTFFMTUMvVXdmbWpBdVh5VnVs?=
 =?utf-8?B?OHRxczQvVVFoL1dycTRRcHNqRHpUOVczODBMWHUveXpPSmxycHpYRFNxb1RN?=
 =?utf-8?B?TjBrS1BtUGd5amlFQWtpRERXRGFJdGJEd1dzWEpSZzErSXlCaHBLM2Fqb09J?=
 =?utf-8?B?RVVWU0ZUM3RReXVvb0RnUTUvcGJqaFhNRnJmZHRJNUpWVUFzWUVZZGVRQm1H?=
 =?utf-8?B?ZXBtWElWZ00raEdvdkNJc0tOZzVERm1WdG5oeVRlMU9GZGZmaHJHSlVQNDJO?=
 =?utf-8?B?dHE3RTFNeGV4NkxqWTFpZFU3K0FrSkgyTXVDYkM1eVh3QXJnQmNRTWhyeUtE?=
 =?utf-8?B?RUEzbERndGVtRWNZWGo5WXZiQk1rUjF5ZkJEREdzVnkrWDBXRG1OeGRCMGxp?=
 =?utf-8?B?bWNTa0EzSkVSQXY5VTdtTkU1TFowa2Q2Q2ZzTkhlNVlKVGFTb2YrVzgrK0Ni?=
 =?utf-8?B?ODhsUjBoNlNqclFYajFJL0dGODE0c2Z1ZnR1UTdWVElNMENrTld2Y0NMQWVh?=
 =?utf-8?B?RXBTNFVnY05pRHBXTU9UMXZkZ3FQNVFSWmhoK3hrcUUrZ2ZIMVFRbXAzWmg1?=
 =?utf-8?B?dURHejd5b2xWNGJ0bGNMRXBCcVZMWHVYTHUvLzVvQjlCT2wxWDJwNWZYdUwy?=
 =?utf-8?B?M0Ird29hU3FzNDVpUExHSlk3OWI5VnR5WUFrdjRtbWJhM2JuYmRrZlVucFI1?=
 =?utf-8?B?MGJRSW9DYW1TcFMwaGpITHF5elJWeDNha2ZBTktBMkppVWdPNFdCTGwrUVkw?=
 =?utf-8?B?RlU0VVFWQ0psMGljcW95SVNDN29seXppU0Qxc1VJUlhYc1J5Y0tLTCs4R1dm?=
 =?utf-8?B?ZHBmeEZNQTNKSEpjMmw5MWx5cm9pbHNTczB6R242a0FCMW54YUlxWFd6bXlW?=
 =?utf-8?B?cjZzeG1jeTVDWEoxMWVZa1FrRE81cUtKS2Y4aWpYZEpPbzdXbVE5eDRXMHRK?=
 =?utf-8?B?N3N4SEtmKzQ5ZXo2eWxXQTBTZUVuamxxeUplRXFaSW5mNUxwUE5wWG5IakJ6?=
 =?utf-8?B?VCtvSEE1U1BFV0FRaWVGVHJlV3IzbFNwekVjUVNRV29XMVdDYUtZVjNWQmoy?=
 =?utf-8?Q?lKA8O7K3Kww7ox7bTlQvDh6dS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0835cd15-f700-4106-9e1c-08daa698f466
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 06:15:09.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IycCBMlSWHwIZdo4FkcDpL/9Pn+pIEa2L1+B74Crwop13yJWp4OQ+V/di6mRQGEwyh42oVNZSehp7ln5R+vZng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9393
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 04.10.2022 17:46, Demi Marie Obenour wrote:
> Linux has a function called efi_mem_reserve() that is used to reserve
> EfiBootServicesData memory that contains e.g. EFI configuration tables.
> This function does not work under Xen because Xen could have already
> clobbered the memory.  efi_mem_reserve() not working is the whole reason
> for this thread, as it prevents EFI tables that are in
> EfiBootServicesData from being used under Xen.
> 
> A much nicer approach would be for Xen to reserve boot services memory
> unconditionally, but provide a hypercall that dom0 could used to free
> the parts of EfiBootServicesData memory that are no longer needed.  This
> would allow efi_mem_reserve() to work normally.

efi_mem_reserve() actually working would be a layering violation;
controlling the EFI memory map is entirely Xen's job.

As to the hypercall you suggest - I wouldn't mind its addition, but only
for the case when -mapbs is used. As I've indicated before, I'm of the
opinion that default behavior should be matching the intentions of the
spec, and the intention of EfiBootServices* is for the space to be
reclaimed. Plus I'm sure you realize there's a caveat with Dom0 using
that hypercall: It might use it for regions where data lives which it
wouldn't care about itself, but which an eventual kexec-ed (or alike)
entity would later want to consume. Code/data potentially usable by
_anyone_ between two resets of the system cannot legitimately be freed
(and hence imo is wrong to live in EfiBootServices* regions). In a way
one could view the Dom0 kernel as an "or alike" entity ...

Jan
