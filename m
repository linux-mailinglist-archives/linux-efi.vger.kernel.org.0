Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F77D8098
	for <lists+linux-efi@lfdr.de>; Thu, 26 Oct 2023 12:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjJZKVu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Oct 2023 06:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbjJZKVf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Oct 2023 06:21:35 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9592199;
        Thu, 26 Oct 2023 03:21:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vuxb1G0_1698315681;
Received: from 30.240.112.233(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vuxb1G0_1698315681)
          by smtp.aliyun-inc.com;
          Thu, 26 Oct 2023 18:21:23 +0800
Message-ID: <8093ceb3-0857-4c36-8856-72a158e47b6c@linux.alibaba.com>
Date:   Thu, 26 Oct 2023 18:21:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/9] Use ERST for persistent storage of MCE and
 APEI errors
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        robert.moore@intel.com, linux-hardening@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        baolin.wang@linux.alibaba.com
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
 <20230928144345.GAZRWRIXH1Tfgn5EpO@fat_crate.local>
 <f654be8f-aa98-1bed-117b-ebdf96d23df1@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <f654be8f-aa98-1bed-117b-ebdf96d23df1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2023/10/7 15:15, Shuai Xue wrote:
> 
> 
> On 2023/9/28 22:43, Borislav Petkov wrote:
>> On Mon, Sep 25, 2023 at 03:44:17PM +0800, Shuai Xue wrote:
>>> After /dev/mcelog character device deprecated by commit 5de97c9f6d85
>>> ("x86/mce: Factor out and deprecate the /dev/mcelog driver"), the
>>> serialized MCE error record, of previous boot in persistent storage is not
>>> collected via APEI ERST.
>>
>> You lost me here. /dev/mcelog is deprecated but you can still use it and
>> apei_write_mce() still happens.
> 
> Yes, you are right. apei_write_mce() still happens so that MCE records are
> written to persistent storage and the MCE records can be retrieved by
> apei_read_mce(). Previously, the task was performed by the mcelog package.
> However, it has been deprecated, some distributions like Arch kernels are
> not even compiled with the necessary configuration option
> CONFIG_X86_MCELOG_LEGACY.[1]
> 
> So, IMHO, it's better to add a way to retrieve MCE records through switching
> to the new generation rasdaemon solution.
> 
>>
>> Looking at your patches, you're adding this to ghes so how about you sit
>> down first and explain your exact use case and what exactly you wanna
>> do?
>>
>> Thx.
>>
> 
> Sorry for the poor cover letter. I hope the following response can clarify
> the matter.
> 
> Q1: What is the exact problem?
> 
> Traditionally, fatal hardware errors will cause Linux print error log to
> console, e.g. print_mce() or __ghes_print_estatus(), then reboot. With
> Linux, the primary method for obtaining debugging information of a serious
> error or fault is via the kdump mechanism. Kdump captures a wealth of
> kernel and machine state and writes it to a file for post-mortem debugging.
> 
> In certain scenarios, ie. hosts/guests with root filesystems on NFS/iSCSI
> where networking software and/or hardware fails, and thus kdump fails to
> collect the hardware error context, leaving us unaware of what actually
> occurred. In the public cloud scenario, multiple virtual machines run on a
> single physical server, and if that server experiences a failure, it can
> potentially impact multiple tenants. It is crucial for us to thoroughly
> analyze the root causes of each instance failure in order to:
> 
> - Provide customers with a detailed explanation of the outage to reassure them.
> - Collect the characteristics of the failures, such as ECC syndrome, to enable fault prediction.
> - Explore potential solutions to prevent widespread outages.
> 
> In short, it is necessary to serialize hardware error information available
> for post-mortem debugging.
> 
> Q2: What exactly I wanna do:
> 
> The MCE handler, do_machine_check(), saves the MCE record to persistent
> storage and it is retrieved by mcelog. Mcelog has been deprecated when
> kernel 4.12 released in 2017, and the help of the configuration option
> CONFIG_X86_MCELOG_LEGACY suggest to consider switching to the new
> generation rasdaemon solution. The GHES handler does not support APEI error
> record now.
> 
> To serialize hardware error information available for post-mortem
> debugging:
> - add support to save APEI error record into flash via ERST before go panic,
> - add support to retrieve MCE or APEI error record from the flash and emit
> the related tracepoint after system boot successful again so that rasdaemon
> can collect them
> 
> 
> Best Regards,
> Shuai
> 
> 
> [1] https://wiki.archlinux.org/title/Machine-check_exception


Hi, Borislav,

I would like to inquire about your satisfaction with the motivation
provided. If you have no objections, I am prepared to address Kees's
comments, update the cover letter, and proceed with sending a new version.

Thank you.

Best Regards,
Shuai

