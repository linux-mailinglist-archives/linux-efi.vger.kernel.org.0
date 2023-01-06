Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E97D65F967
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jan 2023 03:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAFCGw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Jan 2023 21:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjAFCGv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Jan 2023 21:06:51 -0500
X-Greylist: delayed 260 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Jan 2023 18:06:49 PST
Received: from a27-19.smtp-out.us-west-2.amazonses.com (a27-19.smtp-out.us-west-2.amazonses.com [54.240.27.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F0C3C0FD;
        Thu,  5 Jan 2023 18:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ude52klaz7ukvnrchdbsicqdl2lnui6h; d=aaront.org; t=1672970549;
        h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:Content-Transfer-Encoding;
        bh=Cmz24rg2v6sSkGwNw58tGKSlPXAtf7goihufSQSgRQU=;
        b=OTSv+DlU2mrxugOLjgqSj9NaHzlzF78TX1RzcACgtYB7/UWRCeIuAk/4LRW+/8u2
        yX/hekQVtyXKsgabL3qmmCRWr8THpEy0R1uJ6WYTnu0HUsf4rx0iCzy7iAftNyDr6lq
        D8M+2+Q5pQoI5jMkDNAwg+YFeqO1lnJ3mGcHowPs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1672970549;
        h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=Cmz24rg2v6sSkGwNw58tGKSlPXAtf7goihufSQSgRQU=;
        b=Qh0aaAYSWQyh97c8Ybx7gKS/oDcIXWJnAFQgrL/ojIIOEculrzvQcpAm5v0VEURn
        uEwmxT0YqZjp+/KRWtJC2wwMOII11gX+RMMo+MuO3X7dRtTY2WdbX+y88NioN7hYxFt
        EI6pa2GS6TiQpp5SCkO2l1Ob833jY8Xb1CPHkdiM=
MIME-Version: 1.0
Date:   Fri, 6 Jan 2023 02:02:28 +0000
From:   Aaron Thompson <dev@aaront.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 1/1] mm: Always release pages to the buddy allocator in
 memblock_free_late().
In-Reply-To: <Y7aq7fzKZ/EdLVp3@gmail.com>
References: <010101857bbc3a41-173240b3-9064-42ef-93f3-482081126ec2-000000@us-west-2.amazonses.com>
 <20230105041650.1485-1-dev@aaront.org>
 <010001858025fc22-e619988e-c0a5-4545-bd93-783890b9ad14-000000@email.amazonses.com>
 <Y7aq7fzKZ/EdLVp3@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0101018584d0b5a3-ea0e4d67-b00f-4254-8e1c-767fcafbec31-000000@us-west-2.amazonses.com>
X-Sender: dev@aaront.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.us-west-2.OwdjDcIoZWY+bZWuVZYzryiuW455iyNkDEZFeL97Dng=:AmazonSES
X-SES-Outgoing: 2023.01.06-54.240.27.19
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2023-01-05 02:48, Ingo Molnar wrote:
> * Aaron Thompson <dev@aaront.org> wrote:
> 
>> For example, on an Amazon EC2 t3.micro VM (1 GB) booting via EFI:
>> 
>> v6.2-rc2:
>>   # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
>>   Node 0, zone      DMA
>>           spanned  4095
>>           present  3999
>>           managed  3840
>>   Node 0, zone    DMA32
>>           spanned  246652
>>           present  245868
>>           managed  178867
>> 
>> v6.2-rc2 + patch:
>>   # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
>>   Node 0, zone      DMA
>>           spanned  4095
>>           present  3999
>>           managed  3840
>>   Node 0, zone    DMA32
>>           spanned  246652
>>           present  245868
>>           managed  222816   # +43,949 pages
> 
> [ Note the annotation I added to the output - might be useful in the
> changelog too. ]
> 
> So this patch adds around +17% of RAM to this 1 GB virtual system? That
> looks rather significant ...
> 
> Thanks,
> 
> 	Ingo

It is significant, but I wouldn't describe it as being added. I would 
say that the system is currently losing 17% of RAM due to a bug, and 
this patch fixes that bug.

The actual numbers depend on the mappings given by the EFI, so they're 
largely out of our control. As an example, similar VMs that I run with 
the OVMF EFI lose about 3%. I couldn't say for sure which is the 
outlier, but my point is that the specific values are not really the 
focus, this is just an example that shows that the issue can be 
encountered in the wild with real impact. I know I'll be happy to get 
that memory back, whether it is 3% or 17% :)

Thanks,
-- Aaron
